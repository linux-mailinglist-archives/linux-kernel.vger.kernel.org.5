Return-Path: <linux-kernel+bounces-161211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F68B490D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75F4B218A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 01:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CCEC3;
	Sun, 28 Apr 2024 01:21:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7764A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267299; cv=none; b=lb9POVj+DBnCl8R4QK3iGLjXk8lryykD6mGh83uj9iwbJnTt1lANMiR8kOg4MtVEpidPIm0CZcCwJQp9uSZiG7qhe1VcaAz3VGXbVjJmHrgRYDt8Og6Df+QBONJ+cXfnocPz9u0FvSXtuZoMWEzwmde6Zqm/oEKy5x5GVjlaAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267299; c=relaxed/simple;
	bh=5g/JR4o7HrP8CS0M4uDLmZ7HU5Rvun5gbli8N8yWFoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BtF+rmeUmjY5EEVnDTfzgy6+ZsI+X7kIOu/qh24ph2DId4yiP/EaI6OYSW6knfJWPCZC8JA9Lib34elbWZOgnrQF7feuyd6UrmPsVtap77Xv5bVJfoT5KnEgUsPBw3krmMbr6LemnxxEuPejPBw50aZoATFiMm1bgK1cbIG4BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9f1c4fb604fd11ef9305a59a3cc225df-20240428
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8d49a0f7-8ac2-47aa-8d16-ca02200dd778,IP:25,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-11
X-CID-INFO: VERSION:1.1.37,REQID:8d49a0f7-8ac2-47aa-8d16-ca02200dd778,IP:25,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-11
X-CID-META: VersionHash:6f543d0,CLOUDID:0ebebc4c11699d78e967bf3d645ee0eb,BulkI
	D:240426175541Y4NRBIGM,BulkQuantity:1,Recheck:0,SF:44|66|25|17|19|102,TC:n
	il,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: 9f1c4fb604fd11ef9305a59a3cc225df-20240428
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 874946051; Sun, 28 Apr 2024 09:21:21 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/rmap: change the type of we_locked from int to bool
Date: Sun, 28 Apr 2024 09:20:48 +0800
Message-Id: <20240428012049.8182-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the type of we_locked from int to bool
because folio_trylock return bool

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 3746a5531018..3da95b911cc0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -961,7 +961,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
 int folio_referenced(struct folio *folio, int is_locked,
 		     struct mem_cgroup *memcg, unsigned long *vm_flags)
 {
-	int we_locked = 0;
+	bool we_locked = false;
 	struct folio_referenced_arg pra = {
 		.mapcount = folio_mapcount(folio),
 		.memcg = memcg,
-- 
2.25.1


