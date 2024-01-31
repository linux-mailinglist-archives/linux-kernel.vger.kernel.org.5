Return-Path: <linux-kernel+bounces-45983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB98438A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D91C21B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D35813B;
	Wed, 31 Jan 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cw8YYKqN"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1B5D739;
	Wed, 31 Jan 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689183; cv=none; b=hr6Rx34ZnCLBTNHFAaV4vT5j3mqhaBAHF4JMW+Y0ce9+DRnwaKEL3YMmC+IiFcMdJLQ1LR5eVGhlA+eEHJue46eGM7pJWJC6CiFUCClDJpp1zSxu6ECm1csc0BcXXE1NKvR8SSn0j8sAHRW0+A32M/WVKcTXv1I8l2YVO8NtVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689183; c=relaxed/simple;
	bh=roonl72rZoCY0eRCPNI1fFfaZaXU4SJaWKrmE9lbXwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pdCCt6DGxK8PHNYfFfz342stInc/AGARE8rgIj9fp33uTDrOruzwdviYEKHIbc0Trtx+vYIU7tyGq071ZdsLLUv1g8ZiNWzN7juXiPYD2qtIx0X+61UEU9TAMWPQGD4MlVx1G1vAiaMOBfQMnCZkk3E53feF48yyu8+N/TjgRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cw8YYKqN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V5BJEn005588;
	Tue, 30 Jan 2024 23:54:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=ddK/t4zmxUxGOtboW7SIg6Tqsmf8tZCG4JAxK5QM2fE=; b=cw8
	YYKqNyUhXdOYA7Qjp2mPYh5bKzsRJDX4BCq2fyKstYvGE9Kltwas/7EaoEiLwpxL
	YMYrB+A8Ana9ZGVsqJ/rA6dut1E6vGMOxsYCLqFyTMYujdYPvklzDXgeQsSwiOqk
	I4/JRIwcDNw+RkeDFGxjajvm6rsCrOooisEylvPXnZPux8db8txvMoNdtlNXgUuy
	02iWv3iZCaEQAA6feQ65FvQZ6E05WCKtPgnv37QmtPug7/tu7OAUCvHfyjJO6k/6
	MuzEwFo/bbbiH8BePda+XgBh6jav5oPIzVJUHmT6RaB+g1oMmpEN0ERmwZJt3HGn
	S8muNXelSqnOondhN+A==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vy64ka98x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 23:54:47 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jan
 2024 23:54:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 30 Jan 2024 23:54:45 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 398525B694D;
	Tue, 30 Jan 2024 23:54:41 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [PATCH v2 0/2] Dynamically allocate BPIDs for LBK
Date: Wed, 31 Jan 2024 13:24:39 +0530
Message-ID: <20240131075441.17227-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: -Log7YDWi1FvVNTg10i6h1ki5MJTJ8hp
X-Proofpoint-ORIG-GUID: -Log7YDWi1FvVNTg10i6h1ki5MJTJ8hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02

In current driver 64 BPIDs are reserved for LBK interfaces.
These bpids are 1-to-1 mapped to LBK interface channel numbers.
In some usecases one LBK interface required more than one bpids
and in some case they may not require at all. These usescas
can't be address with the current implementation as it always
reserves only one bpid per LBK channel. 

This patch addresses this issue by creating free bpid pool from
these 64 bpids instead of 1-to-1 mapping to the lbk channel.
Now based on usecase LBK interface can request a bpid using (bp_enable()).


v1 -> v2:
   - Modified commit message.
   - Dropped patch2, as for now rvu netdev have no usecase. Will
     be upstream along with the CPT driver.
   - Addressed review comments by Simon Horman. 

Geetha sowjanya (2):
  octeontx2-af: Create BPIDs free pool
  octeontx2-af: Cleanup loopback device checks

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  14 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  21 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 179 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |   8 +-
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   3 +
 .../ethernet/marvell/octeontx2/af/rvu_sdp.c   |   6 +-
 7 files changed, 181 insertions(+), 52 deletions(-)

-- 
2.25.1


