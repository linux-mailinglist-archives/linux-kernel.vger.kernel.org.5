Return-Path: <linux-kernel+bounces-98905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FE8780E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A801F22394
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A993F9D2;
	Mon, 11 Mar 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i7MDCLqw"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C13E491;
	Mon, 11 Mar 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165095; cv=none; b=PT+9n5oJVo9x9iE/ZIJ0ba6Rfdo50bdHsQ2ZqbwP9O0f6UF2PX62wzE2RqsCVIFR3AZD9P2yt06LDzgvcpQeUFQCp9R7Jx7pahnfKYnoX8z1u/V1ukdMnysVXN9/xjPugYSXSOFi/3pwW0jRTfh8Anfw1DQzghTiQ2Ubgoey8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165095; c=relaxed/simple;
	bh=a4qDamwnmkvTg8Fr+2sFfNlrO1RU4hEtcpbHDa1dnLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EIeXh3ER6MOirRPvW4TIgpPqPf9Y6bPhHVw4N7SwXXPckGgwI9HUo2gnI85oPEbuIMz9ESN9/Lpdn1/1X/3LlTOcFpWyPRUwxRjvZB2cyjFkUfHKoEfjuUnfjTlvmpqDnDxEAXWnwdVYjzUcQIVKKwGF70wBrUN2sOS4XzQrQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i7MDCLqw; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9mVxe015527;
	Mon, 11 Mar 2024 06:51:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=3tx4AikW
	SVzffVoM4QxH3dLYukKV8Uobw1Prt+g5Ac8=; b=i7MDCLqwy5Dj1GJMa18h7dhz
	6yamMdY+xmJh7Buad0QGe5ZxXqMGzkxs+yMPGAwLvD6VCpI0hAkqiQJ9aEb68TE8
	v27aHaOZu/B7ct7oFLJ5wReZzhTeqNh4ALFAQ6KF2skeXmAaWtFSx24Atdee8uXD
	zJyFT8kSo08wrjEgAmc1r/e/dwje9AqFcLea5UYpZLFUBqBcKSYDakNvwU7yt5j1
	svpxrhrOVEabeuWUghg6AJDUyyFUjzHjIxdt6atV8z3WUrs1lc29U6wKRIrzT4dO
	yzE+WHtxzXMtGS5uwBbcQNqTbzCnyaWj0P3ERQuf1+VhErE86YRLYK3HFUUXfQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wsynb0ngq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 06:51:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 06:51:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 06:51:18 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id C55763F7045;
	Mon, 11 Mar 2024 06:51:15 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 0/3] Fix prestera driver fail to probe twice
Date: Mon, 11 Mar 2024 15:51:09 +0200
Message-ID: <20240311135112.2642491-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rZ3ESQ97mnL5PZw73iANqYLg99DbGCp6
X-Proofpoint-ORIG-GUID: rZ3ESQ97mnL5PZw73iANqYLg99DbGCp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Fix issues resulting from insmod, rmmod and insmod of the
prestera driver:

1. Time-out
2. memory referencing after freeing
3. MAC addresses wrapping

Elad Nachman (3):
  net: marvell: prestera: fix driver reload
  net: marvell: prestera: fix memory use after free
  net: marvell: prestera: force good base mac

 drivers/net/ethernet/marvell/prestera/prestera_hw.c       | 8 ++++++++
 drivers/net/ethernet/marvell/prestera/prestera_hw.h       | 1 +
 drivers/net/ethernet/marvell/prestera/prestera_main.c     | 7 +++++--
 drivers/net/ethernet/marvell/prestera/prestera_pci.c      | 7 ++++++-
 drivers/net/ethernet/marvell/prestera/prestera_router.c   | 1 -
 .../net/ethernet/marvell/prestera/prestera_router_hw.c    | 1 -
 6 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.25.1


