Return-Path: <linux-kernel+bounces-77036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD586004D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4511F2342A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E883159590;
	Thu, 22 Feb 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RaFjSATJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55472159575
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624891; cv=none; b=InCteLDt9a+7+ctJC+/qxzSUSfCF6ltNlS7fpWBfCbLSzl78xzT8ZyjCUjCi5Wjdu+Sgvmd/DYBLigGts2WfB5sqGw6pjW9Ey7VSk9TLbw/jUK30UrEoyeL6TKO0Q1tIEStP4o4H/oQonQffoXKyQ508V0CP9y39ZV1ORLm4YHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624891; c=relaxed/simple;
	bh=uvISUepi0faJHLxOL9G1jzdyJKkcXe6Hs87hT6kr5QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvNhcZVxx34E67GeeXjQKAdT13Fylo3FLg27UF4Lu9B9f+Ls6sKi1hTlDuZLK/j0a/u9aoPdCrtcWJaWHVfWsWvCnv4dtxh5bKWfWSC2rX14ZD2odZgYCpd1PHLTnpGyyLY9arJoDiU/HDjIMgxfdKzURxemPhUNsAIeKOkVdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RaFjSATJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M7gxmO022032;
	Thu, 22 Feb 2024 18:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jFZj2zAHCd4tUDzFb5d8oO8E2+tJ2x95gkUNT647hRs=; b=Ra
	FjSATJTkQbdUWWGNDQtjSR4aZ1qBr7x8IoJiTpD5DUZ2CODx+Ibb17QFA0AWfbro
	ntr1BVrZVleD2/hcnGfnXuLS6RjWYrsHwqwpeyJn5eThynzweUEkCBcfocXCcANZ
	V5LhnWDjbUTn5Z1ehH0ba2SVdOW0UwFVjULTYdYSwFrYxiH1mf7WJuXQX3unF5Zf
	rbFFUZ3LB/hP4lLHblZVDBSKfS3xbQKo3LEvyKpYY45VT7ak+LDHnyE1bIzjOfZA
	X2CQfj2UoV+pVX742uWdiMRXQnUqcg84iFCLwdNiSK6HUrq5dTzaEtcwe2OlyFxI
	LkNRQrEbGlcNjEbhGHKg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24ahtdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI1BuL010421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:11 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:01:09 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 6/8] firmware: Move module template to the bottom
Date: Thu, 22 Feb 2024 23:30:31 +0530
Message-ID: <20240222180033.23775-7-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ZhYFu_GvPzoLp6U3--ZmILes4t5kBZA
X-Proofpoint-ORIG-GUID: 7ZhYFu_GvPzoLp6U3--ZmILes4t5kBZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

Normally, module template should be kept at the
bottom of the file. Let's do the same for firmware
module as well.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 642b4d5c4375..1d752965d311 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -44,10 +44,6 @@
 #include "firmware.h"
 #include "fallback.h"
 
-MODULE_AUTHOR("Manuel Estrada Sainz");
-MODULE_DESCRIPTION("Multi purpose firmware loading support");
-MODULE_LICENSE("GPL");
-
 struct firmware_cache {
 	/* firmware_buf instance will be added into the below list */
 	spinlock_t lock;
@@ -1633,3 +1629,7 @@ static void __exit firmware_class_exit(void)
 
 fs_initcall(firmware_class_init);
 module_exit(firmware_class_exit);
+
+MODULE_AUTHOR("Manuel Estrada Sainz");
+MODULE_DESCRIPTION("Multi purpose firmware loading support");
+MODULE_LICENSE("GPL");
-- 
2.43.0.254.ga26002b62827


