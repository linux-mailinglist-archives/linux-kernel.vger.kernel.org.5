Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78497AB61E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjIVQgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjIVQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:36:17 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E907197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:36:10 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29D1B41DBF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695400569;
        bh=RKbV4MhZk6b87JTksm1ZK/ObuKYUjj6Uoe+MaWe9BjM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=axOpRfO6PfpGE2I6/iuXN+52W8z6r6OeH/Putaats6zPZaj53Dvhp17aXUAxdRWu5
         ARyhyDJlAy011T75vqdIstcXohjwNuE9NJ9/BpiHYEW6ha3abGBvVcGCHJrWuavJEa
         jVYe0AFjuoVvx7rU67/b4DN27aK83U1cNEBEeDRWRyuYHn+7gH2sRxc2z1I80LH+w4
         viJhXqHe8vZHK1y2X6YfIaMHNjgvb5z4BKvbwJEUxts/BsRziTfGT+cOzHhaN6vJ6f
         woJCMZ/C4mmJlSBFEpZYV+aM8kPzQg2knJFvvu+u4XUy5/WwCXGt8G6f369VYTh8dD
         ri+78Vh6Q3YJQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-412eee4b64cso24925961cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400568; x=1696005368;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKbV4MhZk6b87JTksm1ZK/ObuKYUjj6Uoe+MaWe9BjM=;
        b=Zi6L0YC7JfmxMZbyrn8OsCgN1jNvuCdcAQCjr0Pgmz5dGbOOitpDeOcPl79XvY7YL9
         3MXb5z3etYFm7IpFo0vJWBpsrVpKkuyi5PCKjHODzJXY9e1KLCG1RcpeuOA+Cmvh6H1v
         5F3u0y8LIgSTqJui4PfAdpG5Kc/kXXW+OCN7rRLLxOLgV4C6rbTFJrzpRm+1unQ2CjUI
         MbPipBb1+H/YzWmFaZ+Q/ZcpvPOzvuHMAdbMAQ5V0nKeouWh9CABqyi3wvVcrFfLnBt3
         AmfuR0pWJJKnka3X8FpBBFbwmPZYourBJYs1j8EBo0eN+h24GZ1tqmNt46lFAxC7aZf1
         dIQw==
X-Gm-Message-State: AOJu0Yw4t+fO/A1ymArnxPZOcoh4iY+//Y+ZmAzAZ1mmEvMvReoX7HU9
        enkGt/Hueb/mXw/ldXN4FB0/tTCPhMSAZ5G0FNcbnbNcriu4hHGA3UTfm48v7ENazf4zHGZu+Dy
        nuZ7TmPpZxVVYELS5JY8imfh0DKM1ClRb+9nqke4YKCviGZ3XJCj5IFT7bg==
X-Received: by 2002:a05:622a:1a9b:b0:400:9c4e:2abe with SMTP id s27-20020a05622a1a9b00b004009c4e2abemr9153636qtc.13.1695400568117;
        Fri, 22 Sep 2023 09:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtMOJCOBegPGfmaYPe4P541XIPb9WGKoNNQRopHdNvUyr6IlUhMeHDT069xvrKjurwJHkDV/lgU//1vjPUCGw=
X-Received: by 2002:a05:622a:1a9b:b0:400:9c4e:2abe with SMTP id
 s27-20020a05622a1a9b00b004009c4e2abemr9153614qtc.13.1695400567857; Fri, 22
 Sep 2023 09:36:07 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Sep 2023 11:36:07 -0500
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230922062834.39212-4-william.qiu@starfivetech.com>
References: <20230922062834.39212-1-william.qiu@starfivetech.com> <20230922062834.39212-4-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 22 Sep 2023 11:36:07 -0500
Message-ID: <CAJM55Z-huG6KSLywzA0Zih=MtzqvL0w+CxrqN7CKUrzor_A65g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add assigned-clock* to limit frquency
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

William Qiu wrote:
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Thanks!

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index d79f94432b27..d1f2ec308bca 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -205,6 +205,8 @@ &i2c6 {
>
>  &mmc0 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> @@ -221,6 +223,8 @@ &mmc0 {
>
>  &mmc1 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	no-sdio;
>  	no-mmc;
> --
> 2.34.1
>
