Return-Path: <linux-kernel+bounces-77804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC4860A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B428847A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8092E125A4;
	Fri, 23 Feb 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fGrQYAr8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8ADDB1;
	Fri, 23 Feb 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667315; cv=none; b=nsSJyYfVp+IsmqF1NFHJaktLPqjoHuO+LTpC86AvFhQDlKG2rPhpYhJQBcA802DhHmq8LxcvsVv9YKg0aBQQQXuN4nec6sWDyhtojH7sSF+xicwK5b4pxUkSDc304tf6kuNDxhdlW6Zm5YD90YQu0LMxyAI2rGwsPzek8JpE4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667315; c=relaxed/simple;
	bh=xhDHwk8s9doyKydAn74qDiheXxaJpnOskALgWIt3pAk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b+DyA/wLDHeoVZhGjdCQOYMSw3CBuJU2awlITx1yXRpeUGqSTrv68cyRz6QvDhbwoaqYBEWvqMFJseGEwb2Zc6TTdTMRBtfd20InV7GuizwYh9WT/kusr06y3Sk7xfb2WlyCYQfqxEeBkUnVl/7yBSEw/OQeFZEkK8/Ow6uxeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fGrQYAr8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N5mDZh003570;
	Fri, 23 Feb 2024 05:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=MeYIdH9PJYLC
	uzPezcfeC/12/0LCGKhkxsixocN4V2M=; b=fGrQYAr8MNxtODf/hRJoxNcE9lSr
	EYQou30xZ6OZg0pFUMo+eru7VcUrTXTPYBFMFJdk39BbsNqfRufFmXu/pdw/o0+P
	Rwgl2vBCDwY0R+jOcZNvkQ/z9MYsnPZMdLsg31wjM9OgpkWRhqnCLDOBWfQRRUGS
	yGmqZbFMCyvQbkzjHOopQnTYKI7ZS5ucByXkYqwIuYRTdOREAazHeDuY0MJhtY0Q
	nVCFyMOKnig22N1lAZx4vSyFbwrkSdsGR/+1JOhZfYW175KslAB3JTmRwX+V6c6W
	sWedt2NnTLmsX7uhGQN+gZ+vwRwC6fAgt2tKlTZQRK8CjNcFxF+PqpR8Gw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wekver5pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:48:13 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41N5mCn6020064;
	Fri, 23 Feb 2024 05:48:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3wd3eqk0ys-1;
	Fri, 23 Feb 2024 05:48:12 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41N5mCcW020055;
	Fri, 23 Feb 2024 05:48:12 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-selvaras-lv.qualcomm.com [10.47.205.157])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 41N5mBGG020054;
	Fri, 23 Feb 2024 05:48:12 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 4178377)
	id B0F55600C34; Thu, 22 Feb 2024 21:48:11 -0800 (PST)
From: Selvarasu Ganesan <quic_selvaras@quicinc.com>
To: gregkh@linuxfoundation.org, brauner@kernel.org, axboe@kernel.dk,
        jack@suse.cz, jlayton@kernel.org, keescook@chromium.org,
        peter@korsgaard.com, hayama@lineo.co.jp, dmantipov@yandex.ru,
        quic_linyyuan@quicinc.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Selvarasu Ganesan <quic_selvaras@quicinc.com>
Subject: [PATCH] usb: gadget: f_fs: Fix NULL pointer dereference in ffs_epfile_async_io_complete()
Date: Thu, 22 Feb 2024 21:48:09 -0800
Message-Id: <20240223054809.2379-1-quic_selvaras@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UIIBYA2-SVa_RRETsfsSintFSFGB2UvL
X-Proofpoint-ORIG-GUID: UIIBYA2-SVa_RRETsfsSintFSFGB2UvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230039
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In scenarios of continuous and parallel usage of multiple FFS interfaces
and concurrent adb operations (e.g., adb root, adb reboot), there's a
chance that ffs_epfile_async_io_complete() might be processed after
ffs_epfile_release(). This could lead to a NULL pointer dereference of
ffs when accessing the ffs pointer in ffs_epfile_async_io_complete(), as
ffs is freed as part of ffs_epfile_release(). This epfile release is
part of file operation and is triggered when user space daemons restart
themselves or a reboot is initiated.

Fix this issue by adding a NULL pointer check for ffs in
ffs_epfile_async_io_complete().

[  9981.393115] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001e0
[  9981.402854] Mem abort info:
..
[  9981.532540] Hardware name: Qualcomm Technologies,
[  9981.540579] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  9981.548438] pc : ffs_epfile_async_io_complete+0x38/0x4c
[  9981.554529] lr : usb_gadget_giveback_request+0x30/0xd0
..
[  9981.645057] Call trace:
[  9981.648282]  ffs_epfile_async_io_complete+0x38/0x4c
[  9981.654004]  usb_gadget_giveback_request+0x30/0xd0
[  9981.659637]  dwc3_gadget_endpoint_trbs_complete+0x1a8/0x48c
[  9981.666074]  dwc3_process_event_entry+0x378/0x648
[  9981.671622]  dwc3_process_event_buf+0x6c/0x288
[  9981.676903]  dwc3_thread_interrupt+0x3c/0x68
[  9981.682003]  irq_thread_fn+0x2c/0x8c
[  9981.686388]  irq_thread+0x198/0x2ac
[  9981.690685]  kthread+0x154/0x218
[  9981.694717]  ret_from_fork+0x10/0x20

Signed-off-by: Selvarasu Ganesan <quic_selvaras@quicinc.com>
---
 drivers/usb/gadget/function/f_fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index be3851cffb73..d8c8e88628f9 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -849,7 +849,9 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
 	usb_ep_free_request(_ep, req);
 
 	INIT_WORK(&io_data->work, ffs_user_copy_worker);
-	queue_work(ffs->io_completion_wq, &io_data->work);
+
+	if (ffs && ffs->io_completion_wq)
+		queue_work(ffs->io_completion_wq, &io_data->work);
 }
 
 static void __ffs_epfile_read_buffer_free(struct ffs_epfile *epfile)
-- 
2.17.1


