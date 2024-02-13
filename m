Return-Path: <linux-kernel+bounces-63091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C54852AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C321F233E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4DF22319;
	Tue, 13 Feb 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tm8ZE6O/"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032451803D;
	Tue, 13 Feb 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812278; cv=none; b=dLMl1SQeLBavDy4brloyxw71+U3a8icgz9F4IJDvv4UTsNZ0A8bvjkmtdsP1w7W+rOKb1jmk9qCK6iMHmN70I91tuUMM74q4AHe3j/je7g/JorVjES9MZ4OI2Ax8y2xSxvqyHpbc66bX7sW7PMIpSAnFgfvmYbCHkVH/yfB3dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812278; c=relaxed/simple;
	bh=2LPM9xehDtHRXCEaDf/EFwMKT44BxFMzqxeDwpYhRgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiSpWwXoQoGuLR19Lw+flYymABKeoaaFNvYCJ9+V55mdEzKcCffj9BQdTzp1y1e3QvNpUppxlVfwu+SSxAEMrwxIYVmAWt8lfr7ZxUDUx+4/jTA3F3w5LeyMLOfoi/RWI5D/mVGt+QJ4AOUpEZ3nK1cN7zuJo+qrd1BnRsVTJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tm8ZE6O/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7pL7N028931;
	Tue, 13 Feb 2024 03:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=CwhGNlHoDNSJ9sXx6xc2y1ZwD5Ps1hKjERoLq7p5dcM=; b=Tm8ZE6O/a6AI
	PxMUCr3T6LmJuoEGQkZE7l4AkEqQNVeV4dTR9jkAeifdC588QtA97Zn9L2QmeBa8
	ZaAWpjeJL7CQgHlhL21Dbvz+kk0qlt7/5NsbPHSdEhHuiC8pi5BdmwFcmrK26umV
	fYE4aWjG4esor5XGbjQEDUk/WlXo+izHHpqYfBRFORk9A5+Y0aWYrwSp3pYOI0KT
	7Pn+QZbKQhGatQ64aoE0SyUG5ZryddALZbv6vXEVxOsxmlD5GF0NRHY9T7npWTIN
	7yg6Jnzmfy5BOfOURjiVyWxuNGpS9D79znJTU6pbE2EiAyYRPGlAYBd8+JMjb5G6
	sOv7KK1yow==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w6pwkr27k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 03:17:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41D8HeMN020758
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 03:17:40 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Feb 2024 03:17:39 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Feb 2024 03:17:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Feb 2024 03:17:39 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41D8HPZC025896;
	Tue, 13 Feb 2024 03:17:31 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v4 1/3] docs: iio: Refactor index.rst
Date: Tue, 13 Feb 2024 10:17:18 +0200
Message-ID: <20240213081720.17549-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213081720.17549-1-ramona.gradinariu@analog.com>
References: <20240213081720.17549-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: PL0Rnihg7T4kBoqyL20Q863WfBV3dY6T
X-Proofpoint-ORIG-GUID: PL0Rnihg7T4kBoqyL20Q863WfBV3dY6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=899 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130064

Refactor index.rst such that it contains a section for generic
documentation and a section for Kernel Drivers documentation.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v4:
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


