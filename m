Return-Path: <linux-kernel+bounces-119700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C288CC34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E71B28484
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C0313C9D1;
	Tue, 26 Mar 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AFWRWC7t"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93691292C7;
	Tue, 26 Mar 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478726; cv=none; b=VgDFJy6C/mB2zh47EeRp6mdq86EccewD5YeityqDzG2KSE8l+4hYrHBSePXSSBwsDXRS5sr1R0R1dRmD8jQh208oWGj934J49ZGrHnRWhFFGvjio7egO5/BMf2WiHJHzNnncizP+0IxL25Bcox9W/Drymj+wk/qYyFRUVPd9AeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478726; c=relaxed/simple;
	bh=wQY0mvP9mcZDDkl/5tK4Zee9HLlnOO1nDNKawSvnlbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZU34cLo4n7owgrCvo6Ic6pH/SqadLMF1lKIhcANMAEG452kF6DKgxoP912ZsKjGnL3sJ2h0RFgSsogQd3ne/H3OJNsaO+yKdvWqmEXokfR65OqjqU0DHiwWXBMBElRMaaosFocehyIDhL0yWu8PwM20apMXphxb6xwEWImvQDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AFWRWC7t; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QCmprI017695;
	Tue, 26 Mar 2024 11:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=ekx30cLX
	kPKx7KG2DDmuv4cQEvcz0BL0vVsR8e3P8aM=; b=AFWRWC7tZpo/kdrupzBhe7Sq
	34hX36+lr5N63HyDlt5dGScaZYbNU0war8xgaJ+wrXHokB0ijlDFe/3q0dxvfdpA
	cBgg40t4NtVxGfNQt1YPWNUN+rlde0bTL2ht5Tgi7WnrW6iRIlbhPOB+Iu8irD0x
	ACtyI5IehF1Fea1z4tykj5oRuO5LMcfCwSqWvec20pAaCIDLRekxzyOKznemJaiD
	A+B6VcvHI6yMXn1P12CfB6gf/sit5tJ5dVhGqjb95iU+MfSj7sI1BlAw+QTabGyy
	Q/AybLXcls0dey1UTGXM/LwzrOhypGmNjryPJBss4xpqvnmc5D2BNC4qcvSOWQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x3xpu1vhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:45:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 26 Mar 2024 11:45:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 26 Mar 2024 11:45:16 -0700
Received: from rchintakuntla-lnx3.sclab.marvell.com (unknown [10.111.142.125])
	by maili.marvell.com (Postfix) with ESMTP id 526AE3F705E;
	Tue, 26 Mar 2024 11:45:16 -0700 (PDT)
From: Radha Mohan Chintakuntla <radhac@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>, <horms@kernel.org>
CC: Radha Mohan Chintakuntla <radhac@marvell.com>
Subject: [PATCH net-next RESEND] octeontx2-af: Increase maximum BPID channels
Date: Tue, 26 Mar 2024 11:45:14 -0700
Message-ID: <20240326184514.1628284-1-radhac@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vOVD8OWwbQ1YekRTIHl-8tNvy0hV6Kw6
X-Proofpoint-GUID: vOVD8OWwbQ1YekRTIHl-8tNvy0hV6Kw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02

Any NIX interface type can have maximum 256 channels. So increased the
backpressure ID count to 256 so that it can cover cn9k and cn10k SoCs that
have different NIX interface types with varied maximum channels.

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
Note: Earlier version didn't have 'net-next' designation in subject. No
other changes.

 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eb2a20b5a0d0..3d801a1a4f70 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1213,10 +1213,8 @@ struct nix_bp_cfg_req {
 	/* bpid_per_chan = 1 assigns separate bp id for each channel */
 };
 
-/* PF can be mapped to either CGX or LBK interface,
- * so maximum 64 channels are possible.
- */
-#define NIX_MAX_BPID_CHAN	64
+/* Maximum channels any single NIX interface can have */
+#define NIX_MAX_BPID_CHAN	256
 struct nix_bp_cfg_rsp {
 	struct mbox_msghdr hdr;
 	u16	chan_bpid[NIX_MAX_BPID_CHAN]; /* Channel and bpid mapping */
-- 
2.34.1


