Return-Path: <linux-kernel+bounces-131282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F98985AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB92CB23738
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3182871;
	Thu,  4 Apr 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nNcTYnhu"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7480C0B;
	Thu,  4 Apr 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228637; cv=none; b=uXO8meo+PvmuyiojSEPLMGl9d78aPKF9TChXT3RFCZaFqGG/J39MnB3yjtE7NWaGXvkKlgPozYg3TtxD+g83K0Ijg2bqkoycXjszsjXyDHFFDDLFEJB5V6Dff8Am8nEWmcofyem9agDUQiyNeXFsAhvGrtVnZjKEchXwxGrDkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228637; c=relaxed/simple;
	bh=UI9LYwYsbzsvYImq/LHr54gyhLBEwgpl2jvt1KqrE14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Uxs8n1km6Rk4EgsFzmKiikTpxfFKXjByD8+47xYi5PfGtDLcECfv82j7RDnpxr2h8KYDar1wfd8BJV0rK3KE+4MlNsaB0AFuLvmcWgRL9Tr3LCpKrn+BYEN1sTJVOwLjJyT/2Z70rVv5OpjHP4iPklPCSCNBEoKvjP4zgz8wrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nNcTYnhu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434B0t7Q027727;
	Thu, 4 Apr 2024 07:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=DVie1SwrMjiwlrzQLb/M1yZj1Vl6Rs0UnN786RZz6OU=; b=
	nNcTYnhu1Ypp5Uua6EW3IgTZkQDFcAXkGU0fkBA2qcVm01e3JD88yj1oDivbJcub
	mndqI1sopB4CKcRT1rCVYPuxlBODK3ZtVVQe+beo3UAASq+Zb41FBUuCsPwHZC6s
	enwT1quXTCcJxTGben6/+GtptnFXQ5nge+il2868UFKKdXJ2tl5uIOdkbFvbRvlL
	abKwH/i27KKEMSB1IoovhR/++Q8+0nAbfJIk3mqWBQe8Zr5ljb1ZYS/sbkHpzDhI
	k0V3pDToNRK1asEt5qlfNQMXlpkej1QfAA+h/wJW4qI9uIjk+8cqaaJkkr+znrY8
	LSPNKcj4A3bd+y0wuqNuhw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3x9ty900bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 07:03:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 434B3L9f018926
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 07:03:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Apr 2024
 07:03:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 07:03:20 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 434B2vcB008372;
	Thu, 4 Apr 2024 07:03:17 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Apr 2024 13:06:25 +0200
Subject: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712228790; l=964;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UI9LYwYsbzsvYImq/LHr54gyhLBEwgpl2jvt1KqrE14=;
 b=QpVM/CwFSB08m+dHiZ29iZzwzTePxpxfwoYGgEy0hgyimYu4ynHk3Ye0RAsdO1BJBhEMRYx1M
 uPMEO9hw6K4DFL9AXLgnkn6Nvguu2I22cQ32KH0wgne9HEQX7MuA+AK
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ohDMsrMdtH-xBzVjz5Jt0KLbHxddhxou
X-Proofpoint-ORIG-GUID: ohDMsrMdtH-xBzVjz5Jt0KLbHxddhxou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040075

Using dev_errp_probe() to simplify the code.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2fea2bbbe47f..e0b08283d667 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -296,11 +296,9 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 	}
 
 	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
-	if (IS_ERR(fwnode)) {
-		dev_err_probe(dev, PTR_ERR(fwnode),
-			      "Cannot get Firmware reference\n");
-		return ERR_CAST(fwnode);
-	}
+	if (IS_ERR(fwnode))
+		return dev_errp_probe(dev, PTR_ERR(fwnode),
+				      "Cannot get Firmware reference\n");
 
 	guard(mutex)(&iio_back_lock);
 	list_for_each_entry(back, &iio_back_list, entry) {

-- 
2.44.0


