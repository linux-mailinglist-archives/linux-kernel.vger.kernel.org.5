Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95C97BFE40
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjJJNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJJNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:44:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D296271E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:41:24 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f4f80d084so67991827b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945283; x=1697550083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueK8SG+a7FTCY6O4EvQZ3DF32rOrkudVS05yOM+rm8Q=;
        b=pALrOtvUiukdglMyGsRr3uThX2dEh2snupInYNwlD2ewY0tTT6GLziyOUhO5/1Hrc6
         tgsfPxT0bLxpEDNMH9EshqkjJ9VweTRXAryRym748OFx8h0B3AL+QrCmw+7I0O7CQU2K
         isPz561MXCyShw1qOqdKMXZ1VkFz3j+lUFlbXJuKt8W6AAJYUAEMo/qjCkJv50/51AzR
         TentqMIUEmo+biSZQUUd3E/EZs8u/MO0Y1hgOMQ89+RbFbyIDhuVIugeCidfI2Eblq+i
         YPBICmDq0qqd8xzwU0vBnwxcNrguXMJuj/ruoGPhlDm0/5wC8xfZBkUL04F0nY1AdpuY
         VE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945283; x=1697550083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueK8SG+a7FTCY6O4EvQZ3DF32rOrkudVS05yOM+rm8Q=;
        b=fw5H41dP989H0iVTOYzM5fOt+RatgBZVlf3Ua2aeE6UkZpM8wA05xabBfYPBwsFBMd
         loae00fQhlwOHMO+huWcvfmV0hVkClKKLs6NtRlXAybbps4SJaNeW+7SOq0J6ETyX61W
         H5rrkd77FXEfro2idOT4TdPb978WqoiHOlILmyzDuqXNgSR/OgT3hEsHu5hoHfs+z+Jz
         AgWcdB4NKCUXmrwBVjsbxpe9/9Ns35qt+xQZvUxDOI3tt8Ygqjdffq5WuFiBiGzdyuZB
         Vz4zyhibBGw1cW1TiO5ZgStj/nWPCOKZzadRLmrUm19GqoilYtwjMWoWHU+0/wCvAZG9
         XrUQ==
X-Gm-Message-State: AOJu0Yz+Xq2wC4/OVEKbd2E8takyIep8y3TWq0kWncqIfm+zjBoPZ9VC
        Mm5NKMw2IZyADN6Ot3A3sFb7uB/vchePAHRmccHZLQ==
X-Google-Smtp-Source: AGHT+IFeF565XnMjdeGlwpA7Qpbln3q9KjwdSHBRpi1ETaQ6I7jQT4GcmMxVkkfUJJiXKQ/CDEsXHIM5K+82riuMrBo=
X-Received: by 2002:a81:a0d2:0:b0:59f:6cbf:8902 with SMTP id
 x201-20020a81a0d2000000b0059f6cbf8902mr18245533ywg.33.1696945283469; Tue, 10
 Oct 2023 06:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-13-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-13-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:41:12 +0200
Message-ID: <CACRpkdaK=gk7oeg6U7dcE7oJ0KhM5_FSpGo8Zv_87Fc-nRkyWQ@mail.gmail.com>
Subject: Re: [PATCH 12/20] pinctrl: single: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:23=E2=80=AFAM Uwe Kleine-K=C3=B6nig
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
