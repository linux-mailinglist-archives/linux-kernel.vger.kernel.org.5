Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5D806B52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377398AbjLFKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377379AbjLFKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:08:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54BB120
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:09:02 -0800 (PST)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D5063F15F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701857340;
        bh=AqWoFNYysK0tdV0YeJun1QToBYa0Z8FAZWlnxm20ym0=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=DwjNPhfZjZKQJ+pkntTst/oUdOJNFj/v5hkG3IaDEMxg5WZoxj4DPbpxnZUPIWnsR
         05Yde7hc9lOlRToLx2H9nF+XXLJVlf8HD0G6bjmq3bSO6uh3L9Fu3woVSie3yCo7Fb
         uiUYFLxyjFD/t9pLvVoUs9c1pQdyPwtMNWzFDWMXpNNyxuCKa80lw80ZnZlAk/2XlA
         hbicQ5ZqcXB6AVFWc60TnWxH51pnlAl93YSAOn63JucRvbGjIZb12zRw632hOPRczx
         ZWbnQVEUhsIXEA43mzHw+dRnmZ6OZthy3qeJEnXeRluPk0iqHrR05gzPGAmPaYCS/E
         GQnEWYOgj4AhQ==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bf273aa74so2863492e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857340; x=1702462140;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqWoFNYysK0tdV0YeJun1QToBYa0Z8FAZWlnxm20ym0=;
        b=Tyq292tC8aFSAz3F1KVbQxPB330a5uM2MlAf689Uj4B04s/zRk7Ubwt6O0debsqG35
         ijrSIeoyoMHI8ERB1RKDBz2J4Z3b39c8Plob+OzsVJ2Z2Cf4iR5hID4HAtsSwjGCYuQh
         AsC6Xcr5EsetMoBiDxc9yj1hUj3VGXoTIlpSXv5ThE3oimn8ylrOnmDQ7+hQdFSfE4OZ
         5i6pdU+q5Vpw7pS197xY/5abMpdDUIn8hu9GqH2gAJ5Bk4SseCfPuJlL5EYCb/jyuPxz
         aFtXFrQ3vcYtJIgT2X86jAO7amXP68nUJDCiq6NqZs975xvAoda2NlB09Sed6uu0hXOI
         Oitg==
X-Gm-Message-State: AOJu0YwJeeJDRlDLsU5vUOHb6XPHzYWP0J1//97b9Qtejox960N/av18
        bEk4/31cNT/8JVCg3jzUgy6MlxgGITBklQ+1gDD9pcpA3wdupJ1ZFLJbMyE97ADXsrYv2xE/7fN
        Gbz9FE/lj5ujRiJJps53mIoo5C4R+Tpe23efhDw79l2XRSDRqB0kmCRRPGA==
X-Received: by 2002:a05:6512:5d7:b0:50b:f32c:4d with SMTP id o23-20020a05651205d700b0050bf32c004dmr387788lfo.136.1701857339886;
        Wed, 06 Dec 2023 02:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdJQnx21lgo677Y/w22hAazVC3Yypb1Mi9jGIFZ5ofssNYc7Abs2AMBwvoktWnU2ZF6MV9GexmQoAcnQyWfbI=
X-Received: by 2002:a05:6512:5d7:b0:50b:f32c:4d with SMTP id
 o23-20020a05651205d700b0050bf32c004dmr387775lfo.136.1701857339589; Wed, 06
 Dec 2023 02:08:59 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Dec 2023 04:08:57 -0600
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-1-69220e373e8f@baylibre.com>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com> <20231206-th1520_mmc_dts-v8-1-69220e373e8f@baylibre.com>
Mime-Version: 1.0
Date:   Wed, 6 Dec 2023 04:08:57 -0600
Message-ID: <CAJM55Z_sG2CFZo_MmeTCVz43rRBi9cbjajprWM8MspMZuF9tEg@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
To:     Drew Fustini <dfustini@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Fustini wrote:
> Enable the mmc controller driver and dma controller driver needed for
> T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
> boot from eMMC storage.
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 905881282a7c..e635dc9d1997 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -214,6 +214,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_CADENCE=y
> +CONFIG_MMC_SDHCI_OF_DWCMSHC=y
>  CONFIG_MMC_SPI=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_STARFIVE=y
> @@ -223,6 +224,7 @@ CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_DMADEVICES=y
>  CONFIG_DMA_SUN6I=m
> +CONFIG_DW_AXI_DMAC=y
>  CONFIG_RZ_DMAC=y
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
