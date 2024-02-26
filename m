Return-Path: <linux-kernel+bounces-81263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D765786730D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154B51C22552
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3F1DA20;
	Mon, 26 Feb 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gi6LzCPg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7241D535;
	Mon, 26 Feb 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946922; cv=none; b=s8ovpqInt6cVLU7W+K+AxPdjPtHcsaj4+UtR09UrBNgdH0NeSSdECRmoeMxi4LnuQ2GKbY45ibzPt1fjS5JMJLlXq8BFNj8MaAuxVa/zSSbqcmIjKJlhoeCf6Okj8kc18zVMdFDQdzDUlb6qcpojtPybwOc7sPrnYKP1xAp+zcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946922; c=relaxed/simple;
	bh=9r4Qy7hs0vSKI9uUdjPW2Fhk40C0I8X2MjZQPOXqT44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxv0su92EzsdIUjnd5VkC4gvcKitwaVN3stnKOG+IR6Olsj2TjHChpYNeU8EcKPe0cWfv4YFg7TkPvWDiMEwCS1EKRJvQSnwbVvy0X4SJddjUNEqFhiEYZxEkjK81Y/MLCuTbjY8y7DM1rKmb1+6K7nKmtOQsobGXttz/adpVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gi6LzCPg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QARVOg009380;
	Mon, 26 Feb 2024 11:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=YUBb5zD+GwuxupxQ4TAz
	WAOJqy2HhzpNAOsPo2YrqhM=; b=Gi6LzCPgYIRN1DR5ACKTaX+2Xqp/cnRK3Iyi
	FzsH8p4f7l7c5+s8ciHQkcVWb1ygDnb2Vrby0vAmbt0XJf8kRiKi6oOSaEQIRtbX
	Ol729OvmZBjlpobtkbAj1x7co9adoVGGhe8Pa4aBMHdD+WfqrVm/bwrxDCsNgXJs
	Z8KZ2vFVHvXbS1+VdRaSoxevWAxqd63od/ZNhV9PIWKFfe6NaTbGTvltRF4ZMgod
	2as16AqE/2oHeW4fRgqyqAR8WNb5GalIcWSH1iJ1vOrA5cYsn4foRhzU7scj5kt8
	fBI2G7vrapTp0rtQ4GLI1uwdarnU9AnxxYNDKGBfDXnPwGT9Qw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxm0r18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 11:28:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QBSbuA017977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 11:28:37 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 03:28:33 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC PATCH] usb: gadget: ncm: Fix handling of zero block length packets
Date: Mon, 26 Feb 2024 16:58:16 +0530
Message-ID: <20240226112816.2616719-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GJ68AuHhhZanVx89CWMvuBMiFJIXtUiB
X-Proofpoint-GUID: GJ68AuHhhZanVx89CWMvuBMiFJIXtUiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=869 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260085

While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
set to 65536, it has been observed that we receive short packets,
which come at interval of 5-10 seconds sometimes and have block
length zero but still contain 1-2 valid datagrams present.

According to the NCM spec:

"If wBlockLength = 0x0000, the block is terminated by a
short packet. In this case, the USB transfer must still
be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
and the size is a multiple of wMaxPacketSize for the
given pipe, then no ZLP shall be sent.

wBlockLength= 0x0000 must be used with extreme care, because
of the possibility that the host and device may get out of
sync, and because of test issues.

wBlockLength = 0x0000 allows the sender to reduce latency by
starting to send a very large NTB, and then shortening it when
the sender discovers that there’s not sufficient data to justify
sending a large NTB"

However, there is a potential issue with the current implementation,
as it checks for the occurrence of multiple NTBs in a single
giveback by verifying if the leftover bytes to be processed is zero
or not. If the block length reads zero, we would process the same
NTB infintely because the leftover bytes is never zero and it leads
to a crash. Fix this by bailing out if block length reads zero.

Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---

PS: Although this issue was seen after CDC_NCM_NTB_DEF_SIZE_TX
was modified to 64K on host side, I still believe this
can come up at any time as per the spec. Also I assumed
that the giveback where block length is zero, has only
one NTB and not multiple ones.

 drivers/usb/gadget/function/f_ncm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index e2a059cfda2c..355e370e5140 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1337,6 +1337,9 @@ static int ncm_unwrap_ntb(struct gether *port,
 	VDBG(port->func.config->cdev,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
+	if (block_len == 0)
+		goto done;
+
 	to_process -= block_len;
 
 	/*
@@ -1351,6 +1354,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 		goto parse_ntb;
 	}
 
+done:
 	dev_consume_skb_any(skb);
 
 	return 0;
-- 
2.34.1


