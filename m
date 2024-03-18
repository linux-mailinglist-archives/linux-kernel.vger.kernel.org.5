Return-Path: <linux-kernel+bounces-105872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B487E5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FBD1C217CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCE2C1AF;
	Mon, 18 Mar 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VEZkKPE2"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0624205;
	Mon, 18 Mar 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754217; cv=none; b=cGLMkkY0c3ou2qiIrQi/7pPapCrAAxZoJNeBPdYzmpk2ezitEI4YryHxtSoAtAPKW8bAY8wXnpdq5elUZDszNZnrEdEeboacyqXosP0q828+9rDs1wHQ6eJNZQ5s+UQQ3RmNxwyqRvG/bXQ1XIcdZ2qyvuVO7OaRbsgla1TwTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754217; c=relaxed/simple;
	bh=BPXDf7rV3OrXPaxIf58C0rfEhbVnaKvDjZ564s1bO1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJ+cDntPeB1YTTX0ntaWf3Lt+ol39Aw73+HgRHCsjZJEC+ikXfXTkL8US5Ft16QCd5hUlLIcKVoxZ1KRvqrNk9WScT/GC/RcHH5AKa/KEEV1fB4EQnCHf2iFmYbhijAlxztsGQPrpbd6RmAd9NpmUDY6AD1lK2H8girWW9UVlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VEZkKPE2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMwH16011594;
	Mon, 18 Mar 2024 02:30:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=cd0oB67DNWqAGSh/WIoCmb/Fvb1TO1x0tgEB6/3bgas=; b=VEZ
	kKPE2/uAR1qq/67DJ2HEWJir6SjbF012pCqA6f+Nv9w1wOt1n9J1DP8JjoA8KG1G
	sugvVOj5dx8jcfoS1rQTwTdQ2GQBtNkwgp4kGIqhyiAoq/Iz0QVhdHceT/TS8WgH
	phcI/w3fY6aoQn2V44kvpHj6ylJ8Fbxv8PSss/Ii3zDM0lyhHClGlsBNB+PEgl2b
	6ztKxLdiVkVLmbHiXVAfF5MajPKCB2KUUS+E+XH4mdDXCYAmQwygDZeEuXJbAuwn
	ivJLc4V6Q/20uUP1VigJDGWleIzXsjm5WjXMS/omVe+k0JGz9YNGmWI+gPTPp6+Y
	nwK1FYxMHwETNKQkCnA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgc6qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:30:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 18 Mar 2024 02:30:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Mar 2024 02:30:05 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 940D63F708D;
	Mon, 18 Mar 2024 02:30:01 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v2 net PATCH 0/5] octeontx2-pf: RVU Mailbox fixes
Date: Mon, 18 Mar 2024 14:59:53 +0530
Message-ID: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: DSxtPiF5kYFHQBgK3jgQ4bVmtJiMChWk
X-Proofpoint-ORIG-GUID: DSxtPiF5kYFHQBgK3jgQ4bVmtJiMChWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

This patchset fixes the problems related to RVU mailbox.
During long run tests some times VF commands like setting
MTU or toggling interface fails because VF mailbox is timedout
waiting for response from PF.

Below are the fixes
Patch 1: There are two types of messages in RVU mailbox namely up and down
messages. Down messages are synchronous messages where a PF/VF sends
a message to AF and AF replies back with response. UP messages are
notifications and are asynchronous like AF sending link events to
PF. When VF sends a down message to PF, PF forwards to AF and sends
the response from AF back to VF. PF has to forward VF messages since
there is no path in hardware for VF to send directly to AF.
There is one mailbox interrupt from AF to PF when raised could mean
two scenarios one is where AF sending reply to PF for a down message
sent by PF and another one is AF sending up message asynchronously
when link changed for that PF. Receiving the up message interrupt while
PF is in middle of forwarding down message causes mailbox errors.
Fix this by receiver detecting the type of message from the mbox data register
set by sender.

Patch 2:
During VF driver remove, VF has to wait until last message is
completed and then turn off mailbox interrupts from PF.

Patch 3:
Do not use ordered workqueue for message processing since multiple works are
queued simultaneously by all the VFs and PF link UP messages.

Patch 4:
When sending link event to VF by PF check whether VF is really up to
receive this message.

Patch 5:
In AF driver, use separate interrupt handlers for the AF-VF interrupt and
AF-PF interrupt. Sometimes both interrupts are raised to two CPUs at same
time and both CPUs execute same function at same time corrupting the data.

v2 changes:
	Added missing mutex unlock in error path in patch 1
	Refactored if else logic in patch 1 as suggested by Paolo Abeni


Subbaraya Sundeep (5):
  octeontx2: Detect the mbox up or down message via register
  octeontx2-pf: Wait till detach_resources msg is complete
  octeontx2-pf: Use default max_active works instead of one
  octeontx2-pf: Send UP messages to VF only when VF is up.
  octeontx2-af: Use separate handlers for interrupts

 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  43 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   6 ++
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |  17 +--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  31 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  20 ++--
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 119 ++++++++++++++-------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  71 +++++++-----
 10 files changed, 225 insertions(+), 88 deletions(-)

-- 
2.7.4


