Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2A7E7342
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbjKIVEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbjKIVDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:03:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5246A6;
        Thu,  9 Nov 2023 13:03:43 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 864A16EF;
        Thu,  9 Nov 2023 22:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563799;
        bh=Ct1dLg9BPS1fwkfzrq+nudub5VExw7iMjnLi1u6l4d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBRmhbnkhXIfXNz1ErJ+UkmgnE3+s//2iJ/fWt2qT1Q7FwMdBtJkOcHQAuggFcgEa
         VNR2XJbQ1ftZ/4cjPhSJ65k0SxEELQNom3cOUkF95DWILjq6IZJDN7P1h9REF7AxU6
         aTcZA0DGdx65RM5hRInH25DDK/DaRW6B14CjWRw4=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 09/15] staging: vc04_services: Add helpers for vchiq driver data
Date:   Thu,  9 Nov 2023 16:03:01 -0500
Message-ID: <20231109210309.638594-10-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to set and get vchiq driver data.
vchiq_set_drvdata() and vchiq_get_drvdata() wraps
dev_set_drvdata() and dev_get_drvdata() respectively.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_bus.h      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
index caa6fdf25bb1..800f53bb48c2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
@@ -34,6 +34,16 @@ static inline struct vchiq_driver *to_vchiq_driver(struct device_driver *d)
 	return container_of(d, struct vchiq_driver, driver);
 }
 
+static inline void *vchiq_get_drvdata(const struct vchiq_device *device)
+{
+        return dev_get_drvdata(&device->dev);
+}
+
+static inline void vchiq_set_drvdata(struct vchiq_device *device, void *data)
+{
+        dev_set_drvdata(&device->dev, data);
+}
+
 extern struct bus_type vchiq_bus_type;
 
 struct vchiq_device *
-- 
2.41.0

