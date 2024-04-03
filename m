Return-Path: <linux-kernel+bounces-129709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB5896EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032191C22904
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F238146003;
	Wed,  3 Apr 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CDssN7lk"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484C6E60F;
	Wed,  3 Apr 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146583; cv=none; b=XGbsIhpfZd6c0XeiH/YhWv7ED8xyejTn1n93d9RiNmaI16FfATEAYB8H3kKWtLafsvKMUCIyPK4fB9mh2CmHFTeMKHKIw+G8cfboBJuKCVOuZNo18zJETGYhAw5b+KbVlmDPBPhrlHPCkS6E8ISJFD1bb26/IxgaexghRwcTDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146583; c=relaxed/simple;
	bh=rkDWyKFHQlcK//l8NqLN4Od3LQ6jwyS9wT6NmXfTJO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gan1ACRqSH3D+qodM2RARaaYFjyC4W2JkcWkRO/PvOkjjqdFPOHb+8z3RpOCZKQS+GprmHrUDkVojCVdmL/O0xVhGAj/kmGUA5+JUlImIRrJKDZLmMJBiI5oszWkyx7RYUlUqhtUgM5RX04TBRILXTvMGVMXK7SF8qkr8f7y7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CDssN7lk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4337M1Ag015941;
	Wed, 3 Apr 2024 07:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=PXD3z/o/txzzPGoWI9hDoubN7IcsO/NqLqeUrJhqVfs=; b=CDssN7lk0dbD
	KCzmLE4Fo88z8/kJgBTS+myvckq4U3NvM4/BeRCeljEDh9PdyGPV3w2qhkFy7xZr
	xKKLy+gEiBL50ySXz+6L7zWSaxNnLBgYJuqhmo8TnWC/V398S268ctDWchpapqdl
	N8ixzNC1fH1BrcLT/dkVjYUCM5W5725snEQnV2KYniGBPzPJYm1mxk4tCm265ZEW
	rlKNRuXupEMlzS/f1JjFIbpA+dDV8bxFDIg0q0PXqt4sxSlckuHwbl6VqQWg/8/U
	LuUVrVnVfPp1E2tBKcCKlA5f/lTeMJnaZcP3HIbzK0TEszj7ALg3QIe3TRC/bLlB
	cDNTjxpsqw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3x92nh0tnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:14:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 433BEBhg034631
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 07:14:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 3 Apr 2024
 07:14:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 3 Apr 2024 07:14:10 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.117])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 433BE16q019608;
	Wed, 3 Apr 2024 07:14:06 -0400
From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>
CC: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 1/1] iio:imu: adis16475: Fix sync mode setting
Date: Wed, 3 Apr 2024 14:13:57 +0300
Message-ID: <20240403111357.1074511-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403111357.1074511-1-ramona.gradinariu@analog.com>
References: <20240403111357.1074511-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 4zXI8UjcwJ439MGpJGpvhI9NBGLi0s_Q
X-Proofpoint-ORIG-GUID: 4zXI8UjcwJ439MGpJGpvhI9NBGLi0s_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030077

Fix sync mode setting by applying the necessary shift bits.

Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 drivers/iio/imu/adis16475.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..bd30c3469d9a 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1351,7 +1351,8 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	 * in chip_info.
 	 */
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
-				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
+				 ADIS16475_SYNC_MODE_MASK,
+				 ADIS16475_SYNC_MODE(sync->sync_mode));
 	if (ret)
 		return ret;
 
-- 
2.34.1


