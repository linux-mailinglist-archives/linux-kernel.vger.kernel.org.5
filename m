Return-Path: <linux-kernel+bounces-65114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5178547FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C3289AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB419472;
	Wed, 14 Feb 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HUODt3XT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C591BC23;
	Wed, 14 Feb 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909483; cv=none; b=YEhMlHiR7QZ1cTl3ykYCzLXh4oOs75aHDBV1xojM2yPbuFW+X+tI4IV5Uz5WfELlnvDS7Y5APequxKI6dBMLJBfMJjxw+49pVI/8ddexrSCEomMmxjQCs+VUz6tR9eHhD8TakRC0LJAODXIftZQYBl4h2nruF1UveWKXVY4H8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909483; c=relaxed/simple;
	bh=ZXYInM9DzYBXRy307ukp5GNDcgD4Crt155eACGYgiHg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nrWp9WfJYUkTESuGauZj35q4N7vvxxy4z0RIfEfCUdQymzEC0AnUzxNWV9l42SoZat3D3qeex/Ireyk+lH6iXm3BH6ORk7g9coqzR52sN4yy8FlQpWGyVlqijM0QKeYzPFZ+sROrVkOIsi5n3xEcjukkG2yxu8Bbg+Q/SrXivYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HUODt3XT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E9uCWb026014;
	Wed, 14 Feb 2024 11:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=Jva86+YXCMqx
	o0LT3C/0gbD8Dx0/YyWNE6GHj6ltS1c=; b=HUODt3XTxERqmmu9yz9sfr5x51A6
	b/OBazA68wn4oZVLqV1yDBxjyRAreRbBjn/y/aDeVh8gqk6WuGShZYJdPHoEDM/c
	dwM8iHmNpnt7YYGJNffVKJurIKvSUStKl+fXbK2WSgK2CBL1jD5Sf+6KLrP33EgQ
	RyBD/jbX8r0q/PcqaYqE7PmVo1G91gxCsUu11LIaftrDPcbKzRsrLy+zBi9K1aJP
	tMJZI8/a81uCPKDaZYBWSxmRvMkxc5OWfi3EHyIy5y+R/ZLpJd0VVQ8semMvoQJj
	UnizjtncSJBd6zHl8ykDQ44DbvE7hGSTO24d/a2ao8KXhvXKIve2LPEESw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8jrj905u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 11:17:48 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41EBDjLS016521;
	Wed, 14 Feb 2024 11:17:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3w88r6f091-1;
	Wed, 14 Feb 2024 11:17:47 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EBHl7v023397;
	Wed, 14 Feb 2024 11:17:47 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-selvaras-lv.qualcomm.com [10.47.205.157])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 41EBHk3M023395;
	Wed, 14 Feb 2024 11:17:47 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 4178377)
	id D2401600C33; Wed, 14 Feb 2024 03:17:46 -0800 (PST)
From: Selvarasu Ganesan <quic_selvaras@quicinc.com>
To: tern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Selvarasu Ganesan <quic_selvaras@quicinc.com>
Subject: [PATCH] usb-storage: Add US_FL_FIX_INQUIRY quirk for Intenso Twist Line USB 3.2
Date: Wed, 14 Feb 2024 03:17:21 -0800
Message-Id: <20240214111721.18346-1-quic_selvaras@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E3bxnyCKtXIo7-h0S4A5DagDOAP9Q-VD
X-Proofpoint-ORIG-GUID: E3bxnyCKtXIo7-h0S4A5DagDOAP9Q-VD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=553 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402140088
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Intenso Twist Line USB 3.2 flash drive fails to respond to the
INQUIRY data stage request for a 36 bulk in request from the host. This
commit adds the US_FL_FIX_INQUIRY flag to fake the INQUIRY command for
this device, preventing a storage enumeration failure.

USBMON log:
ffffff8a3ee06a00 3192811972 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
ffffff8a3ee06a00 3192862051 C Ci:2:009:0 -2 0
ffffff8a3ee06a00 3192862185 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
ffffff8a3ee06a00 3192912299 C Ci:2:009:0 -2 0
ffffff8a3ee06e00 3193040068 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
ffffff8a3ee06e00 3193040214 C Ci:2:003:0 0 4 = 880b0700
ffffff8a3ee06e00 3193040279 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
ffffff8a3ee06e00 3193040427 C Ci:2:002:0 0 4 = 00010000
ffffff8a3ee06e00 3193040470 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
ffffff8a3ee06e00 3193040672 C Ci:2:002:0 0 4 = 03050000
ffffff892b309500 3193824092 S Ci:2:009:0 s a1 fe 0000 0000 0001 1 <
ffffff892b309500 3193824715 C Ci:2:009:0 0 1 = 00
ffffff892b309500 3193825060 S Bo:2:009:2 -115 31 = 55534243 01000000 24000000 80000612 00000024 00000000 00000000 000000
ffffff892b309500 3193825150 C Bo:2:009:2 0 31 >
ffffff8b8419d400 3193825737 S Bi:2:009:1 -115 36 <
ffffff8a3ee06400 3194040175 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
ffffff8a3ee06400 3194040372 C Ci:2:003:0 0 4 = 880b0700
ffffff89bee5b100 3194040591 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
ffffff89bee5b100 3194040681 C Ci:2:002:0 0 4 = 00010000
ffffff89bee5b100 3194040999 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
ffffff89bee5b100 3194041083 C Ci:2:002:0 0 4 = 03050000
ffffff8a3ee06a00 3195040349 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <

Signed-off-by: Selvarasu Ganesan <quic_selvaras@quicinc.com>
---
 drivers/usb/storage/unusual_devs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index fd68204374f2..7285287ca379 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -784,6 +784,13 @@ UNUSUAL_DEV(  0x058f, 0x6387, 0x0141, 0x0141,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_MAX_SECTORS_64 ),
 
+/* Selvarasu Ganesan <quic_selvaras@quicinc.com> */
+UNUSUAL_DEV(  0x058f, 0x6387, 0x0002, 0x0002,
+		"Intenso",
+		"Flash drive",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_FIX_INQUIRY),
+
 /* Fabrizio Fellini <fello@libero.it> */
 UNUSUAL_DEV(  0x0595, 0x4343, 0x0000, 0x2210,
 		"Fujifilm",
-- 
2.17.1


