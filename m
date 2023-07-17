Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB447569E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGQROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGQRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:13:43 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D00E43;
        Mon, 17 Jul 2023 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=I1IBVkksfG+qQKrTGDGnSHsQlmlbsma3MfWiTgZTY6Q=; b=WgcaRL2JCPPRtYMOzHVIebs+X/
        pSd/CNjzFIkV8z2rzh68t+tmKHzKfkwBTQpFpUfp7bhJHRpXzBqLbgWGYtYrxdIgN78mvXsq/NpwJ
        jYfAzYIIXYwgwqKquOFGD51QOX3z4bn91kzibs5kdaMePpFqRe5JyCKadAV/I4XvVSqW9Y8A8U0AE
        VPDhD4y7A3FAk7SPqFlpSAPtoUBiRm3ImRrPCdrkW2rKh7CKKuAD34dJURw7cJRugluO6Bz7RWcNB
        lf8UrLppn8TFn9NOzLxYADjzVgRKBGeATTh9qVqUilhBWsDL5urmRIXGimUYSMWovSOXGvT0p3EfW
        2B4UJDMQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qLRmy-00AkKP-0S; Mon, 17 Jul 2023 19:13:36 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qLRmw-009E8k-21;
        Mon, 17 Jul 2023 19:13:34 +0200
Date:   Mon, 17 Jul 2023 19:13:34 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: Add QSPI controller node
 for StarFive JH7110 SoC
Message-ID: <ZLV2vqycWIA5TanD@aurel32.net>
Mail-Followup-To: William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-4-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704090453.83980-4-william.qiu@starfivetech.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-07-04 17:04, William Qiu wrote:
> Add the quad spi controller node for the StarFive JH7110 SoC.
> 
> Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 2a6d81609284..983b683e2f27 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -126,6 +126,38 @@ &i2c6 {
>  	status = "okay";
>  };
>  
> +&qspi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	nor_flash: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		cdns,read-delay = <5>;
> +		spi-max-frequency = <12000000>;
> +		cdns,tshsl-ns = <1>;
> +		cdns,tsd2d-ns = <1>;
> +		cdns,tchsh-ns = <1>;
> +		cdns,tslch-ns = <1>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			spl@0 {
> +				reg = <0x0 0x20000>;
> +			};
> +			uboot@100000 {
> +				reg = <0x100000 0x300000>;
> +			};
> +			data@f00000 {
> +				reg = <0xf00000 0x100000>;
> +			};

It appears that this uses the old layout for the SPI flash. The new
layout is described there:

https://doc-en.rvspace.org/VisionFive2/Boot_UG/JH7110_SDK/boot_address_allocation.html

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
