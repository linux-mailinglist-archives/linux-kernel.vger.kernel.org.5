Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76787792B77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjIEQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353767AbjIEIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:01:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62FDF;
        Tue,  5 Sep 2023 01:01:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EFFA6600B9D;
        Tue,  5 Sep 2023 09:01:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693900888;
        bh=PU+U/dEE7kc5FeBeCNzM0RHGNzET0eI/w37N7m0QFpg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YyzpakIFbIqNDKTvVbkaOuSGBfTwR7NrFX6P/xPmhOIXzsroeFPpIGhdHN6v8zdZd
         oK3uNbuVHuRkS5WTUDHxjHxZrZd53dyQAZWLpjLLIuS6syzFZVYhairWC6dVJFyzqk
         3GRXKbmzsGI620yScWx2pBSlIrFSQUfkdGMZUqp70+Wc61F4rIIT18GmbnXQ4GIwUf
         0wQAK1nbuCx+X+YJoh+OZBXxWA/8efeYBCNpdtWPLyOz7p6437ltiyUbYhRVWocx7i
         MAb8KEExg6F545YX2dgPIxZdRYVPR4wfnfrkCJcZ+w8DDOV0Jw++AHEKYFJmBi2VfV
         9v3opMBOo+Z7A==
Message-ID: <e54394b3-eb52-f36b-3ba4-8a4262b5f5e5@collabora.com>
Date:   Tue, 5 Sep 2023 10:01:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: mt8195-demo: update and
 reorder reserved memory regions
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, stable@vger.kernel.org
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230905034511.11232-1-macpaul.lin@mediatek.com>
 <20230905034511.11232-2-macpaul.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230905034511.11232-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/09/23 05:45, Macpaul Lin ha scritto:
> The dts file of the MediaTek MT8195 demo board has been updated to include
> new reserved memory regions.
> These reserved memory regions are:
>   - SCP
>   - VPU,
>   - Sound DMA
>   - APU.
> 
> These regions are defined with the "shared-dma-pool" compatible property.
> In addition, the existing reserved memory regions have been reordered by
> their addresses to improve readability and maintainability of the DTS
> file.
> 
> Cc: stable@vger.kernel.org      # 6.1, 6.4, 6.5
> Fixes: e4a417520101 ("arm64: dts: mediatek: mt8195-demo: fix the memory size of node secmon")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


