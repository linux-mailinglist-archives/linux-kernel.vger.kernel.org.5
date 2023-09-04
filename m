Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18300791C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbjIDRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjIDRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:48:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91E0DA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 10:48:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so17427435e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693849709; x=1694454509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aos/hZG2kxxhYMB7Cd7Cd6lWeMYzVwziNvlCKk5Ckbo=;
        b=XsrYlRRd52rQNQ5rzBtEDKv5ZkEEkcnLpM7Em68LGMYQSlB72PdrANRBH0M6mJMb8U
         4sgogmbIbhorX4AoKeoEh4tFDYVF5SPC+BeluAhdWRnKHMHtQEmBl1YWbMivWna4DNdW
         oVhwChBn4DMpcKQWGM+V4aDnaXCrHwzBz2HWf0rVg420fsFhbBH9VdUERl9uBvejB+vt
         FsNNvl3d85tc1tE2lwwxqmTvfgMePJt2LLi/Ey+YErMmTa/e8o/gVTVNruOW2TctDQAe
         50uGlsfkqBXH0+SugTRrufSAPf+eK8SpwhT03J1deFDKQGnhP8RE0V7TDxQGT3bQAnoB
         jdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693849709; x=1694454509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aos/hZG2kxxhYMB7Cd7Cd6lWeMYzVwziNvlCKk5Ckbo=;
        b=HpgWIG/T4qz16iEI1JYF46CsF0nyZ80YzoPRjsN3Fja/fnZgp97WuA7N1d/0Uny/cq
         TtoO1lbhZXV1O6DiGKOYgek/nqLPwv3mHBBT9klg0TNRGS0p6Qn4yQtl/FlBLuTJwl/v
         iLY+AZhHHjbvsAZwvrRPnkvNFleAIghaWp473H76aCjJWVLFE8EzwShQ/8VP55VehUA5
         Cdbry4Xwi9Maui2rfwcsmDvh2tdI3p97VkROiyShj3JD02p/OvNIhB1oGtLQwhvQccSe
         bHoUt4E4mu8CG/C7w9f9PcEAqPYo74kiGlmzopomtD8SQetu/6Jgm4BGoI0q/xip9u5G
         Msuw==
X-Gm-Message-State: AOJu0Yzl/trFcAMI5+De7Cu2IPhXRNtfo5dQ+WPDYUuwsUXn2cT7ASI3
        6ZPwfNdAGOZi39LaY7XqLDnudsAKjt5GnXUepNeU0A==
X-Google-Smtp-Source: AGHT+IEamhDEaqdCoqAZliBTHkbNtM/UPtdEvq3fI3mlDWHw8b6KVLBWzPs4O5EcVL5Mv8O73aLmGArMs289GH4AkPk=
X-Received: by 2002:adf:f7c1:0:b0:314:1ce9:3c86 with SMTP id
 a1-20020adff7c1000000b003141ce93c86mr8302488wrq.0.1693849709037; Mon, 04 Sep
 2023 10:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230901080935.14571-1-tinghan.shen@mediatek.com> <20230901080935.14571-15-tinghan.shen@mediatek.com>
In-Reply-To: <20230901080935.14571-15-tinghan.shen@mediatek.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 4 Sep 2023 11:48:18 -0600
Message-ID: <CANLsYkxhmY=TZqiyt=gr7JrQa2ZMgqjESeH0sx3orxK7CLN94w@mail.gmail.com>
Subject: Re: [PATCH v17 14/14] arm64: dts: mediatek: mt8195: Add SCP 2nd core
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matthias - will you pick up this one or should I get it through
the remoteproc tree?

On Fri, 1 Sept 2023 at 02:10, Tinghan Shen <tinghan.shen@mediatek.com> wrote:
>
> Rewrite the MT8195 SCP device node as a cluster and
> add the SCP 2nd core in it.
>
> Since the SCP device node is changed to multi-core structure,
> enable SCP cluster to enable probing SCP core 0.
>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      |  6 +++-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 34 ++++++++++++++-----
>  2 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 37a3e9de90ff..4584077d3a4c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -991,7 +991,11 @@
>         interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
> -&scp {
> +&scp_cluster {
> +       status = "okay";
> +};
> +
> +&scp_c0 {
>         status = "okay";
>
>         firmware-name = "mediatek/mt8195/scp.img";
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 48b72b3645e1..7809118f74fb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -922,14 +922,30 @@
>                         clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
>                 };
>
> -               scp: scp@10500000 {
> -                       compatible = "mediatek,mt8195-scp";
> -                       reg = <0 0x10500000 0 0x100000>,
> -                             <0 0x10720000 0 0xe0000>,
> -                             <0 0x10700000 0 0x8000>;
> -                       reg-names = "sram", "cfg", "l1tcm";
> -                       interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
> +               scp_cluster: scp@10500000 {
> +                       compatible = "mediatek,mt8195-scp-dual";
> +                       reg = <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
> +                       reg-names = "cfg", "l1tcm";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0 0x10500000 0x100000>;
>                         status = "disabled";
> +
> +                       scp_c0: scp@0 {
> +                               compatible = "mediatek,scp-core";
> +                               reg = <0x0 0xa0000>;
> +                               reg-names = "sram";
> +                               interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
> +                               status = "disabled";
> +                       };
> +
> +                       scp_c1: scp@a0000 {
> +                               compatible = "mediatek,scp-core";
> +                               reg = <0xa0000 0x20000>;
> +                               reg-names = "sram";
> +                               interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
> +                               status = "disabled";
> +                       };
>                 };
>
>                 scp_adsp: clock-controller@10720000 {
> @@ -2374,7 +2390,7 @@
>
>                 video-codec@18000000 {
>                         compatible = "mediatek,mt8195-vcodec-dec";
> -                       mediatek,scp = <&scp>;
> +                       mediatek,scp = <&scp_c0>;
>                         iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>;
>                         #address-cells = <2>;
>                         #size-cells = <2>;
> @@ -2540,7 +2556,7 @@
>                                  <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
>                                  <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
>                         interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
> -                       mediatek,scp = <&scp>;
> +                       mediatek,scp = <&scp_c0>;
>                         clocks = <&vencsys CLK_VENC_VENC>;
>                         clock-names = "venc_sel";
>                         assigned-clocks = <&topckgen CLK_TOP_VENC>;
> --
> 2.18.0
>
