Return-Path: <linux-kernel+bounces-34575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682D8381A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D211C24A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77644442A;
	Tue, 23 Jan 2024 01:12:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437C3C3F;
	Tue, 23 Jan 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972323; cv=none; b=dt+HJ5gwF/tJm4JMogFEn+2Uglohiwr6wTwdg7GjcKMcXHQHD7XqF3d0AbufrC17wfh/0B76ammJyMcy+Ia3+JV6DGe4BV93EEMi1ew95ndpC3aSzUcjXgED2G1f1Elfs6GrVVunKwQglRp+SXLBBfeoHdRfWORGjkjjMdFLz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972323; c=relaxed/simple;
	bh=W/F9+FOnuXtpYbwfUt6UiEh6czwR/jZUdZbhJZ2b3ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QcA66ieQPXT51sX0Alma4ghNU6dVRNIrptRyqCWffem7S2uUvo/fgNVNUbhVKN6EkjyhGz6lrh2mSqBoHMiMpAyO1Yc3FOoqW+KxbmGfYxd8IL7q7Obed9hC1dt6e33BcahRClUjghrpDlDNt7zViqpnIj0vc8Yya3eQMYDs4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb7316e849fc4beb9305547c3302b2e7-20240123
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:dfb64aab-61b1-4851-9f5d-ad4ec6a2f7e9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:dfb64aab-61b1-4851-9f5d-ad4ec6a2f7e9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:92218a8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401230911518DL3C44Z,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cb7316e849fc4beb9305547c3302b2e7-20240123
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 257690614; Tue, 23 Jan 2024 09:11:49 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Cong Liu <liucong2@kylinos.cn>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: Fix memory leak in amd_pmf_get_pb_data()
Date: Tue, 23 Jan 2024 09:11:47 +0800
Message-Id: <20240123011147.6843-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_pmf_get_pb_data() will allocate memory for the policy buffer,
but does not free it if copy_from_user() fails. This leads to a memory
leak.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 502ce93d5cdd..f8c0177afb0d 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -298,8 +298,10 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
 	if (!new_policy_buf)
 		return -ENOMEM;
 
-	if (copy_from_user(new_policy_buf, buf, length))
+	if (copy_from_user(new_policy_buf, buf, length)) {
+		kfree(new_policy_buf);
 		return -EFAULT;
+	}
 
 	kfree(dev->policy_buf);
 	dev->policy_buf = new_policy_buf;
-- 
2.34.1


