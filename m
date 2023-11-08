Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3707E5A68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjKHPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjKHPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:46:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE3210B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:46:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D4DC433C8;
        Wed,  8 Nov 2023 15:46:02 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from irqchip to core
Date:   Wed,  8 Nov 2023 15:46:00 +0000
Message-Id: <169945831991.2744977.435558730470523982.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 07:26:56 -0800, Douglas Anderson wrote:
> In commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on
> Mediatek devices w/ firmware issues") we added a method for detecting
> Mediatek devices with broken firmware and disabled pseudo-NMI. While
> that worked, it didn't address the problem at a deep enough level.
> 
> The fundamental issue with this broken firmware is that it's not
> saving and restoring several important GICR registers. The current
> list is believed to be:
> * GICR_NUM_IPRIORITYR
> * GICR_CTLR
> * GICR_ISPENDR0
> * GICR_ISACTIVER0
> * GICR_NSACR
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/2] arm64: Move Mediatek GIC quirk handling from irqchip to core
      https://git.kernel.org/arm64/c/1d816ba168ea
[2/2] Revert "arm64: smp: avoid NMI IPIs with broken MediaTek FW"
      https://git.kernel.org/arm64/c/4bb49009e071

Also "s/Mediatek/MediaTek/".

-- 
Catalin

