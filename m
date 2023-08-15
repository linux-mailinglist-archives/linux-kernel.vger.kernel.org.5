Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C877CC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjHOLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbjHOLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A7610CF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:52:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so8690213e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1692100322; x=1692705122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhMoPgkdQ6YofmpZ1OJSuXaWlrDNH20HBw8OL7m09Z4=;
        b=t1e0ddP6D1O5GOQyKZl594DRM+vK2mIwGeOEeRFZdrYeoUe1NNeAVS/FgrrrdxWTzf
         ZGs/qQQSY+NXDjyI+Eo9/MAlv2a9v0zJi1jLUG5EAhvtYUlCoyVn4TimoUUxc6ea0Y1d
         v7ZkOYr7qocC5CzlQ6iVMZqJ0NQL7cPyLGWzox6BxMrlNrgalvDotvnWYQTsM9u8jKdb
         6i2/sVQgrVlK6cBCRkrfiM6q4MXMe6vCVaqD3ShOF2LzQB7DYwrz9gWSdev84lCjhme2
         msHKbdLBLpzwEtV0ES2188UOc4RvGTU5iEtQEnGW3sWnu4h3IPKntKvTWMlcTLIa2NUm
         Go8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100322; x=1692705122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhMoPgkdQ6YofmpZ1OJSuXaWlrDNH20HBw8OL7m09Z4=;
        b=flq4dX1PPtWQAcHKd3qQsiwfzUvA9031BMsAwky+uRjbxadn9nA/0MXOChqPG0XBqW
         8KTGop/15Abg6oJPW2h2qnkNSgfvaR60AlQqKQfy9wRCQlnwZiUYCCQHrXVfuUC+Q2wx
         RpHl98IwtPqe8m3qXiSe8t/K95AM3Pj2YkyYrJ3eaJiIqn2ABgQhUYAkobhWfwo76kji
         vXp2B0BiTn8GSjvbqpjLfiizskP/cP2qOkxTsWKllvKflpiBmfK/CDWHAlN2EKXnBNY2
         dgVHFg0ion7Yq1df6O3WV7KRJ2f7PlzvWCgHT0ApcObmL/6BEFbWuNoDvjj/OT+LlubS
         Yg3g==
X-Gm-Message-State: AOJu0YxROWx1xsxsuTX0xmijaolyyfprDnO9ajeqaYbMTCPR6YvFxRFx
        GcyWJccXCwH4NEuXrxvYt+mRR562lyJyQNaiwaA2EQ==
X-Google-Smtp-Source: AGHT+IFDrx5gLOZ18cjfQa+q7nuirjsCz4WSOfLoXZDh9drjy333lH0vXwkgc31jA3rKTDQaNHGZ/fUC+289v/9JGrk=
X-Received: by 2002:a05:6512:234c:b0:4f9:5933:8eea with SMTP id
 p12-20020a056512234c00b004f959338eeamr9070237lfu.3.1692100321940; Tue, 15 Aug
 2023 04:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230814180921.3336-1-aboutphysycs@gmail.com>
In-Reply-To: <20230814180921.3336-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Tue, 15 Aug 2023 14:51:50 +0300
Message-ID: <CAH3L5QqCOUYm31MNRgZEXG8qvqexOmuG0E=we4k4hyEe1+FTiQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: generic-adc: removed unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 9:09=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/thermal-generic-adc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/ther=
mal-generic-adc.c
> index f4f1a04f8c0f..1717e4a19dcb 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -142,7 +142,6 @@ static int gadc_thermal_probe(struct platform_device =
*pdev)
>                 return ret;
>
>         gti->dev =3D &pdev->dev;
> -       platform_set_drvdata(pdev, gti);
>
>         gti->tz_dev =3D devm_thermal_of_zone_register(&pdev->dev, 0, gti,
>                                                     &gadc_thermal_ops);
> --
> 2.34.1
>
