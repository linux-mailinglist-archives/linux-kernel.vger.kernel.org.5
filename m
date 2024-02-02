Return-Path: <linux-kernel+bounces-50164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A189847527
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CC529255E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3021487C1;
	Fri,  2 Feb 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cGG0JMzL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1621468E6;
	Fri,  2 Feb 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892124; cv=none; b=TQH2dW9MNXPidxnAEwku70qKFedzdoXNbYfRj9cdXDmhEzUpWt9NDMu6WdWTxsZ5WUSvrkLcWiI3C6kuEZGs3PtTriLQ3nGYeCKYtSGwin9sZtNFKxxtapTWIMBPv8cyPDl726QwUhHG6rX7YX0P0W8v3Jnz1QSLHUywF+OzCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892124; c=relaxed/simple;
	bh=g4/Lme51PqbRNplL2dW1VIxg//AbxpVLnn6uJyh7p8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NTdUQ31UmerWdLJ8vb3wMhw86oKhdGfEaXmFix8vO6pxavAZsyBjEAqt+3/qbVWu21rdPNYnX4gTjPPMa/v4WO3tOjWiiESsIATb1k6fn+SFiSvJq/IeiaudTmwvBwdQ+kHJ5nwe30j3OhhlC0T3pxh38itA1p/ylpy/0xy/N68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cGG0JMzL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412GOVwK029960;
	Fri, 2 Feb 2024 16:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=1ieg7Nu1h5WLta/i10MG
	vCQme0ZcAD8tbxUmkqkp2Jg=; b=cGG0JMzLUfKTzP1NtSJVdkbbbQccaqDAnTfm
	txC+PS50Vo7pEOEAYpI4aC5TSknGT2oFrfWJMweunHBLlobZMiQonedEHWItfHaX
	uNu2Hnwa6mLxTJt3i614QVHVC59/CNlebsHiBmp1eUPu9S7UoRc92+C/0u+yDXJD
	zEWSEusVRPEM0+2gwLdi8atb3r7fiI4jmYl2VwYBUf6BeY5XBQuO4gONnfxKfeaO
	4paxdXmfPX41AbJcVdNbAJZ/G8dHs5i3RoPYUF5ayUs3eggiQZ15lzqKKp0yPQJF
	Tv8SBvULBrzAbZVvia2B4OKPHMrIA8cCy0/b5KMAS4gKWK/zEQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwc1uek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:41:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412GflsN025317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 16:41:47 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 08:41:46 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <corbet@lwn.net>, <carlos.bilbao@amd.com>, <avadhut.naik@amd.com>,
        <alexs@kernel.org>, <iyanteng@loongson.cn>,
        <2023002089@link.tyut.edu.cn>, <quic_bjorande@quicinc.com>,
        <quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <workflows@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
Subject: [PATCH] Documentation: embargoed-hardware-issues.rst: Fix Trilok's email
Date: Fri, 2 Feb 2024 09:41:19 -0700
Message-ID: <20240202164119.4090703-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UHEM4n3Oug9_QCHsvcVEo9sSl-NXoHwV
X-Proofpoint-ORIG-GUID: UHEM4n3Oug9_QCHsvcVEo9sSl-NXoHwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=781 clxscore=1011
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020121

The servers for the @codeaurora domain have long been retired and any
messages addressed to @codeaurora will bounce.

Trilok has an entry in .mailmap, but the raw documentation files still
list an old @codeaurora address.  Update the address in the
documentation files for anyone reading them.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/process/embargoed-hardware-issues.rst             | 2 +-
 .../translations/sp_SP/process/embargoed-hardware-issues.rst    | 2 +-
 .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
 .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 31000f075707..bb2100228cc7 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -255,7 +255,7 @@ an involved disclosed party. The current ambassadors list:
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
-  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  Qualcomm	Trilok Soni <quic_tsoni@quicinc.com>
   RISC-V	Palmer Dabbelt <palmer@dabbelt.com>
   Samsung	Javier González <javier.gonz@samsung.com>
 
diff --git a/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
index c261b428b3f0..7d4d694967c7 100644
--- a/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
@@ -273,7 +273,7 @@ revelada involucrada. La lista de embajadores actuales:
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
-  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  Qualcomm	Trilok Soni <quic_tsoni@quicinc.com>
   Samsung	Javier González <javier.gonz@samsung.com>
 
   Microsoft	James Morris <jamorris@linux.microsoft.com>
diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
index cf5f1fca3d92..c90ecb557811 100644
--- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
@@ -177,7 +177,7 @@ CVE分配
   AMD		Tom Lendacky <thomas.lendacky@amd.com>
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
-  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  Qualcomm	Trilok Soni <quic_tsoni@quicinc.com>
 
   Microsoft	Sasha Levin <sashal@kernel.org>
   VMware
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index 3cce7db2ab7e..93d21fd88910 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -180,7 +180,7 @@ CVE分配
   AMD		Tom Lendacky <thomas.lendacky@amd.com>
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
-  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  Qualcomm	Trilok Soni <quic_tsoni@quicinc.com>
 
   Microsoft	Sasha Levin <sashal@kernel.org>
   VMware
-- 
2.34.1


