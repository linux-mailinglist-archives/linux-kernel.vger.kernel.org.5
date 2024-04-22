Return-Path: <linux-kernel+bounces-152954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB658AC695
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9071C206AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE1502AF;
	Mon, 22 Apr 2024 08:18:13 +0000 (UTC)
Received: from mail-m127105.qiye.163.com (mail-m127105.qiye.163.com [115.236.127.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FB4E1CE;
	Mon, 22 Apr 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773892; cv=none; b=gRWqPgWDuUpVwBtOz5N/ktBh4MloBojK2/6Z96jPuBLBAJeZawYjBJz0RJIgCPdYv0DKEB4ju7ctHFKoy+jOoAGUBCY8CfagygAvE6LZD0qlP33o6x7NJlV5IyFrOLXQ+yN/bjqLToKvVNAbSHrsPCyh1QGJqELK4oCW641cinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773892; c=relaxed/simple;
	bh=GSkHPZSUPFTzOCXW4eKUe6wm5+EVnEO+EwIHJH3hpCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uqnmt+ut+oupRwUki4dsUa/iM92dnZAWx3s0N06OUvu68AYIrFSREye5JG+JHjAVfbEx+x07wu3Zj7FwS+BZnmL9hyVn3LvcsJ6RjIfR8bR69RmASu+D5Tdcvc1+ttSsAy0rjohRA+IXbau+U9K8NJeydZ6xzJXbep6gKRYA6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1D103860262;
	Mon, 22 Apr 2024 15:01:31 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/3] cxl/memdev: Improve sanitize ABI descriptions
Date: Mon, 22 Apr 2024 07:01:21 +0000
Message-Id: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEpDVktOGUpOTR4ZGhlLT1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f049c1e81023ckunm1d103860262
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6LAw*GTc9HRw9IhFCGQI9
	AxxPCh1VSlVKTEpITE1CSUJKQkJLVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSEtOSzcG

From: Davidlohr Bueso <dave@stgolabs.net>

Be more detailed about the CPU cache management situation. The same
goes for both sanitize and secure erase.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230726051940.3570-2-dave@stgolabs.net
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6350dd82b9a9..c4c4acb1f3b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -82,7 +82,11 @@ Description:
 		whether it resides in persistent capacity, volatile capacity,
 		or the LSA, is made permanently unavailable by whatever means
 		is appropriate for the media type. This functionality requires
-		the device to be not be actively decoding any HPA ranges.
+		the device to be disabled, that is, not actively decoding any
+		HPA ranges. This permits avoiding explicit global CPU cache
+		management, relying instead for it to be done when a region
+		transitions between software programmed and hardware committed
+		states.
 
 
 What            /sys/bus/cxl/devices/memX/security/erase
@@ -92,7 +96,12 @@ Contact:        linux-cxl@vger.kernel.org
 Description:
 		(WO) Write a boolean 'true' string value to this attribute to
 		secure erase user data by changing the media encryption keys for
-		all user data areas of the device.
+		all user data areas of the device. This functionality requires
+		the device to be disabled, that is, not actively decoding any
+		HPA ranges. This permits avoiding explicit global CPU cache
+		management, relying instead for it to be done when a region
+		transitions between software programmed and hardware committed
+		states.
 
 
 What:		/sys/bus/cxl/devices/memX/firmware/
-- 
2.34.1


