Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64797A19C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjIOI5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjIOI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:57:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83272D55;
        Fri, 15 Sep 2023 01:56:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 699A866072F9;
        Fri, 15 Sep 2023 09:55:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694768154;
        bh=BTm20ORdC7NaJxZlGLiHeMh6jdPWElHB30R58bwVzUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DmBVjmoQ48pMlsCHB+bYqlbf+Z9dxldjQA3PaWP4GQazm7fFocKuzdABTYLLZJk4h
         IuMd5HMOUpCl/kqYI3BZxnskeVzvEVgfq1uKOBx8DopBDrGu45tdqjGMn/ybIAjjYL
         Fgyo4UO76XkaNXYoo+DcKwVgQ3pZ8FOmDJymYj8oPzJ03uof3fhWUuh0bJFaszvO5S
         hNjPq8ecoVpq8Hz2k7dqdDciuDWbN82xDK33HfQY+TMJ+uHEbEm8GLb6q1sh1V5Dz/
         1mrz02u9wwmQ9muFs8/J/GSEadJ2nsnBWcl8g+ZFUJ90ANGB+VubGaGW3w/X+3TQuJ
         S92ENJIqG9CXw==
Message-ID: <7f743fba-6cba-cce0-d499-0a9d95e3b026@collabora.com>
Date:   Fri, 15 Sep 2023 10:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 02/11] mfd: mt6358: Add registers for MT6366 specific
 regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230822084520.564937-3-wenst@chromium.org>
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

Il 22/08/23 10:45, Chen-Yu Tsai ha scritto:
> The MT6366 PMIC, compared to the MT6358, does away with the VCAM*
> regulators. Two regulators VM18 and VMDDR reuse their register space.
> There's also a VSRAM type regulator VSRAM_CORE thats' split between
> the VCAM* register space and other parts.
> 
> Add register address macros for these MT6366 specific regulators.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

For ease of applying to MFD, I think it's ok to have the header changes split
from the actual user; so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!

> ---
>   include/linux/mfd/mt6358/registers.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
> index 5ea2590be710..d83e87298ac4 100644
> --- a/include/linux/mfd/mt6358/registers.h
> +++ b/include/linux/mfd/mt6358/registers.h
> @@ -294,4 +294,21 @@
>   #define MT6358_AUD_TOP_INT_CON0               0x2228
>   #define MT6358_AUD_TOP_INT_STATUS0            0x2234
>   
> +/*
> + * MT6366 has no VCAM*, but has other regulators in its place. The names
> + * keep the MT6358 prefix for ease of use in the regulator driver.
> + */
> +#define MT6358_LDO_VSRAM_CON5                 0x1bf8
> +#define MT6358_LDO_VM18_CON0                  MT6358_LDO_VCAMA1_CON0
> +#define MT6358_LDO_VM18_CON1                  MT6358_LDO_VCAMA1_CON1
> +#define MT6358_LDO_VM18_CON2                  MT6358_LDO_VCAMA1_CON2
> +#define MT6358_LDO_VMDDR_CON0                 MT6358_LDO_VCAMA2_CON0
> +#define MT6358_LDO_VMDDR_CON1                 MT6358_LDO_VCAMA2_CON1
> +#define MT6358_LDO_VMDDR_CON2                 MT6358_LDO_VCAMA2_CON2
> +#define MT6358_LDO_VSRAM_CORE_CON0            MT6358_LDO_VCAMD_CON0
> +#define MT6358_LDO_VSRAM_CORE_DBG0            0x1cb6
> +#define MT6358_LDO_VSRAM_CORE_DBG1            0x1cb8
> +#define MT6358_VM18_ANA_CON0                  MT6358_VCAMA1_ANA_CON0
> +#define MT6358_VMDDR_ANA_CON0                 MT6358_VCAMD_ANA_CON0
> +
>   #endif /* __MFD_MT6358_REGISTERS_H__ */

