Return-Path: <linux-kernel+bounces-109225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87604881670
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91E31C231B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBD6A8A4;
	Wed, 20 Mar 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TLkdxO9Q"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CD6A02D;
	Wed, 20 Mar 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955245; cv=none; b=sMO+MstoXMj+S0cgV+MOr+XSICNHDOT3iEdYH8jgm0Jlbx+PQJ2A7dMSZgS4OAOvsLb/khPkGHZWVwl/5E91SMiLC+6VBdMfF6RCCfQi37mgQ6pX9nv8YFdv3BI8GCJFZD8Fsgi05Q7xG3weg0hidclsnpPnt0NKRk2F1cP90b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955245; c=relaxed/simple;
	bh=PXbY0Ox61cikah9PXRtM5Cq8s8wbozFkrP2zNiAE6Ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JF9Jk7/u+7w+x3RxVg75JcEiZOUj72U11/qtXeQbBd7q8PUjsI0JxxgzAOXQSgBRsHaVtnqgAJ/Qh6EdnBwN2W0Bvpr8rhAfc2scM9mNqr8dhXdgWknKtn8kTyN0tyKYLaAhbUQ7tyXfTzKKjLXAoTTy8Ihz+qGWPyJJVPfzY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TLkdxO9Q; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFIWm8003494;
	Wed, 20 Mar 2024 10:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pfpt0220; bh=gi7oWzeF3IUKlp7PFSXRd
	A2MzG072PNShX+grViVOt8=; b=TLkdxO9Qg9o2wSxvCsvs/dxsAJHcjQpTF6R5/
	hYhYcEYKd5RpJF0qEVGN8nFvGI79i1FKdMCZ1DKNnBwAvzoAjXUUxPbcfI3EGD4w
	S4j1bfG3rwTSplIFQuJ1BCpQJWYmF4qflHVYUiTfbv+ab1u6lbktla3pp7fvilD8
	jgkMiIB62WlAaY0CED9mf0GJOcOPgrpgNZ1mpIP5NovWg66e8KA2GmKuodOR9by6
	+TJbs//Kz9s3yFWq5zYXstJPf/sh6am4i0VEjvYe2xdiHeX19uMydqpoiRAea5TM
	i6s6WxzGjsy7C2LQNxskjyeDlOKpI8UsGyUjik+Br2JXDrSZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka52e2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:20:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Wed, 20 Mar 2024 10:20:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Wed, 20 Mar 2024 10:20:14 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 807B83F7051;
	Wed, 20 Mar 2024 10:20:11 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
        <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 0/5] Fix prestera driver fail to probe twice
Date: Wed, 20 Mar 2024 19:20:03 +0200
Message-ID: <20240320172008.2989693-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gXYJgsAoS-P74PUf3eptC7CpdzJKvQCG
X-Proofpoint-ORIG-GUID: gXYJgsAoS-P74PUf3eptC7CpdzJKvQCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Fix issues resulting from insmod, rmmod and insmod of the
prestera driver:

1. Call of firmware switch HW reset was missing, and is required
   in order to make the firmware loader shift to the correct state
   needed for loading the next firmware.
2. Time-out for waiting for firmware loader to be ready was too small.
3. memory referencing after freeing
4. MAC addresses wrapping
5. Missing SFP unbind (phylink release) of a port during the port release.

v2:
  1) Split first patch to firmware call for switch HW reset and to
     increasing of firmware loader wait to be ready timeout
  2) Explain why is switch HW reset call to the firmware required
     before shutdown in commit message, and fix wording
  3) Use a simpler bitwise-and on the last byte of the base MAC address
     instead of randomizing again the entire MAC address.
     reflect that change in the commit message, and explain why it is
     needed (switch HW implementation requirement).
  4) Add Fixes Tags to all commits.
  5) For timeout enlargement commit, fix wording in comment and move
     timeout units to milliseconds.
  6) Add Tested-By tags.
  7) Add patch to call prestera_port_sfp_unbind() from
     prestera_destroy_ports() in order to release phylink.

Elad Nachman (5):
  net: marvell: prestera: fix driver reload
  net: marvell: prestera: enlarge fw restart time
  net: marvell: prestera: fix memory use after free
  net: marvell: prestera: force good base mac
  net: marvell: prestera: unbind sfp port on exit

 drivers/net/ethernet/marvell/prestera/prestera_hw.c       | 8 ++++++++
 drivers/net/ethernet/marvell/prestera/prestera_hw.h       | 1 +
 drivers/net/ethernet/marvell/prestera/prestera_main.c     | 5 ++++-
 drivers/net/ethernet/marvell/prestera/prestera_pci.c      | 7 ++++++-
 drivers/net/ethernet/marvell/prestera/prestera_router.c   | 1 -
 .../net/ethernet/marvell/prestera/prestera_router_hw.c    | 1 -
 6 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.25.1


