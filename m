Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89776BDAE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjHAT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHAT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:26:05 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56B9C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:26:04 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7996fe1c31bso2116675241.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690917963; x=1691522763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNDuhFBmOBy6HBRsVeTwL0kBK/jzCbQEkNUhhf47v6E=;
        b=WTsz+mTe7ZNdYs5ny0jxQdgajttapEQSUzmGnFmB0b9gdw7i8MfeBAbmMYq4RPNQnc
         9Pe3mpWJavg0DRjgtGGn0WMkOiMFBzubJ5bfiA0QCq1t804DOt8CAm2M16AQaddlVcru
         U99sc31MhftfhBfz74endDzUKJlSDvW25FjxBFEXfVDV/EUow1mTIfCM3uyff6S3oXws
         z1UQWlCWI8u1nhz8oc2f68jI/jFxNPiArZaumQyEwNG42SUvo2OLFtijgFR/jcCHpDkm
         goVO8YSFN6/r4aWEjlWakpgnTZQR3nwZnsw5n1AgJPlAgLXfOAudKy9C+PCWCGOyLKEM
         FqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917963; x=1691522763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNDuhFBmOBy6HBRsVeTwL0kBK/jzCbQEkNUhhf47v6E=;
        b=YLeEq/GJ2mFmO84ib+lCluGvLvjFBUtHv16qELBLGZGMEHKfiNGt3E4cudeix0Stql
         5sEMhZQraPjUgUxOy8jC/RreC2FbHdaWdqoidGiYTXb+girZftgTU5ipZ14RFVFCqpuv
         pnbZ0iyYKU6V+TD6KXkjRTdrcEgxK9sXXgHlgt0WinC9Br/yoVLx2XRsV0sqsYLlZ134
         T9YISBJXLWzFQrWPcfMPhSwF5JaSHnOs+otXlUlbdRTSPku2KqLUKWCj1+c9N3oUU/sX
         uY7nyddOMA1gUhVuFmCOZ7MK31lHg8i8H7r3G8KUvIlp48GZMUpa4cFehDFPiWdhWslI
         3qOA==
X-Gm-Message-State: ABy/qLYhSZI9aIbj4C3ACwPhE5xCZkEphHfJwT3jRn9yNp4pSveqTFPC
        49vboSruAx17uKShHv+0YRRRs6jeklblxi1/16Jtww==
X-Google-Smtp-Source: APBJJlE6M5JPiyLpacdGzzNbw1Wmg1Md5aj6oBT2iVT+XZjCIIm5PgdA+xvnKEvikGSgj9783L+TZVnzZ2KJCI6+QZM=
X-Received: by 2002:a67:ea8a:0:b0:443:7787:8333 with SMTP id
 f10-20020a67ea8a000000b0044377878333mr3350328vso.8.1690917963201; Tue, 01 Aug
 2023 12:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230728180833.18399-1-aboutphysycs@gmail.com>
In-Reply-To: <20230728180833.18399-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Aug 2023 21:25:52 +0200
Message-ID: <CAMRc=MdMnYcw5SsP+_Obt642S_Coi7miLEGCRbR0M37m8Hj+GQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pmic-eic-sprd: remove unnecessary call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linux.alibaba.com,
        orsonzhai@gmail.com, andy@kernel.org, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 8:08=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
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
>  drivers/gpio/gpio-pmic-eic-sprd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-e=
ic-sprd.c
> index c3e4d90f6b18..bfb003ccbd99 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -363,7 +363,6 @@ static int sprd_pmic_eic_probe(struct platform_device=
 *pdev)
>                 return ret;
>         }
>
> -       platform_set_drvdata(pdev, pmic_eic);
>         return 0;
>  }
>
> --
> 2.34.1
>

Applied, thanks!

Bartosz
