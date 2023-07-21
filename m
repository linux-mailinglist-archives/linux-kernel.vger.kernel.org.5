Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7E75C11D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGUIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjGUIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:16:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A32719;
        Fri, 21 Jul 2023 01:16:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 043796606FD8;
        Fri, 21 Jul 2023 09:16:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689927407;
        bh=Da4LQlPmUJ4jB9lCBAB/poUxMFWGV22f2vqy6CM2uCE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TWzxKl8DzdNWcaEdkKBN9YU/bWg4LM3NKyQoQwTqZN6NVP5JIFMmOTo4ECDoU+EGp
         exRttprdTpB/Q+mSz+jxxxOOLt6MyPTrWiAzf7HlFXGBtCAQ7VL4RsO/jU7C5/zI/9
         bg2fYR1XyKACcVpe52w3hJv1c48xjh/hweGexcD67T7kjYWWA94iZZ570dpAjZC6SX
         aTvDKDPufBOrsw+8EaDLLjwqCb8ILKdE69DBcAlFGNvKhT9YkutltakDfd2G3MVmrM
         5wfLvwe0Uf9HgOwTuR+Vb/4laLbWQwbGXqjDt1iNKg3+hE+FP4r2j5kUZH6G9RoeJ3
         b0cdkL7yx8jIQ==
Message-ID: <8bb1a42d-2809-04a9-dcdd-45fc91ea1bde@collabora.com>
Date:   Fri, 21 Jul 2023 10:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Set DSU PMU status to fail
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230720200753.322133-1-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230720200753.322133-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 22:07, Nícolas F. R. A. Prado ha scritto:
> The DSU PMU allows monitoring performance events in the DSU cluster,
> which is done by configuring and reading back values from the DSU PMU
> system registers. However, for write-access to be allowed by ELs lower
> than EL3, the EL3 firmware needs to update the setting on the ACTLR3_EL3
> register, as it is disallowed by default.

Typo: ACTLR_EL2, ACTLR_EL3 bit 12 must be set if SCR.NS is 1;
ACTLR_EL3 bit 12 must be set if SCR.NS is 0.

On MT8195 Chromebooks, SCR.NS is 1 - hence ACTLR_EL2/EL3 must have BIT(12) set,
but at least ACTLR_EL2 doesn't have it set.

I haven't verified EL3, but that doesn't matter, since both need to be set.

> 
> That configuration is not done on the firmware used by the MT8195 SoC,
> as a consequence, booting a MT8195-based machine like
> mt8195-cherry-tomato-r2 with CONFIG_ARM_DSU_PMU enabled hangs the kernel
> just as it writes to the CLUSTERPMOVSCLR_EL1 register, since the
> instruction faults to EL3, and BL31 apparently just re-runs the
> instruction over and over.

...at least for this SoC, TF-A's BL31 fault handler loops over the same
instruction forever, hanging the AP...

Regards,
Angelo

> 
> Mark the DSU PMU node in the Devicetree with status "fail", as the
> machine doesn't have a suitable firmware to make use of it from the
> kernel, and allowing its driver to probe would hang the kernel.
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 5c670fce1e47..0705d9c3a6a7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -313,6 +313,7 @@ dsu-pmu {
>   		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
>   		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
>   		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
> +		status = "fail";
>   	};
>   
>   	dmic_codec: dmic-codec {


