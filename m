Return-Path: <linux-kernel+bounces-82885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BEE868B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88207B26DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A449130E2B;
	Tue, 27 Feb 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BAAHNGCx"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B77BAE7;
	Tue, 27 Feb 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023667; cv=none; b=Qsc9t3hO2eESCZPX5814QkVSkegkxfJ9gM/RPFU1fC2GbA+qLGPZnVBFVFUR3rny+coqbGveLo/ghrOZIc25NJEU6D90+er0oxAtGiC87bp6NTVRYpLPQwKRKGoXVz6RQ+7PiyNk/HuSBHZBJ6ZMU6es7P6C25sSuT8ErEOl8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023667; c=relaxed/simple;
	bh=nkC19/00v/rubX28CJkyPWJwtpAXys7cf6QL/2swOBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMJyEnjckcr6ELkakTWDsQqw09JVK5IZ+e/OQXnwLvAIzTU02pOuxNVQlit6B/LkeG4awABkL/H4WMnJz8+rNh1sOGqMdSousvcMcrQtRqWeZq+wU00Qri9JXWwF0wXPDrlAq2XGjyFe1u/PFBwjuiOYrhpz9XRc6zxsPhEQrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BAAHNGCx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QNNxBx011614;
	Tue, 27 Feb 2024 00:47:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=0UTqIdO9lhrgAtpQJ6u95vzHcLEzYJKBHUIHpWzRYZM=; b=BAA
	HNGCxqFOjwXNLNY8squFgCkA7L/VhsB5s4ffNtAfxfr+5U7hVq9eqs2vpEAHvfwX
	dqcgN0vSW7dlAHqPAyUAhJK81GxHfyDaKhfPy36U7Cp+kXDyHB1GYku6dzOg1EsP
	eHPEvEjgKLOrqBaHuB3hO4SdNvGUKolfxVOu8hRwJArerlxm1iCDKnagwVuccG21
	i55VPCPyQXTvHNsy9lUN2GclnEY2s5N513vYUrT1NlfiCS4j+p5VD5L9Tcldel1H
	KWDjTJdYRMmreXR9Rb4YJ2eixVVP5q2GVxmkfjV1LBNsM1mUYeG1A27VvJhWxEKo
	SYQaJkxKUF/KV6XmIvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wfgun8rp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 00:47:28 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 00:47:27 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 27 Feb 2024 00:47:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 00:47:26 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 68C203F707B;
	Tue, 27 Feb 2024 00:47:23 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <sgoutham@marvell.com>
Subject: [net-next PatchV3] octeontx2-pf: Add support to read eeprom information
Date: Tue, 27 Feb 2024 14:17:22 +0530
Message-ID: <20240227084722.27110-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lYx5WpYLzmIohgajFVHNu9rldFepWstn
X-Proofpoint-GUID: lYx5WpYLzmIohgajFVHNu9rldFepWstn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02

Add support to read/decode EEPROM module information using ethtool.
Usage: ethtool -m <interface>

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
V3 * remove redundant checks as stack is already doing it.
V2 * consider length and offset fields while copying
     the eeprom data.

 .../marvell/octeontx2/nic/otx2_ethtool.c      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 7f786de61014..55ec0792038f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1184,6 +1184,38 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
 			      otx2_link_modes);
 }

+static int otx2_get_module_info(struct net_device *netdev,
+				struct ethtool_modinfo *modinfo)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct cgx_fw_data *rsp;
+
+	rsp = otx2_get_fwdata(pfvf);
+	if (IS_ERR(rsp))
+		return PTR_ERR(rsp);
+
+	modinfo->type = rsp->fwdata.sfp_eeprom.sff_id;
+	modinfo->eeprom_len = SFP_EEPROM_SIZE;
+	return 0;
+}
+
+static int otx2_get_module_eeprom(struct net_device *netdev,
+				  struct ethtool_eeprom *ee,
+				  u8 *data)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct cgx_fw_data *rsp;
+
+	memset(data, 0, ee->len);
+
+	rsp = otx2_get_fwdata(pfvf);
+	if (IS_ERR(rsp))
+		return PTR_ERR(rsp);
+
+	memcpy(data, &rsp->fwdata.sfp_eeprom.buf + ee->offset, ee->len);
+	return 0;
+}
+
 static int otx2_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
@@ -1342,6 +1374,8 @@ static const struct ethtool_ops otx2_ethtool_ops = {
 	.set_fecparam		= otx2_set_fecparam,
 	.get_link_ksettings     = otx2_get_link_ksettings,
 	.set_link_ksettings     = otx2_set_link_ksettings,
+	.get_module_info	= otx2_get_module_info,
+	.get_module_eeprom	= otx2_get_module_eeprom,
 };

 void otx2_set_ethtool_ops(struct net_device *netdev)
--
2.17.1

