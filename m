Return-Path: <linux-kernel+bounces-42170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85383FD61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4012826C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3BB4CE1F;
	Mon, 29 Jan 2024 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SQX5dEuV"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05A4CB2E;
	Mon, 29 Jan 2024 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504622; cv=none; b=RJiEdb7Dru7nDgNqceAoCS0EPlo8gGhH0rNZSml4z4NXh9Hg7ncZQAGufyGAqRL2zgZmYQxb1qjSP72q6QjUxAUBnaStu2mcAIAeJORGn/wDoSdeoK4RLpgU17rvXj+eBq4b5U1cAf9WPd6rbajogFgz7yKlPbLu3RYyyVgRtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504622; c=relaxed/simple;
	bh=02tLcVFEsGbvDgtG5CO32AJ9t0Jnx97kboE+P+QpW0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9KGWKrkJ7vPWfjCy6zJh3Il9kkqtV26zS8uY3+ZHIfWVu1xRsG3wm4MFevvQbtbeshpzPZzBvuvo4LyrRbuV0jaTHE+jFamU8e2HQGdA/+b0VNAp3k+38NnDooaWx/UgmwWEk7tCDqOObYqFa7/Z4q6G4QYtvEbpHGeXieHTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SQX5dEuV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4KMvI027576;
	Sun, 28 Jan 2024 21:03:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=JZbJQIpsxvb2F2yfcVHmxpDYI9ShTQpL8rgQ4G8yZDo=; b=SQX
	5dEuVBB7NMoeAVqLpu0hQXJxZnC+50Iw+UIynLVYYV6zUS0LuNrMWNLuBEaY0ob6
	ozMZUzrQUiVPX1HWkFQ7ogv2Ru6n+p4A9mEFNsLg8BI1tte3F3q/KXPgc8qHM4kk
	QAaOQQnzz15cOZJnGv8eiVPLwJft4QIYi8/Ba9RRlP+rRY7hn3Hl8uvB47RBoBtm
	m6rA9EOH85XNmdWLFjsv5O9PMqw4uPFDrMgLKMfpFfkKsHEf9+OSWEDPFGMW5s5O
	p7ZQWu6FCiiSZAyi4HwEbAwKAN8nMAZnBZW6AD2y7Frc8EMb10Zjg1EibVK9YwVw
	O4KN+coYK8L3JneQ9xA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vx4vr82dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:03:35 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 21:03:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 28 Jan 2024 21:03:34 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id BA98B3F7048;
	Sun, 28 Jan 2024 21:03:33 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>
Subject: [PATCH net-next v5 8/8] octeon_ep_vf: update MAINTAINERS
Date: Sun, 28 Jan 2024 21:02:54 -0800
Message-ID: <20240129050254.3047778-9-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129050254.3047778-1-srasheed@marvell.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rfHDmNHdZ5ctHm3RTyjLVt2Q87eSkpm-
X-Proofpoint-GUID: rfHDmNHdZ5ctHm3RTyjLVt2Q87eSkpm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02

add MAINTAINERS for octeon_ep_vf driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V5:
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
index cec57b22d937..457ca249a651 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13058,6 +13058,15 @@ L:	netdev@vger.kernel.org
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


