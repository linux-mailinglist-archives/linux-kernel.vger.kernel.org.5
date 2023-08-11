Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E694778734
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHKF7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:59:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D72722
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:59:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe55d70973so1907936e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691733579; x=1692338379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwIEg6s/orCxGs+9VesvS+BV/VFnW9UqmoxlIM3Njec=;
        b=xg97r8zV1yri0k0ZIHpqldCLdk9AvK7kDVaPrDtBBWqv0UujeDFPr9D/vKLWwBUIDW
         b8jnUVBMwCxzCADrlKYs2lsEXa8x3vV1TRby0at564y7wuuGYZH0ZiaoG7eID61nxySD
         jIXNpK9axEgZr2e3KLQ45v1r/s3mD76FX8jQTtinElh5RGbJP8sTIhJjTwM4wJ4Xozr4
         6ncASVjTc83WI3zWxQooJPyMy/GaA2IWb1Kzx62K4q7vH5ZV7YWRlHS0/+LO/DjtAsaH
         cR/6ukpEkgj7fE7NVcNjG60ys+rs1/i8yQEAkSn0HMySo8/WOSPSRJ4d94Klw73TFEno
         BIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733579; x=1692338379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwIEg6s/orCxGs+9VesvS+BV/VFnW9UqmoxlIM3Njec=;
        b=Uk9HyV+zlz4XuSm9fxy+xZxYt9eiL4vKiyUrSH14evN7+bINXD7/idSCWo82fofxSi
         +vhsMs3IYeqvnjv8G0HPTDcekLZ0616fCqQyohxOuZcWS0C+0Is5cCt6CTYrzUdE3NVT
         iymvntW73y4gO5Sbjhztb7SFm0pntTQs1yTZJA0jsK92sRinEcxy2Q9h8S4B/ubb0sbU
         lk0xzwuNOocrx8nQXWUBiFxTlpPE94oB2nVJfHu7f+m/yeXSebefwPUQ0ieNCDbBU25E
         S1mzF3XnfS/qp2F4Wzb0Q41fbLsPigfSgp/JxUpIZBCCBuqTbcjTt2S6XKEXbIkP0Uds
         X5xg==
X-Gm-Message-State: AOJu0YzCVKAqjkD65/gv7727+x6LYtBKSKSxsqdoQRZE6dB5Y/90sL1o
        CI1ya3nUEcAgOi01TqLixDvMptF2XfRf/D1lxt2ueA==
X-Google-Smtp-Source: AGHT+IGVqjloDcyp79PYJ4Qbn7CoKvcAcik2kuJgWXt9PRPiIb5obernd9RSwDNaSkP1vmsWhdNdrIFy4GgP3H64j2w=
X-Received: by 2002:a05:6512:2829:b0:4fe:e8c:6f31 with SMTP id
 cf41-20020a056512282900b004fe0e8c6f31mr376555lfb.2.1691733579386; Thu, 10 Aug
 2023 22:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230810112344.3806-1-aboutphysycs@gmail.com>
In-Reply-To: <20230810112344.3806-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 11 Aug 2023 08:59:28 +0300
Message-ID: <CAH3L5QpyQejK6H_FDW1akzd8Tn3T0WbKHsKEbmHcA2R9y+W2cA@mail.gmail.com>
Subject: Re: [PATCH] thermal: k3_bandgap: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:23=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
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
>  drivers/thermal/k3_bandgap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
> index 1c3e590157ec..f985f36f2123 100644
> --- a/drivers/thermal/k3_bandgap.c
> +++ b/drivers/thermal/k3_bandgap.c
> @@ -225,7 +225,6 @@ static int k3_bandgap_probe(struct platform_device *p=
dev)
>                 devm_thermal_add_hwmon_sysfs(dev, data[id].tzd);
>         }
>
> -       platform_set_drvdata(pdev, bgp);
>
>         return 0;
>
> --
> 2.34.1
>
