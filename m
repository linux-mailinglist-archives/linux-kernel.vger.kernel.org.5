Return-Path: <linux-kernel+bounces-161379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E08B4B53
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9133F1F21704
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEE5576D;
	Sun, 28 Apr 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Tm/8ZO5t"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EC3D0C6;
	Sun, 28 Apr 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301606; cv=none; b=KUxZ6mgGM8Fcjvv73XiIrUhBVPAEjBl3MocmEfs9tpWdmCUHjRR03n0dusvqDDgyTC40ulMW8iEt8m3cIfC/5EdqHV1XK18Yiy8QQ03yn7Oiu1wFn/0FbVjc6+s3sYPgmvSBjvnRkrrRf11jvd1rd0ZiPSpC3U9iCpBCkxj9gv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301606; c=relaxed/simple;
	bh=dQklhoQwx+dpFBNP31geBGAZOWX8f0pDbvTUyaDJZCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pKnUTnQmBzKAjgrZuMz/9SMTP1L3mH8BcxwNGQ94nPA3/GPNsz36TWdaIhKUzi2nAsT855W6Ph3fi0eSUZp+TOeRg3IxCz59kELO72+92QXeuTgs89porgiO7hntIOrEcleJSG7h9xdM6p0Cy2YLUlhbGZdqACRKHwMjUzATAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Tm/8ZO5t; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43SA0sos024329;
	Sun, 28 Apr 2024 03:53:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=fIVVax1aKQo6hTrmZ84DF/KIuY8UziYlmDzN2elYqng=; b=Tm/
	8ZO5t65h09VZrEKw7Le6Q57cx6xiU6EoeAAm9u802Zpas+Vbj8T8ouOCafpo7pCt
	PuwwqSmE6zxJQ0HH6WHdP+G4eyHRaOBDloAGJQ/0iQGqhPvtrnl0IRX68v+kaavV
	+u8fw1SX1CtsjeAL8Jghu4J44FHBvzQrVKaat9RO+BIocuuTcRZPMlkm57vRj9mt
	8iVzxF9V+x4uSAY1Ef+7dE15lgEqBBT449vBIs4a87lcEbVpFzO3L2VJ9semaCkF
	eslhwEB+DKnHKR2A4BaZyluNWWCCqkBxEOoIVK+nzvlfTTWj0FCVayJjiA1Vv/wS
	+9aSvFlFtS3SHJIJvfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xs0vfsprv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 03:53:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 28 Apr 2024 03:53:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Apr 2024 03:53:16 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 6CF045B6949;
	Sun, 28 Apr 2024 03:53:13 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 0/9] Introduce RVU representors
Date: Sun, 28 Apr 2024 16:23:03 +0530
Message-ID: <20240428105312.9731-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _SWaQvdTRI0CQFUdedQYTJpOAvD6XkEg
X-Proofpoint-GUID: _SWaQvdTRI0CQFUdedQYTJpOAvD6XkEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_07,2024-04-26_02,2023-05-22_02

This series adds representor support for each rvu devices.
When switchdev mode is enabled, representor netdev is registered
for each rvu device. In implementation of representor model, 
one NIX HW LF with multiple SQ and RQ is reserved, where each
RQ and SQ of the LF are mapped to a representor. A loopback channel
is reserved to support packet path between representors and VFs.
CN10K silicon supports 2 types of MACs, RPM and SDP. This
patch set adds representor support for both RPM and SDP MAC
interfaces.

- Patch 1: Refactors and exports the shared service functions.
- patch 2: Implements basic representor driver.
- patch 3: Add devlink support to create representor netdevs that
  can be used to manage VFs.
- patch 4: Implements basec netdev_ndo_ops.
- Patch 5: Installs tcam rules to route packets between representor and
	   VFs.
- patch 6: Enables fetching VF stats via representor interface
- Patch 7: Adds support to sync link state between representors and VFs .
- patch 8: Enables configuring VF MTU via representor netdevs.
- patch 9: Add representors for sdp MAC

Command to create VF representor
#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
VF representors are created for each VF when switch mode is set switchdev on representor PCI device
# devlink dev eswitch set pci/0002:1c:00.0  mode switchdev 
# ip link show
25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff

-----------
v1-v2:
 -Fixed build warnings.
 -Address review comments provided by "Kalesh Anakkur Purayil".

v2-v3:
 - Used extack for error messages.
 - As suggested reworked commit messages.
 - Fixed sparse warning. 

Geetha sowjanya (9):
  octeontx2-pf: Refactoring RVU driver
  octeontx2-pf: RVU representor driver
  octeontx2-pf: Create representor netdev
  octeontx2-pf: Add basic net_device_ops
  octeontx2-af: Add packet path between representor and VF
  octeontx2-pf: Get VF stats via representor
  octeontx2-pf: Add support to sync link state between representor and
    VFs
  octeontx2-pf: Configure VF mtu via representor
  octeontx2-pf: Add representors for sdp MAC

 .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  26 +
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  51 ++
 26 files changed, 1707 insertions(+), 225 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


