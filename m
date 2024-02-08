Return-Path: <linux-kernel+bounces-57844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E984DE19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E1D1F2857D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159C6DCFB;
	Thu,  8 Feb 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F7f1Hdmn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658EF71B2D;
	Thu,  8 Feb 2024 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387574; cv=none; b=E8WAg3jkdusQUkS4b2OjymOBD+cQePhZS2qatBWcb6kHRdxVe7k8OqJKvkWiuxsub4aXp6s/2fXV9z0DSpIoHV0+RHwr7/tzrr8D8sryzh2KWN9V86mROcfKLr7Spu1j8A7OodHwiv7jTy2veL/JftdnHuF5axcBTeZML4gpiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387574; c=relaxed/simple;
	bh=a8omMV6Mtf7DbIxI/PaXF2Oa2IF2DNNOExyu1bwySJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1KVxZriGNmZD4veD/3AgUW6zfD6Zx1OHlMwkuUdEGHXh/twpo40s4SV94RT0YG9wryQS/hhdcaB6ENYAhw61uMYwnCUyS38U1Rg8Rnck1jc93OEJ3IddQQcWsoX7ZkcwQ9ipxi9IBcvWAa6VVmhyeiM+ImUDL96fAngNJRQOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F7f1Hdmn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4184GWBT000444;
	Thu, 8 Feb 2024 02:19:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=dx6r30rxAqDubdOjGGSy+gN+rrEcPcbRySV+C9U7xPw=; b=F7f
	1HdmngUuZ3mDEhtUjlZMGEmPkyeQAMG7cdh5HC0ITdf39JvYol+lqdRScj+TL2Y0
	jghpxwY1aQx5DJNJ7xeWg4n983A8BSvWDS8MiBGyv9KecQseJ4RTGU/mE+0RQaS7
	QTQnYBzLn6h/2tJkeMx4W790kXTYVQJklrSjGTcexOmLtBi3nhFm+GJRlmZqMFZs
	wk371t1/4Mh3IDLcOIG1AtBI1+8l6p+wYYbr7osK3FHUC6ZE0VsAtPDrWT4n/QRy
	RcrSdSoNAWttwe5APE1BsrRQ1vmvpvG2oNesH0sOYv8nc3kkQsos3CC9+Gee8zYA
	2C2ZjjgsNfhTdimlcmQ==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w4qsq0whg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 02:19:27 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 8 Feb
 2024 02:19:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 8 Feb 2024 02:19:25 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 162D13F7054;
	Thu,  8 Feb 2024 02:19:25 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <hgani@marvell.com>, <vimleshk@marvell.com>,
        <sedara@marvell.com>, <srasheed@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>
Subject: [PATCH net-next v7 8/8] octeon_ep_vf: update MAINTAINERS
Date: Thu, 8 Feb 2024 02:18:40 -0800
Message-ID: <20240208101841.3108103-9-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208101841.3108103-1-srasheed@marvell.com>
References: <20240208101841.3108103-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: len-7IA0T8GEfQN8sO0xQew4U1EBqVfD
X-Proofpoint-GUID: len-7IA0T8GEfQN8sO0xQew4U1EBqVfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02

add MAINTAINERS for octeon_ep_vf driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V7:
  - No changes

V6: https://lore.kernel.org/all/20240207065207.3092004-9-srasheed@marvell.com/
  - No changes

V5: https://lore.kernel.org/all/20240129050254.3047778-9-srasheed@marvell.com/
  - No changes

V4: https://lore.kernel.org/all/20240108124213.2966536-9-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20240105203823.2953604-9-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231223134000.2906144-9-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-9-srasheed@marvell.com/

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f465fd778b1..d3689c9a4a62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13060,6 +13060,15 @@ L:	netdev@vger.kernel.org
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


