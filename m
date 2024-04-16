Return-Path: <linux-kernel+bounces-146251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDB8A62BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E141F2302F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F305539AF2;
	Tue, 16 Apr 2024 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iLwXxxVb"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B74381DE;
	Tue, 16 Apr 2024 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243998; cv=none; b=ZsYQKejXq//7bb87xwdnGewCDK+znE21B/opZ/Qxlg3qdBLxMiKzQVxleGOkVcV1pdX2hgrPtxWCXsQj8jsN8BFs3TZNvYDqUY/FRTPlQ841FL7/itiLw7T1Dkr0juwN8H+aiUJVFUwxqQZbeZtWcWTWGxMp8CUeZGRxUc0s1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243998; c=relaxed/simple;
	bh=FtPVwxpazB+LTsdeHlcML2FBH0nSAup/h6vWHsSB4yk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecgbGyUVVBN2MCbiTEZFzHwebKCLwqs6kvc9igbKNVlLTuft/11zgEDc6TDcUJ03C8TnYvdiKhxmV/65ku0OJMsyPo5R+XyxNMeKXrSHsW6jPrrgUCvtmkh27jsPbXSGNdmyRVBDjEd4QJ4ShMBoIT1JP1EUT/vvlUvVBavnNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iLwXxxVb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G19E6o029795;
	Mon, 15 Apr 2024 22:06:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=F42ZO3PwDbnZJkaHBcltiAhhCQWaLh7MZqhgu2XJ3Zc=; b=iLw
	XxxVbOPlC6bx2H3DrAY9Hszm3rzWHTjswBbBG5/Qhm2UkMaUXVhaXE8uuhlxqLsj
	/qC2WEkh2VfralJ/mHGIzMco+stwogAF+2+F5lI9kmsVTvE1RZFDxkvNOGuNj0BQ
	wSzmaIOkX2t9Q7qeUbYNqJl7NllPT41hHHP9CeQtA5CFiyykS9SJcjV38fgTkpEr
	1ZgJnFCqL82kgGhcTriCvn5x50qgPQg3GwppenoZaX/6DwUs6IQN0PZDOpvXLUZ4
	EZGrShpY0t7MhAEwcmWz36CCKx5AQwaWKwt0V9zTgmzeT0/W87qwYqRGP4u5vHWQ
	80WHe3DaNAIvFswzRqQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn0j7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 22:06:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Apr 2024 22:06:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 15 Apr 2024 22:06:20 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id E3B913F7084;
	Mon, 15 Apr 2024 22:06:17 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 0/9] Introduce RVU representors
Date: Tue, 16 Apr 2024 10:36:07 +0530
Message-ID: <20240416050616.6056-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: t65CxtMA38EyCgxYLjCT0h-n6t9r08Qt
X-Proofpoint-ORIG-GUID: t65CxtMA38EyCgxYLjCT0h-n6t9r08Qt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02

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
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  67 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 +++++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  26 +
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  48 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |  33 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 602 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  51 ++
 25 files changed, 1704 insertions(+), 223 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


