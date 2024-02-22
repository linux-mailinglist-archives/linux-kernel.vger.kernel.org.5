Return-Path: <linux-kernel+bounces-76955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11585FF03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC351C25A74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35920157E66;
	Thu, 22 Feb 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IMagX8Bh"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9866154C12;
	Thu, 22 Feb 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622167; cv=none; b=KddrKrR8Dl7ax09oyH2/QzUcme3pxfpmONRj2oRUS5zxBkfgU+jmaP5Z8BIagXAGB5fj2baog/TCCZMx02jtb3hDY+9tzHUlkqiCTkzUFcwxYtpyXpwg9i2dF5SNyv1SFe0XmmawqYfGWpr23II70bgogcIKPfO9bsNv5Rjkg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622167; c=relaxed/simple;
	bh=A84qU1m9BzTIx1AZLiz7uRz4hjvZ6jdO9TMJ0cHGnus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7wqoJ8Rz7//7Br6mDlx5tXq8yrIrPsROvqCgd8CP3IlpjEdSgNmSG0JFJH5xv/tS0BrkR1x2Hr3FWsjYY32mBsOB9aUZruS5D0Ij4Fq3z+rLekr7+EmNlMQOwhaw+nwfsKkRMJWfE1N1BROZusHKTnFucuFl926+Js5+kwMdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IMagX8Bh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M9BLW6021854;
	Thu, 22 Feb 2024 09:15:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=UDUvIki+z64+cnjRMxcgq65JHKEkA1p7m7rxVXwber4=; b=IMa
	gX8BhksoxMzd7mAACLBi5vEmoNc2LNclA6cxn0rFrgifRT0/nNxdWMNZSQAfJrup
	yiM3gESOzYR28BYR7fzFJwh3Ww9Ih/ruL+XjjB84jwN+pkV+h+FQRdS6FhuKSgnM
	Z35MY2CV/zsyBehcBSdpby+GMdxfF8H6bLGV1BuZ9rDUPNxNF5xvvP57vmy0us9Q
	epyYHvt1X8am15hGk8lG0Wb+EtwqI4lp4JKPZfJUhA2cCs8Qd3WkK7xzDDEfsPVD
	+QrbxWFc1+fGWv2yqG4Tc15+i22IFM+Wba3aeLH7qY3fjH2+GonLDhR5tC0a90cR
	OHf85Sf/WV+Vs6U4STg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3we3dw9ycv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 09:15:47 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Feb
 2024 09:15:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 22 Feb 2024 09:15:45 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 35A5C3F7153;
	Thu, 22 Feb 2024 09:15:42 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <sgoutham@marvell.com>
Subject: [net-next PatchV2] octeontx2-pf: Add support to read eeprom information
Date: Thu, 22 Feb 2024 22:45:42 +0530
Message-ID: <20240222171542.12995-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: r_iJEr-Olns6htIDz4kBDq1c1mrmWaY7
X-Proofpoint-ORIG-GUID: r_iJEr-Olns6htIDz4kBDq1c1mrmWaY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02

Add support to read/decode EEPROM module information using ethtool.
Usage: ethtool -m <interface>

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
V2 * consider length and offset fields while copying
     the eeprom data.

 .../marvell/octeontx2/nic/otx2_ethtool.c      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 7f786de61014..7f66d18e8a4e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1184,6 +1184,41 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
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
+	if (!ee->len || ((ee->len + ee->offset) > SFP_EEPROM_SIZE))
+		return -EINVAL;
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
@@ -1342,6 +1377,8 @@ static const struct ethtool_ops otx2_ethtool_ops = {
 	.set_fecparam		= otx2_set_fecparam,
 	.get_link_ksettings     = otx2_get_link_ksettings,
 	.set_link_ksettings     = otx2_set_link_ksettings,
+	.get_module_info	= otx2_get_module_info,
+	.get_module_eeprom	= otx2_get_module_eeprom,
 };

 void otx2_set_ethtool_ops(struct net_device *netdev)
--
2.17.1

