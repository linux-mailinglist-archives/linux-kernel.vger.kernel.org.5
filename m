Return-Path: <linux-kernel+bounces-49277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED3846823
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F21C217EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882217567;
	Fri,  2 Feb 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OV3os6Dt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702617547;
	Fri,  2 Feb 2024 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856054; cv=none; b=QlQM/uDPO419IAa7wLyP+UHOg+3tZ8+4Q3a+BOxNsuU1uSGh5Umc6PkMY0YCjZyMXPj2ZD8KkzJG4QqqW9gBrjW5zkeGv/STPZbUhGmwbKN7KqwPUxlp73agprd+pFKzZCbULnQgNFlSRUzgb63CEufrdHCjShXqX3+Se0uif14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856054; c=relaxed/simple;
	bh=0WPUbXEkltUC9kTeWulHY70DcyijaXOjZQQP7zT+rDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gg3HsYXKsp4wlEmjbUZPDX/uQwBZgf7b3i8RICv4bZAvjBb61dgTYWJ5aRym4MJ3EFVHO+1hpfLigAsgABV0JetFkVA03aXchO6wJ6wC+sTAkCCmPfMr9cMS3qUljXhkOJdzDD8puVWXnkUye3Nzu9AtJs7JuvrGfQSbEdKYRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OV3os6Dt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124UfDl001619;
	Fri, 2 Feb 2024 06:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=rEmyEiSDXDWTDo90qxNOTF+tuXrkGyWL/uXs4iQglqg=; b=OV
	3os6DtbWOHVXSet2XwKkMSsNFvzj5KVguvI1IWqTCFZUh5VSFWhAnDwN3AHAAs74
	w6ri9qH4TwH7vwMaFgahkdAydogU30FoxrJCUdrx67OGUCj2jMmcfg9qilR1zpcn
	7ZoWT3gsPFLjT/uJc8ibetYOm96BUqtsrULh0HZFXpuL5/gQIlyqJ+gqpz9qZxNh
	on5RvfCRL5fwj74adp7LcrEeEKoSohziRtM/pjWvwjedvR6T1cMk+mVwU8Gmd3KS
	W3F5PTV8uloswv0Z4OwmRNtIAm144dh4xE0yK+lwuzp6rin+8lpbm4HjBsdWQQ4Y
	255bH+6rvnW37LaNJniw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00n2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:40:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126enUo002282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:40:49 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:40:47 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/16] Add missing features to FastRPC driver
Date: Fri, 2 Feb 2024 12:10:23 +0530
Message-ID: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
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
X-Proofpoint-GUID: lhfpXLFol1rKj9Uzkvm1ACYuHiqsCJsF
X-Proofpoint-ORIG-GUID: lhfpXLFol1rKj9Uzkvm1ACYuHiqsCJsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 malwarescore=0 mlxscore=2
 mlxlogscore=162 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 adultscore=0 spamscore=2 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

This patch series adds the listed features that have been missing
in upstream fastRPC driver.

- Redesign and improve remote heap management.
- Add static PD restart support for audio and sensors PD using
  PDR framework.
- Add changes to support multimode invocation ioctl request. This
  ioctl call facilitates multiple types of requests from user including
  CRC check, performance counters, shared context bank usage, etc.
  This series also carries patch to save and restore interrupted
  context.
- Add early wakeup support to allow DSP user to send early response
  to CPU and improve fastrpc performance.
- Add polling mode support with which driver polls on memory to avoid
  CPU from going to low power modes.
- Add notifications frameworks to provide users with the DSP PD status
  notifications.
- Add a control mechanism to allow users to clean up DSP user PD
- Add wakelock management support
- Add DSP signalling support
- Add check for untrusted applications and allow trusted processed to
  offload to system unsigned PD.

Ekansh Gupta (16):
  misc: fastrpc: Redesign remote heap management
  misc: fastrpc: Add support for unsigned PD
  misc: fastrpc: Add static PD restart support
  misc: fastrpc: Add fastrpc multimode invoke request support
  misc: fastrpc: Add CRC support for remote buffers
  misc: fastrpc: Capture kernel and DSP performance counters
  misc: fastrpc: Add support to save and restore interrupted
  misc: fastrpc: Add support to allocate shared context bank
  misc: fastrpc: Add early wakeup support for fastRPC driver
  misc: fastrpc: Add polling mode support for fastRPC driver
  misc: fastrpc: Add DSP PD notification support
  misc: fastrpc: Add support for users to clean up DSP user PD
  misc: fastrpc: Add wakelock management support
  misc: fastrpc: Add DSP signal support
  misc: fastrpc: Restrict untrusted apk to spawn privileged PD
  misc: fastrpc: Add system unsigned PD support

 drivers/misc/fastrpc.c      | 1949 +++++++++++++++++++++++++++++++----
 include/uapi/misc/fastrpc.h |  112 ++
 2 files changed, 1844 insertions(+), 217 deletions(-)

-- 
2.17.0


