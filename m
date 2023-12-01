Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831EE800C72
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379037AbjLANpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379024AbjLANpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:45:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4E197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:45:04 -0800 (PST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A3764443E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701438301;
        bh=aIjaCW3pUrXp+pTpaK834thD0tFwpmqmqseWMXTUtMQ=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lJfVPYBMJyAwvJfqMZzEYJKspBsM6suBWYY0btqL9WHMBewzLbsrI/pWzADENo3lr
         gY4N2QKm1237X/3w0zzuyRw73RJ1wXbO9mytTSW/P6LNUwWwucOfw9+1T2zLj1Ihhf
         5DHt0AUk9Kh+AOZWsVtgYHg1I7yauNQnCQhnOJJFYbRQjpz0SAeKSw0+FY5Cll7omq
         fex1cwq578pEGOB2RlM1XtleKyHmFesBm7PsSNYfPJGmkhPxXGlYF2e5Qtv4E8vNgh
         8/1aUdKIU779z+5gJpdHao/4Eg/v7KPIuADuTnsA97nEhQ7rQAiW1pCTkh3XIRR0I2
         PFjKwkurrXgrA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-423e22075f4so24317761cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438299; x=1702043099;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIjaCW3pUrXp+pTpaK834thD0tFwpmqmqseWMXTUtMQ=;
        b=o8X0xF0uU+l9H34+iSo6m5X5DMGY5+0U33ef7/B1v0CzOL0K1GdF2GJ362843RIZDl
         rmPIqf6NY430wfTn6LjDEbXEciTd5oYKUO4FmU6BQuh/+5Q4T/6095XjuW8cz8uoBhE9
         /FABxxhAVE231csPznNpwZEA4zUz5ite6SGLkB1SIIStIMWH4YiWAdoZJueWkL7JaySp
         oDBYT89nUE4srzO4DQvEo5sZUwUi22RfHBz5NCgLghN5QIpmgpPSCSB+sPeC9cHaOuHb
         bVtENMaQvuzCeWnmaXKd7T4qrrLrevPQVL/jRZSblvgfdFnW7wrdAX+4TSc4JxDlZ1kM
         1T7A==
X-Gm-Message-State: AOJu0Ywq31v0RmhQ5yVejroT18OCW7BDF/dkEn5SB8N1CvJPk+X5tNLP
        tdX628nH6+CzoF3g+jSy1WWoh5Z6M7YMLQq/BYxqpi+efNrTk4ZVHpEjENlhuUlmKNZaMhXF5he
        yMPRMTW4CWaWK+NhIrX7R0twEetQc5sAfEOtkOlRjeN1oaJ+yH92vawOnfw==
X-Received: by 2002:ac8:40c1:0:b0:423:a89d:df9c with SMTP id f1-20020ac840c1000000b00423a89ddf9cmr18751999qtm.60.1701438299402;
        Fri, 01 Dec 2023 05:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHu8/CBHAQYpaT2ANfVt7np+IE7Kk+pb17J4F9RrGzYnoZjQle0hRYNK96EYSsKkM1msPRiaodJCBtMDr0rLA=
X-Received: by 2002:ac8:40c1:0:b0:423:a89d:df9c with SMTP id
 f1-20020ac840c1000000b00423a89ddf9cmr18751983qtm.60.1701438299151; Fri, 01
 Dec 2023 05:44:59 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 14:44:58 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231130-bobbing-valid-b97f26fe8edc@spud>
References: <20231130-bobbing-valid-b97f26fe8edc@spud>
Mime-Version: 1.0
Date:   Fri, 1 Dec 2023 14:44:58 +0100
Message-ID: <CAJM55Z9=smqcZ=su1oNdk1YZL_XdYAKrwtrZS7ScS=cAVmxZOA@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: move timebase-frequency to .dtsi
To:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Properties fixed by the SoC should be defined in the $soc.dtsi, and the
> timebase-frequency is not sourced directly from an off-chip oscillator.

Yes, according to the JH7100 docs[1] the mtime register is sourced from the
osc_sys external oscillator through u74rtc_toggle. However I haven't yet found
a place in the docs that describe where that clock is divided by 4 to get
6.25MHz from the 25MHz.

I expect the JH7110 mtime is set up in a similar way, but haven't yet dug into
the available documentation.

[1]: https://github.com/starfive-tech/JH7100_Docs/blob/main/vic_u7_manual_with_creativecommons.pdf

/Emil

>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I actually have no idea whether this is true or not, I asked on the
> jh8100 series but only got an answer for that SoC and not the existing
> ones. I'm hoping that a patch envokes more of a reaction!
>
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: Conor Dooley <conor@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Walker Chen <walker.chen@starfivetech.com>
> CC: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100-common.dtsi               | 4 ----
>  arch/riscv/boot/dts/starfive/jh7100.dtsi                      | 1 +
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ----
>  arch/riscv/boot/dts/starfive/jh7110.dtsi                      | 1 +
>  4 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index b93ce351a90f..214f27083d7b 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -19,10 +19,6 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>
> -	cpus {
> -		timebase-frequency = <6250000>;
> -	};
> -
>  	memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x2 0x0>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index e68cafe7545f..c50b32424721 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -16,6 +16,7 @@ / {
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		timebase-frequency = <6250000>;
>
>  		U74_0: cpu@0 {
>  			compatible = "sifive,u74-mc", "riscv";
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index b89e9791efa7..7873c7ffde4d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -26,10 +26,6 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>
> -	cpus {
> -		timebase-frequency = <4000000>;
> -	};
> -
>  	memory@40000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x40000000 0x1 0x0>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 45213cdf50dc..ee7d4bb1f537 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -18,6 +18,7 @@ / {
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		timebase-frequency = <4000000>;
>
>  		S7_0: cpu@0 {
>  			compatible = "sifive,s7", "riscv";
> --
> 2.39.2
>
