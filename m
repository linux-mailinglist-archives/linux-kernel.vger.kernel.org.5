Return-Path: <linux-kernel+bounces-71356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013985A3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9C2B22F30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83031A79;
	Mon, 19 Feb 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hVtVF45y"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4802E844;
	Mon, 19 Feb 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347344; cv=none; b=DEdBhMbSyguCEYQ2j6LPkd/PCmPJW9CHFIFPT7kk7qFvGmXwySaLGtxofK4Yfl2xdvY3WCo4pmlmPf1Bu32IkV7OrVcbANlMsl95Q1Inar6vhPztCF3LXQ+bydpK1va/gOk8anWUGWfyoO2q734JXjKaNT15TIpy86sTG/9dLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347344; c=relaxed/simple;
	bh=2eoTnZ/3sqpihyRo3EwafjNnuu63QfId39rcykL5KBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mXoYM6xYf6sk5cntWnOBb96oagCiHSvZz1L8CgnyyiPRFiIaDQodUDphrIf31yHO6rIW3eGp9l0HXeK3WeCQjHekK2TNBiS0ji8QtMWT8gPOuMWuK05BDT2ZslIxhqO9K4TvCoZGzgur0qn2d9R8iSbYZTQV/FzQPEQAp6mkSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hVtVF45y; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41INnvMf020664;
	Mon, 19 Feb 2024 04:55:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=+Fo9IVYowPyi1LncksOQzJGd5fMCzgpCmmcZhOyruV4=; b=hVt
	VF45y+UPcGvY/Fk71esqTUeN89q4OnJEIDn+Hiqm+Wuv49jHVYkaFVcsDW1m/i+Z
	SHxDhJkvilsRyxXlOVe0+Q7LJOLe9FAPMt58y1BTTer7qImWWsZPFn1oGSQXo/Qn
	hzo6Z0JYqKCBUqNMytSuUSnnMAnizpeem1bExeYB5+8GF2LV7uuer9uLKG7LQhPW
	zX4N4e5xlC99KJ/sFm1UOLKY79IglIIhHetJ/YjNCT9YIQh8h0q1vlqEkGrPAHB4
	UryzXuzZHxqZkELHBy8YHyJk3BTuLga4bxGibMv8ogVzeICULVXK54Iy8RfYLMIt
	nTGK7sjlA4yj28RihcA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3waw6jv83v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 04:55:29 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 19 Feb
 2024 04:55:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 19 Feb 2024 04:55:27 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id CFC693F7060;
	Mon, 19 Feb 2024 04:55:23 -0800 (PST)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-af: Consider the action set by PF
Date: Mon, 19 Feb 2024 18:25:14 +0530
Message-ID: <1708347314-21624-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: s9nlq-SDGdRonDmXlSg5blNdPpBJl9tW
X-Proofpoint-ORIG-GUID: s9nlq-SDGdRonDmXlSg5blNdPpBJl9tW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02

AF reserves MCAM entries for each PF, VF present in the
system and populates the entry with DMAC and action with
default RSS so that basic packet I/O works. Since PF/VF is
not aware of the RSS action installed by AF, AF only fixup
the actions of the rules installed by PF/VF with corresponding
default RSS action. This worked well for rules installed by
PF/VF for features like RX VLAN offload and DMAC filters but
rules involving action like drop/forward to queue are also
getting modified by AF. Hence fix it by setting the default
RSS action only if requested by PF/VF.

Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index e5d6156..516adb5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -415,6 +415,10 @@ static void npc_fixup_vf_rule(struct rvu *rvu, struct npc_mcam *mcam,
 			return;
 	}
 
+	/* AF modifies given action iff PF/VF has requested for it */
+	if ((entry->action & 0xFULL) != NIX_RX_ACTION_DEFAULT)
+		return;
+
 	/* copy VF default entry action to the VF mcam entry */
 	rx_action = npc_get_default_entry_action(rvu, mcam, blkaddr,
 						 target_func);
-- 
2.7.4


