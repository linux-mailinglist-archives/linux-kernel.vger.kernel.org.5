Return-Path: <linux-kernel+bounces-136219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DB89D159
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90B91C20FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4A56B67;
	Tue,  9 Apr 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SYhSaaT/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17055E45;
	Tue,  9 Apr 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634846; cv=none; b=rnZDnhYU7c8MzD5ADjg7Xnyf3fWplqFvnMYC3tfPpV2DacxGE6sa/A/fEm2AAduMr/kmlYOcXOOB4vEJncGfEvJZZYQKzvsrrwnpxe6hwFIA204R0u2wa9+lT0cSPZ5STWyzJZWUq0BoYXwP4a1QUpk0+wxLJTkVZ+KRsYot+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634846; c=relaxed/simple;
	bh=VaB13mZvsSAtXvIGJhKOkspISedcMVO1Bd+yR+ifBdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OhfsYfmDsbeIOgFpBaNu+RpjTzIixBzhqkO0650nzgjXOetfE54GYDgB+LNiSAmmTWOxXPh/IYlhCJh5zWMJr4l+JMWGLyuRoUxCxcSgP3A2sapV6/eH5em6fpqFYX/tzzMbnuEIJWQVmo8olIP2E1E9g/uJbWZ78ZebYSVE/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SYhSaaT/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cc42a432f62411eeb8927bc1f75efef4-20240409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gn4SVKjDp2+oRxnoHIuawfi3x9MS9w2xBc7UDFhjgkg=;
	b=SYhSaaT/QBMZd2TFXFBZh6V3wIWlWzq1vLkAtaLZVpq/N6B8Vc7fxOED0sdiFuhvPPp63+bIXnLNqr0KsJxtfpX0G/Kun/pIOmQBMgkqI7kEWZy/E02VJi6YQ6Ea49qFGBY7mnDEIRXat5pemTxlN9BMd5BdjVMwzEvc/J76VJ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:46e1551d-ad9f-433c-8e8b-ba65d09fd744,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:9339f385-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cc42a432f62411eeb8927bc1f75efef4-20240409
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-ch.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2046319621; Tue, 09 Apr 2024 11:54:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 11:53:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Apr 2024 11:53:57 +0800
From: Jason-ch Chen <jason-ch.chen@mediatek.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-watchdog@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	Jason-ch Chen <Jason-ch.Chen@mediatek.com>
Subject: [PATCH] soc: mediatek: mtk-socinfo: Correct the marketing name for MT8188GV
Date: Tue, 9 Apr 2024 11:53:55 +0800
Message-ID: <20240409035355.27659-1-jason-ch.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.265700-8.000000
X-TMASE-MatchedRID: VZuxIYcieyzh8RW9qY6+GwPZZctd3P4B7f6JAS2hKPhrTDNJQXOxDaPF
	jJEFr+olwXCBO/GKkVr3FLeZXNZS4IzHo47z5Aa+JSsrnm9gBe1vuqvSSWUSX8OmhAllm9BvzsP
	W6bH7ICFbnGka1c72QtIUoq3qtzf10Huf0+4h7vtorSEFudR6+b4uS7g0k2sdeZUpm6wun3ba/0
	6NhYDa4wyzCDjlUx89p2y3mIB+it9WXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.265700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CCEE519ECF554D8D2C4644AD0C835A1320B2366487E12B37B88ADE3CC7D605D32000:8
X-MTK: N

From: Jason-ch Chen <Jason-ch.Chen@mediatek.com>

Change 'Kompanio 830' to 'Kompanio 838'.

Signed-off-by: Jason-ch Chen <Jason-ch.Chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index 6943ab29f095..74672a9d6d13 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -48,8 +48,8 @@ static struct socinfo_data socinfo_data_table[] = {
 	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000940),
 	MTK_SOCINFO_ENTRY("MT8186", "MT8186GV/AZA", "Kompanio 520", 0x81861001, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81862001, CELL_NOT_USED),
-	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 830", 0x81880000, 0x00000010),
-	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 830", 0x81880000, 0x00000011),
+	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 838", 0x81880000, 0x00000010),
+	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 838", 0x81880000, 0x00000011),
 	MTK_SOCINFO_ENTRY("MT8192", "MT8192V/AZA", "Kompanio 820", 0x00001100, 0x00040080),
 	MTK_SOCINFO_ENTRY("MT8192T", "MT8192V/ATZA", "Kompanio 828", 0x00000100, 0x000400C0),
 	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EZA", "Kompanio 1200", 0x81950300, CELL_NOT_USED),
-- 
2.18.0


