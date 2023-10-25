Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018137D6CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjJYNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJYNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:10:54 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ADE131
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:10:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C53E1C0008;
        Wed, 25 Oct 2023 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698239448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvYmcIcCGRiRBdovjjijg/K4s2UhXR/ugjcSPeRqWQE=;
        b=fqr6A0QBx9OdbMBlweZ9mllXJ7PsOsV/vG9zCJ7AAInKEDTkgJ99KTerKJfFitSfZGBXzS
        nXuZL5vf8rPYgtMa6tRnOeK72TRI0l5+LSZyc2+iFzlZHq48PhLopt35AaYpre5fV/yaLc
        ORA/A+OmQ/PaNW41tigZrrB7VvwA4vtoYR9mMKISfATlYnq5yZlX7qf9CcPOxxxOAvFuDd
        Mq/URw2B1q12lXcQbUfJKwb1R1phtOGcyk82F02xaGzt7udpVzxYw3tv/HC3b4jHO8nrAE
        nCYSjfVKTrGBxdrhhTv7jGeCs42RvUicO9X66Sh5OfyOefN65MP0NpPrJzQc4Q==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] drm/logicvc: Define max dimensions from USHRT_MAX
Date:   Wed, 25 Oct 2023 15:09:46 +0200
Message-ID: <20231025130946.119957-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025130946.119957-1-paul.kocialkowski@bootlin.com>
References: <20231025130946.119957-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing macro instead of redefining it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/logicvc/logicvc_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_regs.h b/drivers/gpu/drm/logicvc/logicvc_regs.h
index 4aae27e9ba2b..0fc413fef6dd 100644
--- a/drivers/gpu/drm/logicvc/logicvc_regs.h
+++ b/drivers/gpu/drm/logicvc/logicvc_regs.h
@@ -10,7 +10,7 @@
 #ifndef _LOGICVC_REGS_H_
 #define _LOGICVC_REGS_H_
 
-#define LOGICVC_DIMENSIONS_MAX		(BIT(16) - 1)
+#define LOGICVC_DIMENSIONS_MAX		USHRT_MAX
 
 #define LOGICVC_HSYNC_FRONT_PORCH_REG	0x00
 #define LOGICVC_HSYNC_REG		0x08
-- 
2.42.0

