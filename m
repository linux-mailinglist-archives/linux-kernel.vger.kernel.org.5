Return-Path: <linux-kernel+bounces-36483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0383A18A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D701F234E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C0F51E;
	Wed, 24 Jan 2024 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fY6AlO3G"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C4E579;
	Wed, 24 Jan 2024 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075431; cv=none; b=tUcKwS7ri3uIrV8Z+i4h3HE0m1bSt1wuqyqAT0QodG/hkQZijA8/NHOmpy5tBqIc5r01ni+rqZY+2xrFTYmcqddbjdg62+vL9ADvYUr/ZnzJ3iRmGMGjI5Rq732ZFYQL+iaZJ/9+spXAMHbVcjNPaibKda5999fzGif3C0vsGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075431; c=relaxed/simple;
	bh=BF05yO91Iry4JBzSEX4Thf2a4ewvATjtdXiUzdV66mI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQqPu2/s5H5WyMfLdeOpPyifEE4G5Ynk9V9teSF+glLCxCFBNdyFDRPpcZL71HExPJr2GmBLrE4slsS3cpyIsTUCEoBE9Knm0LfVh1HCRXrDV/wu1nHpxWAHIMvKn4E7ewD2BH/rzWXxhbMSzLm3yaJSa1/4mvKP261fmc6t/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fY6AlO3G; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NKRcNo008082;
	Tue, 23 Jan 2024 21:50:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=46Rvm9FQCWP55TJBdnEFLrOvq3gVeIGa+Kc7aG9KLkg=; b=fY6
	AlO3GmP+GecHAGHtyUhje9rJwexDCXb6gBom86CyAYGpIPuZdrpxbqgXjwWfh43V
	NDGmNhd4J3mQNXHAvs8fPgGbmUzgw+nncOI29x2wfaPO66lJM7MEWLnq8H7VUR7D
	JX0vGHj6HXfVd9SEw59/l1BOyi8bRut2Iz61FxXU6nunAU4X3v9cUvRPgtP65wYS
	o94daUyf7+Nkm61iABWTbmQzSmS5i3e2GdK0o7VkCqNW0AbJUe1CKcTXaH6dac4l
	4cjm9dGDIC+kD/K56htiK9EVYKO7+py/YZo8e0txiA7eyurGVXBKkgVEqOvXwnou
	gv/omkzrH7u1NdHKs4g==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vtmgvhfhy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 21:50:20 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Jan
 2024 21:50:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 23 Jan 2024 21:50:18 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 9B8F83F7051;
	Tue, 23 Jan 2024 21:50:15 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 0/3] Dynamically allocate BPIDs
Date: Wed, 24 Jan 2024 11:20:11 +0530
Message-ID: <20240124055014.32694-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9eo182zJPzrnfbltQxc414xJzv9JzVBi
X-Proofpoint-GUID: 9eo182zJPzrnfbltQxc414xJzv9JzVBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02

Current hw support 512 backpressure(BP) Ids. These BPIDs are
statically reserved among 4 interface types based on number
of channels supported. Latest HW support configuring
multiple BPIDs per channel. To support this feature, the
patch set creates BPIDs free pool from the BPIDs reserved for
LBK channel as, LBK uses single BPIDs across multiple channels
and on request it dynamically allocates N number of bpids
from the free pool. This patch also reworks the LBK device id
checks.

Geetha sowjanya (3):
  octeontx2-af: Create BPIDs free pool
  octeontx2-af: Add mbox to alloc/free BPIDs
  octeontx2-af: Cleanup loopback device checks

 .../ethernet/marvell/octeontx2/af/common.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  32 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  14 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  21 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 387 +++++++++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |   8 +-
 .../ethernet/marvell/octeontx2/af/rvu_sdp.c   |   6 +-
 7 files changed, 404 insertions(+), 65 deletions(-)

-- 
2.25.1


