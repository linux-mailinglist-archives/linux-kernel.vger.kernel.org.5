Return-Path: <linux-kernel+bounces-52162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDCA8494C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6006B23B96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5910A36;
	Mon,  5 Feb 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rq/K7jZl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9D11190;
	Mon,  5 Feb 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119253; cv=none; b=b9yJ6CzRjkVDgT5Qhbhd07hMhwfhgFR/8njLCp4QytciFirbbmBOt5dwtcROCuO1aexuEh28cRqCGraDG53L4+NI+fxIJ3yWKeYZ8DJ5pVfWIs5nPrDLCXOag1BsXmujnS70DsnZZulwVn26h3rv1DYJg9ABFCGxFPo4PVZFKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119253; c=relaxed/simple;
	bh=gvdIDaltTS0ihBKlSJXlAE64b+5OpymAOgP9TR84kks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNnxujajShlwZHUzLNMDHwxKmfMM5ZAbS+jgx1H6m1d2cmup9zp5SqALs7uaEGRUNJDESKF9c9EEJrCVwU6A3haL7jeq5NX8PUZG+inW85U68wCq07+LugQqo26w0zfh356W9X7J7lhPnRPN+pLSaBoahabdn0h6BrNJ5TC0Z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rq/K7jZl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4154xFFo003831;
	Mon, 5 Feb 2024 07:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=H43mdPT
	LvVJVPRl+DPOkCMfp+JmkCA5TA8E3ZocTvR4=; b=Rq/K7jZl97cLFk5SHgDRy6A
	2CbFshNw5hthllYCRL+1iRS0LwNeliX4IiSJ8d3uypwGVVu+CIou+89QbgrOnz+q
	K6lmF/Q32AMst5o35Ts3DX2TLHzcO94jWxZscljeNWZCv24qlC6yzgdyB8ezqHNS
	K9/08w8/jr5GIaoacq6kAhf6uvF2AbYXY4yXvoj41fJQeEHaYkV6Xt0CuLK7AJXH
	JPnDGf2W3Wqj3obsXH6WDvPAYvLrW0tSm4sAUhIePBZBqH5xpQ+8yg61c+jwaxyY
	2Jd7gsVRrg3mJxKjXPyg7CWFR/zaeEr4ocn0n8q3w90XuIOIpch7C+iOXxE/hGA=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rvj89m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 07:47:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4157l5YL002700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 07:47:05 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 4 Feb 2024 23:47:02 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
Date: Mon, 5 Feb 2024 13:16:50 +0530
Message-ID: <20240205074650.200304-1-quic_kriskura@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4-tTLD6_E1V8ZOQTbSjRVm22jzLoejB1
X-Proofpoint-GUID: 4-tTLD6_E1V8ZOQTbSjRVm22jzLoejB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=485 bulkscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050059

It is observed sometimes when tethering is used over NCM with Windows 11
as host, at some instances, the gadget_giveback has one byte appended at
the end of a proper NTB. When the NTB is parsed, unwrap call looks for
any leftover bytes in SKB provided by u_ether and if there are any pending
bytes, it treats them as a separate NTB and parses it. But in case the
second NTB (as per unwrap call) is faulty/corrupt, all the datagrams that
were parsed properly in the first NTB and saved in rx_list are dropped.

Adding a few custom traces showed the following:
[002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
req 000000003868811a length 1025/16384 zsI ==> 0
[002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 1025
[002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x400
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x10
[002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames

In this case, the giveback is of 1025 bytes and block length is 1024.
The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
all datagrams in rx_list.

Same is case with packets of size 2048:
[002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
req 0000000011dfd96e length 2049/16384 zsI ==> 0
[002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
[002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x800

Lecroy shows one byte coming in extra confirming that the byte is coming
in from PC:

Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
- Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
--- Packet 4063861
      Data(1024 bytes)
      Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
--- Packet 4063863
      Data(1 byte)
      Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)

According to Windows driver, no ZLP is needed if wBlockLength is non-zero,
because the non-zero wBlockLength has already told the function side the
size of transfer to be expected. However, there are in-market NCM devices
that rely on ZLP as long as the wBlockLength is multiple of wMaxPacketSize.
To deal with such devices, it pads an extra 0 at end so the transfer is no
longer multiple of wMaxPacketSize.

Cc: <stable@vger.kernel.org>
Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v2:
https://lore.kernel.org/all/20240131150332.1326523-1-quic_kriskura@quicinc.com/

Changes in v2:
Added check to see if the padded byte is 0x00.

Changes in v3:
Removed wMaxPacketSize check from v2.

 drivers/usb/gadget/function/f_ncm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index ca5d5f564998..e2a059cfda2c 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1338,7 +1338,15 @@ static int ncm_unwrap_ntb(struct gether *port,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+
+	/*
+	 * Windows NCM driver avoids USB ZLPs by adding a 1-byte
+	 * zero pad as needed.
+	 */
+	if (to_process == 1 &&
+	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
+		to_process--;
+	} else if (to_process > 0) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
-- 
2.34.1


