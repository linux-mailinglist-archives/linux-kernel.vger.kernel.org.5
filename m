Return-Path: <linux-kernel+bounces-56042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49984C53B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB61F27190
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013AE20B20;
	Wed,  7 Feb 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ihw3tnOl"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3A1CFBC;
	Wed,  7 Feb 2024 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288781; cv=none; b=IhHSOm5ktM8p1FYPzIB1/RNbX3TPBZm9FjwUgApge/rYsbJWOKUNabJb+9AR1t2DGCSXoXOv7j1DhnsRF9ZsD/d5/a69yK9N7NnC1Zytph9o98GCO0kE7Xh8gPtBT/AdVJgB+a+/Bz+CZP4UfxsqlOXDobS3F+lvIALGFsotjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288781; c=relaxed/simple;
	bh=d8hufRZWZfHfcV+6af56uVgzd4/gjlVd6kkD0RuJYnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnckv97yQbm9/zPLLhiw+4I8CMNrfE+F6/ZQZTeofXz7zB5/M4wC9XWxIXFQanuJ5yoVcyWM8V21dPIfaQf1NE4rwUGIyPwqGKmjYItekCmH5lLb7PtxiF3iAoFPOefmrt026TX5Ciu4riAc+Ej92kAY/hncGKdNp9vBqWj/ToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ihw3tnOl; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4170Huke007429;
	Tue, 6 Feb 2024 22:52:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=n80sBwGKd9QK+sNcyrXlms3sJp5DLHe/uH/XBkXcnnE=; b=ihw
	3tnOlMCCSU9LxKggnw7mrYNkVFop+XDcvLufiopLkPE/76NCXkqy49Kjbm+lNq0o
	zXQ0FBeeiWv7QKF6HFcE5XcyAFB2Bx69eumoBOCK/EU1XrwkoD9HeMjn/XD6OIze
	IWMfGH+fcqwBEliKmqtvBT6jIKzLMGgrtzb6h3muT5hV+X/a+gAWpd8rOtcGRFRU
	YssXA4/pQEuaOt2SOZ01nT3aUj++S6QedQAd4bU5iAmFXXl+6fLVB2H7Ls3KGP+O
	PLG5JzQYbObxX9wHdhdBmd7eJPtn0bawErU/XxEMkky9V79rzgnsHeBLghppyJNC
	B7zaY2+aU3o8tEEqbfQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w38u85xxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 22:52:54 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 6 Feb
 2024 22:52:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 6 Feb 2024 22:52:52 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 5574B3F7086;
	Tue,  6 Feb 2024 22:52:52 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>
Subject: [PATCH net-next v6 8/8] octeon_ep_vf: update MAINTAINERS
Date: Tue, 6 Feb 2024 22:52:07 -0800
Message-ID: <20240207065207.3092004-9-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207065207.3092004-1-srasheed@marvell.com>
References: <20240207065207.3092004-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MeAql7yeCSWqxSGZrB1JTh6wR87dITrW
X-Proofpoint-GUID: MeAql7yeCSWqxSGZrB1JTh6wR87dITrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02

add MAINTAINERS for octeon_ep_vf driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
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
index f70c15292707..f6755e03c7c3 100644
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


