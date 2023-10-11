Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5577C525B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjJKLp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJKLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:45:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA6E8F;
        Wed, 11 Oct 2023 04:45:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51DC36607312;
        Wed, 11 Oct 2023 12:45:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697024720;
        bh=TWolS2D3X/ecYXpEbYexeXAOoxmkjgrzjgbeeYp7+QQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fiZV9zz4S/NyzVmT6m4f1Vkd3JpB3DJbxhmxSh8bQ84PXA9q01KCyIIjOiBex8Z+j
         /6+M3rLtg7kMOFwG4hvNXsAXEGMhTWz9NNUf9e6J7uU9Sn7Z21MQsbXi767QNjeWjS
         VpQflzGk5XqpwmZc3DQO0tFuyFGOGi8RdV45ktsxjj9zUi9Uk6/7Qzq0JH2TcZwM7h
         qe3SRyUgLvgde5m54wrQ5sMqnRyw6jColTLxVQrCqES4pVL4ueuplk2Cx2ACvO0oor
         OIe5ylyg2rpeuKZOlX7XvcrC/6Zupm84xAHb/km8YBTqDI8MCogim+COAftufaf/cs
         Twdpk0EbYAidA==
Message-ID: <bd71eb81-71c4-e2ea-aed2-9e6b57588592@collabora.com>
Date:   Wed, 11 Oct 2023 13:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 3/3] arm64: dts: mediatek: mt8195: add MDP3 nodes
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Nancy . Lin" <nancy.lin@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231011075031.30660-1-moudy.ho@mediatek.com>
 <20231011075031.30660-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231011075031.30660-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/10/23 09:50, Moudy Ho ha scritto:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

On a first glance, this looks good to me, but I need the dt-bindings to
be accepted to actually be able to review this patch.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 392 +++++++++++++++++++++++
>   1 file changed, 392 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 0bfaa6db59de..f75ed1d36343 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1960,6 +1960,115 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		dma-controller@14001000 {
> +			compatible = "mediatek,mt8195-mdp3-rdma";
> +			reg = <0 0x14001000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x1000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RDMA_SOF>,
> +					      <CMDQ_EVENT_VPP0_MDP_RDMA_FRAME_DONE>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +			iommus = <&iommu_vpp M4U_PORT_L4_MDP_RDMA>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_RDMA>;
> +			mboxes = <&gce1 12 CMDQ_THR_PRIO_1>,
> +				 <&gce1 13 CMDQ_THR_PRIO_1>,
> +				 <&gce1 14 CMDQ_THR_PRIO_1>,
> +				 <&gce1 21 CMDQ_THR_PRIO_1>,
> +				 <&gce1 22 CMDQ_THR_PRIO_1>;
> +			#dma-cells = <1>;
> +		};
> +
> +		display@14002000 {
> +			compatible = "mediatek,mt8195-mdp3-fg";
> +			reg = <0 0x14002000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x2000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_FG>;
> +		};
> +
> +		display@14003000 {
> +			compatible = "mediatek,mt8195-mdp3-stitch";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x3000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_STITCH>;
> +		};
> +
> +		display@14004000 {
> +			compatible = "mediatek,mt8195-mdp3-hdr";
> +			reg = <0 0x14004000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x4000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_HDR>;
> +		};
> +
> +		display@14005000 {
> +			compatible = "mediatek,mt8195-mdp3-aal";
> +			reg = <0 0x14005000 0 0x1000>;
> +			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +		};
> +
> +		display@14006000 {
> +			compatible = "mediatek,mt8195-mdp3-rsz", "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14006000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x6000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RSZ_IN_RSZ_SOF>,
> +					      <CMDQ_EVENT_VPP0_MDP_RSZ_FRAME_DONE>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_RSZ>;
> +		};
> +
> +		display@14007000 {
> +			compatible = "mediatek,mt8195-mdp3-tdshp";
> +			reg = <0 0x14007000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x7000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_TDSHP>;
> +		};
> +
> +		display@14008000 {
> +			compatible = "mediatek,mt8195-mdp3-color";
> +			reg = <0 0x14008000 0 0x1000>;
> +			interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x8000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_COLOR>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +		};
> +
> +		display@14009000 {
> +			compatible = "mediatek,mt8195-mdp3-ovl";
> +			reg = <0 0x14009000 0 0x1000>;
> +			interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x9000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_OVL>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +			iommus = <&iommu_vpp M4U_PORT_L4_MDP_OVL>;
> +		};
> +
> +		display@1400a000 {
> +			compatible = "mediatek,mt8195-mdp3-pad";
> +			reg = <0 0x1400a000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xa000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_PADDING>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +		};
> +
> +		display@1400b000 {
> +			compatible = "mediatek,mt8195-mdp3-tcc";
> +			reg = <0 0x1400b000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xb000 0x1000>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_TCC>;
> +		};
> +
> +		dma-controller@1400c000 {
> +			compatible = "mediatek,mt8195-mdp3-wrot", "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x1400c000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xc000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_WROT_SOF>,
> +					      <CMDQ_EVENT_VPP0_MDP_WROT_VIDO_WDONE>;
> +			clocks = <&vppsys0 CLK_VPP0_MDP_WROT>;
> +			iommus = <&iommu_vpp M4U_PORT_L4_MDP_WROT>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
> +			#dma-cells = <1>;
> +		};
> +
>   		mutex@1400f000 {
>   			compatible = "mediatek,mt8195-vpp-mutex";
>   			reg = <0 0x1400f000 0 0x1000>;
> @@ -2107,6 +2216,289 @@
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
>   		};
>   
> +		display@14f06000 {
> +			compatible = "mediatek,mt8195-mdp3-split";
> +			reg = <0 0x14f06000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x6000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_VPP_SPLIT>,
> +				 <&vppsys1 CLK_VPP1_HDMI_META>,
> +				 <&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f07000 {
> +			compatible = "mediatek,mt8195-mdp3-tcc";
> +			reg = <0 0x14f07000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x7000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_TCC>;
> +		};
> +
> +		dma-controller@14f08000 {
> +			compatible = "mediatek,mt8195-mdp3-rdma";
> +			reg = <0 0x14f08000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x8000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_RDMA_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP1_MDP_RDMA_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_RDMA>;
> +			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_RDMA>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			#dma-cells = <1>;
> +		};
> +
> +		dma-controller@14f09000 {
> +			compatible = "mediatek,mt8195-mdp3-rdma";
> +			reg = <0 0x14f09000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x9000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_RDMA_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP2_MDP_RDMA_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_RDMA>;
> +			iommus = <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_RDMA>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			#dma-cells = <1>;
> +		};
> +
> +		dma-controller@14f0a000 {
> +			compatible = "mediatek,mt8195-mdp3-rdma";
> +			reg = <0 0x14f0a000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xa000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_RDMA_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP3_MDP_RDMA_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_RDMA>;
> +			iommus = <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_RDMA>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			#dma-cells = <1>;
> +		};
> +
> +		display@14f0b000 {
> +			compatible = "mediatek,mt8195-mdp3-fg";
> +			reg = <0 0x14f0b000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xb000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_FG>;
> +		};
> +
> +		display@14f0c000 {
> +			compatible = "mediatek,mt8195-mdp3-fg";
> +			reg = <0 0x14f0c000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xc000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_FG>;
> +		};
> +
> +		display@14f0d000 {
> +			compatible = "mediatek,mt8195-mdp3-fg";
> +			reg = <0 0x14f0d000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xd000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_FG>;
> +		};
> +
> +		display@14f0e000 {
> +			compatible = "mediatek,mt8195-mdp3-hdr";
> +			reg = <0 0x14f0e000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xe000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_HDR>;
> +		};
> +
> +		display@14f0f000 {
> +			compatible = "mediatek,mt8195-mdp3-hdr";
> +			reg = <0 0x14f0f000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xf000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_HDR>;
> +		};
> +
> +		display@14f10000 {
> +			compatible = "mediatek,mt8195-mdp3-hdr";
> +			reg = <0 0x14f10000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_HDR>;
> +		};
> +
> +		display@14f11000 {
> +			compatible = "mediatek,mt8195-mdp3-aal";
> +			reg = <0 0x14f11000 0 0x1000>;
> +			interrupts = <GIC_SPI 617 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x1000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_AAL>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f12000 {
> +			compatible = "mediatek,mt8195-mdp3-aal";
> +			reg = <0 0x14f12000 0 0x1000>;
> +			interrupts = <GIC_SPI 618 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x2000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_AAL>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f13000 {
> +			compatible = "mediatek,mt8195-mdp3-aal";
> +			reg = <0 0x14f13000 0 0x1000>;
> +			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x3000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_AAL>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f14000 {
> +			compatible = "mediatek,mt8195-mdp3-rsz", "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14f14000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x4000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_RSZ_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP1_MDP_RSZ_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_RSZ>;
> +		};
> +
> +		display@14f15000 {
> +			compatible = "mediatek,mt8195-mdp3-rsz", "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14f15000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x5000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_RSZ_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP2_MDP_RSZ_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_RSZ>;
> +		};
> +
> +		display@14f16000 {
> +			compatible = "mediatek,mt8195-mdp3-rsz", "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14f16000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x6000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_RSZ_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP3_MDP_RSZ_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_RSZ>;
> +		};
> +
> +		display@14f17000 {
> +			compatible = "mediatek,mt8195-mdp3-tdshp";
> +			reg = <0 0x14f17000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x7000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_TDSHP>;
> +		};
> +
> +		display@14f18000 {
> +			compatible = "mediatek,mt8195-mdp3-tdshp";
> +			reg = <0 0x14f18000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x8000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_TDSHP>;
> +		};
> +
> +		display@14f19000 {
> +			compatible = "mediatek,mt8195-mdp3-tdshp";
> +			reg = <0 0x14f19000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x9000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_TDSHP>;
> +		};
> +
> +		display@14f1a000 {
> +			compatible = "mediatek,mt8195-mdp3-merge";
> +			reg = <0 0x14f1a000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xa000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_MERGE>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f1b000 {
> +			compatible = "mediatek,mt8195-mdp3-merge";
> +			reg = <0 0x14f1b000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xb000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_VPP_MERGE>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f1c000 {
> +			compatible = "mediatek,mt8195-mdp3-color";
> +			reg = <0 0x14f1c000 0 0x1000>;
> +			interrupts = <GIC_SPI 628 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xc000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_COLOR>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f1d000 {
> +			compatible = "mediatek,mt8195-mdp3-color";
> +			reg = <0 0x14f1d000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xd000 0x1000>;
> +			interrupts = <GIC_SPI 629 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_COLOR>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f1e000 {
> +			compatible = "mediatek,mt8195-mdp3-color";
> +			reg = <0 0x14f1e000 0 0x1000>;
> +			interrupts = <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xe000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_COLOR>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f1f000 {
> +			compatible = "mediatek,mt8195-mdp3-ovl";
> +			reg = <0 0x14f1f000 0 0x1000>;
> +			interrupts = <GIC_SPI 631 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xf000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_OVL>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_OVL>;
> +		};
> +
> +		display@14f20000 {
> +			compatible = "mediatek,mt8195-mdp3-pad";
> +			reg = <0 0x14f20000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_VPP_PAD>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f21000 {
> +			compatible = "mediatek,mt8195-mdp3-pad";
> +			reg = <0 0x14f21000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x1000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_PAD>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		display@14f22000 {
> +			compatible = "mediatek,mt8195-mdp3-pad";
> +			reg = <0 0x14f22000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x2000 0x1000>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_VPP_PAD>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +		};
> +
> +		dma-controller@14f23000 {
> +			compatible = "mediatek,mt8195-mdp3-wrot", "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x14f23000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x3000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_WROT_SOF>,
> +					      <CMDQ_EVENT_VPP1_SVPP1_MDP_WROT_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_WROT>;
> +			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_WROT>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			#dma-cells = <1>;
> +		};
> +
> +		dma-controller@14f24000 {
> +			compatible = "mediatek,mt8195-mdp3-wrot", "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x14f24000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x4000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_WROT_SOF>,
> +					<CMDQ_EVENT_VPP1_SVPP2_MDP_WROT_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_WROT>;
> +			iommus = <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_WROT>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			#dma-cells = <1>;
> +		};
> +
> +		dma-controller@14f25000 {
> +			compatible = "mediatek,mt8195-mdp3-wrot", "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x14f25000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x5000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_WROT_SOF>,
> +					<CMDQ_EVENT_VPP1_SVPP3_MDP_WROT_FRAME_DONE>;
> +			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_WROT>;
> +			iommus = <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_WROT>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
> +			#dma-cells = <1>;
> +		};
> +
>   		imgsys: clock-controller@15000000 {
>   			compatible = "mediatek,mt8195-imgsys";
>   			reg = <0 0x15000000 0 0x1000>;



