Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F75376E3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjHCIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjHCIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:52:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44FE7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:52:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317b31203c7so640648f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691052752; x=1691657552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J72ZCMiP8be+FmTbKr7cCJxSbCeOBd7SRmuAXWbyv8U=;
        b=szM+YrFrkDalypCo/0ZG9zFLnFzwXVhzt0iiecWcnIJFc/3kt8xPLF04oeNEvquc9I
         ocXSVfi7/4WHQ0c+INJgOg4ecn1KlV3XGkAmvsPWRZ7wqbYmF3MYsJ6bYVga9Emvcv9X
         2BIJwTxTixPJ5OqrfF/4F2L6hNNjevwjSRXZtym46OvLe7pDMEMO5agzer8cq+CsuemI
         KhCdHna1IVEeJJq8d5IMCHmNpayXweMawtuZyKWFSXR6RQBzyJCPFCrEAl6S0gg/+ZGg
         zxCplFDzjGJyommM0qIjAyhyCUYicZ0C2kF8WMovz440F87ELuV8Zdy3KaMGtb3VQDT1
         Y/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052752; x=1691657552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J72ZCMiP8be+FmTbKr7cCJxSbCeOBd7SRmuAXWbyv8U=;
        b=NW24KoGO2VNQWuZYMf4tnYvYP9vFfZUZ8dPpmql2ffL/99nL4OwynXirbe5+7Bnli4
         Y/2zpH1VYwfkIpthytC1edYEtPBfZFo4D9Q1XQJG+rk4FTM8v8qr+rzyoo8YfbvI8tlc
         TtsCjziMrrThXkJbIVYzDSvVo1o0hSYQEuT0eJtBi1CC8LLkbLsYudykXiv24ym36SAV
         +iNoz0hbrqK5qpcBvrfl8Lv+tbTgiBT29S8amwrDAt7cWs47eRNdobAETIY9MadKQ3vg
         HgXh3lnkDibAIPfD34HcoCKxyO6s1QF3cF2gYM60K6A4DPZfU6mOiJKy7o+virEMnf6K
         26xA==
X-Gm-Message-State: ABy/qLYLMa59dk+NZu3ZJuJRwy3Pw6wIZXbY71aG8Gh5ykRzWjBq5147
        m3tb/HfaZ87sINf7LjJGz0810g==
X-Google-Smtp-Source: APBJJlEN9R4IgJNpMlQ3xJMdsGaNvKhN1Gc4doOaCc43QqlOvQrkehbZtA+GP/6VFDnvSP/T5nnNhw==
X-Received: by 2002:a5d:5389:0:b0:313:ea59:7ded with SMTP id d9-20020a5d5389000000b00313ea597dedmr6210883wrv.24.1691052752109;
        Thu, 03 Aug 2023 01:52:32 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0031773a8e5c4sm21141347wrn.37.2023.08.03.01.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 01:52:31 -0700 (PDT)
Message-ID: <04f1f2f4-fd22-b22f-7285-2884ae92c7d8@baylibre.com>
Date:   Thu, 3 Aug 2023 10:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/8] soc: mediatek: MT8365 power support
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230713150414.891893-1-msp@baylibre.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230713150414.891893-1-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Gentle ping, because I think this serie is ready to be merged. Do you 
agree ?

Alex

On 13/07/2023 17:04, Markus Schneider-Pargmann wrote:
> Hi,
> 
> this version just fixes some small style issues and rebases to v6.5-rc1.
> 
> Thanks for any feedback!
> 
> Best,
> Markus
> 
> Based on v6.5-rc1
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
>   drivers/soc/mediatek/mt6795-pm-domains.h      |  16 +-
>   drivers/soc/mediatek/mt8167-pm-domains.h      |  20 +-
>   drivers/soc/mediatek/mt8173-pm-domains.h      |  16 +-
>   drivers/soc/mediatek/mt8183-pm-domains.h      | 125 ++++++----
>   drivers/soc/mediatek/mt8186-pm-domains.h      | 236 ++++++++++--------
>   drivers/soc/mediatek/mt8188-pm-domains.h      | 223 +++++++++++------
>   drivers/soc/mediatek/mt8192-pm-domains.h      | 112 ++++++---
>   drivers/soc/mediatek/mt8195-pm-domains.h      | 199 +++++++++------
>   drivers/soc/mediatek/mt8365-pm-domains.h      | 197 +++++++++++++++
>   drivers/soc/mediatek/mtk-pm-domains.c         | 157 ++++++++----
>   drivers/soc/mediatek/mtk-pm-domains.h         |  51 ++--
>   .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
>   include/linux/soc/mediatek/infracfg.h         |  41 +++
>   14 files changed, 972 insertions(+), 446 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
>   create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
> 
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5

-- 
Regards,
Alexandre
