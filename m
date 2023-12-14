Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6384B81360C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjLNQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:20:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B710A;
        Thu, 14 Dec 2023 08:20:28 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rDoRR-0005iB-OR; Thu, 14 Dec 2023 17:20:05 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: display: rockchip,inno-hdmi: Document RK3128
 compatible
Date:   Thu, 14 Dec 2023 17:20:04 +0100
Message-ID: <2221612.3VsfAaAtOV@diego>
In-Reply-To: <df84a0cc-cb38-431f-864b-012ada7bb0d5@linaro.org>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <288857ab-bebd-4f80-9cdc-9b04fa6c7386@gmail.com>
 <df84a0cc-cb38-431f-864b-012ada7bb0d5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2023, 17:07:27 CET schrieb Krzysztof Kozlowski:
> On 14/12/2023 16:22, Alex Bee wrote:
> > 
> > Am 14.12.23 um 08:53 schrieb Krzysztof Kozlowski:
> >> On 13/12/2023 20:51, Alex Bee wrote:
> >>> Document the compatible for RK3128's HDMI controller block.
> >>> The integration for this SoC is somewhat different here: It needs the PHY's
> >> Please wrap commit message according to Linux coding style / submission
> >> process (neither too early nor over the limit):
> >> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> > OK. Not sure why checkpatch --strict  didn't tell me that I'm over the 
> > limit here.
> >>
> >>> reference clock rate to calculate the ddc bus frequency correctly. This
> >>> clock is part of a power-domain (PD_VIO), so this gets added as an optional
> >>> property too.
> >> If clock is part of power domain, then the power domain must be in the
> >> clock controller, not here. So either you put power domain in wrong
> >> place or you used incorrect reason for a change.
> >   Rockchip defines it's powerdomains per clock and I was little to much 
> > in that world when writing this. Actually the controller itself is part 
> > of the powerdomain. Will rephrase.
> 
> Does it mean you have like 200 different power domains in one SoC? Then
> how are they different than clock if there is one-to-one mapping?

It's more like the other way around. Controllers and their clocks belong
to specific power-domains. So there are of course more clocks than domains.




