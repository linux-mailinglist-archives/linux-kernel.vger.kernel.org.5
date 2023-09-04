Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7D791B49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353314AbjIDQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbjIDQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:16:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830CE1980;
        Mon,  4 Sep 2023 09:16:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A995866072B8;
        Mon,  4 Sep 2023 17:16:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693844183;
        bh=zFqttaYZLcrzVe0HaglrMmejxKKOSu901QLw+H/wB0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLzwg6q5d/mdGSkc1ECUOZVhKdYSEY5X/XCHBSHOMPcZH2jrOF8qCm8QEM2zYnWzP
         2r17Hdxji0WxRB16GmbqcVQ9f1WteLQboMKvOqfS5cjnb3C4eLoRljgCRZehzqA2Ig
         h5XcooSx409BCPk7J6pw0jp/uCmKOZ8CobD2TddN6e+bfa14FT1TMWRFpNRBNrylw5
         EFAD6FQuD1JTeSI09eQEUfuxAXf1bqbadl138cK46fTCBRxnK5l6H5Pwd/kGQAW9/D
         e5TNK/JqcZxTDUWinriKuial1gEXWkmmN2wbY0xyohz8QQO3kU/a4VC2T8a3/q9FmP
         HWBOe0Xoy//9g==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        emma@anholt.net, robclark@freedesktop.org, robdclark@google.com,
        anholt@google.com, robdclark@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, jani.nikula@linux.intel.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/7] drm: ci: Enable configs to fix mt8173 boot hang issue
Date:   Mon,  4 Sep 2023 21:45:13 +0530
Message-Id: <20230904161516.66751-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904161516.66751-1-vignesh.raman@collabora.com>
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable regulator
Enable MT6397 RTC driver

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes
  
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

