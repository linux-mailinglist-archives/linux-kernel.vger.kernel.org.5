Return-Path: <linux-kernel+bounces-103189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A4887BC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2741F24487
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D66F071;
	Thu, 14 Mar 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n+gXxgNB"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E86F066;
	Thu, 14 Mar 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416704; cv=none; b=Sdbb95j27ylunWdmjgJ5GCnVQHDQFQFb5r7uBTYZjv4IpSOx25cNK4TwJ9P0ITpm3QI/FX8L8ba6YS4Iia3VDjctvdzvq0FfDXjgDP+je28dlKS8IDKtOGDPWyBVdLi1LuB2BOluvmGRTIiQ5etUj+mHQKT9fV2l5/1BU3uO2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416704; c=relaxed/simple;
	bh=dM7gSMltkO2iXzKg5g67/S6GcDNL6hTuJG/M2KRQRSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKowmi+fBELzBR/oxgbeKnTEuK285nkJW0oNct1YtPz5pfdS3QTv6foBZw1bG99OPtTJVW8wsdYIi7/KFTxIzeOE4QDV8Pfo9hV/uNOvpiFfdcF19OO47r+A895DiVtCK3u7Vkk2SBhNOf/O+qB9y8XJxP0ZYPryL1OY7UJNK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n+gXxgNB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4724f9dee1f811ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UxJYj8Ub0WqcViLUsXIUaPYc9DwJ148RUl4hICOZhNU=;
	b=n+gXxgNB4zKf+GXn/ZIyaQ8x6+cMsF1tKzhiMxRw3LY7QZyOF3/lkllOj0BZXbKmud6FGamawwgpM2Tll5TwDvO8bRUDDJyKcRfITW/zvwCqb9b/vSp2EvEF2KCfjJo7769llbiPjDKv90KoAXtJu4nKvlC70geV859jFVUmncY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d482f04c-52c7-4e77-ac65-c5511373c2bc,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:81238081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4724f9dee1f811ee935d6952f98a51a9-20240314
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1858208254; Thu, 14 Mar 2024 19:44:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 19:44:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 19:44:53 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,0/4] media: mediatek: vcodec: fix ctrl request complete fail
Date: Thu, 14 Mar 2024 19:44:48 +0800
Message-ID: <20240314114452.17532-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Moving v4l2_ctrl_request_complete to before of function
v4l2_m2m_buf_done to make sure the status of request correctly.

Replace v4l2_m2m_next_src_buf with v4l2_m2m_src_buf_remove to
make sure the src buffer won't be removed for some unknown
reason leading to buffer done error.

Patch 1 setting request complete before buffer done
Patch 3 flush decoder before remove all source buffer
Patch 2 change flush decode from capture to output when stream off
Patch 4 replace v4l2_m2m_next_src_buf with v4l2_m2m_src_buf_remove
---
compared with v1:
- add patch 2/3/4 to fix timing issue.
---
Yunfei Dong (4):
  media: mediatek: vcodec: setting request complete before buffer done
  media: mediatek: vcodec: change flush decode from capture to output
    when stream off
  media: mediatek: vcodec: flush decoder before remove all source buffer
  media: mediatek: vcodec: replace v4l2_m2m_next_src_buf with
    v4l2_m2m_src_buf_remove

 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 52 +++++++++----------
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |  3 +-
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 28 +++++++---
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 28 +++++-----
 .../decoder/vdec/vdec_h264_req_multi_if.c     |  3 +-
 .../decoder/vdec/vdec_hevc_req_multi_if.c     |  3 +-
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 37 ++++++-------
 .../mediatek/vcodec/decoder/vdec_msg_queue.h  |  2 +
 8 files changed, 84 insertions(+), 72 deletions(-)

-- 
2.18.0


