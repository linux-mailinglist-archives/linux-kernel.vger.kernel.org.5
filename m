Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52981152F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379307AbjLMOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379383AbjLMOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:46:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB118F;
        Wed, 13 Dec 2023 06:46:51 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rDQVN-0000JI-AG; Wed, 13 Dec 2023 15:46:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, sebastian.reichel@collabora.com,
        krzysztof.kozlowski+dt@linaro.org, chris.obbard@collabora.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: (subset) [PATCH v5 00/16] Add VOP2 support on rk3588
Date:   Wed, 13 Dec 2023 15:46:31 +0100
Message-Id: <170247871959.753029.11166929824242336708.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211115547.1784587-1-andyshrk@163.com>
References: <20231211115547.1784587-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 19:55:47 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> This patch sets aims at enable the VOP2 support on rk3588.
> 
> Main feature of VOP2 on rk3588:
> Four video ports:
> VP0 Max 4096x2160
> VP1 Max 4096x2160
> VP2 Max 4096x2160
> VP3 Max 2048x1080
> 
> [...]

Applied, thanks!

[10/16] dt-bindings: display: vop2: Add rk3588 support
        commit: 4ccdc92c1fea732fac8f3438d6288719055fa141
[11/16] dt-bindings: rockchip,vop2: Add more endpoint definition
        commit: dc7226acacc6502291446f9e33cf96246ec49a30
[12/16] drm/rockchip: vop2: Add support for rk3588
        commit: 5a028e8f062fc862f051f8e62a0d5a1abac91955
[13/16] drm/rockchip: vop2: rename VOP_FEATURE_OUTPUT_10BIT to VOP2_VP_FEATURE_OUTPUT_10BIT
        commit: 9d7fe7704d534c2d043aff2987f10671a8b4373d
[16/16] MAINTAINERS: Add myself as a reviewer for rockchip drm
        commit: 6c3ab21f37a97a868193ccbeb8a492e51210ff31


I skipped the debugfs patch for now, as I need to look at that separately
and of course the dts patch as that needs to wait for iommu maintainers
to pick up the binding addition.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
