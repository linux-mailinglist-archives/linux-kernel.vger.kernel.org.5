Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF47B9F41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjJEOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjJEORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:17:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A021D00
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:43:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40651a726acso6618085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696498998; x=1697103798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JwKnCE50Or3wTNbb8nnaCjSfC0KHldEcWfUSQ5mNeMI=;
        b=PcjYl6fosxe3bu124GfB1jVOexCe2p5G1dYKIInFv7zmOBTZ2RLTD5bxDytT9F/s/q
         7Gl+lrx7WsZ3db5b6q5954TN4MV20dJTtaBzqHRB3NATgnVYCOD7xVHwUGBlWltcp3z2
         UNx1IpttiSEJHxn5N+To8PKATussPj/ym20yoa4YRcTq7f/2fgZGWjsnq2Mx1zB33lXZ
         2VC70HbtLNJGXbIEI9H68tqWtY12yJ4o1pYDeBnHfp4Cp7HlqQbITxWl8XuBKNd8tlmo
         gKeroiZRz1EPGziaY+KTLSt1x7BEaIVy09vtxJmaGqzTyavt+SgHq+WRKlRjwLEuvSx0
         JdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498998; x=1697103798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwKnCE50Or3wTNbb8nnaCjSfC0KHldEcWfUSQ5mNeMI=;
        b=STAo/UPuy9K7plcSUlhXMCZUwop0La1JWoKRSkEw5oHrVcKKHEfGXBzG092Me5RmCz
         HDChBhpAeRp+n9mbhs4kDyulKLm5E9F5YEdnQx7pvYAzkflRl/ilqB8DvncZh/yjUtR/
         Jnryq2i5Ut6ancJss1Adoq014Mbqp6tIrIPNn7sVn7ONRFaMT61Nz+OuL5khPIhKdV0u
         p0AJLjRzQxcAMi7GOXDainJAueLDqIaAa9Fu2EGWWLTMiGGWpQ9avx398c7ZrJbIS3b3
         sxMc/icT4oyPbZkdo83tFks2hzDLHeLU1uDtyXiJpW8Gl6ozoaJEWeWIGBeUSyI0pEa2
         Uwsg==
X-Gm-Message-State: AOJu0YzPiz+gq633Q4xYXb/WGAeyJGsi8YIhbOfAjUBhtoBArBPTvGkc
        ZLK7Dopzb+p4TFhUzwy4zyHCVg==
X-Google-Smtp-Source: AGHT+IEA8Pv/FN9E11LJAyjgn8EofUjuGcu3RKUVzw7ZzFbiuhbNcnB4JemmblVGztHfx0rlL56C5A==
X-Received: by 2002:a5d:630c:0:b0:31f:fa6a:936e with SMTP id i12-20020a5d630c000000b0031ffa6a936emr4440521wru.17.1696498998220;
        Thu, 05 Oct 2023 02:43:18 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id d16-20020adff850000000b003232d122dbfsm1355989wrq.66.2023.10.05.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:43:17 -0700 (PDT)
Date:   Thu, 5 Oct 2023 11:43:16 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 0/8] soc: mediatek: MT8365 power support
Message-ID: <20231005094316.nj5w6cmefvc36tbl@blmsp>
References: <20230918093751.1188668-1-msp@baylibre.com>
 <06f8a769-1845-ea87-dcc4-37dd5ad255ed@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06f8a769-1845-ea87-dcc4-37dd5ad255ed@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Thu, Oct 05, 2023 at 10:54:16AM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/09/23 11:37, Markus Schneider-Pargmann ha scritto:
> > Hi,
> > 
> > no real changes in this update. Rebase to v6.6-rc2 and according change
> > of directory.
> 
> Since the driver changed to pmdomain/mediatek, can you please change the commit
> titles for the driver commits?

As far as I understand Ulf applied the series today and changed the
title as well:
https://lore.kernel.org/lkml/CAPDyKFrUbWBQgMm6wYwFfybiRQKhBpwH7wwcXaT+KrQJLevq3w@mail.gmail.com/

Best,
Markus

> 
> soc: mediatek: pm-domains: ===> pmdomain: mediatek: pm-domains:
> 
> or alternatively, I honestly would like it more like
> 
> pmdomain: mediatek: pd:
> 
> and (not relevant to this series)
> 
> pmdomain: mediatek: scpsys:
> 
> ...but before that, does anyone have any strong opinions against the prefix
> "pmdomain: mediatek: pd:", instead of the full "pm-domains"?
> 
> Thanks!
> Angelo
> 
> > 
> > Thanks for any feedback!
> > 
> > Best,
> > Markus
> > 
> > Based on v6.6-rc2
> > 
> > Changes in v8:
> > - Rebased to v6.6-rc2
> > - Moved changes from drivers/soc to drivers/pmdomain
> > 
> > Changes in v7:
> > - Rebased to v6.5-rc1
> > - Fixed a couple of small style issues pointed out by Angelo
> > 
> > Changes in v6:
> > - Change flags field to be u8 instead of u32
> > - Use macro concatenation to simplify BUS_PROT macros:
> >    BUS_PROT_WR(_hwip, ...) etc.
> > - Use the final bit values for scpsys_bus_prot_flags from the beginning
> >    of the series.
> > - Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
> >    MTK_SCPD_STRICT_BUS_PROTECTION.
> > 
> > Changes in v5:
> > - Create defines for all registers and bits in mt8365 power domain patch
> > - Redesign scpsys_bus_prot_data to use flags to store reg_update,
> >    clr_ack as well as the difference between SMI and INFRACFG. The code
> >    uses the appropriate regmap depending on the flags.
> > - The WAY_EN patch now uses two flags, one for inverted operations
> >    'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
> >    'BUS_PROT_STA_COMPONENT_INFRA_NAO'.
> > 
> > Changes in v4:
> > - Redesigned WAY_EN patch and split it up in smaller patches.
> > - Added two documentation patches.
> > - Added mediatek,infracfg-nao field to the binding.
> > 
> > Changes in v3:
> > - Mainly redesigned WAY_EN patch to be easier to understand
> > - Rebased onto v6.0-rc1
> > - Several other stuff that is described in the individual patches
> > 
> > Changes in v2:
> > - Updated error handling path for scpsys_power_on()
> > - Minor updates described in each patch
> > 
> > Previous versions:
> > v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
> > v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
> > v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
> > v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/
> > v5 - https://lore.kernel.org/linux-arm-kernel/20230619085344.2885311-1-msp@baylibre.com/
> > v6 - https://lore.kernel.org/linux-arm-kernel/20230627131040.3418538-1-msp@baylibre.com/
> > v7 - https://lore.kernel.org/linux-arm-kernel/20230713150414.891893-1-msp@baylibre.com
> > 
> > Alexandre Bailon (2):
> >    soc: mediatek: Add support for WAY_EN operations
> >    soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
> > 
> > Fabien Parent (2):
> >    dt-bindings: power: Add MT8365 power domains
> >    soc: mediatek: pm-domains: Add support for MT8365
> > 
> > Markus Schneider-Pargmann (4):
> >    soc: mediatek: pm-domains: Move bools to a flags field
> >    soc: mediatek: pm-domains: Split bus_prot_mask
> >    soc: mediatek: pm-domains: Create bus protection operation functions
> >    soc: mediatek: pm-domains: Unify configuration for infracfg and smi
> > 
> >   .../power/mediatek,power-controller.yaml      |   6 +
> >   drivers/pmdomain/mediatek/mt6795-pm-domains.h |  16 +-
> >   drivers/pmdomain/mediatek/mt8167-pm-domains.h |  20 +-
> >   drivers/pmdomain/mediatek/mt8173-pm-domains.h |  16 +-
> >   drivers/pmdomain/mediatek/mt8183-pm-domains.h | 125 ++++++----
> >   drivers/pmdomain/mediatek/mt8186-pm-domains.h | 236 ++++++++++--------
> >   drivers/pmdomain/mediatek/mt8188-pm-domains.h | 223 +++++++++++------
> >   drivers/pmdomain/mediatek/mt8192-pm-domains.h | 112 ++++++---
> >   drivers/pmdomain/mediatek/mt8195-pm-domains.h | 199 +++++++++------
> >   drivers/pmdomain/mediatek/mt8365-pm-domains.h | 197 +++++++++++++++
> >   drivers/pmdomain/mediatek/mtk-pm-domains.c    | 157 ++++++++----
> >   drivers/pmdomain/mediatek/mtk-pm-domains.h    |  51 ++--
> >   .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
> >   include/linux/soc/mediatek/infracfg.h         |  41 +++
> >   14 files changed, 972 insertions(+), 446 deletions(-)
> >   create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h
> >   create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
> > 
> > 
> > base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> 
> 
