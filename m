Return-Path: <linux-kernel+bounces-60189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32485012F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D09F1F26811
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72123C6;
	Sat, 10 Feb 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BI11iwot"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8A1FB3;
	Sat, 10 Feb 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525146; cv=none; b=bse8fGydcZUbNM4CHObZ6TIdCvjNvl4er2Y32nTQXXde5RIX/yE0HEdZHkBzqJXlH1uEZpXiIdRj5Q4lN5eJAQVoXScBE49GiACzm+PDf0ZZbiy6im7OhK8dBt15SRKX8XiG1fyq23cdh9gETXHj2lZyzktPNpsWehr7UrY2I58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525146; c=relaxed/simple;
	bh=86ofy+kM5/T8yxYifh+rhywEk+E0E7T2saCw5ZL4pS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGjeDFcB29lk0BZzEu114Tu+thmtHtGPzcckk5sAvGyWmnFcCCuT2DMzkig8WXcnPdjZ+GmnShQ/bwUZO3oOI/hJpK70eFG7F3GUxTl0/cD6p9FkB3Go7h/WVrcFFkBqKFAmKricZtcdiJ+eUYBCCOmsQeIsmSzDypWEhZ++uhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BI11iwot; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419Nts6s031351;
	Sat, 10 Feb 2024 00:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Y+AILw3pX1T29zesxJoDs7erTQv/gDbeD35hCxK6nqc=; b=BI
	11iwotVsHW4+YaVnK6MfOXbxyVFhGjjb7xTNKbO6c+0r8/TTeZnKJPcIA/bZrZxh
	I1IfTPs5Gc9Vt7G8KjJGaGgL7UtHuBybizvQml1skqiDwNd2HF0xVuEio/6NdcuP
	mL2TeLoY0dzn+9pw9P7v3rv9cnnLIRzgKBtzujicQwVsfkpe4iNj97Vey7bS/A1r
	p/A+3uwcUjM2IMHGfyJXVrZiP/HmwTFSUTJ61djqQaXAK80AmnvYGBxUuOTh3dSF
	TdXTPy28w+kL0dm3+24tS6jxna/hb5tyO80GpgGGsCa3LRogzbhdx38B4+p7EpaG
	p25KzyVD5G73vZ+prKrg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5u2k8c02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:29:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A0TlCw025917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:29:47 GMT
Received: from th-lint-014.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 16:29:44 -0800
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
Subject: [PATCH 0/3] Restructure init sequence to set aside reserved memory earlier
Date: Fri, 9 Feb 2024 16:29:28 -0800
Message-ID: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.7.4
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
X-Proofpoint-ORIG-GUID: _wH-3-rOkUcyW1AYOaxCUEVnFN9qy5ZW
X-Proofpoint-GUID: _wH-3-rOkUcyW1AYOaxCUEVnFN9qy5ZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=510 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100002

The loongarch, openric, and sh architectures allocate memory from
memblock before it gets the chance to set aside reserved memory regions.
This means that there is a possibility for memblock to allocate from
memory regions that are supposed to be reserved.

This series makes changes to the arch specific setup code to call the
functions responsible for setting aside the reserved memory regions earlier
in the init sequence.
Hence, by the time memblock starts being used to allocate memory, the
reserved memory regions should already be set aside, and it will no
longer be possible for allocations to come from them.

I am currnetly using an arm64 device, and so I will need assistance from
the relevant arch maintainers to help check if this breaks anything from
compilation to device bootup.

Oreoluwa Babatunde (3):
  loongarch: Call arch_mem_init() before platform_init() in the init
    sequence
  openrisc: Call setup_memory() earlier in the init sequence
  sh: Call paging_init() earlier in the init sequence

 arch/loongarch/kernel/setup.c | 2 +-
 arch/openrisc/kernel/setup.c  | 6 +++---
 arch/sh/kernel/setup.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 

