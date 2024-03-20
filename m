Return-Path: <linux-kernel+bounces-109224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8788166F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117171C20AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF036A343;
	Wed, 20 Mar 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eu0CNpb6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8276A014;
	Wed, 20 Mar 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955244; cv=none; b=Fs93PM3+VI4h3mx4o0ULlrDo6brBUptLO1yRjNydhbaen7a91HBZtI9VIWnfeKn0gmMH4PgnCySD65axL5m8wHIQ8yl96PvIZ4g/49SAXzx568Usf0p4+sdVqjVQA+BLXPI+6AwbwKYuQB0wY4eoVQTf0umLts7QYgO660ZbK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955244; c=relaxed/simple;
	bh=/606eP2z2/2P76YRuiGFsmoave4pKqy70yn+c+cgOqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu8Pux4HOQjMqylH16uYMdGHnuD18UtctQLdYzxPgRmaWKkF2+lyUsMd6lQ68/XqHlJ6NSSFDZS92WBzums21G8I056lY5bW9hYuad/oZ8WaygfmIt9Ov/7IQfICT55Zamen8Ia9V7SoxfHT3XX80v/gnMFwj5TqVJ1NVfi+AKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eu0CNpb6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFAhqJ003418;
	Wed, 20 Mar 2024 10:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	pfpt0220; bh=GuDypbNjlvBbfQVbDBTBAICh1XOtnfNIJ5il1Xye/So=; b=eu0
	CNpb6iqhG/TDxX+fCy31mCWNYtGeXdfugbGAzF79IbC0TjSW6zt409cSoegEOBD7
	scNsurnbA/MX847CosPw//+50v1zAjIhL+zHEBky38l+RgsSKXcek8O5jyDPbM5H
	b5MYf0ldDHcqPIHayWdrVYzC4wWMV6Iiauk4aEu0ntTE2mRK9phqwBTaI4oS7+y+
	dEhWLo6GGnQTkZxc4mJtTuT8oy90ftDOYMkWCxoHwYk+V3UoY2hrGRA6JnXOW2fv
	W+EpHNf4L2UKB+CjliHEvUjwy/CYcGXWNgpdrdXSvAJqr16aL55zr9VVpNe19IbN
	hYgoX5iUw6ZD43LPI/A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka52e38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:20:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Wed, 20 Mar 2024 10:20:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Wed, 20 Mar 2024 10:20:22 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id E007A3F7051;
	Wed, 20 Mar 2024 10:20:18 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
        <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 2/5] net: marvell: prestera: enlarge fw restart time
Date: Wed, 20 Mar 2024 19:20:05 +0200
Message-ID: <20240320172008.2989693-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320172008.2989693-1-enachman@marvell.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mrIRt4thHQ8kevDmX95toSMu1m7rpiO4
X-Proofpoint-ORIG-GUID: mrIRt4thHQ8kevDmX95toSMu1m7rpiO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Increase firmware restart timeout, as current timeout value of 5 seconds
was too small, in actual life it can take up to 30 seconds for firmware
to shutdown and for the firmware loader to shift to the ready to receive
firmware code state.

Reported-by: Köry Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7390/T/
Fixes: 4c2703dfd7fa ("net: marvell: prestera: Add PCI interface support")
Tested-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 35857dc19542..2caa33d195ab 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -24,6 +24,11 @@
 #define PRESTERA_FW_ARM64_PATH_FMT "mrvl/prestera/mvsw_prestera_fw_arm64-v%u.%u.img"
 
 #define PRESTERA_FW_HDR_MAGIC		0x351D9D06
+/* Timeout waiting for firmware CPU to reboot and restart
+ * the firmware loading software layer, hence becoming
+ * ready for the next firmware downloading phase:
+ */
+#define PRESTERA_FW_READY_TIMEOUT_MS	30000
 #define PRESTERA_FW_DL_TIMEOUT_MS	50000
 #define PRESTERA_FW_BLK_SZ		1024
 
@@ -765,7 +770,7 @@ static int prestera_fw_load(struct prestera_fw *fw)
 
 	err = prestera_ldr_wait_reg32(fw, PRESTERA_LDR_READY_REG,
 				      PRESTERA_LDR_READY_MAGIC,
-				      5 * MSEC_PER_SEC);
+				      PRESTERA_FW_READY_TIMEOUT_MS);
 	if (err) {
 		dev_err(fw->dev.dev, "waiting for FW loader is timed out");
 		return err;
-- 
2.25.1


