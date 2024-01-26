Return-Path: <linux-kernel+bounces-40887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488183E78C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50BB28F103
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D066281C;
	Fri, 26 Jan 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hieDGjJE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471060876;
	Fri, 26 Jan 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313365; cv=none; b=d+862qxFmC9fRVw/wf4+GGXIqvgJCtRUIGnb0DNu87e4wa/fhV787YNLxkdv3L9EYK7E4/pJV5knVYBf1fc3EDr7NQcTDSjDaZPt50bkOB7pzPvuPiSztFpM6kkDURt/ysRRgFY9Fs2cdvMBJJuEqHbsLkhBfkHN5qKQZm3cC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313365; c=relaxed/simple;
	bh=6T2WTb6El6HviQWBUPe5bY/jkQH9KN1dRogKYtmuuwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU6H97QEYQnqZe1Ci82eRXaIe2uVD2i72+Sn3Ri5rZXvLnG3ekWrVYGMddFPQVeQPv3SLXdIE9CPP20GDZXIe4YjL8/8OehtoYgWDSi2/s5UA7jU+C7FFLz9AeznU7E/g0PXqZpz2gTVIzF89z6y7TZvCTrRa0aQaDXVy+YJWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hieDGjJE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMNT1w023758;
	Fri, 26 Jan 2024 23:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=TQbxaUradiVsQAjmlk+e
	lqhTc/xEHMy4mH289Ds/6RY=; b=hieDGjJEIJ4KYvgxtpXww114lPvQuyPPwhqK
	Pa7vEvRIxH0Qw7sIubTcUXm3jsqqR4l1fZbbOc24cC9dlIgE53IU6yBLFt4yzjjC
	k27ffZcZw4h01AEGxpWUFv6lzfAW1XMkNZLuC2KLAld7CPfzAqPwxk8a3CrNLqZH
	uvD5hKcrlY+aBk11uJt+ge7todLie0qsNrCeHsWixzMjH8u7pWJmSJQ3c8pYymUV
	YZajBZPudI07T/rpQ/6lPY3ccxQ4+c8Rwhm1npPn/U8z+daaJo69gwAvJeHbiiLe
	4b25/h9libYHFHakDkNUMPf0HS/77JYIhumU3MCMrMV5B5/OsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvmmmg7w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtMRT009460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:22 GMT
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
Subject: [PATCH 23/46] microblaze: resrved_mem: Move fdt_init_reserved_mem() below unflatten_device_tree()
Date: Fri, 26 Jan 2024 15:54:02 -0800
Message-ID: <20240126235425.12233-24-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: 1YFft0XNdhKnvYvkmrY4qIB5N9zsQ1B-
X-Proofpoint-ORIG-GUID: 1YFft0XNdhKnvYvkmrY4qIB5N9zsQ1B-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=863
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
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
 arch/microblaze/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 631faa4613ec..d999ad774a44 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -55,12 +55,12 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_memory();
 
-	fdt_init_reserved_mem();
-
 	console_verbose();
 
 	unflatten_device_tree();
 
+	fdt_init_reserved_mem();
+
 	setup_cpuinfo();
 
 	microblaze_cache_init();
-- 
2.17.1


