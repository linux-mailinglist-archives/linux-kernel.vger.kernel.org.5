Return-Path: <linux-kernel+bounces-57816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161584DDB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535791C27F19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997E6F069;
	Thu,  8 Feb 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cAt9j2EC"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D746EB55;
	Thu,  8 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386524; cv=none; b=t2FgEh5AyK4MoN6KfrrJw8vb+3TN7nvfosJwLmqL4z1/7+WuLAWQnzhvrMjHgQQGIHAFyQbdXW8kBDNbTbt0hyOWY/FP2rZmC69zetavOJgZPb25eUZFLHYauBOk9/EiHTvplWi4dA+fFBESOuTSOvHmJhTkQKlH1RpYJ2YsGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386524; c=relaxed/simple;
	bh=7o4lIaG2NTyVExMC/ImG68CMmDlDyiZ/DvPycsSNAoU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FmXdZeICgDPvUyjPG2cwEFl2oy/BvMNzYr9K7G20Pv8Ru5ylbGQZ3qXqxyApDDBY8FC0EPoNE4zpPhnjs95yy4OpBjN7im2xRRsKxkt/+TyN0LL1lsCChIkkozfoWjJ//05WABg/pXE7AbSID36gkyTKHd0fS3bNiW/I2eQ6qSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cAt9j2EC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4186EKNX020307;
	Thu, 8 Feb 2024 05:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=S5GmtdhaVR3Z
	Btgo7T6okFtkC1i1lkkf6nc7nqgGtJU=; b=cAt9j2ECJUxSBhbv2Pcko0YSOlce
	JXvrLFx4I7bILHBm+WlYqnqWxjZpTYN1Hui87a5Wqy6MXa1pxg7NPgAFivYIwO6m
	Xjxg/XsZEUUxvCK/fhYLzajIP+BESO8W/gvPVay9GEuUOaZEUA/6F2IjppIvNRFa
	C0Kwa9+wNfjlUrM7YF2t9NFmw7fb2GFd4EoSFd60zM7+xrBG3yc+/YBWGeISkpYd
	/dhoOMUWPv1/eK1oAn736NGnG1sGP3LBkQtbaTB/QUWza4JC8i2UxRqO8TmFwmjx
	64stjGUW7/mreEpD+MzlxlE3nxh9Gge14pbU5o2OAcUeoSl4MNowhoFMRg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w3pjt8n8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:01:48 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 418A1kG1053239
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:01:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 Feb 2024
 05:01:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Feb 2024 05:01:43 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.135])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 418A1UNo027963;
	Thu, 8 Feb 2024 05:01:32 -0500
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v3 0/3] adis16475 driver documentation
Date: Thu, 8 Feb 2024 12:01:23 +0200
Message-ID: <20240208100126.183697-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xtLVScjOv59REU1vwyqEbJv6bxjb9QhO
X-Proofpoint-GUID: xtLVScjOv59REU1vwyqEbJv6bxjb9QhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=611 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080051

Add documentation for:
- iio device buffers describing buffer attributes and how data is structured in
buffers using scan elements.
- adis16475 driver which describes the driver device files and shows how the
user may use the ABI for various scenarios (configuration, measurement, etc.).

This kind of documentation describes how the user can interract with the drivers
device files, showing the driver's particularities and we think all IIO drivers
need such a documentation and will benefit from it.
Having this documentation in the Linux Kernel will make it more accessible to
the user, seeing how it is in the same location as the code.
Analog Devices is prepared to add similar documentation for all new drivers (for
ADI components), and in time to also add documentation for existing drivers,
following the adis16475 documentation template.

Ramona Gradinariu (3):
  docs: iio: Refactor index.rst
  docs: iio: add documentation for device buffers
  docs: iio: add documentation for adis16475 driver

 Documentation/iio/adis16475.rst  | 381 +++++++++++++++++++++++++++++++
 Documentation/iio/iio_devbuf.rst | 121 ++++++++++
 Documentation/iio/index.rst      |   9 +-
 3 files changed, 510 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/iio/adis16475.rst
 create mode 100644 Documentation/iio/iio_devbuf.rst

--
2.34.1


