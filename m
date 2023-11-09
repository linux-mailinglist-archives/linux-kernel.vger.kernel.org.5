Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A136D7E700A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbjKIRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjKIRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:18:34 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05030D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:18:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b980391d7cso877128a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699550312; x=1700155112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sETpXjNQzICuFitVFLZxqbi5fXHH6j39NgeWIXg4AEc=;
        b=tG/Nl6IxW956YJhFGMfbFXaKEDBO9A8Rj8FwciYfV+Rx+cF3fGwlTC9r8EVgp3xFUa
         tDAQG3pkOcvEgVtUmdLt6zOUJJCHmndDs/8i/qLQ2BKGs7+dC5Z/59DVQOd1gDnmR5dD
         V2ZjxYtSNwHhXGiP/MmvhT1pO818HrnFClWrR8P9PB3i4br5WWwDLPvuMIryIou7rvZW
         qUhdTrLQLAK/mDo+1UPfblS/8aJg8uiJ9Lv7ZHIVKBrg1cOAfZDzQCRMWlAb2GVRXEA4
         y8WsmaCnHNUYMvB0q2hseiWmls//hzZ1PRYwPkfe8vOX8WxZTHVe2DgVUyARYWZjL2BS
         oj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550312; x=1700155112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sETpXjNQzICuFitVFLZxqbi5fXHH6j39NgeWIXg4AEc=;
        b=BE5esBbFoZk+lnbE+WMzzgyMPFnQjsNqy3wLJDTJzEPper6o3JKnCLBE1mYlJjBB0M
         TPuthgwByuROW7VjgBTDsk7i1LGO4jlcmcY1O5rTmoMFM2YpNjkE7BQldlvj+l95Tp7q
         1WGFIO5LgKSZWAdL6ITSzUg4bxu/+bMLmSjSpVGquQ3cLtE/84Dxc3S84fuK6G97+IqS
         st5Mb18CyV1xfBX4+Bj78ttUWN0oxD094FlI+SP0lLVI3SwR79NF5iuiZXXVN/UwCf3K
         aFV53Uy1WxgizPS/paEauO5+Tymloyc3INuizggDDQOok7IEXieC/OCoqbw6xqSYBRFK
         sOaA==
X-Gm-Message-State: AOJu0YxqsOP5empa0PDgcEQgG0eEJ3W4qDwqP81ndA3Cs7pTNTBe/dei
        o/B0kdxQhSHUzHReGWdULgZYDNYN2qLA04bKiG9A3g==
X-Google-Smtp-Source: AGHT+IEjNKsPYRbDywGL5IVqy65WLDYYH1YmfsFR5Qhhi8kAgJ2XOcWYnPrga4W/M5uQvoxORRqAEr3CsijD0Yl4sd8=
X-Received: by 2002:a17:90b:17c5:b0:281:2634:f81e with SMTP id
 me5-20020a17090b17c500b002812634f81emr2238764pjb.37.1699550312016; Thu, 09
 Nov 2023 09:18:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231109104758eucas1p2e98e8cf22a42aae212a98228e46b4438@eucas1p2.samsung.com>
 <20231109104748.2746839-1-m.szyprowski@samsung.com>
In-Reply-To: <20231109104748.2746839-1-m.szyprowski@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 9 Nov 2023 11:18:21 -0600
Message-ID: <CAPLW+4=DHhtbr2zh61WJ7QpkwYTmJaWxoi-Vd4AoSSs0TrZWrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: samsung: Fix broken resume after putting
 per-channel data into driver data
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 4:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> PWMF_EXPORTED is misleadingly used as a bit numer in the pwm->flags, not
> as a flag value, so the proper test for it must use test_bit() helper.
> This fixes broken resume after putting per-channel data into driver data.
>
> Fixes: e3fe982b2e4e ("pwm: samsung: Put per-channel data into driver data=
")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/pwm/pwm-samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 568491ed6829..69d9f4577b34 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -631,7 +631,7 @@ static int pwm_samsung_resume(struct device *dev)
>                 struct pwm_device *pwm =3D &chip->pwms[i];
>                 struct samsung_pwm_channel *chan =3D &our_chip->channel[i=
];
>
> -               if (!(pwm->flags & PWMF_REQUESTED))
> +               if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>                         continue;
>
>                 if (our_chip->variant.output_mask & BIT(i))
> --
> 2.34.1
>
