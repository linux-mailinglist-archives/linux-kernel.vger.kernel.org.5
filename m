Return-Path: <linux-kernel+bounces-153130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898788AC9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAB51C211B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340D13D50F;
	Mon, 22 Apr 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="X4Zmj6XU"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE012FB18;
	Mon, 22 Apr 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779667; cv=none; b=czdK/B7PVOFd/Xu08S5IzuouLjRFI8nMqVOZoLSjvSYr/1X9umvpzeEAvx/0zZWGXTdKAecGa8AhDVOCSIeRxxlVz6xEHhiU7ccJX3VbctatUgnZj9picwDzDkk81iw2OvicNi3eLNIIXPUrjydhvA2B0pgTauirpFu4imK65Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779667; c=relaxed/simple;
	bh=Qft8l338/bedAG53SIqjSD7+vskX6IVG9oU03aZUTu4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ArbffjgLv4oyLSlV3hILnpxR6qEsELZnPD2js55P+BWly11BNPh2z+Z1/KR0/EGO0SO1RLdyfgLq3iCNPgKGLWm+Tj/6TVDtDnVndHBjmNkjU7utngKI+iVN+GK93Kt00g7erJIL8+2Y4sP4FLZ/4cBSTkRZ66zWPaBEw0544jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X4Zmj6XU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9gfo7011759;
	Mon, 22 Apr 2024 02:54:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=Fz41v+ZBS9sN0sKCSItFux9tluRxaSDGTWgtPT960ng=; b=X4Z
	mj6XUPDSh9tUEEKIytyuO0P6yGLqQ8hSv5m64Jg1vertP04PF5hpJHmEb/g6gqrL
	feM1C+dARsArxDeJPu+LPwXb2FgDWNgkiu5sfYgFNPLjlcKq1wkL+JUmKy9nyuKN
	tcAyjhv3+ec0u1uuRw+q235zs7+GVCBk7caup81dcCeXiARCPlhUMzvuQcLvWLu7
	imre51R3TMTc9Ng0SmeFsmKuagZY/+AiOuDm2EUEizw/jOOqioch0fhX89dLwFIL
	dQBAy2397y4MX9Q5cF0bSAZxvy24/FavnqGiutZRgXuk6EBDKXmrHY4kVONMVBzK
	QfxIZBOx592RQnhzIhw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xnngcr168-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 02:54:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 22 Apr 2024 02:54:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 22 Apr 2024 02:54:06 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 244F73F705C;
	Mon, 22 Apr 2024 02:54:02 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2 0/9] Introduce RVU representors
Date: Mon, 22 Apr 2024 15:23:52 +0530
Message-ID: <20240422095401.14245-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: l-f7hrdiOa9B9YJtPEekxOIz0pTy3Wov
X-Proofpoint-ORIG-GUID: l-f7hrdiOa9B9YJtPEekxOIz0pTy3Wov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_07,2024-04-19_01,2023-05-22_02

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
- Patch 2: Implements basic representor driver.
- Patch 3: Add devlink support to create representor netdevs that
  can be used to manage VFs.
- Patch 4: Implements basec netdev_ndo_ops.
- Patch 5: Installs tcam rules to route packets between representor and
	   VFs.
- Patch 6: Enables fetching VF stats via representor interface.
- Patch 7: Adds support to sync link state between representors and VFs.
- Patch 8: Enables configuring VF MTU via representor netdevs.
- Patch 9: Add representors for sdp MAC.

-----------
v1-v2:
 -Fixed build warnings.
 -Address review comments provided by "Kalesh Anakkur Purayil".

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


