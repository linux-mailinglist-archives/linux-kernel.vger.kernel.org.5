Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AE7B97BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJDWJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjJDWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:09:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81544C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:09:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d865db5b4c7so377720276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696457382; x=1697062182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGtL9ni/bmY+k+XLO0zZ//MJWYpwr9WdA7Lq88K11GI=;
        b=r0NfUJhLIWnl8d+T7mPYNKKQ5OaUUvMwYuOd5fUR6kaXxUmQzYdU4b0aRxDb0UX3/y
         pCBnCAYwBBhxZbV1a/fMJtBH2BgwZKcbe1IZP9eciOm9DmvFlrdZACNoQFrIt+z2v+EP
         Ne25ID5PulMrmmW3NDK77YU/2Oc+PLxRh/zlIm+yYQYSmidmXsLl8E94anAt7yt6wrs/
         +HryNABdKJuOEQtnTEmXt8mHBP9BeaVGyvA10t1QwDj8w8Aw8z2We8e+OIeG0CweWT6g
         +6t0w0i63818BPSwD2N0bEDaL+lbSzYh2ifq6bEncN21HHji2dVfAlwk7/MLoS/VT66x
         Ys/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696457382; x=1697062182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGtL9ni/bmY+k+XLO0zZ//MJWYpwr9WdA7Lq88K11GI=;
        b=LNLV2/Cw0QP9xeLsC2Ltt52MZfbOQ4sk8aAYlVpzmJmL7GSvg/Jjny1HxQ7wbPZL8m
         PAU4cVQZRPIymNdQuFKZqCfC+JOb+F3HsFeKmgPa6NF5U8VNmcN1ZdMdLb/VF8ccKxce
         5zJMEAhNKEru3Ls5TBUGTlQ9qv2+lbVTK5DRF8viB+esigLwz80jazmwwFZpujdrHgRP
         qJm/ohNdzoY7vgIEGYZxjkg77pfljQQYmL76C9p5i6vQOjt9U78F+Z/OS08KgeFsVpEx
         pNkO9QD42khVHPJ0D0gsiKORN0XuPASgIlBKBTfVAFVPIE6FOCP4j4KzRXgk4flFdF/A
         XeNg==
X-Gm-Message-State: AOJu0Yx4r1TamRvTJPnAPbss3RSslfSyrYx425F45kowmr6RMytOIBSi
        OVKxcNhqfChSowSNb0COB3WRuEp1lri1E7Grwm6nbFYslFITsGIA
X-Google-Smtp-Source: AGHT+IG2vlQncNwaL0mmf9ziNDQ+6c9ln+am4OcVzZ69yv7TcOY3i+q6gckxUGP152XYVi1xj1I6LdPgzXEO0LROnnE=
X-Received: by 2002:a25:d707:0:b0:d8d:5dc1:b463 with SMTP id
 o7-20020a25d707000000b00d8d5dc1b463mr3381310ybg.64.1696457382451; Wed, 04 Oct
 2023 15:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230918093751.1188668-1-msp@baylibre.com>
In-Reply-To: <20230918093751.1188668-1-msp@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Oct 2023 00:09:06 +0200
Message-ID: <CAPDyKFrUbWBQgMm6wYwFfybiRQKhBpwH7wwcXaT+KrQJLevq3w@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] soc: mediatek: MT8365 power support
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 11:38, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
>
> Hi,
>
> no real changes in this update. Rebase to v6.6-rc2 and according change
> of directory.
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
>   BUS_PROT_WR(_hwip, ...) etc.
> - Use the final bit values for scpsys_bus_prot_flags from the beginning
>   of the series.
> - Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
>   MTK_SCPD_STRICT_BUS_PROTECTION.
>
> Changes in v5:
> - Create defines for all registers and bits in mt8365 power domain patch
> - Redesign scpsys_bus_prot_data to use flags to store reg_update,
>   clr_ack as well as the difference between SMI and INFRACFG. The code
>   uses the appropriate regmap depending on the flags.
> - The WAY_EN patch now uses two flags, one for inverted operations
>   'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
>   'BUS_PROT_STA_COMPONENT_INFRA_NAO'.
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
>   soc: mediatek: Add support for WAY_EN operations
>   soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap
>
> Fabien Parent (2):
>   dt-bindings: power: Add MT8365 power domains
>   soc: mediatek: pm-domains: Add support for MT8365
>
> Markus Schneider-Pargmann (4):
>   soc: mediatek: pm-domains: Move bools to a flags field
>   soc: mediatek: pm-domains: Split bus_prot_mask
>   soc: mediatek: pm-domains: Create bus protection operation functions
>   soc: mediatek: pm-domains: Unify configuration for infracfg and smi
>
>  .../power/mediatek,power-controller.yaml      |   6 +
>  drivers/pmdomain/mediatek/mt6795-pm-domains.h |  16 +-
>  drivers/pmdomain/mediatek/mt8167-pm-domains.h |  20 +-
>  drivers/pmdomain/mediatek/mt8173-pm-domains.h |  16 +-
>  drivers/pmdomain/mediatek/mt8183-pm-domains.h | 125 ++++++----
>  drivers/pmdomain/mediatek/mt8186-pm-domains.h | 236 ++++++++++--------
>  drivers/pmdomain/mediatek/mt8188-pm-domains.h | 223 +++++++++++------
>  drivers/pmdomain/mediatek/mt8192-pm-domains.h | 112 ++++++---
>  drivers/pmdomain/mediatek/mt8195-pm-domains.h | 199 +++++++++------
>  drivers/pmdomain/mediatek/mt8365-pm-domains.h | 197 +++++++++++++++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    | 157 ++++++++----
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |  51 ++--
>  .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
>  include/linux/soc/mediatek/infracfg.h         |  41 +++
>  14 files changed, 972 insertions(+), 446 deletions(-)
>  create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h
>  create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
>

Applied for next, thanks!

Note that while applying I amended the patch-prefix for patch 2->8 to
"pmdomain: mediatek:", please try to conform to this when going
forward, as it help me to better filter emails.

Kind regards
Uffe
