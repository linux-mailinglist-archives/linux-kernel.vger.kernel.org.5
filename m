Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF10797980
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbjIGRPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjIGRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:15:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC11FE5;
        Thu,  7 Sep 2023 10:15:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D181E66072E3;
        Thu,  7 Sep 2023 09:30:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694075405;
        bh=EdQ9ASI8+iF8t5u8HGmRUqDa9g/nGIlcPEp4NR/29MA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cfkdhopb2O4/2hTFhZZuemvDZx5NWOEZ/XtEtWECmev2t3Ss2FaIJXXLASntsQXFX
         gs/GQP6qP8CUdiGz+DdX/PpKOJ2OoTVPqq8lBysVuruhA68lkhBxNGHupKvbUDT6wD
         /2feRHQ0EJRHs49z+kigbY1kwR+KEJA43JM3dSueXYX+uBn7DYQMeVJb4VoUg8ifup
         7shMyDx2ny1PDi3Yoxh+GiFEUyvUB6HYDEZGcKfFTRpvI/UUN1nNI+v5+lcArOjSc+
         s0NkDt2WFsJQu4z0C2zz4u+/qF1wUPdz4BkFE+F39lCmwql+fg3jCeST2RmpQ8lU2h
         MromValbfAwAQ==
Message-ID: <0470ab6d-7bf9-8c21-6e34-19b4f9023f10@collabora.com>
Date:   Thu, 7 Sep 2023 10:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt7622: fix memory node warning
 check
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        linux-mediatek@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com
References: <20230814065042.4973-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230814065042.4973-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/08/23 08:50, Eugen Hristev ha scritto:
> dtbs_check throws a warning at the memory node:
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> 
> fix by adding the address into the node name.
> 
> Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index e4605d23fdc8..8220a4fd6319 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -73,7 +73,7 @@ led-1 {
>   		};
>   	};
>   
> -	memory {
> +	memory@40000000 {
>   		reg = <0 0x40000000 0 0x40000000>;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index dad8e683aac5..c435984ca767 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -55,7 +55,7 @@ key-wps {
>   		};
>   	};
>   
> -	memory {
> +	memory@40000000 {
>   		reg = <0 0x40000000 0 0x20000000>;
>   	};
>   


