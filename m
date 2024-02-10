Return-Path: <linux-kernel+bounces-60192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8C850135
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA51283DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B4524B;
	Sat, 10 Feb 2024 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i1e/u8ml"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428D364;
	Sat, 10 Feb 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525147; cv=none; b=fQYwDf4Snc5hcQa0tNk0B0MefTb7vgBRB3BJFTDF5QqclOMRcypNJeJQv994leCJpeGLYWcEMYAF4Sw9p2+lFRzR43NweFmIHSOWo8zm2hR3SftxgO7fuNLwrWUd5UqDl2f1qqEXqQI0stMUpOJJjQKvg8hWimwh1VevBU/cAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525147; c=relaxed/simple;
	bh=tWs/RdzKNSpeNzDiKFrH3scRraIzvGSczheN43Mzbmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghC+ZCEEqMREE8kll4PVffpUUWi/ZomsAV1lS93tuRKKbs0Kb9rmkMeiFSIAu7JVDeFmKvCe5S2zZIBDnoPNoa7xU2/5lTQYLmZWrYbsk+bz3VWhAUKulHu/tJBdgchiNVBpcD/QH1NwdQB1IpHxOAN9utiEEYp0OAV4il7HbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i1e/u8ml; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41A0A2jM028423;
	Sat, 10 Feb 2024 00:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=d6dqZepJKO2rTUXSkKqD
	A+q3/xHQWCJswgErNvcSL/I=; b=i1e/u8mlsbL3zHlvANP1b06qPEQG4XpUsU1O
	RI6JisAzcGzNtLCMDbMsp5OsDe50MEK/uvAtV+yzh/DrMduN74hmxR/HpCK+qx6L
	afGn63vRw53qHV68rhtzeDkFFTeYZJvs8NujfaZGtVZnee7nweGGZjqyYYhae48z
	72I2pr0FNfd8G9uAM19fBdwUKX6ezo7/Bk5qxBl3MT3pQg0vJMVf+fpDBH77cqhb
	SGSk4FqX2kNc6ANjKZ8VVRtuOTVr5+xeWfVoK2yLm8Lx8hESxF/9MfvqNHPUKFAX
	x5PMpFyZRXT/3/UgA5R8e1iBiUmooHsN4geJyi76pULcA09b4A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5m159bts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:29:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A0Tn2A011721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:29:49 GMT
Received: from th-lint-014.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 16:29:46 -0800
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <chenhuacai@kernel.org>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC: <linux-openrisc@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde
	<quic_obabatun@quicinc.com>
Subject: [PATCH 3/3] sh: Call paging_init() earlier in the init sequence
Date: Fri, 9 Feb 2024 16:29:31 -0800
Message-ID: <1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ayi3Q_Ob1ob7P-VVfjTiuXJiq6E1gt_K
X-Proofpoint-ORIG-GUID: Ayi3Q_Ob1ob7P-VVfjTiuXJiq6E1gt_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=862 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100002

The unflatten_device_tree() function contains a call to
memblock_alloc(). This is a problem because this allocation is done
before any of the reserved memory is set aside in paging_init().
This means that there is a possibility for memblock to allocate from
any of the memory regions that are supposed to be set aside as reserved.

Hence, move the call to paging_init() to be earlier in the init
sequence so that the reserved memory regions are set aside before any
allocations are done using memblock.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/sh/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index d3175f0..ea40798 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -322,6 +322,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
+	paging_init();
+
 #ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
@@ -330,8 +332,6 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
-	paging_init();
-
 	/* Perform the machine specific initialisation */
 	if (likely(sh_mv.mv_setup))
 		sh_mv.mv_setup(cmdline_p);
-- 

