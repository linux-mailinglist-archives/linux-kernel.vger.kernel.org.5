Return-Path: <linux-kernel+bounces-109229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D67881679
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8934B23E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E446F075;
	Wed, 20 Mar 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GV68HtCk"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBB6CDD7;
	Wed, 20 Mar 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955249; cv=none; b=mk+LAyhBbedRRAUW7EjrX6R8AdMLcCX8jU4UALn7NyGSHpCmKRTQOHHHfeNdiN/WBRv0d83D3rXBOXIMHU3mfdFdXoj5lwf4i3ic2DR8474z+jK8AS4kj92jd5fEn37pjIfU05bDM0tIDRXthPk5XFmUOD5ds4New/AT1mJu27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955249; c=relaxed/simple;
	bh=q3Eoe3HwZcr+BKmfzkyBcxUaWH/JJnCtsp+8KtLyrc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1Gymk5JxmAoDFNs9x30vdABCz8Ip+HmXp4WocOT4UKfcwkJK9+CSUfqR5uedL4UjlWR+XJpZLKhLXl3US5GnbJtzy2Px6HgKgfzu2EBxkC1yme1G8AentxuCHCgaE3IWAw2Z07ACC9lHQMZLQ+qGt4OyH6F+1Hy4qowdqNoN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GV68HtCk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFCX8S003415;
	Wed, 20 Mar 2024 10:20:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	pfpt0220; bh=sW9PW9x2tpq78PgTkORMNKTzi6wA1fKqdpwgJEf8NNs=; b=GV6
	8HtCknu3vaB3j4kcCo1TPQlIrcR8YimvTDeNwPXZhlxWEtO1Ipi1yT1Eidnth6PH
	Abj1ZyIUahSHcWZGt0peJgtNGCptYtZBLvUdqiB5X0eM0RrHgcmeiIB6QnuZoCtw
	2j8xAO76ouAcEjAwICnWTvu0+ce5/BDDO3vBjVhKGWcm2pNtLnEycIyhrAhf3tuk
	HwFy2XDHFBfXyZ1azcuyVx8FbiNrCootfr+t4UQiI/aTKBf7R1uoopwazLxjbK3P
	7d+ymrkUSHjo8EmEOBKFOTl6BCRfxPF7CbfwMCrFxH8D0AvyKYF1jgm8cLRnQHPR
	hw/rO37KVjLXkhIZlcQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka52e43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:20:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Wed, 20 Mar 2024 10:20:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Wed, 20 Mar 2024 10:20:33 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id D86A65B692A;
	Wed, 20 Mar 2024 10:20:29 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
        <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 5/5] net: marvell: prestera: unbind sfp port on exit
Date: Wed, 20 Mar 2024 19:20:08 +0200
Message-ID: <20240320172008.2989693-6-enachman@marvell.com>
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
X-Proofpoint-GUID: wApieGSGS-BxHIsYjFagktKnev62dGE5
X-Proofpoint-ORIG-GUID: wApieGSGS-BxHIsYjFagktKnev62dGE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Call unbinding of the sfp port when ports are released, This will call
phylink_destroy() to cleanup and destroy the phylink instance, needed
to unregister SFP and free used memory, which will otherwise leak.

Reported-by: Köry Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/lkml/20240312164526.4a0e242a@kmaincent-XPS-13-7390/
Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 87d8fc4162b3..20c0ebb52af8 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -756,6 +756,7 @@ static void prestera_port_destroy(struct prestera_port *port)
 	cancel_delayed_work_sync(&port->cached_hw_stats.caching_dw);
 	unregister_netdev(dev);
 	prestera_port_list_del(port);
+	prestera_port_sfp_unbind(port);
 	prestera_devlink_port_unregister(port);
 	free_netdev(dev);
 }
-- 
2.25.1


