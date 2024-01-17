Return-Path: <linux-kernel+bounces-28763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139498302BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659ACB20DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453414271;
	Wed, 17 Jan 2024 09:49:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364C14264
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484963; cv=none; b=DC5ZVDC5wdlVS4Eu9tTcbQjXbVfvCuup44Vm4YZ29tqDipbQawKpSXYX676RYAdzrafawRS620i958FUuYdARJeV+scJqDqdn371U50N31OEUOw3rITdWf4t+3JRoopB8QQ4r4vm2iByW0FcbR+22PFoeDbuCrhiqsO33KKAiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484963; c=relaxed/simple;
	bh=7GWS1V6NjJSHOFU7bkOXSHE/D7l3qrvU5HZcUfH1Vnk=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=NcndrdFmYeVZvnpi7+ljvMn4+5sEs8rIsbkW6qgqh74qpMVsBWfiaXkW1vxl4UfhnXMmVOyJvViJyRdlGIbiRynsNINw2VHBr1BRxSp+UQouaH00Mg4RE0/Yv06ceaHWs+vjFUZZs3CsoD9meGXS/GbllIx9EvfmZdqkuCVremg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a3c479c79494d19a82d0990871f5611-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:99b7ab5f-8fc9-4f37-af81-8e90cc9060ab,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:99b7ab5f-8fc9-4f37-af81-8e90cc9060ab,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:f0ac432f-1ab8-4133-9780-81938111c800,B
	ulkID:240117174916YVG0YATC,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6a3c479c79494d19a82d0990871f5611-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 757765849; Wed, 17 Jan 2024 17:49:15 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0B315E000EB9;
	Wed, 17 Jan 2024 17:49:15 +0800 (CST)
X-ns-mid: postfix-65A7A29A-856248760
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 911CEE000EB9;
	Wed, 17 Jan 2024 17:49:14 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] fs: dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create
Date: Wed, 17 Jan 2024 17:49:12 +0800
Message-Id: <20240117094912.155729-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6296c62c10fa..712165a1e567 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -248,7 +248,7 @@ struct kmem_cache *dlm_lowcomms_writequeue_cache_crea=
te(void)
=20
 struct kmem_cache *dlm_lowcomms_msg_cache_create(void)
 {
-	return kmem_cache_create("dlm_msg", sizeof(struct dlm_msg), 0, 0, NULL)=
;
+	return KMEM_CACHE(dlm_msg, 0);
 }
=20
 /* need to held writequeue_lock */
--=20
2.39.2


