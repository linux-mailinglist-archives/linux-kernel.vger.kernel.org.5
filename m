Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5278994A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjHZVvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjHZVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:50:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84444CC4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:50:45 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F221F3F65D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693086643;
        bh=VjTIpaKc3M9gQ6muJD7ayrAgi+ZhVB11zZBZ8oimfFg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q9VrHbf6IT0Yw68n55/HpfW8GkEnYfTztXHhSfNrpTdOFCDMIcQCNyyfqdheXMOuV
         9OwnfwmJqpskMb0w0e5fSzelxg6E0USiHFdPjUld25U1A5Fout1PzidK0Vg8rYmdfg
         Q9WwUxyP18KeZB+GcqxWcIG7KidmHWxXNq6LD+OHH93GDhMeiWgBgafu6YKUsNlRzD
         AWSGozJchS4Wuj3Vdu20LdrtRgb9V4WtPlYPeuBoatoTAXBFos2wnJIpRfYNEFmcAS
         TtYaITjwtibIqs3OwaciQYWHS+evXsaYg9QQvTJCZVpDFOlsE6eFBrmxww2eMG90Jh
         Ny0X8EBBndHdg==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40ff67467c9so21598131cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693086642; x=1693691442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjTIpaKc3M9gQ6muJD7ayrAgi+ZhVB11zZBZ8oimfFg=;
        b=B2XNi5+aDDTltUIhrdHlQ3tLNJ8OtCnv2csQha5SRsGHRRDOA2njBH2OK8rD5W+j2p
         Mmk3a+ohVKlaXr6Cl0hphrj6A2TF2ZeEhCo36RQt5d/4Nd3G3qzXVUPVukhFr2LwRiAK
         wYMuvMhGsDdJN5fdn3hhyTrgDD/OFC5EA2VwF/zQfZhMhTwa4fTitnBclf8bAfSyrWpC
         M2VOEDxVDwliFlCUVBzoDFK+22X+HJqUqwz+RI9FBpSfftjHxpWgGJG5Wm6kKSG0g/S2
         GepnEXG13hCRPvhbObDlMWkQPZtmaLpcP6eLvLeHUn+TB0nqQyhSWJ1zLfu4EjHMsPpq
         Yd2Q==
X-Gm-Message-State: AOJu0YyvV62tQYqeNFYxBNGcaV/60O4EkOcLW9o/af3BOpG2GWpX1+Ws
        TxBnr6G/uMJAwrz1WzK/t/7gE9DAqP66CJ11+DaEgTt1iJ2S1rlMOuY+QNZ/EyhyefMS44TZQtG
        npqC2UlPg1mSy+hGunBy5VMJrppSZ0lsC10CS9m7TNnFbU7n5LVo/li2qKQ==
X-Received: by 2002:a05:622a:118c:b0:412:bea:af8f with SMTP id m12-20020a05622a118c00b004120beaaf8fmr7293527qtk.23.1693086642736;
        Sat, 26 Aug 2023 14:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnBLfcky1Z5PXKn1SUBVQjv9ZgfioMwralikcznERsXZJGRRjNVz25sqDnqt9XYzbuahJwL0KTCDKt/yzCUAg=
X-Received: by 2002:a05:622a:118c:b0:412:bea:af8f with SMTP id
 m12-20020a05622a118c00b004120beaaf8fmr7293510qtk.23.1693086642493; Sat, 26
 Aug 2023 14:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230826182702.2641743-1-aurelien@aurel32.net>
In-Reply-To: <20230826182702.2641743-1-aurelien@aurel32.net>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sat, 26 Aug 2023 23:50:26 +0200
Message-ID: <CAJM55Z8zsfywScSeoSyKogAJZndKuPTF+_4GGd9+9ZcYraqLHQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: fix NOR flash reserved-data
 partition size
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023 at 20:28, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> The Starfive VisionFive 2 has a 16MiB NOR flash, while the reserved-data
> partition is declared starting at address 0x600000 with a size of
> 0x1000000. This causes the kernel to output the following warning:
>
> [   22.156589] mtd: partition "reserved-data" extends beyond the end of device "13010000.spi.0" -- size truncated to 0xa00000
>
> It seems to be a confusion between the size of the partition and the end
> address. Fix that by specifying the right size.
>
> Fixes: 8384087a4223 ("riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC")

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 498eb179d90f..30c85ba6da02 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -262,7 +262,7 @@ uboot@100000 {
>                                 reg = <0x100000 0x400000>;
>                         };
>                         reserved-data@600000 {
> -                               reg = <0x600000 0x1000000>;
> +                               reg = <0x600000 0xa00000>;
>                         };
>                 };
>         };
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
