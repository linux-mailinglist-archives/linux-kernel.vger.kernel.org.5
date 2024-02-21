Return-Path: <linux-kernel+bounces-74336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5585D2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6114B23076
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D993D578;
	Wed, 21 Feb 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sHo3siLR"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE33D3BE;
	Wed, 21 Feb 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505959; cv=none; b=dlFSvs8QEMEGntF+V6N33L5EWR+GX4Jo3Z6P9EjSqUw6SlMgirGobmpPRvbQszDh8qutyeMfD8OTia7hTRn2wboLJmKdG4/n0GtBX1kRKcdMPXVq5bGcyTNGxmvPTkibMQ1P8yYyNfTOnB63D9PayWSwJ3pOhT3EAcL/oKshBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505959; c=relaxed/simple;
	bh=nDn4PQmjMHHtj3eMeXPvF0RWKLDWpauKLwUGl1KeX54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2zImYC8b7S/mdvqM7rgiWX5WWnoDq6hQJmUetSC5G1sqDmcMkK6ZVTqj4evB7O++dWCLp3XbrRozekQTE3zRVuw9Zh7351klnsqUJDGJrOlcbsKDMnuiooGdP9/5cCrt4M/gxj+Xr8OixI9k4hCns1+cGAJIAUtPmJWlZpfq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sHo3siLR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L77VvB030385;
	Wed, 21 Feb 2024 03:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=pXwGWClYp9wVjQBSD28zYcC5WaHnWxUGwSoGfrcWOVs=; b=sHo3siLRfkRF
	7Os8AhVdb1pHdpoXX7JaYJYlJmhUvjOPlQf7+2YzCHsAjYxymXnY08mFw/bsj8c9
	TyhXotK8m27ytQM8SvsbNLhl5Z35p7pe+Nef7MxNzi4e558HpLF/JM+3hEZvbr1o
	ETTNd2gHcspSaiZDvG99N97EL60cKMPk9eIhChjauMFKCQxKR2KAlkOeZT2UcjHV
	EC2aSYPtqLMyqOFXkPVTtxn97IuBh9voymet8rnasW4pAFDPPx+wCFBNpvkySocw
	ENn/F9RAxCeTuokKhxEDgXc9XKQhHD7DH3HabqWp6qUsyZjC30T8aIV2dLXYkg1S
	+4UZLcXQhA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21gartp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:59:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41L8x79u041510
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 03:59:07 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 21 Feb 2024 03:59:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 21 Feb 2024 03:59:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 21 Feb 2024 03:59:06 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41L8wqJA004732;
	Wed, 21 Feb 2024 03:58:57 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v5 1/3] docs: iio: Refactor index.rst
Date: Wed, 21 Feb 2024 10:58:46 +0200
Message-ID: <20240221085848.991413-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221085848.991413-1-ramona.gradinariu@analog.com>
References: <20240221085848.991413-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: h55UOR_7mcoFy4olK6e7Q3yiIGhKpo1L
X-Proofpoint-ORIG-GUID: h55UOR_7mcoFy4olK6e7Q3yiIGhKpo1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210069

Refactor index.rst such that it contains a section for generic
documentation and a section for Kernel Drivers documentation.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v5:
 - no changes
 Documentation/iio/index.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 1b7292c58cd0..db341b45397f 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -9,6 +9,11 @@ Industrial I/O

    iio_configfs

-   ep93xx_adc
+Industrial I/O Kernel Drivers
+=============================
+
+.. toctree::
+   :maxdepth: 1

    bno055
+   ep93xx_adc
--
2.34.1


