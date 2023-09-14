Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A279479FF20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbjINIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjINIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:55:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D81FDD;
        Thu, 14 Sep 2023 01:54:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 559036607346;
        Thu, 14 Sep 2023 09:54:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694681695;
        bh=r1jaHMPOHPCTM2uD5QgQxj8lASgXqxWcsduJK72LnYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKB1By0On5GV8IZ9K3s+PjwayG74dV/8I/purQcQsY+OQCPoR3o32qfJgNKUUsoXf
         SqkXNdhz2Ic+HorT016zwCFpCSTbBT1Dv95NBx7CCTGH+NwJiR6Grhh4xUuX5zA8/d
         Huh7BxNo6pxcBB977hLUMmZwe1C/OxLEgae5TTq8PTz4MSyLm9miJARaGxzXem2RdT
         CJsfL+9hsC4AqCgP8mXh0M2Ar1anV2GYrIjSN38SY38gYi+fwo4BfsQeZhbSIvp9Nb
         Ceh0tZiKZV9LAcYSFWLdRAYmzVL7euf7ed8p37qJGcEeNig5YxPZ4lC66FY14n+qaJ
         gYdAHyqOKihGQ==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 4/7] drm: ci: Enable regulator
Date:   Thu, 14 Sep 2023 14:24:23 +0530
Message-Id: <20230914085426.883255-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914085426.883255-1-vignesh.raman@collabora.com>
References: <20230914085426.883255-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_REGULATOR_DA9211=y to fix mt8173 boot issue.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes

v3:
  - Remove CONFIG_RTC_DRV_MT6397=y as it is already enabled in defconfig

v4:
  - No changes

---
 drivers/gpu/drm/ci/arm64.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 817e18ddfd4f..ca95e141a7ae 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -184,6 +184,7 @@ CONFIG_HW_RANDOM_MTK=y
 CONFIG_MTK_DEVAPC=y
 CONFIG_PWM_MTK_DISP=y
 CONFIG_MTK_CMDQ=y
+CONFIG_REGULATOR_DA9211=y
 
 # For nouveau.  Note that DRM must be a module so that it's loaded after NFS is up to provide the firmware.
 CONFIG_ARCH_TEGRA=y
-- 
2.40.1

