Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91FF77E028
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbjHPLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbjHPLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:17:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5682123;
        Wed, 16 Aug 2023 04:17:47 -0700 (PDT)
Received: from [172.20.10.4] (unknown [109.166.130.180])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A185266071DF;
        Wed, 16 Aug 2023 12:17:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692184666;
        bh=NRfGcuwBsM/mHuY7Ji1D+ZyvpHFkv2T1TUJuvYW9S8c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PFIZutdjY21qgCq+Fen+1uRJQm2bFCoKxnTEdJNR+2F2XExnx3YhK7pu/5zitiD6l
         si1KCI+8IUBSh80pm+71APW+xEA+oFvcTm3cGUbyHsWWG0HkYVvCN3Kv/2oJD/G1yG
         re9iW6ziV/1VYbjsJ5tukB5QU9YKfVxmUPlawSx3EQSSqt5XnA6uNPmjYQCtwmbt21
         IQNcpOplkz5mI6j9sLPaehiyI2x2UAI4EeyDU6cot6HIc7t3vv4pOQ2P4DKQ4vY7KO
         0RmD4z12PkGtrlDTbC6oYIa9z5w1pAusaVzblEFcLq/nor/8QqnL3625TPF76pKrQ6
         2o+ese6i4w87Q==
Message-ID: <699d7552-cb9b-041a-467c-597e5a209857@collabora.com>
Date:   Wed, 16 Aug 2023 14:17:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt8183: disable quad mode for
 spi nor
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230815154412.713846-1-hsinyi@chromium.org>
 <20230815154412.713846-4-hsinyi@chromium.org>
Content-Language: en-US
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230815154412.713846-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 18:31, Hsin-Yi Wang wrote:
> Some of the SKUs are using gigadevice gd25lq64c flash chip. The chip
> default enables quad mode, which results in the write protect pin set to
> IO pin. In mt8183 kukui, we won't use quad enable for all SKUs, so apply
> the property to disable spi nor's quad mode.

Hi Hsin-Yi,

To me this property, and the way you 'apply' it, makes me think that you 
are using the devicetree as a configuration and not a description of the 
hardware itself.
I think the driver should decide whether to use quad or not depending on 
the situation or the pinout of the device (as in your case quad mode 
overlaps with the WP pin)

Eugen

> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 6ce16a265e053..8e4761e2b8ff4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -877,6 +877,7 @@ w25q64dw: flash@0 {
>   		compatible = "winbond,w25q64dw", "jedec,spi-nor";
>   		reg = <0>;
>   		spi-max-frequency = <25000000>;
> +		disable-quad-mode;
>   	};
>   };
>   

