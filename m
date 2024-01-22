Return-Path: <linux-kernel+bounces-33081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41C836431
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451241F221FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41953CF57;
	Mon, 22 Jan 2024 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i8HXBNEM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF53D0A0;
	Mon, 22 Jan 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929393; cv=none; b=XC7Xbp7p7ja7RRKF5RPzVHITSIc/zXFBlVDLwx+Zoh5IgkAMr7+gyp/NZjSe5oayvJ2ANgeCRatUis3XCszAzG5XIluFx4HTTAhmTRdjqbHTSUTbl3PPp3lbJEVdm4gHVSV729OMShJejmKoKPumcnKoTjUAfWHmjNidXhOhIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929393; c=relaxed/simple;
	bh=Q1m7h0F6DzQ/vkJJU6RqqEh9DBk1bEKm9OrtdMCbdAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rGnnYKFIekdh+73ewxmkkKfW0a3cBzOQpAnPcE5r8ptgQUN2Z24oApJV+yJjjy9IgQR0FsemscOskBcDPwGFRfZoXzaqyvwfpohp3vb0qUyW0V0BKCE9yrMSGH91D3KUSW9+T4DFXl2g+RcqRd88FwanDWrIUTUH6XINDXNAV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i8HXBNEM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MCYFRe028209;
	Mon, 22 Jan 2024 13:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=ZtkcX/MfE5owMEhrjCNwUtd6yGeRWH2ZVRmmOAfHJIc=; b=i8
	HXBNEM5evjmD9D1yTuwc1JCzeggkgV1/69+qP5eWtopUhHmyd/Mo1TiD0YekgweI
	ljR13zdCQKrWbGt2oWEADy/2wYzGe0u7oDZN6GezoYUeWm04HjdHw0HXm57Gd3Us
	8dYe0yla0mqA5Ox3E5KALmNxfscH0H/jfswLoawMbBs3vHWsI+1tSdn/Z3ZLh3d1
	a/k7tssgqHpRydBose5dam9DnYtAlUCBT39f6b6UgSsDD6Qg4xxAsAyMJDOu3kzK
	SHdD7YRhW82PV37yqaeO+xip4WdvUFFQsxroRRxdtDAzAAEzlCeoMhSreWiQFo0+
	RjGt8ulwQZ2YVRdRJbTQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8rf98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:16:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MDG6E4013327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 13:16:06 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 05:16:00 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC: Nikhil V <quic_nprakash@quicinc.com>, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Tejun
 Heo" <tj@kernel.org>, Yan-Jie Wang <yanjiewtw@gmail.com>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_mpilaniy@quicinc.com>, <quic_shrekk@quicinc.com>,
        <mpleshivenkov@google.com>, <ericyin@google.com>
Subject: [PATCH v3 0/4] PM: hibernate: LZ4 compression support
Date: Mon, 22 Jan 2024 18:45:24 +0530
Message-ID: <cover.1705927916.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-GUID: w1dCeyiSx-DKrRBH32VbOBwxbjoNW5-Y
X-Proofpoint-ORIG-GUID: w1dCeyiSx-DKrRBH32VbOBwxbjoNW5-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220093

This patch series covers the following:
1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
used in the next patch where we move to crypto based APIs for
compression. There are no functional changes introduced by this
approach.


2. Replace LZO library calls with crypto generic APIs

Currently for hibernation, LZO is the only compression algorithm
available and uses the existing LZO library calls. However, there
is no flexibility to switch to other algorithms which provides better
results. The main idea is that different compression algorithms have
different characteristics and hibernation may benefit when it uses
alternate algorithms.

By moving to crypto based APIs, it lays a foundation to use other
compression algorithms for hibernation.


3. LZ4 compression

Extend the support for LZ4 compression to be used with hibernation.
The main idea is that different compression algorithms have different
characteristics and hibernation may benefit when it uses any of these
algorithms: a default algorithm, having higher compression rate but is
slower(compression/decompression) and a secondary algorithm, that is
faster(compression/decompression) but has lower compression rate.

LZ4 algorithm has better decompression speeds over LZO. This reduces
the hibernation image restore time.
As per test results:
                                    LZO             LZ4
Size before Compression(bytes)   682696704       682393600
Size after Compression(bytes)    146502402       155993547
Decompression Rate               335.02 MB/s     501.05 MB/s
Restore time                       4.4s             3.8s

LZO is the default compression algorithm used for hibernation. Enable
CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.

Compression Benchmarks: https://github.com/lz4/lz4


4. Support to select compression algorithm

Currently the default compression algorithm is selected based on
Kconfig. Introduce a kernel command line parameter "hib_compression" to
override this behaviour.

Users can set "hib_compression" command line parameter to specify
the algorithm.
Usage:
    LZO: hib_compression=lzo
    LZ4: hib_compression=lz4
LZO is the default compression algorithm used with hibernation.


Changes in v3:
 - Rebased to v6.8-rc1 after resolving the minor conflicts.
 - Link to v2:
 https://lore.kernel.org/all/cover.1700048610.git.quic_nprakash@quicinc.com/

Changes in v2:
 - Fixed build issues reported by kernel test robot for ARCH=sh, [1].
 [1] https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@intel.com/
 - Link to v1:
 https://lore.kernel.org/all/cover.1696410298.git.quic_nprakash@quicinc.com/

Nikhil V (4):
  PM: hibernate: Rename lzo* to make it generic
  PM: hibernate: Move to crypto APIs for LZO compression
  PM: hibernate: Add support for LZ4 compression for hibernation
  PM: hibernate: Support to select compression algorithm

 .../admin-guide/kernel-parameters.txt         |   6 +
 kernel/power/Kconfig                          |  26 ++-
 kernel/power/hibernate.c                      |  85 +++++++-
 kernel/power/power.h                          |  19 ++
 kernel/power/swap.c                           | 189 +++++++++++-------
 5 files changed, 251 insertions(+), 74 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.17.1


