Return-Path: <linux-kernel+bounces-129700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E91896EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4101C25BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F30145FE4;
	Wed,  3 Apr 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XmJDrd+t"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063B1386A8;
	Wed,  3 Apr 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145860; cv=none; b=O/QqWLJ3KYg9MLWTzbcTLl23v3S6liUOOugmLghRyM8BXvMXmuwiuXkHSUeP1mmwT69Ob/2gXMpAqBRAMu9QiJpVpDz5iDDBQJtyg8+OA4rByFn3mUxGWpFrtxAQuRUcV0Jncu5mokznq3lNsxJfTW7Z/RLUcl8+Sl4ykvYBSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145860; c=relaxed/simple;
	bh=hdLUuD8fx1CMGkGXwESeN9RSE2VD3mvgjslSyivSGQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZawTMeSjUYlLRXiwx1B0H8Gygu2AUtdaMxzwvoTebf1bCVlP8qEccEqrVWgN4+hg9IogNJO51Cccy0okrWzYIpDlOurfRzBLqKrdaQwkndhRyGwax1rE+kBtQbIzGwLseXK/Fa8KEi60R2uVmC1tRTKvRKjtQhr+ORgAa9eCmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XmJDrd+t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4339ab75016340;
	Wed, 3 Apr 2024 07:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=T2FYrIWfqhlY
	ziqC5pSMisEdsl1NqWOtXWWgDNIMMA4=; b=XmJDrd+tUy6PMvJv3DVZ1bGYkDjM
	pHqPcV6WskAcBE4padRSwEk+fMDrEox/ZqVXc/ITt8sM54DmG+GEgddCopE0HbEP
	V4C7fN+/F+8mbKFz6RvuyQFvhMakdsZvfWCoof+qSw+Sxgraoy8JX8Fkhq8epk03
	Z6EgBaZ/7iKHqI5jkhIhc6blGp8HuZfCiVaf/QazBsokAHMIKk457rp5bnXQxxSd
	vcFF8FM7UGVCgUGpqOlzHmZmLBsPt5ZAKLKqfUvnO5MDvaXSzL6+H6xNaz820r0s
	ynKqGgA6/rVabnheK7+mATSYJxZTHgB9isvhRfKW3gkQfKksmMbxvgzQLA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x87c6f0hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:14:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 433BEB3a030966
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 07:14:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 3 Apr 2024
 07:14:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 3 Apr 2024 07:14:10 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.117])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 433BE16p019608;
	Wed, 3 Apr 2024 07:14:03 -0400
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 0/1] iio:imu: adis16475: Fix sync mode setting
Date: Wed, 3 Apr 2024 14:13:56 +0300
Message-ID: <20240403111357.1074511-1-ramona.gradinariu@analog.com>
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
X-Proofpoint-ORIG-GUID: 5FDR5Wh8e7KCreIrYZ1CMBk7WL2Y2iAP
X-Proofpoint-GUID: 5FDR5Wh8e7KCreIrYZ1CMBk7WL2Y2iAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=831 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030077

Fix sync mode setting by applying the necessary shift bits.

Ramona Gradinariu (1):
  iio:imu: adis16475: Fix sync mode setting

 drivers/iio/imu/adis16475.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
2.34.1


