Return-Path: <linux-kernel+bounces-161217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9C8B4924
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0821F21EF3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB02110A;
	Sun, 28 Apr 2024 01:47:44 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3C818;
	Sun, 28 Apr 2024 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714268863; cv=none; b=WKQZvtNED5zvgtl1uZBXBd3eGmBg4hQ/caP3tSTjrqerNHiCYP0IZNkCcIFWzomL8FPt9rcafraQKnrZER2KwJUa9njELy/vJww51vnsVYHJGjGz8QaFZ3IHDEHFamIXOMMg9rT3UAsCsKWjQppkA3KdFlzXf/XMBacxcV1CRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714268863; c=relaxed/simple;
	bh=ikOi+uDK8epeGqvxSfiFVSemIj6ySgZQCVG2dkQQHT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnMlPmwlEAW9kb6EuZxYFLetlbP9EA61kGAYOs5gJk/XB+Uo81SoVXMfaVgUp1oKbWABcOn6Xr28RaKEGhNCmhObbsqJcJVXna8AkbpojizGQOVSgiKTa0fKa+7GCqAUtW0RWD/SgaBvrMFRPPpPBVSXBPMFyuLXHtHBQLk5JPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 481ae35e050111ef9305a59a3cc225df-20240428
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:59f421bb-1977-4ec0-9785-0162880479c4,IP:25,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-11
X-CID-INFO: VERSION:1.1.37,REQID:59f421bb-1977-4ec0-9785-0162880479c4,IP:25,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-11
X-CID-META: VersionHash:6f543d0,CLOUDID:4d174e793c43c25dc3d9e9d0d80dc204,BulkI
	D:240428094735YIB4OV1A,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|25|102,T
	C:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
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
X-UUID: 481ae35e050111ef9305a59a3cc225df-20240428
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1783356139; Sun, 28 Apr 2024 09:47:33 +0800
From: Hao Ge <gehao@kylinos.cn>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/pagemap: Make trylock_page return bool
Date: Sun, 28 Apr 2024 09:47:11 +0800
Message-Id: <20240428014711.11169-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make trylock_page return bool to align the return values of
folio_trylock function and it also corresponds to its comment.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 include/linux/pagemap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..d8e2f7e0f66f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1014,7 +1014,7 @@ static inline bool folio_trylock(struct folio *folio)
 /*
  * Return true if the page was successfully locked
  */
-static inline int trylock_page(struct page *page)
+static inline bool trylock_page(struct page *page)
 {
 	return folio_trylock(page_folio(page));
 }
-- 
2.25.1


