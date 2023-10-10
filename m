Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B77BFDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjJJNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjJJNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:38:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9EB4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:38:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7ab31fb8bso16590917b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945119; x=1697549919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=vjGvr/19I04ZeEcJtAs+W7J2FJAhYwqz+jcLg7s01KRDzn9Gm31kIwhvIBZyEI2Khm
         YZl+xtY/gqR1XfvPuPSk3IetQR+AuiZnjiOeEMHuWLCfgRJqjfEbNJXvCDqHQDnSusZs
         5AavMQU9VRlBl0vAaSjrF/CH+ClX7ITD128m8m03VnRVUP3gtVWB2vn8TTzHkQu8Cv8N
         yExQKdCfsy1me4hwZexMNUv4wGJhX8Lvm/x93DXeLKilItU5VCIHIgIzx5CK5pOqeyi3
         GHFcdjMDZONGYDN1+u0OvBuVHS63MZA7VHh0Bm9iANtTeA60FMUHWgpsAWniWEnL7pi9
         tJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945119; x=1697549919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=hgn7uHqBx7PIiwxeCjp4Lmcklu2/s/5qETZfr6fhqNVQTYtiDSTb827mdl9qGGRS6W
         LiMde26ar/tFvAigvZh4MQIrH8KUE9T6R6++v6JINzPaZvUFL24ViqJTsbDLgI0OH3C+
         Fc3pHQLxKAuhd+Zc51nfjrk5ZheMSG/uwdeko28kTVCrq580RT/ZPdpgu0Tu+RqDhfsQ
         mb6THX5FbD37UifMe+8gO/CPBu5SiMYBBh/Cw+luKHHU1nVRGS8Qdo6jNlV1sXGujqCV
         xRh6Tzb3tw9/AHzbqWg6fpUsjigVc901MIcWY56vlALcXwdPstY/XtZm8Cwg31/GG5Rg
         LjxQ==
X-Gm-Message-State: AOJu0YwDfyc8BFkQCzCS2UgZFVi0krqrhkkiWulXmuAfcXq6ovQBTBvf
        hLPJFkQgAIamBU15TMG6VwGOKQ6rsma98HM3r2I3Rg==
X-Google-Smtp-Source: AGHT+IG/rlSZIRsdAPMDOoGUHKv+XY8vnEpd9QbiKwE7u+RhPkcD35mkR2VD79T3VBscOEXfDa8Gy+LU06PrtiMtCXU=
X-Received: by 2002:a81:4f95:0:b0:5a7:b819:648f with SMTP id
 d143-20020a814f95000000b005a7b819648fmr2909918ywb.4.1696945119170; Tue, 10
 Oct 2023 06:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-8-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-8-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:38:28 +0200
Message-ID: <CACRpkdYL641NTMjngRY-uf3UE5Lo5wMiyUPqh-Bq1T+WhGPm3Q@mail.gmail.com>
Subject: Re: [PATCH 07/20] pinctrl: nomadik: abx500: Convert to platform
 remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
