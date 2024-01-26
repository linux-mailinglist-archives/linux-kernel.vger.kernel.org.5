Return-Path: <linux-kernel+bounces-39726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DE83D568
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440F21F26CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686536169A;
	Fri, 26 Jan 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f7tQ/Z9t"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BC125DB;
	Fri, 26 Jan 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255707; cv=none; b=iy4IH1EPpBVFodZxMQ39Gmf9HI5dXjQGHueAh/QIQuxdntzEtL6XF0fvX7EDMkuVdToiiB4ZKTq3Qx1AA6tfiNAgeQR5XG2Agio64DObg/p2dZ/cawT8ptLzq1EFmNhJKyE/Ww8FivIUwRjlnzPYAf2cmUorGeo9xB09/u2hp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255707; c=relaxed/simple;
	bh=PLcDYGc3A3KbkeSJVUSvsPSMylDJVowTLRFbic23reM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3085clUgDLVWZRmu+GrdZqG0KrdLvSHqRglFRKzQQA/Rf6Llq26jmFGL6PXh/qAZl4NLZQ+JoQ6zG+YweFoTe3poGPaz90H95qVs+oZda4l0EYJWgCLqw2QRcskA2y8ptiYeoeEXFxbooqPH53lvwDPFIBQoVjINxckXPeE5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f7tQ/Z9t; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706255695; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MNOY8Q5NDwaHI6XaoJ0LQ9C0/crVlCsDYm9O0vJ51+M=;
	b=f7tQ/Z9t9WKGeoWCxIPSBXoRZNDIwd6ZCDolGCz3ixx4fPdm6o+iBQ7QBfkNn2VPNYd4eyXWIhw1gJmo+eGkc2jWLAb6jMsx7ZVk9RRNV0SDZh1ELhtMvzw4Z5W201q/HSh6NygWV6W4uhiRP9njtSc2ECSCyHM0YoxmWv465Pc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.MzF4n_1706255688;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W.MzF4n_1706255688)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 15:54:54 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: djogorchock@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] HID: nintendo: Remove some unused functions
Date: Fri, 26 Jan 2024 15:54:45 +0800
Message-Id: <20240126075445.15495-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions are defined in the hid-nintendo.c file, but not called
elsewhere, so delete these unused functions.

drivers/hid/hid-nintendo.c:757:20: warning: unused function 'joycon_type_has_left_controls'.
drivers/hid/hid-nintendo.c:763:20: warning: unused function 'joycon_type_has_right_controls'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8060
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/hid-nintendo.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 7ce6be0a8dee..ab5953fc2436 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -754,18 +754,6 @@ static inline bool joycon_type_is_right_nescon(struct joycon_ctlr *ctlr)
 	return ctlr->ctlr_type == JOYCON_CTLR_TYPE_NESR;
 }
 
-static inline bool joycon_type_has_left_controls(struct joycon_ctlr *ctlr)
-{
-	return joycon_type_is_left_joycon(ctlr) ||
-	       joycon_type_is_procon(ctlr);
-}
-
-static inline bool joycon_type_has_right_controls(struct joycon_ctlr *ctlr)
-{
-	return joycon_type_is_right_joycon(ctlr) ||
-	       joycon_type_is_procon(ctlr);
-}
-
 static inline bool joycon_type_is_any_joycon(struct joycon_ctlr *ctlr)
 {
 	return joycon_type_is_left_joycon(ctlr) ||
-- 
2.20.1.7.g153144c


