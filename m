Return-Path: <linux-kernel+bounces-30019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82E08317BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CBD1C244ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C7241FA;
	Thu, 18 Jan 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="llcZOavu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297122F16;
	Thu, 18 Jan 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575602; cv=none; b=XsesBXC/gc84LUXZ1UaCed7oVAAcfYo2UscesELxW9i4euxpkBRL1CPbH9oaf6DpKa1/1iXxDQ2x/orirBW1mm9kk5AanE156OlxUNGgMsJaoacPbwUY1znj3N6bh9qE4V9Y0Pd45CHI09DS6qw/DFcqLpH5zezT14wxTJb0t4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575602; c=relaxed/simple;
	bh=QgYur3T9UwvSVkNtHMOx7Ihz32gtSj12RpHQg6Kj0fI=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=aYerE771/X0Xkd3oE/h7qIejmb9oVJ5zcFfXKziJBZbGEy1FptQn73wEzWUVmyYyQNbiBtTyN/JAw1IcZhbvLDrFgzae8bvlqE1uC1d6MkovmMM30eUP4/hvquE3JSRh2nmiNZuqGy6w4o6pYwCvAjzmiwiYaykj6q3pRyQ2RoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=llcZOavu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I8oWpk004925;
	Thu, 18 Jan 2024 10:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=D4SKnA3
	O9LLEGsotqMbDim6PNntDd3euh2Q5XQ9jEbg=; b=llcZOavuEt1XRAO+rXjgrsz
	x2lJhLMDm1ovhn84sbNJfvyBc3gc/E1yUcU1ZZQqwL/mN8hG9Xue74OnpoD8cDtm
	BS5bJV2MZsPzca2zsGCizLBs8aUo1qJYRs4kUqyqcZeM4DaLbxEYiq3XAO8O3z0D
	cFoVtXgQHPVv/6oqS0F/p/PFCEmdVO7HEx4Bnld+rs5B/3gFSGNkSP14cUgliGpj
	oIvGQmqu4UcDSSL5FNYwnzERuvR2/2BO2e3F7oVp7jqj6/ZHB1zfU8lOD7b56nQs
	vCGDRxwxGdgc0XqaJckZDWs5qV6oBkrRoyl4ZjCU3VrP/Y9HSlruXwl0fpefIow=
	=
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpxaj0n65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 10:59:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IAxu4u013107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 10:59:56 GMT
Received: from hu-sachinku-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 02:59:52 -0800
From: Sachin Kumar Garg <quic_sachinku@quicinc.com>
To: <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 0/2] add MBR type rate control for encoder
Date: Thu, 18 Jan 2024 16:29:32 +0530
Message-ID: <20240118105934.137919-1-quic_sachinku@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WAQHh77HLt2Me-K_yPraZsZPRC0dgdpw
X-Proofpoint-ORIG-GUID: WAQHh77HLt2Me-K_yPraZsZPRC0dgdpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=508 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180079

This series adds the support for MBR rate control type in the
venus driver.

This rate control type will limit the frame level maximum bitrate as
per the target bitrate.
It will improve the video quality of low motion video at ultra low
bit-rates.

Sachin Kumar Garg (2):
  media: v4l2-ctrls: add encoder maximum bitrate control
  media: venus: add new rate control type MBR for encoder

 .../media/v4l/ext-ctrls-codec.rst             |  2 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 38 +++++++++++++------
 .../media/platform/qcom/venus/hfi_helper.h    |  1 +
 drivers/media/platform/qcom/venus/venc.c      |  2 +
 .../media/platform/qcom/venus/venc_ctrls.c    |  5 ++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  1 +
 include/uapi/linux/v4l2-controls.h            |  1 +
 7 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.34.1


