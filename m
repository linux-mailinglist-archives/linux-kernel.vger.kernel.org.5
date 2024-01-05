Return-Path: <linux-kernel+bounces-18344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C84825BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73721F2466F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26738F9B;
	Fri,  5 Jan 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TS71lsUu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC6225CF;
	Fri,  5 Jan 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4058MNa1030822;
	Fri, 5 Jan 2024 12:39:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=Wt/X8NrCnuNYIAxbYjm0rOJPDQW+4K+yMKtdvkIsCzc=; b=TS7
	1lsUuP6YzEQsWh5zXdPufyd8xMGIRqRFpnNiNDhLjK6w88T9pguaiwZgurRAG9kB
	W8I5Xs8ZRPevuyxZqjxJAZCEchKsnvkQrAMQKHwlYYU4oOpLobsVdZ6j+KGWWil0
	MmT70UmQbMCkv0ueYFtwOs8kQXkZXBU/jJQpekExM2HW0sbZVh/UBiFyNS4emVec
	tCRrhOxyFr5+1Qm7hqT9OsqIO59vMj1tr1YXr868nw6YSoG8yCa5X4662/WXHXmj
	Ve/ySZmzPuZeEj55nrqkTenGbcLyppaIx+M4riSWv5ulUTWGsL91zYIO2pX8kc4w
	v2Y6Ui9Gu8kDoGxcSlA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vee6xa46a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 12:39:23 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 Jan
 2024 12:39:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 5 Jan 2024 12:39:21 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id EEA583F7099;
	Fri,  5 Jan 2024 12:39:20 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>
Subject: [PATCH net-next v3 8/8] octeon_ep_vf: update MAINTAINERS
Date: Fri, 5 Jan 2024 12:38:23 -0800
Message-ID: <20240105203823.2953604-9-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105203823.2953604-1-srasheed@marvell.com>
References: <20240105203823.2953604-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: X5gm_bDwjjw0tLhxd_vxz-JPIgcHI-WV
X-Proofpoint-ORIG-GUID: X5gm_bDwjjw0tLhxd_vxz-JPIgcHI-WV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

add MAINTAINERS for octeon_ep_vf driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - No changes

V2: https://lore.kernel.org/all/20231223134000.2906144-9-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-9-srasheed@marvell.com/

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0897c8467701..6ae61c14b4d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12867,6 +12867,15 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/marvell/octeon_ep
 
+MARVELL OCTEON ENDPOINT VF DRIVER
+M:	Veerasenareddy Burru <vburru@marvell.com>
+M:	Sathesh Edara <sedara@marvell.com>
+M:	Shinas Rasheed <srasheed@marvell.com>
+M:	Satananda Burla <sburla@marvell.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/marvell/octeon_ep_vf
+
 MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
 M:	Geetha sowjanya <gakula@marvell.com>
-- 
2.25.1


