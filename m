Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E257FA0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjK0NWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjK0NWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B187B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E204C433C8;
        Mon, 27 Nov 2023 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091326;
        bh=Vwhxnt4f22Jqm2f+no8vVvfxwUzvv6b9URiNaYVC1Z4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RpTMTTF6H5EZOoQo5s387IJVl+0oeBUdDVeSUuFoNbGG2A0Cc6+NH6nOaBJSfZZYt
         GAZE9fh3lBe8TC1kOSdIcInp7kY6VNXTbxXscaP+EJdlTc0TUMSs5rLQTqYz4cT2hf
         JisWVOaGzuDff8PWoXHjRbFkmanTQAihWGKe22Sre8Uxa4T8luPRRD4lGv1n0mSsAo
         0gkhDeg4QQHDagB+mCkZBjTycS+ya9qCNKa80SS4GeWTEZ2ZzRYKACdS6wdWmwnsVq
         oWOvW/utbVfXf1yBQqIJcB86J4CahpI5/+YXDutlZv92VQRvE1jyL8xuvWnS4UudsS
         gzu/ujqknBwbA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>,
        Michael Walle <mwalle@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231123110202.2025585-1-mwalle@kernel.org>
References: <20231123110202.2025585-1-mwalle@kernel.org>
Subject: Re: [PATCH] phy: mediatek: mipi: mt8183: fix minimal supported
 frequency
Message-Id: <170109132204.42536.9999917712237405775.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:02 +0530
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


On Thu, 23 Nov 2023 12:02:02 +0100, Michael Walle wrote:
> The lowest supported clock frequency of the PHY is 125MHz (see also
> mtk_mipi_tx_pll_enable()), but the clamping in .round_rate() has the
> wrong minimal value, which will make the .enable() op return -EINVAL on
> low frequencies. Fix the minimal clamping value.
> 
> 

Applied, thanks!

[1/1] phy: mediatek: mipi: mt8183: fix minimal supported frequency
      commit: 06f76e464ac81c6915430b7155769ea4ef16efe4

Best regards,
-- 
~Vinod


