Return-Path: <linux-kernel+bounces-36273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438EB839E41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FFF1F2B058
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5C15CE;
	Wed, 24 Jan 2024 01:30:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE41842;
	Wed, 24 Jan 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059812; cv=none; b=fMaayZpveHBrBgIwQXZboIcdVjc7qsmb8mfms/IAuLuvDoB53Tnxkg7oe6QgajQ+DmDcgRLVTy8dG4HDUYN5ZTPJe+ESYMn9JUpJvGmqWwDNgkpG/3r4D2RvgvuZb+Zw/+QvvX1EcCzMo475syILa/1HOEN3U0D52KOJqJ59uAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059812; c=relaxed/simple;
	bh=NtAGrG5ZVUfxOpHnwIUN/o79MwAWDi+dzyZYGdfD7Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnOVpzj6XvD4WEVs4tORMAuM6k92sXjxegRsOQXB1ZMwtldkhpkhwgPZtZIpGzjHlOj5B7ugdyygnk86anIVK3lEByRUmBI2Qj0rwizLwuRvwnSemMavFpq16UyhbeQXbaNZnLNVQo/XLe/jA3M01ALJjUmmBVuIWgZXzzwANj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bbcbf84f5b84bd5b7f9669488c5eb53-20240124
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:cd248ffa-ee3d-4b45-8f20-b57da0cb9ae0,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:cd248ffa-ee3d-4b45-8f20-b57da0cb9ae0,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:e9a613fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240124093002G6S37MJB,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 0bbcbf84f5b84bd5b7f9669488c5eb53-20240124
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1784765844; Wed, 24 Jan 2024 09:30:01 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: shyam-sundar.s-k@amd.com,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-kernel@vger.kernel.org,
	liucong2@kylinos.cn,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86/amd/pmf: Fix memory leak in amd_pmf_get_pb_data()
Date: Wed, 24 Jan 2024 09:29:38 +0800
Message-Id: <20240124012939.6550-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b7bd8769-5f97-4c9a-be80-8d1acac92b19@amd.com>
References: <b7bd8769-5f97-4c9a-be80-8d1acac92b19@amd.com>
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

Fixes: 10817f28e533 ("platform/x86/amd/pmf: Add capability to sideload of policy binary")
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
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


