Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E3788735
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbjHYM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbjHYM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:27:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBF2114;
        Fri, 25 Aug 2023 05:26:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.83.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D081660728C;
        Fri, 25 Aug 2023 13:25:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692966326;
        bh=NyIn73BQxUrufKyWq8BDAMtc8SZCd6gx2Lk9WFhK3Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8QshP2U5DJiUF7YueJ5M3UMGb/xy1qVTBpLqtvCvmRHlJ9Sev0qybWHNGqqfkqLh
         C+I8ZNkkUyuEOMVh+3pbLiP4PdBVFVxDHfyqF4GBcoR8WdQPcDZo0cmrBruIBH9du9
         5oaQf5x3Sva4vXLBt1fp5qlFm7by3HfwXc5zJWK05PAUi+Mj9fHICeO1ZH6uEXiXaQ
         UqyC/9VxpCRwt88OxRoBNt3DJhGnRcTB0Qw6aay2ovu08IwdcyvPOUnGvntLwAtbMr
         WWp3wPbhPwA9WH3D4/7HMPIKnjAJWhdJFTs8TuF/F5GvTXGFzWiWDkVAK/9haRwGfb
         jn9JQhk1DSqxQ==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, emma@anholt.net, robclark@freedesktop.org,
        gustavo.padovan@collabora.com, robdclark@google.com,
        anholt@google.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, corbet@lwn.net, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, heiko@sntech.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 4/6] drm: ci: Enable configs to fix mt8173 boot hang issue
Date:   Fri, 25 Aug 2023 17:54:33 +0530
Message-Id: <20230825122435.316272-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230825122435.316272-1-vignesh.raman@collabora.com>
References: <20230825122435.316272-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable regulator
Enable MT6397 RTC driver

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/arm64.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 817e18ddfd4f..ea7a6cceff40 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -184,6 +184,8 @@ CONFIG_HW_RANDOM_MTK=y
 CONFIG_MTK_DEVAPC=y
 CONFIG_PWM_MTK_DISP=y
 CONFIG_MTK_CMDQ=y
+CONFIG_REGULATOR_DA9211=y
+CONFIG_RTC_DRV_MT6397=y
 
 # For nouveau.  Note that DRM must be a module so that it's loaded after NFS is up to provide the firmware.
 CONFIG_ARCH_TEGRA=y
-- 
2.40.1

