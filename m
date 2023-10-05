Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3B7B9EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjJEOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjJEOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3E4204;
        Thu,  5 Oct 2023 01:54:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 191CF660731A;
        Thu,  5 Oct 2023 09:54:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696496059;
        bh=bApHrP5+rFCG+AvPQEp0nvYRi/WjkCcLC3j4z/vfddQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I2CGLtIBRs07RgZCkRO2P3NXkFXb3qjOhfw9LtB4KRtCUj2rRosl8OyqvCKZqg35u
         OEeV1JpqU6IRvfCT2zzFqzhJhzVeF1FdUWctYBon6aQF+sEZ9t5HDnDtRTqkz5GVm2
         jQfo1suUiMDzkhvcEtmi1gldJwEVk2+xlQPXkGAmpZyyw4wIXGbVcTPxPRYt6PB44V
         ohZgPaIgJzYssvvWaJ43D4PFiquBmYzaQj+D1RWkRFHV19LxfleStWVJP7Ps8el3la
         VqV6IxldPDGrrpoPVZ5RuHrJde0+Asswow34c2Q8WPNDmlJ3rXdUMSlWQGjk8OagnD
         ai9W46lzqe7jQ==
Message-ID: <06f8a769-1845-ea87-dcc4-37dd5ad255ed@collabora.com>
Date:   Thu, 5 Oct 2023 10:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 0/8] soc: mediatek: MT8365 power support
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230918093751.1188668-1-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230918093751.1188668-1-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 11:37, Markus Schneider-Pargmann ha scritto:
> Hi,
> 
> no real changes in this update. Rebase to v6.6-rc2 and according change
> of directory.

Since the driver changed to pmdomain/mediatek, can you please change the commit
titles for the driver commits?

soc: mediatek: pm-domains: ===> pmdomain: mediatek: pm-domains:

or alternatively, I honestly would like it more like

pmdomain: mediatek: pd:

and (not relevant to this series)

pmdomain: mediatek: scpsys:

...but before that, does anyone have any strong opinions against the prefix
"pmdomain: mediatek: pd:", instead of the full "pm-domains"?

Thanks!
Angelo

> 
> Thanks for any feedback!
> 
> Best,
> Markus
> 
> Based on v6.6-rc2
> 
> Changes in v8:
> - Rebased to v6.6-rc2
> - Moved changes from drivers/soc to drivers/pmdomain
> 
> Changes in v7:
> - Rebased to v6.5-rc1
> - Fixed a couple of small style issues pointed out by Angelo
> 
> Changes in v6:
> - Change flags field to be u8 instead of u32
> - Use macro concatenation to simplify BUS_PROT macros:
>    BUS_PROT_WR(_hwip, ...) etc.
> - Use the final bit values for scpsys_bus_prot_flags from the beginning
>    of the series.
> - Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
>    MTK_SCPD_STRICT_BUS_PROTECTION.
> 
> Changes in v5:
> - Create defines for all registers and bits in mt8365 power domain patch
> - Redesign scpsys_bus_prot_data to use flags to store reg_update,
>    clr_ack as well as the difference between SMI and INFRACFG. The code
>    uses the appropriate regmap depending on the flags.
> - The WAY_EN patch now uses two flags, one for inverted operations
>    'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
>    'BUS_PROT_STA_COMPONENT_INFRA_NAO'.
> 
> Changes in v4:
> - Redesigned WAY_EN patch and split it up in smaller patches.
> - Added two documentation patches.
> - Added mediatek,infracfg-nao field to the binding.
> 
> Changes in v3:
> - Mainly redesigned WAY_EN patch to be easier to understand
> - Rebased onto v6.0-rc1
> - Several other stuff that is described in the individual patches
> 
> Changes in v2:
> - Updated error handling path for scpsys_power_on()
> - Minor updates described in each patch
> 
> Previous versions:
> v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
> v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
> v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
> v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/
> v5 - https://lore.kernel.org/linux-arm-kernel/20230619085344.2885311-1-msp@baylibre.com/
> v6 - https://lore.kernel.org/linux-arm-kernel/20230627131040.3418538-1-msp@baylibre.com/
> v7 - https://lore.kernel.org/linux-arm-kernel/20230713150414.891893-1-msp@baylibre.com
> 
> Alexandre Bailon (2):
>    soc: mediatek: Add support for WAY_EN operations
>    soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
> 
> Fabien Parent (2):
>    dt-bindings: power: Add MT8365 power domains
>    soc: mediatek: pm-domains: Add support for MT8365
> 
> Markus Schneider-Pargmann (4):
>    soc: mediatek: pm-domains: Move bools to a flags field
>    soc: mediatek: pm-domains: Split bus_prot_mask
>    soc: mediatek: pm-domains: Create bus protection operation functions
>    soc: mediatek: pm-domains: Unify configuration for infracfg and smi
> 
>   .../power/mediatek,power-controller.yaml      |   6 +
>   drivers/pmdomain/mediatek/mt6795-pm-domains.h |  16 +-
>   drivers/pmdomain/mediatek/mt8167-pm-domains.h |  20 +-
>   drivers/pmdomain/mediatek/mt8173-pm-domains.h |  16 +-
>   drivers/pmdomain/mediatek/mt8183-pm-domains.h | 125 ++++++----
>   drivers/pmdomain/mediatek/mt8186-pm-domains.h | 236 ++++++++++--------
>   drivers/pmdomain/mediatek/mt8188-pm-domains.h | 223 +++++++++++------
>   drivers/pmdomain/mediatek/mt8192-pm-domains.h | 112 ++++++---
>   drivers/pmdomain/mediatek/mt8195-pm-domains.h | 199 +++++++++------
>   drivers/pmdomain/mediatek/mt8365-pm-domains.h | 197 +++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    | 157 ++++++++----
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    |  51 ++--
>   .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
>   include/linux/soc/mediatek/infracfg.h         |  41 +++
>   14 files changed, 972 insertions(+), 446 deletions(-)
>   create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h
>   create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
> 
> 
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70


