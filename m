Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52747FA0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjK0NXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjK0NW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0AF19B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A3AC433CA;
        Mon, 27 Nov 2023 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091372;
        bh=GAarMoewnkwJp9XLJQmcej2YbN3Q4NV+hfVw+jdVqdE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=po8G/Jd1b5AVxwfM7ACP6l3yi12wgDzzx5ru7waF6zgVpdZN39rWzCrIOAWLsSdGm
         N9rZ1yj6R1P8kCHvJxyS5qGtRQb6iJ2l0GWZZJX1NrpZ5vIIlaCiRyPOf2N7MPcGbD
         JU9imQ+VOMoYL2lj8HVUDSL3qTSApsBVQo45xWuJuaHk9+GyNhQiXfC2+RzX1ZNe5v
         AwlPtiHDdiwSonfwUeMkwxVLD9Wkvylt21nBNInPfQXgLORhP09ns4ptcDk7zF9wCV
         2DTCdcNfSFdjw0xMEDAkbNPZpDgSo0NLtK7v+0PkxrbhKZ/uZdNyNOu3a2ij+Eq9yA
         LWjaZ/qRhA8OQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Michael Walle <mwalle@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
In-Reply-To: <20231123133749.2030661-1-mwalle@kernel.org>
References: <20231123133749.2030661-1-mwalle@kernel.org>
Subject: Re: (subset) [PATCH 0/4] drm/mediatek: support DSI output on
 MT8195
Message-Id: <170109136570.42627.4378174652499590897.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:45 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Nov 2023 14:37:45 +0100, Michael Walle wrote:
> Add support for a DSI output on VDOSYS0. Luckily, there is a new
> feature to support dynamic selections of the output (connector).
> Use it to add support for a DSI output.
> 
> Apart from that, this is pretty straghtforward by just adding new
> compatibles and add the correct DSI nodes to the SoC dtsi.
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: phy: add compatible for Mediatek MT8195
      commit: fa50920b4f82993941e0aac349eb8081ce11e38f

Best regards,
-- 
~Vinod


