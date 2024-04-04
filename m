Return-Path: <linux-kernel+bounces-131283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9058985AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6491A1C22A12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524480C16;
	Thu,  4 Apr 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="P7g4AvrR"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAF745C3;
	Thu,  4 Apr 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228637; cv=none; b=qsjIt93hUgEcr8CdjIHIKFkVkNdNg/XnB2+4mxsUvwvL2kXqeIMMumN3zizW/TWPzWeJiguaOkBCNMMoO6LyFnzwfjCQU5hIAurSF6EcDK3GqGHGn6ajpV0PS/iDkR/gyTj3EOQLmMhibidxABofiA3nEYaTSQ+kRiDJkCOVOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228637; c=relaxed/simple;
	bh=87v1wghWfpMJ0bHVd3Jee9dLM2aOFzaMiSOSC+PXCsw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=neRt1YeG8PbJVqwOlve8kgzNEXOyH99jpwnRTnEpwkvqUZDkH7nZw/rGy7AOP6jtPsDJystsu7J+W/xTl+qRy5G95lTcUcBXCFC8F3C6BrS8M0M7h6DqPDcbzG/wxUqoCJQI22TVhDSeMJjJc5rU7AwaJtI/LHkTy5e4U8G7yT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=P7g4AvrR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4348RPhE001360;
	Thu, 4 Apr 2024 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=uWqk0JO3baIctyaWPjp
	fcs40ZE8bKsqU4sHSf23WV8s=; b=P7g4AvrRy9w2BmdAYK+/BSIGVv3TdxZx4gq
	yAEIdRwJYSni54fBJZTaVCozv86UHkqwtH0tJ9ccPnGPevnoaRxXuc5NtwdQ3C0n
	KuwVcK4wClLTGM9XLFqPa//1QlcoLsWEYHZyEU5LVPF9yqi3jxRDDuXY2jDFH117
	P9BMj9ih91VVJFjRCYQxAPdmfqb90ubk+BavXO1Xy1odmEqhSK+sszId04YiFgF/
	lSUtyhUQFeT57iZvOv40oVHmo420WUPZiDJb3GKujUDHlb5sLT5hFVv3DpT87lvw
	V9i1+m7zi2e1KMMOrmKF+mSIsTRBD/mt7DYgm5bpihwwF7qQAIA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9eks2kxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 07:03:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 434B3J4K018912
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 07:03:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Apr 2024 07:03:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Apr 2024 07:03:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 07:03:18 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 434B2vc8008372;
	Thu, 4 Apr 2024 07:03:00 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/4] dev_printk: add dev_errp_probe() helper
Date: Thu, 4 Apr 2024 13:06:22 +0200
Message-ID: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK6JDmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDINRNSS3TTUxJiQfS8alFRQXxBUX5Sam6Zpap5qZGJslGFgbGSkDNBUW
 paZkVYIOjY2trAd/SrnFoAAAA
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712228790; l=1552;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=87v1wghWfpMJ0bHVd3Jee9dLM2aOFzaMiSOSC+PXCsw=;
 b=K5ua3M1fp8McUAe46RoYz9pu0EtKvriBWwVhiuiHthke0oFGOW89EfaiWWWY/dhw/qZlZF3rn
 ctenC+k3qtTAG83veAaaQttLKycdbk4bLf2UgKpXD7KJRnoeEMeonWr
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gymPCS_wSV0XUHuI-F9ZCPIaml9eF14g
X-Proofpoint-ORIG-GUID: gymPCS_wSV0XUHuI-F9ZCPIaml9eF14g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=716 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040075

This series adds a dev_errp_probe() helper. This is similar to
dev_err_probe() but for cases where an ERR_PTR() is to be returned
simplifying patterns like:

	dev_err_probe(dev, ret, ...);
	return ERR_PTR(ret)

The other three patches are adding users for it. The main motivator for
this were the changes in the commit ("iio: temperature: ltc2983: convert
to dev_err_probe()"). Initially I just had a local helper [1] but then
it was suggested to try a new, common helper. As a result, I looked for
a couple more users.

I then move into dev_errp_probe() [2] but it was then suggested to separare
the patch series so we have onde dedicated for the printk helper.

[1]: https://lore.kernel.org/all/20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com/
[2]: https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com/

---
Nuno Sa (4):
      dev_printk: add new dev_errp_probe() helper
      iio: temperature: ltc2983: convert to dev_err_probe()
      iio: backend: make use of dev_errp_probe()
      iio: common: scmi_iio: convert to dev_err_probe()

 drivers/iio/common/scmi_sensors/scmi_iio.c |  45 +++--
 drivers/iio/industrialio-backend.c         |   8 +-
 drivers/iio/temperature/ltc2983.c          | 255 +++++++++++++----------------
 include/linux/dev_printk.h                 |   5 +
 4 files changed, 142 insertions(+), 171 deletions(-)
---
base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
change-id: 20240404-dev-add_dev_errp_probe-69e7524c2803
--

Thanks!
- Nuno Sá


