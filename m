Return-Path: <linux-kernel+bounces-90138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B686FAE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3261F2287A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB31428B;
	Mon,  4 Mar 2024 07:32:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21F171AC;
	Mon,  4 Mar 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537536; cv=none; b=JJIoI0pABbwKTj8qyhRD0mPgUh1iwX/FRAYWeQ5oKohRVqpE8lVVQksySTJFlkakpJ6SK5fC2ANBSBG1FFSt1tXVOqcn5VBBmJEskAE/Lme0UMA2jxNexYtLWG9kdgI33p2OO1HnsZdoWiBOzasqLxGon2MNNSKbY8XmkDAMUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537536; c=relaxed/simple;
	bh=RagmrRWQq0m3oiVO8oHg3x7fGhfbXpfmjQaGVkqERQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uvPN188Pevk9QMb/566GhuIL3b2YztqOTVLoSWN4hAEYgbCIojdTGqq8+99Q+ywb7UOp9cYUuHkUbOQSLlaz2F+lv0DoKKfccbJSnq6ggfRvMPvWHctGqFLSv3P0ALn6pFvTOMVBt6UbHG+hFSlGrU+/+UiUImDfpsdKaoGjmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6f1873923ca1490ba3bc406d5f42efba-20240304
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d5def658-cfa3-4510-acc1-3599ecb64312,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:d5def658-cfa3-4510-acc1-3599ecb64312,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:0c6e79ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240304111709GTSTWZ2V,BulkQuantity:9,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6f1873923ca1490ba3bc406d5f42efba-20240304
X-User: huxiaoying@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <huxiaoying@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1626496290; Mon, 04 Mar 2024 15:31:59 +0800
From: Tom Hu <huxiaoying@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	Tom Hu <huxiaoying@kylinos.cn>
Subject: [PATCH v2] usb-storage: Add Brain USB3-FW to IGNORE_UAS
Date: Mon,  4 Mar 2024 15:30:31 +0800
Message-Id: <20240304073031.225422-1-huxiaoying@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UAS mode of BRAIN USB_HDD is reported to fail to work on several
platforms with the following error message, then after re-connecting the
device will be offlined and not working at all.

[  622.518442][ 2] sd 8:0:0:0: [sda] tag#17 uas_eh_abort_handler 0 uas-tag 18
                   inflight: CMD
[  622.527575][ 2] sd 8:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 03 6f 88 00 00
                   04 00 00
[  622.536330][ 2] sd 8:0:0:0: [sda] tag#0 uas_eh_abort_handler 0 uas-tag 1
                   inflight: CMD
[  622.545266][ 2] sd 8:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 07 44 1a 88 00
                   00 08 00

These disks have a broken uas implementation, the tag field of the status
iu-s is not set properly, so we need to fall-back to usb-storage.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hu Xiaoying <huxiaoying@kylinos.cn>
---
v2: remove junk information from patch.

 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1f8c9b16a0fb..98b7ff2c76ba 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_LUNS),
 
+/* Reported-by: Tom Hu <huxiaoying@kylinos.cn> */
+UNUSUAL_DEV(0x1234, 0x1234, 0x0000, 0x9999,
+		"Brain",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
 UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
 		"Initio Corporation",
-- 
2.25.1


