Return-Path: <linux-kernel+bounces-39473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07F83D1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A465B255AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D9EBE;
	Fri, 26 Jan 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uSquuGR3"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA9385
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230320; cv=none; b=jYrUFJ7kZW/zl4nqYUoJSeNvgyc7MCij/iaAJkF/3R/cTgPW2Qv9l3rAj8KQ2LuM59PUzkcvcKhZNb6gUdeRpsxhEmPuwN5NbOF0oXxCkvZQdJ61zVmyRGwax+wmVGgY5uyR13iEo9ikhTYA3LCe8Q1wimv3RsoAi11mGRbjFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230320; c=relaxed/simple;
	bh=vEh+gFEmMdUX9UP227WSXtBed/m/QQhh+3wwORgi3E4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=b9nHaH2J6FhMgfhBKBLNqQkjsNypL2nvUK0a3LH7XCOMYkv/C7Yaa8tDpTtosceFzj0XcnyktqvPeXuVQhaZfvA/P3j0eryFRz5Kdd3BM9ozUoST7QXw1fwGoSPigsQZ4vFHVSksokP9IvZ1NaKmbIl6pnN4OjRNYi1obS/NrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uSquuGR3; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706230305; bh=dsSSj5gkDCcVs1xlBOaqKLlk0NdIYeNu5G6pUUGGwVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uSquuGR39yuf1CRJ/l1ttZS+zTy382Gt0v0auI43NAX3pRx6Pzo/vxEPQ3GpzatyO
	 MccRdKXeuRKZp67KEPQn8nCUKXwQnTZPlZQCbH3sVKRj4F8bXENsg7ri3utoQxxTe9
	 xPnjAjtJGNeY6SWmHmpxR8ynQvw8Tp04SDmq1KZk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id ADB0DEDA; Fri, 26 Jan 2024 08:43:27 +0800
X-QQ-mid: xmsmtpt1706229807txww7xain
Message-ID: <tencent_295DB5DDAC196ACFF38DA625A98DFB926107@qq.com>
X-QQ-XMAILINFO: ND42uzdxTIzrNrxs9vjXBhIyoqXYvQFCPmU6Z9Ngf8CiawKF2K5hjUTuimmmaz
	 u90k68yOFRHoli3im0dQd2SjHgwKs0XljGeeOtHTeuLUsR7ckcMM1tE1vSxRBrvgG3RTWcBBRheu
	 2QBZLCGufTKKOr9ga72th4dz82hYrbvwoPKve93zIYvEERUe0ktbzJ9an1Tk91SJemlK59WzF5yU
	 rD9pPOlmPU6S75BNtVHkVv++9pcrIbXq2YKGoUKvyroslUFeOh1y6Ri3HvtZ/RuF89S3z6sXk60T
	 E6kOlL4MB8uHfj7JHsmxIo7lNnxDQ4jeiclxmkpxAXinUWzKn68WYdeRC3B4akMK07rVCA98pPVK
	 AVK6ymDXQ9AJk1Hmnv/oiBvC4ik9E+QYdtn1Db+/hkTvJYGAGp6UiUK39qIqkcJbXm1RkQNxT/LS
	 GIsxnqTp+NlZYYl14b/43kT+kZGBlv405MIclkhwPM+h9CcvefKWELxniSmwFy2WLGvnuopsg7X2
	 FgwDHQqPyQOmXb8Zmt5rvA7UQwKJ2R6eD/5Q5bg/Pq6E6pBEnfUB++BX1WbYTf7ZzSxLV4Pznjyh
	 Eb8vliXjvK/Q3CWEFE/nxzYhKxgMkVP/ZBoaN32FXB7ofmiQhPGfYj67ktQ7avcA7qC/nodSP3Jn
	 VDJHVqLQKkgTjujjrnRdYAdHwlg9JNSsINZ9PpdRrgxGBmzuw4FegXdKkJMgtwyLXaqO3sfh6JOY
	 yx/HCuSu6mrj/ARfH6HYRqxWuRKL2aia2xGWPWM3AcUE3zwCgi8fvOt+YXl8bZI4/mQAs4/tpdOX
	 TLq3Yk6iawbCpK7gY7fXTU63daWhLLYMvIYuCt11jUYOv82Jqu9rb3bpLLi1FRxK+ibbpBQQQhTo
	 JEj7/CK9esXuBrvytNkdWorSBMt3ZGs1JJzTbDWs9AqvVbeM8eWi7oLb7drxPIQRtvSgn9uwYq
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Date: Fri, 26 Jan 2024 08:43:28 +0800
X-OQ-MSGID: <20240126004327.2777797-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
References: <000000000000fd588e060de27ef4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in virtqueue_add (4)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 9d1bdcdc1331..4ca6627a7459 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -427,7 +427,7 @@ static int __virtscsi_add_cmd(struct virtqueue *vq,
 			    size_t req_size, size_t resp_size)
 {
 	struct scsi_cmnd *sc = cmd->sc;
-	struct scatterlist *sgs[6], req, resp;
+	struct scatterlist *sgs[6], req = {}, resp = {};
 	struct sg_table *out, *in;
 	unsigned out_num = 0, in_num = 0;
 


