Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D77E90C5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKLN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjKLN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432BD46A2;
        Sun, 12 Nov 2023 05:28:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C17C433C8;
        Sun, 12 Nov 2023 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795686;
        bh=Z1g+PkT9+YcNoLveB5s4Kcz6GlKNQUZJs2E9KCwoAeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPKEdb5IJVHS57BENgTORYjEI12D30X0B7bZjEI4jzBOYK8oyStAfed7QilHWzzTd
         nSo2eAXJ2yuGVReYjurZYlk408JIwMtPDHUkp8VxKw2CEAm/DphWaanAYnZ04kkWsb
         m0QxvaOHhWPGc7c7ymBD6wbO34ZJ8Jih2nVmFBWNNqcAsh/2z51cIefgrDV+ymCKnY
         uV03BLg8A92NPxggVxT/1H1qUJTjt3ukaLIUrgRrXepQ0qMgKhVBkqCzH0gJeMFR28
         d4WeEyYCssisMwc+3neEZaPge0h3ZRezRi9RixlpzN7LST8AJAWq9iCf1+1mg4Gyws
         btOsvG4JAzyhQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 07/10] media: ccs: Fix driver quirk struct documentation
Date:   Sun, 12 Nov 2023 08:27:50 -0500
Message-ID: <20231112132755.175757-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132755.175757-1-sashal@kernel.org>
References: <20231112132755.175757-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 441b5c63d71ec9ec5453328f7e83384ecc1dddd9 ]

Fix documentation for struct ccs_quirk, a device specific struct for
managing deviations from the standard. The flags field was drifted away
from where it should have been.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ccs/ccs-quirk.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-quirk.h b/drivers/media/i2c/ccs/ccs-quirk.h
index 5838fcda92fd4..0b1a64958d714 100644
--- a/drivers/media/i2c/ccs/ccs-quirk.h
+++ b/drivers/media/i2c/ccs/ccs-quirk.h
@@ -32,12 +32,10 @@ struct ccs_sensor;
  *		@reg: Pointer to the register to access
  *		@value: Register value, set by the caller on write, or
  *			by the quirk on read
- *
- * @flags: Quirk flags
- *
  *		@return: 0 on success, -ENOIOCTLCMD if no register
  *			 access may be done by the caller (default read
  *			 value is zero), else negative error code on error
+ * @flags: Quirk flags
  */
 struct ccs_quirk {
 	int (*limits)(struct ccs_sensor *sensor);
-- 
2.42.0

