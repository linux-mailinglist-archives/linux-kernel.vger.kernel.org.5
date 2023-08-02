Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4476CCD3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjHBMhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjHBMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:37:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A726AF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:37:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso454412e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1690979834; x=1691584634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbOtrbuAbCVZChFvcVrSuATOys/C2fprGpeUD9URBHg=;
        b=QRO9Nxa1SiODUkYydluq+gWpZ7lZ4XtHwTuzFSmZAxcvSEOXaPNKSd0GU9Xf8+SG/+
         5jHKrezoWOdT8A59vVUo/48L1hVgSbYcSBkDf/IjVovPMZp5WW5oSMcl6ULsMEaKFhXI
         5r36JgkUedq4jVrtbcLTjUtCFLZXqEiMQ+hq1Yo9JkCBfArXgXMitEiCxmpI9DJnFMxM
         0KZPyDGh6ei2tbkA2duXrB5Sf7utXuFg8CazYqjnLCU1fY2A6mMAbNcgGMtzrkcvH19+
         BKBu8/hfAxmkDKwoMb5W2JxkPFhuNhhJAet7izdaXPJXFFC/DFb4Iv+NvGOdGtTYQ0U0
         HYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979834; x=1691584634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbOtrbuAbCVZChFvcVrSuATOys/C2fprGpeUD9URBHg=;
        b=kJaSeISJ6HTibuT4NJ7z3JVA0qA6EL4VkYtsNLtqsrlvRufSq+HtgkS6WMd1S970nB
         S5tm4v+eP6Ir6lO8Bb3EYjHRAdZc1iZhCM/xsTEmq3NPq9DS4R99O9CaaR1ilSWBU/s9
         gZFmfWqRa6FfbutKNQVYh4QF+xVlzo6yja42odJuKKK834o42AFIY8G1ieXZauClww1v
         nZNwxuDl2RE820CIuv6WFMSJFE2CiZvGrGv7iWs8qP8RikLZG7Zu92KKEOwj4Ru/hYA4
         EM2vcvIiwxqFicHwxFPdu410LTaknP7kQEbo4RIfJekRFV10g9MkrFtHxwt0+COYirzW
         twRg==
X-Gm-Message-State: ABy/qLbAogKcosJC14smONfI2jNJ/e+97nyWz4t45Yntm/xhQoNsLoUr
        VsoA5fFSdJhBnyGxiDnNwNWuGWT/f6lY+lYCpyabjQ==
X-Google-Smtp-Source: APBJJlGPcZH9vNmqB+R7XZfYsW3LGvr8Ed/uiifd4Mh50scxNI/J+i41X6mfphDAdRHRWKO0PLYVyMZqq/CNNewyYpg=
X-Received: by 2002:a05:6512:70b:b0:4f8:6833:b13c with SMTP id
 b11-20020a056512070b00b004f86833b13cmr4141389lfs.14.1690979833551; Wed, 02
 Aug 2023 05:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230802120915.25631-1-aboutphysycs@gmail.com>
In-Reply-To: <20230802120915.25631-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Wed, 2 Aug 2023 15:37:02 +0300
Message-ID: <CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 3:09=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/iio/trigger/stm32-lptimer-trigger.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/tr=
igger/stm32-lptimer-trigger.c
> index 2e447a3f047d..df2416e33375 100644
> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> @@ -92,8 +92,6 @@ static int stm32_lptim_trigger_probe(struct platform_de=
vice *pdev)
>         if (ret)
>                 return ret;

this can become now:

            return stm32_lptim_setup_trig(priv);


>
> -       platform_set_drvdata(pdev, priv);
> -
>         return 0;
>  }
>
> --
> 2.34.1
>
