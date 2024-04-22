Return-Path: <linux-kernel+bounces-152702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D928AC320
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BA01C209A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E2EAF6;
	Mon, 22 Apr 2024 03:38:43 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E45DDAB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757123; cv=none; b=c4yudkBShCe+GIujznEV4AbhgAhOHq0/1PwL084nZ2sI139KV0pUyho1EEfU5P4KvQjEqHL7CVRBeVRzKRl8XMVtFArZ/5hAFQb3JoDkx4OgRiWyilcbU0mbz1f9Thf9FXw9qYHHLPIAkSpBqbSWZszx6PWmr1El7UUpVw45WQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757123; c=relaxed/simple;
	bh=HmgUjEtE2D65gXb4uwnzJYArIQyX/6Kk/HUdfLvGQbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXaXR6uDB5AntekrgiQZTIgLchLw5m9vBorzuTCR9XA1SKl4eempaE366bh9ZemWIinfLQCNjoJw3FQAQjsBFdAUaSsaKcFnSYLAxW1NAc0jqjo2GJqJQN++LLlIWGqHwU2Pg7IKVfLkuIYnbpaluc1MUVOUL4gPWe0ivALr7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4ba26e00005811ef9305a59a3cc225df-20240422
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3cc5f76e-1216-462c-9101-c3fdefd9e948,IP:25,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-6
X-CID-INFO: VERSION:1.1.37,REQID:3cc5f76e-1216-462c-9101-c3fdefd9e948,IP:25,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-6
X-CID-META: VersionHash:6f543d0,CLOUDID:de48ecc80ffdb81986e69b4a94ad0c9a,BulkI
	D:240422112750583FJ6BJ,BulkQuantity:0,Recheck:0,SF:25|72|19|44|66|38|102,T
	C:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
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
X-UUID: 4ba26e00005811ef9305a59a3cc225df-20240422
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1761472885; Mon, 22 Apr 2024 11:27:49 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: david@redhat.com,
	lrh2000@pku.edu.cn,
	josef@toxicpanda.com,
	vishal.moola@gmail.com,
	gehao618@163.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/page-flags: make PageUptodate return bool
Date: Mon, 22 Apr 2024 11:27:25 +0800
Message-Id: <20240422032725.41452-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make PageUptodate return bool to align the return
values of folio_test_uptodate function

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 652d77805e99..497ec781a681 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -764,7 +764,7 @@ static inline bool folio_test_uptodate(const struct folio *folio)
 	return ret;
 }
 
-static inline int PageUptodate(const struct page *page)
+static inline bool PageUptodate(const struct page *page)
 {
 	return folio_test_uptodate(page_folio(page));
 }
-- 
2.25.1


