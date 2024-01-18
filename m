Return-Path: <linux-kernel+bounces-29640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F70E83112C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC163283385
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC528FD;
	Thu, 18 Jan 2024 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vsbyOaWa"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6C20F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543096; cv=none; b=KNkoDNLP5CvJfORQygQZ8suJ4xscZM5YjYxagfCNGNwFTHjoRpHLfwy1WpQBVSJNFWTQbiF1uCV+5ehFx6e02EQNsXkmyn+T7Yhxwua52jfyERlFAcgixFA/EeNsNq8Hw2lVEjtG3IDR5UrwZEYMDsq7J3jMOGoeHsU0JqllhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543096; c=relaxed/simple;
	bh=/yNQMgTpmIQvXJcDMi+7SFnmZY+Cg5CYOixjsHZIBto=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score:x-atlnz-ls; b=YFfFgKtzfDSavFp61cU05QoKFyQXV8aRWjFzfWVbrGr5Z3poE80nUdSSPB96jyeizhbVBuCyDFOOh1CcBS9upGE+dJKONYjB3LHmBAU2S545gizaIKrbeUfqqB8K/xV6ikb5OUojRfFP/ubqZXnAI9cFyvBaAw/YSn5xYUq75mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vsbyOaWa; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4A6642C04EA;
	Thu, 18 Jan 2024 14:58:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1705543091;
	bh=FRzy5TWNR9TvahVng24nBv5nswqp/8FBQOCzVf4vOhM=;
	h=From:To:Cc:Subject:Date:From;
	b=vsbyOaWazyBCp8HGmXGkzaNiOsLCqKIa247JVUYZ9S+pYaguL5RRwECnskeZKWUNG
	 3TdHBJNggjTDmJOpWvPdhJQ/6XW4y2JfobhTIElkkS6X5QMvPdf/LzfWDQ6O3Hm0+S
	 gGHffGOwQLoxzHQqDtBMSycIK/Yc8E67oe/ZfgG0Sl3USWYxb9Ei8w9ezJJrqtgxN4
	 yX7h950dzU2kbTrZE8D3DQ1ny5o0KXmGlWvJ+uElTmN7yTTFHHbD70GGdOUzEcrKb5
	 S3QA/9MfFeEAwhrDZRkOmR6eSsU8GtY6pcqgbLIZgcLFTR8DAJcHadDcuqkQS9UJJW
	 Y1+pqeysWqmvQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65a885b30000>; Thu, 18 Jan 2024 14:58:11 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 158C013ED7B;
	Thu, 18 Jan 2024 14:58:11 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 0EF9F3C0F25; Thu, 18 Jan 2024 14:58:11 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: mvpp2: Add EEE get/set to mvpp2 driver
Date: Thu, 18 Jan 2024 14:57:48 +1300
Message-ID: <20240118015748.3507954-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dEuoMetlWLkA:10 a=uUW33zXHdHhOziz9OLUA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Fill in the missing .get_eee and .set_eee functions for the mvpp2
driver.

Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index 820b1fabe297..85dc06c85b31 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5701,6 +5701,26 @@ static int mvpp2_ethtool_set_rxfh(struct net_devic=
e *dev,
 	return ret;
 }
=20
+static int mvpp2_get_eee(struct net_device *dev, struct ethtool_eee *eda=
ta)
+{
+	int ret =3D -EOPNOTSUPP;
+
+	if (dev->phydev)
+		ret =3D phy_ethtool_get_eee(dev->phydev, edata);
+
+	return ret;
+}
+
+static int mvpp2_set_eee(struct net_device *dev, struct ethtool_eee *eda=
ta)
+{
+	int ret =3D -EOPNOTSUPP;
+
+	if (dev->phydev)
+		ret =3D phy_ethtool_set_eee(dev->phydev, edata);
+
+	return ret;
+}
+
 /* Device ops */
=20
 static const struct net_device_ops mvpp2_netdev_ops =3D {
@@ -5743,6 +5763,8 @@ static const struct ethtool_ops mvpp2_eth_tool_ops =
=3D {
 	.get_rxfh_indir_size	=3D mvpp2_ethtool_get_rxfh_indir_size,
 	.get_rxfh		=3D mvpp2_ethtool_get_rxfh,
 	.set_rxfh		=3D mvpp2_ethtool_set_rxfh,
+	.get_eee		=3D mvpp2_get_eee,
+	.set_eee		=3D mvpp2_set_eee,
 };
=20
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
--=20
2.43.0


