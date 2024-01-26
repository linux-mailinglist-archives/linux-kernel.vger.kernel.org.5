Return-Path: <linux-kernel+bounces-40883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793383E776
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0741C20E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4460DDC;
	Fri, 26 Jan 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fMr+6M2D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CF605AF;
	Fri, 26 Jan 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313362; cv=none; b=kUx95lJm6MCJDK1UYIq+QOfyYVtM/bSrF+Yx+nVJhYGqtHL25D9hc4Oc1rNtpvItpt3gQ41TbBSQjlFp2IO6LfBCxkDLdGKNpHC8HXg1TT6+FlVKCuL6RkspCKRs0TU4VrfIbGI8mrMJuXp1ytRsejg5a2t34MInEM7n8fqGgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313362; c=relaxed/simple;
	bh=oATBYg4WZvtVhxazY83MItcqBPQxfC9ckmoF5bcehvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUOEO5VKmeKEVShpPGISTS6kVCODDbWiBqny8g8kdbM66pDu8UAOHPyxsj5PP3/JXdOSJHCn2OYc1JOeFCned0mbbc7rkaptqs3eFUPJPNVX/Wq+iQZxqNH188VOXS0qL9XjUxNBC2OqwpFIiPVDJn1JDhQ3QlwfssweOX6/uUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fMr+6M2D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNABQ2002718;
	Fri, 26 Jan 2024 23:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=9NIeVab+4KQFwJjvpVja
	hQhcsSm6ssiCjFbQstrLKNA=; b=fMr+6M2D9JB9W03G4AclBkYHg1/U5DQfspNX
	5yuTVgvmYEwIj8iK8EfN4MMYa67iFl+IYDwYcEJc1VEtdM93+iXz/OS4kruq0V6R
	l/678czq8sW12SjfGN+CYEQtse7BAKFrQILPO5ZTn+BzkYFtUjmBXVC+sLAcrHrY
	g09yy/jWWYTDBEw+ycJjfb0+8lHGKnvi3UCLsmMO5x9JuC9RgYAxSCL1IX7zHoja
	gpyjuA9L9ngrf6eximgRRNu9o0y0OB/0rACAHmr6AuCaf4ycIT7qWIMBazEqm6Az
	UCp/q6cFxXD0rf7/NdiBo0f4h3alKFvPmy+o3dO3GXQVMWaT6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvgp2gru5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtJP6010237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:19 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:07 -0800
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <vgupta@kernel.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>, <guoren@kernel.org>,
        <monstr@monstr.eu>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <dinguyen@kernel.org>, <chenhuacai@kernel.org>,
        <tsbogend@alpha.franken.de>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH 22/46] csky: resrved_mem: Move fdt_init_reserved_mem() below unflatten_device_tree()
Date: Fri, 26 Jan 2024 15:54:01 -0800
Message-ID: <20240126235425.12233-23-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126235425.12233-1-quic_obabatun@quicinc.com>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LxtbCnVNAdzpVkcCk8ApI7GAjVIE2oTM
X-Proofpoint-ORIG-GUID: LxtbCnVNAdzpVkcCk8ApI7GAjVIE2oTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=863 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

The unflattened devicetree structure is available to be used not long
after the page tables have been set up on most architectures, and is
available even before that on other architectures.

Hence, move the call to fdt_init_reserved_mem() to after
unflatten_device_tree() is called so that the reserved memory nodes can
be accessed using the unflattened device tree APIs.

Using the unflattened devicetree APIs is more efficient than using the
flattened devicetree APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/csky/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 4e2b739ac968..d8c65819877b 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -73,10 +73,9 @@ void __init setup_arch(char **cmdline_p)
 
 	csky_memblock_init();
 
-	fdt_init_reserved_mem();
-
 	unflatten_and_copy_device_tree();
 
+	fdt_init_reserved_mem();
 #ifdef CONFIG_SMP
 	setup_smp();
 #endif
-- 
2.17.1


