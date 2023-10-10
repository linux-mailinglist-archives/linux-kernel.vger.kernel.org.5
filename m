Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD59D7BFE50
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjJJNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjJJNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:46:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E311B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:46:00 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f6441215dso69837347b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945559; x=1697550359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=GTUMG2cpZN4joGYPbhokWog/jJTcMXKbBiDYC6LtZs6lP4a49st7GEBz//heCGpXEw
         uUh1JjGi0cVxqiFUp4gsCs0D3xajYftcFEY3g7eGUDz6IMaFVoey0gUEc66iZ5tG7+VF
         cNjWcHtzYIy3Tng6510oTKpqZHbIiDcG+o5TN9vdUuL08nb8XH49zS2+RuymiSZ2I0XO
         FO60COI84CybG3cawNdzQAHVo8z4l62Q13e0VV7QboHNjv3I+czsSi3JAzSsw3rf5s6d
         Re4oiOqKsO7eidLsguCgzxVG14cbUV+z0K363YO2KvVBVNjD9UARtCBdQfAeLQR6sS8j
         5D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945559; x=1697550359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=Q+pIZ49ktQHD2hzIt5/d3VMBrj9jq+jaUPUFwLeWZ6P9XkupcFubak8y4yti9V5PIY
         3Vvka+mke2NoLdOfGrkzSsWwZbYOSUz3skI2xV7CuVr+RdvOeej11LQjDlgtMsKw5JUP
         31FV9MY1HkSvp1FY/PVgMmi4oLSuoZO+D0TgdmGMjwU+Tu0e4K3Xyxd+/gN6ghEaq5H+
         uakhCCTUR470qis1dj5Is5tYHPuk9NSqz5OYqR6/2DINgI9pkMIHFJVUMz38d4C9vC6r
         M1R6/eypEhosSFYKphrzaUlJRH77HeCE/f1V39bBkZaNpRT2/VQ4JdAI9Kva4H/MyZ5r
         I7Lg==
X-Gm-Message-State: AOJu0Yz7ZdEf3XhrQg7Zd/cX9IsjCs2HnvAkj2drWPTo7ClrShQ9dFDP
        vcBN5Wt8u1Dc7OHxh4lG1Q+SZ3DNdjJAoI+aVhurdQ==
X-Google-Smtp-Source: AGHT+IF1SXeIVHVjztm0ZYgmGwxo8f5C/HSuYvcTMCEjyu3oU5F3VUCegkBp1Fx4EXbM/bhgnNYUk/mo1XprdT+stfc=
X-Received: by 2002:a0d:f5c7:0:b0:59b:d872:5ca8 with SMTP id
 e190-20020a0df5c7000000b0059bd8725ca8mr17276014ywf.22.1696945559617; Tue, 10
 Oct 2023 06:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-21-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-21-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:45:48 +0200
Message-ID: <CACRpkdY5rDMxaVwBTM3Dj3JdBXO3+2VwYFKaZJ5smnzEdtHDoA@mail.gmail.com>
Subject: Re: [PATCH 20/20] pinctrl: ti: ti-iodelay: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
