Return-Path: <linux-kernel+bounces-99455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EC8788A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341CF281D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159954F88;
	Mon, 11 Mar 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E7z+hhWb"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0452655E4F;
	Mon, 11 Mar 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184630; cv=none; b=tC/FNow811mkf6VFDLf/+eiy1GO3uhLFQJWaA7bzFBbxx248f/cWSjVqIc5PPxypO1tU17wZfuEkuhmRg0xeGrN8ZNgFdac8YHCRhRIl1F44HwYL63SEaAr4ydIV57ZGWp1CAv+wPqy0O6EmFbYA678RPNw5U6RfT9e4O+l0ZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184630; c=relaxed/simple;
	bh=mMGeg29gwzpCoVxiA8/LEboh4bcjnzGK8a/aWqQS1Vw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rDMyyckLGScerBLxBZARUXM1envqM0VFJvnrBdjq7/cfChSd1bV2p/HKplOf16+Q72QkV1DDDwz2T+weRFe76grJVvrzDhESUnNOyInnBMrFyTKI54egHQVVV1o8QQAF6fjUxlqy4aa7ONHvNlBaNY3PJIUm332+x9wGWEu9fxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E7z+hhWb; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BIWO9j004861;
	Mon, 11 Mar 2024 12:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=jiAYZlSTTVTc9JemCt40FhYTOp4MDk5dogqt7SwUfZw=; b=E7z
	+hhWbbG7DI3iTQLWjHvIceNcvMhPPHV6IrSdg5rbYdmV4etmc91vMH94UAMQPD7W
	cTsVkGzcYMMI3gLt1SNrLrn+/bitYaDAZM5kIfM6HXyiqBpSbOysXk/enfnkrfP1
	LypeHmjxmfjL+Gq+O5+yf/C9KAj7f3XxBWlestrrKx43KF7baZWX6RMvujCSs6AX
	+suMFSwUGhwgC5xtMw37TODixV25iHKF/rV1lj8u2esYe8Ovk1LYPtFdxSDIGPxx
	s/sgGE8ZzUUngLTiBZUELU9xhliyz7wJPsD4mM1VYMtGvSEW7iCe3YwH4VufoA9d
	ZUxNqgEelqYMt3Vp/DQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wt54n0j2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:17:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 12:16:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 12:16:59 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 1F1773F704C;
	Mon, 11 Mar 2024 12:16:55 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>
Subject: [net PATCH 0/5] octeontx2-pf: RVU Mailbox fixes
Date: Tue, 12 Mar 2024 00:46:47 +0530
Message-ID: <1710184612-29027-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gWmHqV-kpJgr-RPAX_kdNud3GmVxf9W1
X-Proofpoint-GUID: gWmHqV-kpJgr-RPAX_kdNud3GmVxf9W1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02

From: Hariprasad Kelam <hkelam@marvell.com>

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


Subbaraya Sundeep (5):
  octeontx2: Detect the mbox up or down message via register
  octeontx2-pf: Wait till detach_resources msg is complete
  octeontx2-pf: Use default max_active works instead of one
  octeontx2-pf: Send UP messages to VF only when VF is up.
  octeontx2-af: Use separate handlers for interrupts

 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  44 ++++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   6 +
 .../marvell/octeontx2/af/mcs_rvu_if.c         |  13 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  31 ++++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  20 +--
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 119 ++++++++++++------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  71 ++++++-----
 10 files changed, 223 insertions(+), 87 deletions(-)

--
2.17.1

