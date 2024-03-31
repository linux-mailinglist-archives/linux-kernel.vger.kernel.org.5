Return-Path: <linux-kernel+bounces-125932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E2892E5D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE55B215C8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06DB184E;
	Sun, 31 Mar 2024 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HwpM0mq5"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E6138E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711853022; cv=none; b=NCqXSh4cBacVLR5FuF3ZoPcZ0rZ2gNuleZ3IQzT4htLj7CjhZEIRu4lNApCXY6sn7g03BtR/UVz6MKywOMSqGFTzi2Hf6+8d+xRzw5OL6b9hOTXHTnMqXPit3jmzA1EHaimaa4t1jRosJ4s6IWDMnCwWR7NLj8v1l6fQ0hUpIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711853022; c=relaxed/simple;
	bh=kOkbClIJRk5GAx3K3G3l/uXVi2LfWu8FXmQYwKEtbvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JPo8OljOPnG1px/uKGZ5+1y+RLyxmWo+CHdDZnrRoHVCDuNrndTJJz591oETBWSy/dkex4OG3emQLMFDRZT5k06x5VQ4rerdb2igJIA1PSAJ3t8ZzDfotu05Qjs14JZUgd37mY0vjMjuUHFRNNMs9wR0Vm3n8Gmul1tZwSsNTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HwpM0mq5; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 42V1vEYb008954;
	Sun, 31 Mar 2024 02:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=qfU1Y
	HR4SX2Z20H/Yd7UvZqf9unQq643rBx7wKMYKCs=; b=HwpM0mq5omH93wHVaH4+R
	XxMfpK8w4G2J5MqqhbZxDvaRexiDqbJDGtrsHNAJgAZCOEMc8VhnHHIEJO3I+y17
	tfuhSeO74gWjx2B/uaG8K2ms69YKTVi3iJ83A1s8WfixAX+Pb+TzNBfSSFhqF1nv
	bS99mrrADmh0RmEiIqvOgxUMMGwM/0YiWRinMlryIBoO9SgQuRiYUh9Kl57+W/Z3
	thi9po4EnktfqC5i73Gyk56boeHMtVr09SYGzB6Bjrl6cjrHAbvc4VfvmBroG2ly
	keVjqphekRhRETqbPv2nU2BndzeJC9vq1w/3Y+dMU6opKPbhOy6oQrATVQCArkqM
	A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x67xy0u4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 31 Mar 2024 02:19:36 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 19:19:35 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Sat, 30 Mar 2024 19:19:33 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH 0/4] SLUB: improve filling cpu partial a bit in get_partial_node()
Date: Sun, 31 Mar 2024 10:19:22 +0800
Message-ID: <20240331021926.2732572-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rVlno1WbqhyLlX6eeifTL2PB42HMiyDp
X-Proofpoint-ORIG-GUID: rVlno1WbqhyLlX6eeifTL2PB42HMiyDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=405 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310016

From: Xiongwei Song <xiongwei.song@windriver.com>

This series is to remove the unnecessary check for filling cpu partial
and improve the readability.

Introduce slub_get_cpu_partial() and dummy function to prevent compiler
warning with CONFIG_SLUB_CPU_PARTIAL disabled. This is done in patch 2.
Use the helper in patch 3 and 4.

No functionality changed.

Actually, the series is the improvement of patch below:
https://lore.kernel.org/lkml/934f65c6-4d97-6c4d-b123-4937ede24a99@google.com/T/

Regards,
Xiongwei

Xiongwei Song (4):
  mm/slub: remove the check of !kmem_cache_has_cpu_partial()
  mm/slub: add slub_get_cpu_partial() helper
  mm/slub: simpilify get_partial_node()
  mm/slub: don't read slab->cpu_partial_slabs directly

 mm/slub.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.27.0


