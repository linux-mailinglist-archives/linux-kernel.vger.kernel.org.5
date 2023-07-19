Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53CC758EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGSHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGSHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:21:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616526A0;
        Wed, 19 Jul 2023 00:21:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A916D66003AA;
        Wed, 19 Jul 2023 08:21:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689751262;
        bh=eoZISowr7QrTo8XDR+V8qw4PjxQY2Bmj/1UAP+hq3Bw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O8CEihVe9gOmBSC26nZD06STF1dGhxdcsNFXM7+PnStUGpVMmyZKkCL7ow8wCn+W1
         xRwu8DZbjhcBjG8wuR8B9OIysr4NJIzgjeYt3KuxtpZ/D06G2ZYCERnb98L6jKZ1yu
         9tvDkVPeFTIIb6OfmwhXcSQ2rUC9bexVellw2MjIIS8n5lnJjRTeIE2k9+sHTjlU9u
         okBDAlAX5FEJ6Mj7OO61Pj43hBeggQ5JCVGYlFqWL3qg022x9XJOLLqRO1vwVo7vX1
         a0hHsq5jdqKK2tAoxbLRndDczxP84rAayJmHOo/Ex8qifEPOEYVPJtZmzBPFFt03ba
         M/z3owyipvJ3A==
Message-ID: <bcf9c0f0-ba06-d89b-56f9-b1d8abb6737c@collabora.com>
Date:   Wed, 19 Jul 2023 09:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Content-Language: en-US
To:     William-tw Lin <william-tw.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
 <20230718112143.14036-2-william-tw.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230718112143.14036-2-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/07/23 13:21, William-tw Lin ha scritto:
> Add driver for socinfo retrieval. This patch includes the following:
> 1. mtk-socinfo driver for chip info retrieval
> 2. Related changes to Makefile and Kconfig
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig       |  18 +++
>   drivers/soc/mediatek/Makefile      |   1 +
>   drivers/soc/mediatek/mtk-socinfo.c | 203 +++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-socinfo.h | 213 +++++++++++++++++++++++++++++
>   4 files changed, 435 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-socinfo.c
>   create mode 100644 drivers/soc/mediatek/mtk-socinfo.h
> 

..snip..

> +
> +/* begin 8186 info */
> +#define mtk_mt8186_EFUSE_DATA_COUNT 1
> +static struct efuse_data mtk_mt8186_efuse_data_info[][mtk_mt8186_EFUSE_DATA_COUNT] = {
> +	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81861001}},
> +	{{.nvmem_cell_name = "socinfo-data1", .efuse_data = 0x81862001}},
> +};

I'm *sure* that there's a way to avoid specifying the soc-specific compatible, as
the efuse_data is used only for validation, while what you do here is to simply
read the SoC ID from eFuse array.

In theory, this driver could simply have

compatible = "mediatek,socinfo";

as compatible string, without any SoC-specific string in the devicetree, at all,
so that the SoC ID would get recognized completely dynamically - and adding the
name and other strings would be a consequence.

> +
> +static struct name_data mtk_mt8186_name_data_info[] = {
> +	{.soc_name = "MT8186",
> +	 .soc_segment_name = "MT8186GV/AZA",
> +	 .marketing_name = "Kompanio 520"},
> +	{.soc_name = "MT8186T",
> +	 .soc_segment_name = "MT8186TV/AZA",
> +	 .marketing_name = "Kompanio 528"},
> +};
> +/* end 8186 info */
> +

Regards,
Angelo

