Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5BE7A9F97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjIUUYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjIUUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:24:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8886A199D;
        Thu, 21 Sep 2023 10:23:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D52BE66072BD;
        Thu, 21 Sep 2023 08:55:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695282949;
        bh=WiT2aa8Rhk3aS7e7dZ1mtGJrKI4vTo0qji3osRdEPc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zhmj7ZlENxigYQSiBMNrhhDc3znNJb6e3KXnfU9zYJCvR6zs4dSBACc7Ck1CvAzbi
         6hQx5bcxvlG4do+a2qAwpSzXiNcQT5ZJGHgGDCPaCasLDRqMVVSXU8CUybcobIsyCJ
         2YlAo+iObbdEFviGeos7ADDrGmcuzZi5h5c6TLc8ZLdX0b/tmfuu+0mee7gIMv+7IW
         x6A7Kvc+NnFHqigaVBGfAFbQy5SEFsHdcQF0NCbJ+9w6pt3KXfwgrvg7y2bY8xSnQ+
         VHG6xP02c5eBfzU4n8qoi7LViqLAmfNcN7fhP09ASdjF7eCv2B+FZrzg1CTPTgryG4
         8wiGhfzQ8wxTQ==
Message-ID: <31fbdae8-d41c-358b-c8ea-6ee31b158dfd@collabora.com>
Date:   Thu, 21 Sep 2023 09:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/4] dt-bindings: thermal: mediatek: Add LVTS thermal
 sensors for mt7988
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230920175001.47563-1-linux@fw-web.de>
 <20230920175001.47563-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230920175001.47563-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/23 19:49, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add sensor constants for MT7988.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v2:
> - new patch (moved from driver code to binding header)
> - give sensors more meaningful names
> ---
>   include/dt-bindings/thermal/mediatek,lvts-thermal.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> index 8fa5a46675c4..8c1fdc18cf34 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -7,6 +7,15 @@
>   #ifndef __MEDIATEK_LVTS_DT_H
>   #define __MEDIATEK_LVTS_DT_H
>   
> +#define MT7988_CPU_0		0
> +#define MT7988_CPU_1		1
> +#define MT7988_ETH2P5G_0	2
> +#define MT7988_ETH2P5G_1	3
> +#define MT7988_TOPS_0		4
> +#define MT7988_TOPS_1		5
> +#define MT7988_ETHWARP_0	6
> +#define MT7988_ETHWARP_1	7
> +
>   #define MT8195_MCU_BIG_CPU0     0
>   #define MT8195_MCU_BIG_CPU1     1
>   #define MT8195_MCU_BIG_CPU2     2

