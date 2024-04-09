Return-Path: <linux-kernel+bounces-136095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C189CFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47431F23F60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D494EB32;
	Tue,  9 Apr 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BFpso7Ku"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA2A951;
	Tue,  9 Apr 2024 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626879; cv=none; b=OYOuaniZUu7GD3CFu5fm9uahj6ZN92zq80wepzM6cwpTpFC+yBzUVeSUG73gjfuE+lhXrTsBtUzqvB1t6SRp7yodaDVUz0qdAy72LBvIhCmnDqYecPV5Cnqn33GMLIY7VO/k+gGkcCbXQcqL1wI5Uzw1lNIV2aRtI5lK9PVWPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626879; c=relaxed/simple;
	bh=v9gTQlFxN2Ywe4+j2VYorWaU3s9VI5QpZJC70xd2TLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0g5kHyYBpHmVnaUUfX/iovctqQ99IXdS5KHmzCiAYD9XuADy4gS3ZPJRaBmd0+gzmCS5pUNAEgOgb5XEKhg8YmJVW0r6iIOuRZvjyFWRZhTD+OYa22Y9pDf8uCdI6AuO2Efhjri1U4JIYHWAXtGo4orvNbzIDD02be+AbNod4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BFpso7Ku; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4391fBY8025998;
	Tue, 9 Apr 2024 01:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=D2HX2Osq00BW9tDMT8nYKOdziRBPRE8braxVi6Lkz6Y=; b=BF
	pso7Ku/xm3D7eu1U00jw5mzffbwRiIzp1OoHms5nJX6xgWaz6nIJnWBdLrNPw+BL
	JvziuVxYHyx7hwv0C4FqzNBVXsD2VFOC1QIIIcaBrXnZX3B7mT3XEfTdDiGJpEn6
	dqTMol5aGy0UUnFk60xFmPAeqCjopHXJ44dn7O8GTVF/cdUa4507qIURv5BFw8/M
	wkhGNdsv6O5SWnoj7G4Cw85Vo6nHlAJKYdf2mFgk5DQKqFWe2/mbE03y9sPMtU2v
	nFsG9O8ddQE4ao0bSOTrVsgDvGD8xwT+dyK+jVpO2hMHNPcS7cP52PWFyIyrcLuF
	hPfzz8puaGgKnKFhPqwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xctku04dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 01:41:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4391fE06006817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 01:41:14 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Apr 2024 18:41:14 -0700
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>
Subject: [PATCH] usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete
Date: Mon, 8 Apr 2024 18:40:59 -0700
Message-ID: <20240409014059.6740-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l1-rswPVzpfXQxXJmN1Jzi-PN1MKoCbq
X-Proofpoint-GUID: l1-rswPVzpfXQxXJmN1Jzi-PN1MKoCbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090007

FFS based applications can utilize the aio_cancel() callback to dequeue
pending USB requests submitted to the UDC.  There is a scenario where the
FFS application issues an AIO cancel call, while the UDC is handling a
soft disconnect.  For a DWC3 based implementation, the callstack looks
like the following:

    DWC3 Gadget                               FFS Application
dwc3_gadget_soft_disconnect()              ...
  --> dwc3_stop_active_transfers()
    --> dwc3_gadget_giveback(-ESHUTDOWN)
      --> ffs_epfile_async_io_complete()   ffs_aio_cancel()
        --> usb_ep_free_request()            --> usb_ep_dequeue()

There is currently no locking implemented between the AIO completion
handler and AIO cancel, so the issue occurs if the completion routine is
running in parallel to an AIO cancel call coming from the FFS application.
As the completion call frees the USB request (io_data->req) the FFS
application is also referencing it for the usb_ep_dequeue() call.  This can
lead to accessing a stale/hanging pointer.

commit b566d38857fc ("usb: gadget: f_fs: use io_data->status consistently")
relocated the usb_ep_free_request() into ffs_epfile_async_io_complete().
However, in order to properly implement locking to mitigate this issue, the
spinlock can't be added to ffs_epfile_async_io_complete(), as
usb_ep_dequeue() (if successfully dequeuing a USB request) will call the
function driver's completion handler in the same context.  Hence, leading
into a deadlock.

Fix this issue by moving the usb_ep_free_request() back to
ffs_user_copy_worker(), and ensuring that it explicitly sets io_data->req
to NULL after freeing it within the ffs->eps_lock.  This resolves the race
condition above, as the ffs_aio_cancel() routine will not continue
attempting to dequeue a request that has already been freed, or the
ffs_user_copy_work() not freeing the USB request until the AIO cancel is
done referencing it.

This fix depends on
  commit b566d38857fc ("usb: gadget: f_fs: use io_data->status
  consistently")

Fixes: 2e4c7553cd6f ("usb: gadget: f_fs: add aio support")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/function/f_fs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index d3a7f7bae07b..e5281ca75109 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -853,6 +853,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 						   work);
 	int ret = io_data->status;
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
+	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
 		kthread_use_mm(io_data->mm);
@@ -865,6 +866,11 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd);
 
+	spin_lock_irqsave(&io_data->ffs->eps_lock, flags);
+	usb_ep_free_request(io_data->ep, io_data->req);
+	io_data->req = NULL;
+	spin_unlock_irqrestore(&io_data->ffs->eps_lock, flags);
+
 	if (io_data->read)
 		kfree(io_data->to_free);
 	ffs_free_buffer(io_data);
@@ -878,7 +884,6 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
 	struct ffs_data *ffs = io_data->ffs;
 
 	io_data->status = req->status ? req->status : req->actual;
-	usb_ep_free_request(_ep, req);
 
 	INIT_WORK(&io_data->work, ffs_user_copy_worker);
 	queue_work(ffs->io_completion_wq, &io_data->work);

