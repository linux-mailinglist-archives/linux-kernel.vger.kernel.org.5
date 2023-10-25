Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E27D64F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJYIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjJYIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:25:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140EA130;
        Wed, 25 Oct 2023 01:25:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 390E06607343;
        Wed, 25 Oct 2023 09:25:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698222336;
        bh=/MPWeMyHAxsAWZyZD0cLcFQjlH545S+f/HIffRuUkyk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fYwIbmVddSkhLodZZOH9Fx8w+GTRLwjEsh6ZTa1A4fk1tMKMqUIkNsItdeAH6fXOi
         auCk8Xk/4uNYkWXxMEmpjRO7zQEy1Tl6etkpwI/M7WIc9zxARd//FfC/mAY5S4INGF
         Y+LkcEHG5kdBY9W/lK1KtJLVQ3JIqSQxqgV5FzV8Y3hKdve7GdWp+gql7J8w5HHrN1
         pQf1pO3NbM3SdO08cg/H6uS7MszAREGg9+Dux4Nj13FBV1UtsiXystd1dU/BEe1Orp
         sF8v1UsMEPHO6sNPheC458oYP0E4aSI3wT8nX6EybSmKmOiOsNd/tBJo/J42io78/y
         cFzSindBf4fmA==
Message-ID: <0dcc5a99-ef14-4250-b8c1-bf9d7471f5cb@collabora.com>
Date:   Wed, 25 Oct 2023 10:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: mt8183: Add kukui katsu board
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231024212618.1079676-1-hsinyi@chromium.org>
 <20231024212618.1079676-4-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231024212618.1079676-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/10/23 23:22, Hsin-Yi Wang ha scritto:
> katsu is also known as ASUS Chromebook Detachable CZ1.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2: non sku38 is sku32
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>   .../dts/mediatek/mt8183-kukui-katsu-sku32.dts | 40 +++++++++++++++++
>   .../dts/mediatek/mt8183-kukui-katsu-sku38.dts | 44 +++++++++++++++++++
>   3 files changed, 86 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index e6e7592a3645..a13419e67e8e 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -36,6 +36,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku32.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku38.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> new file mode 100644
> index 000000000000..9fa205c06c74
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-kakadu.dtsi"
> +#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
> +
> +/ {
> +	model = "Google katsu board";
> +	chassis-type = "tablet";
> +	compatible = "google,katsu-sku32", "google,katsu", "mediatek,mt8183";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +

The i2c0 node already inherits status = "okay" from mt8183-kukui-kakadu.dtsi,
this is redundant.

> +	/delete-node/touchscreen@10;

You can definitely avoid those ugly /delete-node/ statements: if you check more
closely, mt8183-kukui-kakadu.dtsi is used by only two *.dts files.

I would propose to move the touchscreen@10 node from kakadu.dtsi to kakadu.dts
and kakadu-sku22.dts: in my opinion, that will make things more readable, as
every board defines its own touchscreen.

It would be a different story if we had to duplicate that @10 node for something
like five times or more, but that's not the case.

> +	touchscreen1: touchscreen@5d {
> +		compatible = "goodix,gt7375p";
> +		reg = <0x5d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&open_touch>;
> +

This....

> +		interrupt-parent = <&pio>;
> +		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;

...should be done in one line, like so:

		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;

> +
> +		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&lcd_pp3300>;
> +	};
> +};
> +
> +&panel {
> +	compatible = "starry,2081101qfh032011-53g";

Actually, same comment goes for the panel node: kakadu.dtsi defines a panel
compatible "boe,tv105wum-nw0" but then you're overriding it here with the
starry panel.

You could leave the status = "okay" in kakadu.dtsi and move the panel compatible
to each *.dts board file, therefore increasing readability.

> +};
> +
> +&qca_wifi {
> +	qcom,ath10k-calibration-variant = "GO_KATSU";
> +};

Same comment applies to sku38, of course.

Regards,
Angelo

