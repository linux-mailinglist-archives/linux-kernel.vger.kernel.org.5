Return-Path: <linux-kernel+bounces-38497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA4B83C0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CC21C221FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B72C68A;
	Thu, 25 Jan 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ksFqiTwE"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1151CAAE;
	Thu, 25 Jan 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181720; cv=none; b=CxmpbZBdTOnMH8RRwrXgM7cSY1Q7wpILLTszPieZWV7VapU1PxlvTePYSBZJTt1c7C8eSyyIlK112wonVxCCNJirHuPGBmzdChSTYHkOcwhgDJN2oeenDe1i+1RvwRD+1VYcx8wI4j9PmoY8RPcn9J3JZlhWZWcgHPCpiMNuFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181720; c=relaxed/simple;
	bh=3UJsTPYOcBuLCUS/AoSNIE0q49JbYk1tipQ/7awvQm4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cR96S6Qz1vVAaHlTX42rX+lC1YtynVOqzTkdZN8u2lvmWT9PKf/NIm0F0RRh4VCJhgUErbwZh0DnQeGFfIT43lYdXnOB3hexUEyFe1vLv66uX+Dyf0xBqdjldVoDVc/hKqks4NRlgek52odS063pnNT16qSh8dDehDQVvCa/hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ksFqiTwE; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P8veXf008478;
	Thu, 25 Jan 2024 03:21:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=fXkopoE1vDo6nTbf5yAboxI/984BJBBIUflwlsaQrIs=; b=ksF
	qiTwEEOqoKrq9gY1jtjMl7VPu0nPt6CDQMjfV1erDZcuTWyjeHWQDIcFW1HjPC8E
	+pQgnrOQJG3dFiv6vC2IV5o1Q07oHYz0P9691kBSWH36862xeo2JrFHi2TmCxD2S
	2tUoVhvZVnddUVCCmNwce1Ho08FPeKpJaS3igbdjhmkoNakVSKqC8LZbLNlcCa66
	VYLFR2Kq7uPrI83rLDX/YDZv90RCVrIw0BeaxqU34PIFINnMu2ZxwBkcYdUkFGx2
	KoNcaQJ4MO4qBUjDK4eIp33b8uMemBNxvLyfaPPdz5Twdi9Fg8B07ZmTJw8YNIBO
	T1IQwaHocWb8I8MH2lA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vumk90cqn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 03:21:51 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jan
 2024 03:21:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 25 Jan 2024 03:21:37 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 0EF4E3F7082;
	Thu, 25 Jan 2024 03:21:34 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <sgoutham@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Add support to read eeprom information
Date: Thu, 25 Jan 2024 16:51:33 +0530
Message-ID: <20240125112133.8483-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jiRCFEXdqvLs-pdKTnxH8gPY9UkgKTWQ
X-Proofpoint-GUID: jiRCFEXdqvLs-pdKTnxH8gPY9UkgKTWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02

Add support to read/decode EEPROM module information using ethtool.

Usage: ethtool -m <interface>

Signed-off-by: Christina Jacob <cjacob@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 2928898c7f8d..8e4e22a2817b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1185,6 +1185,37 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
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
+	rsp = otx2_get_fwdata(pfvf);
+	if (IS_ERR(rsp))
+		return PTR_ERR(rsp);
+
+	memcpy(data, &rsp->fwdata.sfp_eeprom.buf, ee->len);
+
+	return 0;
+}
+
 static int otx2_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
@@ -1343,6 +1374,8 @@ static const struct ethtool_ops otx2_ethtool_ops = {
 	.set_fecparam		= otx2_set_fecparam,
 	.get_link_ksettings     = otx2_get_link_ksettings,
 	.set_link_ksettings     = otx2_set_link_ksettings,
+	.get_module_info	= otx2_get_module_info,
+	.get_module_eeprom	= otx2_get_module_eeprom,
 };
 
 void otx2_set_ethtool_ops(struct net_device *netdev)
-- 
2.17.1


