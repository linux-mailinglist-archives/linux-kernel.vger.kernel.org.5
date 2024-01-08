Return-Path: <linux-kernel+bounces-19612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5303826FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF4E1F23113
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9D44C87;
	Mon,  8 Jan 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L133qaA2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6344C7F;
	Mon,  8 Jan 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408DG8Yo005240;
	Mon, 8 Jan 2024 13:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Cz9N0Iv039pO0J3plF5Oz0zQifQGedt5jqRTlubgixI=; b=L1
	33qaA2hKvcsykHXx4JvjAmwKQit65Zze3fhkD+m7tVYbKR7F2N0bIjD4e6mNXRTC
	5YUjO6la4cd7WhniphbTtTuPAVQ8XSZ0fuXywxAtD99XZOjqm8lA+ynHNjOia3is
	SjEpjxtxdKh7wMttKYwXRIjhMFsOn0nNADsS0Xa8TSSWrGjuUYGk4WexyCeJ4dkx
	oFTtVlcB+AYb3sdTk6J/gAK3IGPs4OYbJv3TDgzilRRSPbmAR80aOAqJq/m1eBj+
	Ib3+ce8s1fOfNPGSLrQn3HsLTPzmOmPPrOzJyHWhuPQ3/NPIwdPDXTio616Ow8Q0
	+m1iM0TyONLmJkFVU3nw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbuj8tk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:27:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408DRcpV011973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 13:27:38 GMT
Received: from hu-ugoswami-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 05:27:36 -0800
From: Udipto Goswami <quic_ugoswami@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: [PATCH v2] usb: gadget: ncm: Fix indentations in documentation of NCM section
Date: Mon, 8 Jan 2024 18:57:20 +0530
Message-ID: <20240108132720.7786-1-quic_ugoswami@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7sfaMaf-krFeYvCKwbT0-1gCbFEM438K
X-Proofpoint-ORIG-GUID: 7sfaMaf-krFeYvCKwbT0-1gCbFEM438K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=576 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080116

Currently, the section of NCM which describes attributes are having wrong
indentation.

Fix this by following the correct format recommended.

Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240108160221.743649b5@canb.auug.org.au/
Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
---
v2: Added "Reported-by" and "Closes" tags.

 Documentation/usb/gadget-testing.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 8cd62c466d20..077dfac7ed98 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -448,17 +448,17 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ncm".
 The NCM function provides these attributes in its function directory:
 
-	===============   ==================================================
-	ifname		  network device interface name associated with this
-			  function instance
-	qmult		  queue length multiplier for high and super speed
-	host_addr	  MAC address of host's end of this
-			  Ethernet over USB link
-	dev_addr	  MAC address of device's end of this
-			  Ethernet over USB link
-	max_segment_size  Segment size required for P2P connections. This
-			  will set MTU to (max_segment_size - 14 bytes)
-	===============   ==================================================
+	======================= ==================================================
+	ifname			network device interface name associated with this
+				function instance
+	qmult			queue length multiplier for high and super speed
+	host_addr		MAC address of host's end of this
+				Ethernet over USB link
+	dev_addr		MAC address of device's end of this
+				Ethernet over USB link
+	max_segment_size	Segment size required for P2P connections. This
+				will set MTU to 14 bytes
+	======================= ==================================================
 
 and after creating the functions/ncm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
-- 
2.17.1


