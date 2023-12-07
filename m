Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE84808D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443747AbjLGPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443741AbjLGPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:52:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E61FC2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:51:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D15C433BA;
        Thu,  7 Dec 2023 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701964260;
        bh=xG3hS2ngUa/aofzm6kQ2kyb39tRnM/ERnWFUzHIz8Dk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hCecSIlialbxUNgslpXSkcNagMI7gQGMi+ZA0btXEZydBkbiGggQoR1himb57qsQX
         VXzGm7GGV3K0Vg3NvVvyq5oG+KxTZG5bL/4fXdGFY1oa+854tYaTZ19vPDgNphVqBR
         /btxmnErdxWwYm8F/dbKYV/E/a+OKlZZw+tQwpGvhkt/ZrN8W1yfj84yMHAy1MDSfS
         sCNSAncVi677qqpjaO8RhTOrC3FIL3eB1QI09VY8e+2eDuLf3nJFl6ApFlBgMfKtT0
         NzlgHQ0d+f+c5PPih9osuAc4KVCf9q+ffD8ZoZKAewrLGQpooYqrk1szemzECl2FZE
         Zb2mVIHTWPkVw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 07 Dec 2023 16:49:54 +0100
Subject: [PATCH v5 31/44] drm/rockchip: inno_hdmi: Remove useless enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-kms-hdmi-connector-state-v5-31-6538e19d634d@kernel.org>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xG3hS2ngUa/aofzm6kQ2kyb39tRnM/ERnWFUzHIz8Dk=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmFL9s65sepT5zr4pr81a7hjseU5Cs1zXlbwo5XW/mfO
 HLSrP9+RykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACZiXM/IcCBm5hURnvt+U8qt
 vxycIn5zbbbTkkPbSr4f9aidfW6dRgPD/yJP/0OKn4venZafYMcYpPlnw8NQs5/PAi53Mv6okpd
 p5QIA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSC_* enum has no users left, so let's remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index c342bc8b3a23..f05417c6b637 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -66,15 +66,6 @@ static struct inno_hdmi *connector_to_inno_hdmi(struct drm_connector *connector)
 	return container_of(connector, struct inno_hdmi, connector);
 }
 
-enum {
-	CSC_ITU601_16_235_TO_RGB_0_255_8BIT,
-	CSC_ITU601_0_255_TO_RGB_0_255_8BIT,
-	CSC_ITU709_16_235_TO_RGB_0_255_8BIT,
-	CSC_RGB_0_255_TO_ITU601_16_235_8BIT,
-	CSC_RGB_0_255_TO_ITU709_16_235_8BIT,
-	CSC_RGB_0_255_TO_RGB_16_235_8BIT,
-};
-
 static const char coeff_csc[][24] = {
 	/*
 	 * YUV2RGB:601 SD mode(Y[16:235], UV[16:240], RGB[0:255]):

-- 
2.43.0

