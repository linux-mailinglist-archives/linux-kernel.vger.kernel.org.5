Return-Path: <linux-kernel+bounces-30300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04074831CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784781F278D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38F250E1;
	Thu, 18 Jan 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a8zsqaCQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74628DA9;
	Thu, 18 Jan 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592970; cv=none; b=cbOf+eJtR1CtAzSCxJzqNjZHDJCa9pP/2pR46rsRnEr6SvDuvXlOMj6C9kH+FL4EIpc7n/kTeYAfChLPwsdDnnQ2spSV6xj4XU/sJhyKQVr3bDtonuyo2gqLmE+wZETJqSkkNhpW4tVbb+qtz4WsNAVtoQvta+GFeYvKszNwnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592970; c=relaxed/simple;
	bh=QboJPgVs2VQtu7EcSaHZOW9/KLxh1z+JQ7085wVOEqc=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=E8Ssdbw/0yiDNotYo9ANTy6xF0EkSODhCSq9xYOGdlABEJKP80JGeKAUeFKJGHJztfyYI0Im+mcgmWSRI1wIa6hUz2b2fsmuwGJ84U6XhFVzD5s9Q0tBzY/bvuEPofN8Ci6mrrlXkUrnwnRjahhvEQAR7GCEmWD+vvLvMFu7lnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a8zsqaCQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IEPCrS002892;
	Thu, 18 Jan 2024 15:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=rpFfB4jGj6+d+f1dIWgC
	5FJtUd61jkYOQ1ScgiCwKJs=; b=a8zsqaCQNZ3chi3YrITtvVqj2g12mJz4rCjh
	A/tLCG+BGOHl+ksDiN8ZP474D2qwv38ej+Hq5MwwkUVgbdQS1KDugOJw8+ks+ZmD
	BXGYsbfyJV2xeK2BRanzTHX1bxETdmV1rUFJ6v5NmLbm6FqnhYGcd4NADIm8aWea
	ckmhgpHB7x36p1hEbkiprcvHhNFbnDrsSjy7Z2mxSHYmTEl5v/S8V4Ig6HBIYQ3d
	VP6mo2KHNH5tF1JCx+wJfb1eHA29eEQyYie40hC/s3iurJ2e4+PRTd2w1FVTVPdt
	QiK3tl89clvWAdGjaRi/Kf98016gZiGr6kGUgMYBMh8v7krscw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq5qrg6tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 15:49:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IFnNc5011085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 15:49:23 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 07:49:19 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: gadget: ncm: Fix endianness of wMaxSegmentSize variable in ecm_desc
Date: Thu, 18 Jan 2024 21:18:53 +0530
Message-ID: <20240118154910.8765-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
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
X-Proofpoint-GUID: 48kkOIk1KSaMS8jKqh5-jxyho3kfRjqP
X-Proofpoint-ORIG-GUID: 48kkOIk1KSaMS8jKqh5-jxyho3kfRjqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401180115

Recent commit [1] added support for changing max segment size of the NCM
interface via configfs. But the value of segment size value stored in
ncm_opts need to be converted to little endian before saving it in
ecm_desc. Also while initialising the value of segment size in opts during
instance allocation, the value ETH_FRAME_LEN needs to be assigned directly
without any conversion as ETH_FRAME_LEN and the variable max_segment_size
are native endian. The current implementaion modifies it into little endian
thus breaking things for big endian targets.

Fix endianness while assigning these variables.
While at it, fix up some stray spaces in comments added in code.

[1]: https://lore.kernel.org/all/20231221153216.18657-1-quic_kriskura@quicinc.com/

Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Since the patch was tested on ARM based QC devices, no issues were seen
as these devices were little endian. Thanks to Maciej Żenczykowski for
pointing it out offline over ACK that the patch breaks functionality for
big endian devices.

 drivers/usb/gadget/function/f_ncm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index a1575a0ca568..ca5d5f564998 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -105,8 +105,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
 
 /*
  * Although max mtu as dictated by u_ether is 15412 bytes, setting
- * max_segment_sizeto 15426 would not be efficient. If user chooses segment
- * size to be (>= 8192), then we can't aggregate more than one  buffer in each
+ * max_segment_size to 15426 would not be efficient. If user chooses segment
+ * size to be (>= 8192), then we can't aggregate more than one buffer in each
  * NTB (assuming each packet coming from network layer is >= 8192 bytes) as ep
  * maxpacket limit is 16384. So let max_segment_size be limited to 8000 to allow
  * at least 2 packets to be aggregated reducing wastage of NTB buffer space
@@ -1489,7 +1489,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	ncm_data_intf.bInterfaceNumber = status;
 	ncm_union_desc.bSlaveInterface0 = status;
 
-	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
+	ecm_desc.wMaxSegmentSize = cpu_to_le16(ncm_opts->max_segment_size);
 
 	status = -ENODEV;
 
@@ -1685,7 +1685,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
 		kfree(opts);
 		return ERR_CAST(net);
 	}
-	opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
+	opts->max_segment_size = ETH_FRAME_LEN;
 	INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
 
 	descs[0] = &opts->ncm_os_desc;
-- 
2.42.0


