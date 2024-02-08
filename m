Return-Path: <linux-kernel+bounces-57817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8384DDBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B362B26A11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DED6F09E;
	Thu,  8 Feb 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="c3MQVhYy"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3F6F062;
	Thu,  8 Feb 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386526; cv=none; b=Z7ZLPPRWd3b28KObQX1/yjFrXH2gJK4TODPMIEmSUYVWGd765YYa/m62oc5BbUtHkxFkdbvZCafqMaoJJGi4wawf4xuCnKJkrjiCEVMVxKqjR1olCmTvERaycUt0zuZ2i2DmAHGzibu/zGDwJizcNOL++S5jizrJEkyaReWBI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386526; c=relaxed/simple;
	bh=idc17Dnd0aMzqJYfPa6mns93WThUwAMCvs6BQAGOx6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpwPWJD33rpQ7S3mngAgehHpJhFKFzrojdjD/6F/BRjO4gFqJ2HLcoRuZGvI39LV0hEbu/voCgBzjfgYXRFlkopAZCfV51Sxz/03xapZJBC/zzAFKa/DI5f/pkqk28J6TImtIVJG8SkxgVA6RZMqJp3bzkQYfHcpvdBrKsCNryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=c3MQVhYy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4185ewU5020295;
	Thu, 8 Feb 2024 05:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=7zmTt+czFejwupv3+fEEMk8vHdLFPKQaGXl8NSU4w+A=; b=c3MQVhYy+xgA
	EJQ6vyRaWoVTdZ0Ps/LHys+iGaspSOW7OYjX1f3lDhnFT7xfONYeK82ZBs4EFRVG
	8lyYEfxJmpVIs2ZLZquq/xRRfwOKbhrD0wjCIBlfcUMqpzMA3NV/r0HZCLFUSTIb
	Vr4au0+n4ht65svtipDNQOUGYihrv3GeoiLK6bT/hhWVha3Qhl0wXfIEYDqTmAnm
	ANYmr4dAUm57pdSbY6pRjPAhr7mRvimM/N/j5zmppD1fjeQ9F5f0EXuHuYRZmzV5
	qPUw9KeEjJlhOI9dYzp50xdrNuGMOJn/ErQ9sDRB07hniJYT6n9MW2f0rGhgf6r3
	EHTqmV00Zw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w3pjt8n8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:01:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 418A1nZ1006785
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:01:49 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 Feb 2024
 05:01:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Feb 2024 05:01:45 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 418A1UNp027963;
	Thu, 8 Feb 2024 05:01:36 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v3 1/3] docs: iio: Refactor index.rst
Date: Thu, 8 Feb 2024 12:01:24 +0200
Message-ID: <20240208100126.183697-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208100126.183697-1-ramona.gradinariu@analog.com>
References: <20240208100126.183697-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BAq0eKiqa3JMTUlYJpiAH5QI58jKQYX9
X-Proofpoint-GUID: BAq0eKiqa3JMTUlYJpiAH5QI58jKQYX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=834 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080051

Refactor index.rst such that it contains a section for generic
documentation and a section for Kernel Drivers documentation.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v3:
 - new patch
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


