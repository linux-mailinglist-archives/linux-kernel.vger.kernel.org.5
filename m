Return-Path: <linux-kernel+bounces-60190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6785012E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB491C225D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80C23CA;
	Sat, 10 Feb 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QdoyaOhv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBE1FC4;
	Sat, 10 Feb 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525146; cv=none; b=k1gtPhubAhxWQ9g2udyhp/5o8E31MI+kduE+nlRDDhvUOcReqo9faKUBxGcoiBIB3akf4JoOSvuwOylpmfIzZoZWYMBBgHtA7eQ13cxby+NjCB8jqQyNMPlSO+/FXYyKoKXOE2jSRm3WU2h/iPFnJ+CmNZVrjahuqcsMjCZAQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525146; c=relaxed/simple;
	bh=S2uxyVIX+2DXgeJoXOSia6BmZqQD1L2X+CX/Og66v7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6n+YKDcNFz0Ob+jFSrpy+9iOoPlDOEfnjzwfs0aN8bYLbtV9qz2P66olMpBbPzF0JEQYyi34pW8iQ5Qt/K9HFLpPQR1men8BooRow6O9dTxRrI75quVU78T4OFa1CDHuGuYz4Tij6CYaCHKv/Lp50Jm7TQts9gJpC6DpN1WgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QdoyaOhv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419NbBKU022924;
	Sat, 10 Feb 2024 00:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=e286i0IykEAFU41r707Y
	XUMX3M7ZIYdFhpid21aIVz0=; b=QdoyaOhvQ9B7TTBWUlTXI7ZTyofr0fzAOTLO
	G7w+IsCoNXpYNZpdz4KEfHF8LCESm9aSVswEO+iSUkO9tvPDDFJ4YhSGxqPtHX8d
	/YL/OV5cPVac8g+8dtTN5DPZ+k8kW4E0SAna/cNtwA2pgarOA1luQfGemEPW0U+6
	1AOxgHU03i8xNVYicbFC8SO5wXJKaNMKztMywpTJfetvsMR4MyrTom8t6/ff4jP3
	IW4B4hVlWw1M0e2SDm+h/udCiEDrs/8tikpPu+VgkbIYTKpdLi0vC2MbxmmB1Bn9
	ryq6Vcg5hdcVJTg7MJREhcPfLuAjDt6MX4fi4hGt0vQvDgRvcQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5u4brcd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:29:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A0Tmrv025927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:29:48 GMT
Received: from th-lint-014.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 16:29:45 -0800
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
Subject: [PATCH 1/3] loongarch: Call arch_mem_init() before platform_init() in the init sequence
Date: Fri, 9 Feb 2024 16:29:29 -0800
Message-ID: <1707524971-146908-2-git-send-email-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9KmMJXSg3bjc8OdQ-nRggXQomCevukaI
X-Proofpoint-GUID: 9KmMJXSg3bjc8OdQ-nRggXQomCevukaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=834
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402100002

The platform_init() function which is called during device bootup
contains a few calls to memblock_alloc().
This is an issue because these allocations are done before reserved
memory regions are set aside in arch_mem_init().
This means that there is a possibility for memblock to allocate memory
from any of the reserved memory regions.

Hence, move the call to arch_mem_init() to be earlier in the init
sequence so that all reserved memory is set aside before any allocations
are made with memblock.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/loongarch/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edf2bba..66c307c 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -597,8 +597,8 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 	reserve_initrd_mem();
 
-	platform_init();
 	arch_mem_init(cmdline_p);
+	platform_init();
 
 	resource_init();
 #ifdef CONFIG_SMP
-- 

