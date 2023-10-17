Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A207CBDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjJQIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:38:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3BFB;
        Tue, 17 Oct 2023 01:38:26 -0700 (PDT)
Received: from [IPV6:2a02:2f04:a37:9d00:b380:eb44:83c6:6b95] (unknown [IPv6:2a02:2f04:a37:9d00:b380:eb44:83c6:6b95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 845E46606EE0;
        Tue, 17 Oct 2023 09:38:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697531905;
        bh=BSMLjbZcuwNhTxKRB4oqXbZT9i1jbW/ydiS26D4uPQo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YccWFxDrI8/xGCFcYHGPIGLkbs3FwJSrgHRhoi/litiDLuS1CxIw4ySYdnuJ8lItu
         WzDLqQC3CRZtWwaLBfTSnbQJBLym84QrfASDpyxRuuXL2bsqz+M7kG7M0kbHGjbLwf
         dLUkSDFMW/FkEQT064gjl3eyspBjwHgrkCUJl94+POe+wGE+XGg1KGty/TPJ87R4q5
         MYRT95fAvjchdgY/66rT1FDXzl7Dlbg9fO1NO1Fw16lczTXnINqM1qAjKwlhsaWC+A
         HWPHkMPr3wXb+woclNkb0EuKT+/OYEWA4bha8ZmCoIXVAxX94RaNKNhzVIE36vk3xN
         pn0TCXNIllB/A==
Message-ID: <ecd6a00f-2166-48b7-a6ae-e165a2a6d70b@collabora.com>
Date:   Tue, 17 Oct 2023 11:38:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230921060235.32478-1-jason-ch.chen@mediatek.com>
 <20230921060235.32478-5-jason-ch.chen@mediatek.com>
Content-Language: en-US
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230921060235.32478-5-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 09:02, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8188 on evaluation board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 400 ++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 951 ++++++++++++++++++++
>   3 files changed, 1352 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> 

[...]

> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {

Hi Jason,

arch/arm64/boot/dts/mediatek/mt8188.dtsi:320.37-341.5: Warning 
(avoid_unnecessary_addr_size): /soc/interrupt-controller@c000000: 
unnecessary #address-cells/#size-cells without "ranges" or child "reg" 
property


This warning pops up when trying dtbs_check.
Can you have a look please ?

Eugen

> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
> +				};
> +
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&cpu6 &cpu7>;
> +				};
> +			};
> +		};
> +

[...]

