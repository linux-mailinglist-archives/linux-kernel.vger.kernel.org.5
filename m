Return-Path: <linux-kernel+bounces-101464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1087A776
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA852847ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF82405DF;
	Wed, 13 Mar 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OJFNyDrt"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FED1E531
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332410; cv=none; b=QAb5PkCfx7ysp2uAS86EQyXpF8irHwIF6pXEsl49WsqaTlVBTh1eLeggVaM9M5WQoMn7a4Tw2SCh7Nv+4zmnEekWKWHWOKQbrdHBSqZLzD6dJfO/vlKAQ8by6FlGY+CSe+h1uRk4iZnCEqBdgrEHmDypjD9ARn2iRcf8tya202Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332410; c=relaxed/simple;
	bh=kRcXtIS0ZB+5A1tH+RAb/Y3bMwHWyq/xrkLxiZ8FCuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlRO1JqC9jA2Hwh98kO2ly1bGfk4jlTnTXvejPdtjq+zPu+SceMScF1e181hNnNcOoLe/eo9XdAumafaHz3AlE+P3OSZoEOuwBsipuAMYXnQTzINnWmzqsizEkR23FdBnGal51nZ5VY6AsyOHS+qIhkEdBptqPr8OZ9JZyOVjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.helo=mailgw01.mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OJFNyDrt; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mailgw01.mediatek.com
X-UUID: 0542496ee13411eeb8927bc1f75efef4-20240313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=or3eZs8Nrn7r67hSRxouiC9/TCgQeXLDBKP3b0Zq57o=;
	b=OJFNyDrtC3+oQbXmk5FsU5zXM1+tzZHvj/J5qyvfWsMtHLD1AgslKEOeNhlycK8tcUFyA3akbVofeu1D7cgkg84q7sBHWfwhXFy7b1X1ACIoXd4fr4xTE/W97WuHImBtJ68G1yiD0PJ8/AYvB1WtQMcysUDiqOUEs/6Uo62r8IQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:607074f0-30ea-4ce9-a3c9-c7fe5cb0a1dd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:10,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:0fc95b90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:20,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0542496ee13411eeb8927bc1f75efef4-20240313
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <empty.sender@empty.domain>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1803951228; Wed, 13 Mar 2024 20:20:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Mar 2024 20:20:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Mar 2024 20:20:02 +0800
From: John Hsu <john.hsu@mediatek.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <surenb@google.com>, John Hsu <john.hsu@mediatek.com>, Chinwen Chang
	<chinwen.change@mediatek.com>, Casper Li <casper.li@mediatek.com>, "Kuan-Ying
 Lee" <Kuan-Ying.Lee@mediatek.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH] direct-dma: WARN_ON_ONCE when the page is not addressable by device's coherent_dma_mask
Date: Wed, 13 Mar 2024 20:19:30 +0800
Message-ID: <20240313121933.15839-1-john.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.982500-8.000000
X-TMASE-MatchedRID: ApWTbtae/ntKpt0bXTOsseIfK/Jd5eHm5Y0kb0hqatzb6Y+fnTZULx8+
	XHETeZCzWC2b8unx+lIBXdtZPWfJ2ti5OqTR/Gdcdj6ndECc9fQwCmrLlx+Sdd9RlPzeVuQQrWv
	A11V1iKmeI7jQOR42AmzlLAWyLHZTHxPMjOKY7A+Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDWuik
	CL8VXXTOdCoM5AWaTNQYSNUwqrAIm7Om/jsUAZXIZt0Zt5H8bBdGByp+zdaDg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.982500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DDC29104D7E7600799E9307E9FEDE743D00DAE66AF562F97600BD1818E0CF95B2000:8
X-MTK: N

From: JohnHsu <john.hsu@mediatek.com>

The dma_direct_alloc() may return null in some cases. For example, the
allocated page is not addressable for the device's coherent_dma_mask,
and the allocated page will be assigned to null.

This patch can WARN_ON_ONCE() when the returned page is null in
dma_direct_alloc. It helps the developers position the root cause of
allocation failure rapidly.

Signed-off-by: JohnHsu <john.hsu@mediatek.com>
---
 kernel/dma/direct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9596ae1aa0da..a73b8ad1ef9e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -156,6 +156,8 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		}
 	}
 
+	WARN_ON_ONCE(!page);
+
 	return page;
 }
 
-- 
2.18.0


