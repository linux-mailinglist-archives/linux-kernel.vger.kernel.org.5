Return-Path: <linux-kernel+bounces-136317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D002489D29A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C42846FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35887C098;
	Tue,  9 Apr 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Skgp1VIW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE431A66;
	Tue,  9 Apr 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645090; cv=none; b=CEJtubLRjo5xfM1xrN6FDvmPMK91qGwN/kWee1SijrxLIvYGXANbmripAUGzgui+7MCXQjRzlgSVvn++EnWSseekALhzmZtcGCJZtn3WoYdnquadKq63H2YGBMJPLjOPYWVTVCNvQHUgVMDqILiyuJSobAViSytPdcxrnk2wGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645090; c=relaxed/simple;
	bh=q1G+JNro1SvAejSlTjBQCfwqSlrqn6Kuimwj88FxVXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWHdWLrzuaDuZLL6dR1k+K1IElT7YiIOGeiN2Cla92B2d9f2uEI1ougklZF5Yf7dTdtZ3mITwyWINqcR2T7dfN1IYBoGar+IVvVG4nDR8eX6/DOUk0f/bRaoT9sqHCVq3mvAdm7Geq4hCILOwvPen1wAxsJVftgol6CNkRZ8lII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Skgp1VIW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a1040668f63c11ee935d6952f98a51a9-20240409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UnZa+kymEWALAGSMk0rr8+0T+l265TIU6gLXOBOUsZo=;
	b=Skgp1VIWML4MExHSKn7sg/sWgQG9JaU82WU6oo2g5GomSY7UODkDqSz2UlF8YuQeESkG6u6zBR3arsoNL8R3e4eFgJzy3Bop3xtIlQHZuoIy02h+3qYlOXuvmtQoa+iPyC4zwEXZn+tscsKmzb+dGJDuZnF1+G/NOTigMjKlVJI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:38c3c22d-6a64-4c78-8ba8-dd889ba774a0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:504a7482-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a1040668f63c11ee935d6952f98a51a9-20240409
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 151941499; Tue, 09 Apr 2024 14:44:35 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:44:32 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Apr 2024 14:44:31 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, "Yunfei
 Dong" <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,0/5] media: change the calculation method of sizeimage
Date: Tue, 9 Apr 2024 14:44:26 +0800
Message-ID: <20240409064431.16909-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.658400-8.000000
X-TMASE-MatchedRID: tiRXYRqWr+t7EGbCBtXNh5dc7I2df+ms7TLAShhI26nfUZT83lbkEF2k
	xKIqW9ov4vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8hxKpvEGAbTDs2d8v07uhCE1LI
	xCR7fv4UoyD9yZkFZeBEgi3uuWutXDxXLKQJKaUy36ORTd1K+uaY7sVJ5Q4+lfdzU+O6sfADO8T
	UL2Fw68xz+PhojlLUuev0YPTN868QBqq+/+aGCsUu0bcffALXE
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.658400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7216C0668EF25ACFABAA8C78AB5D3A64ACCEEE92F96DE857900F403C65F763032000:8
X-MTK: N

The bytesperline and sizeimage of each plan are different for 8bit
and 10bit bitstreams. Using v4l2 common interface to calculate them
independently.

---
compare with v1:
- add patch 1/2/3/4
- change the calculation method for sizeimage for patch 5
---
Yunfei Dong (5):
  media: mediatek: vcodec: fix incorrect MT2T format information
  media: mediatek: vcodec: fix incorrect MT2R format information
  media: mediatek: vcodec: add MM21 format definition
  media: mediatek: vcodec: add MT21 format definition
  media: mediatek: vcodec: fix incorrect sizeimage for 10bit bitstream

 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 28 ++++++-------------
 drivers/media/v4l2-core/v4l2-common.c         | 12 +++++---
 2 files changed, 16 insertions(+), 24 deletions(-)

-- 
2.18.0


