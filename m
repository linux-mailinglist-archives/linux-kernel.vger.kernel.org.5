Return-Path: <linux-kernel+bounces-13817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745E88212DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367171C20F72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B581E;
	Mon,  1 Jan 2024 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Bdgtk0Jz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4857F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704077348; bh=KabU2A20PeH4SZvFCt9NizESfm+H7X76LgXU4kut9EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bdgtk0Jz8er9VwJV5A+nzjanappZ/3m3AY0LZ/azIcz/Kop8D9psWvKOVW+1ROotx
	 ZbOZSdPqby+vmds+uMb+Cjoc7nR18wHrtWzy5fiNoDWobG53blIdMkIt9DujBVNl+v
	 fx5VqM16htLqGEFqN6ZeCGVHGfOkx4sXVsryVnPY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id AB9902DF; Mon, 01 Jan 2024 10:42:57 +0800
X-QQ-mid: xmsmtpt1704076977tn6u9b761
Message-ID: <tencent_1C4C8CE7D046CC52DC0664498C6ED52EDB06@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj9WoC9EoF/oqbsyZHeK7h3Ac31eb5jQGc0J4BZuiJJHd/po+Yky
	 Rb+rrS66YsZJPgVn+QP+KM8m8bzWF+VF2/HNIH7v8ymN045MHASXVn/xi+1uOcP0MVE2qqkxNZZl
	 V431AW7s8z0Y85lLJmqtyClpNFiEuVT2j7tsEQt/oxAl4kjqonnpW9yGYKrruTWYLGS+8QtMNQ/r
	 fr3UjQ+M/R6ULUX0t99sdGKzgh9r7X8M/RGv+PTh2Hknq/0qDJRPMDjyGmHIuDfWnp1flQRLxHdP
	 yORihYuAsZbeCb7LjvM83wOePoaJbiF7RBuwkKNiAVe6HwzuhzJ0WTNXZrj/QohIxXE0uBqpHxu/
	 V9aRvPqqx1NDth57kqHu5NYqlkAvIt7qDp1gdAsSwkkaibhWTpvKehGnXmiSufTD9YbduUBx3OGo
	 XQ9rNVVoFKfo3Wz0H6lf7Xu6FeR8fb1S9ZQH9tmR+9ApS59uALQlRwlOLcglO3zrqxM/aMGuG1sl
	 n31K2A79eXcSQEy9D+O96zT/VXBsUIJFzc4AZmIGzJCE0XJJRkXTh+hQm+MrxQnRPSN5bNaQJY44
	 1K5G+UQIncnjJiZzxdoLtaQZOJsAQJqYnjpidwDUagFWU1MD7ca5pqq6gGuqL4FlfZc45flzm2JT
	 VEggB/1rw69KH8S2pe8GzObbZ8X/Oq3g49ZkptmBkNzNr0CBzRbq5JO6sh3iBaZpG2HT++JbDm4z
	 JgSJ9V9xQe1X3dwaTMkaU73HMwb7LfUYUYOKHdbQOCPB7j8QrqEnESp8xIbRTR0cgkuFxzC1MN+h
	 cpG2Qoltfkdc1ks+SN2v9IqTiRHwQM2ySulfaZvvQ8BCXXtcUH8qXCWyqPKNZyorbrmBytJuhHqC
	 QN8SVa4cOe+lHc1ekCJOK6HOlMpW88zA5lD7zkCVdBq4eCfva53BL5/RCL27Sh8w==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
Date: Mon,  1 Jan 2024 10:42:58 +0800
X-OQ-MSGID: <20240101024257.148635-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009e6825060dd6c287@google.com>
References: <0000000000009e6825060dd6c287@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test memory leak in get_sg_table

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 21916bba77d5..709260211546 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -471,8 +471,11 @@ static long dma_buf_ioctl(struct file *file,
 
 		if (sync.flags & DMA_BUF_SYNC_END)
 			ret = dma_buf_end_cpu_access(dmabuf, direction);
-		else
+		else {
+			if (dmabuf->doing)
+				return -EBUSY;
 			ret = dma_buf_begin_cpu_access(dmabuf, direction);
+		}
 
 		return ret;
 
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c40645999648..ed98c0319e03 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -152,6 +152,7 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 	struct device *dev = ubuf->device->this_device;
 	int ret = 0;
 
+	buf->doing = true;
 	if (!ubuf->sg) {
 		ubuf->sg = get_sg_table(dev, buf, direction);
 		if (IS_ERR(ubuf->sg)) {
@@ -162,6 +163,7 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
 				    direction);
 	}
+	buf->doing = false;
 
 	return ret;
 }
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 3f31baa3293f..4316ad0e6155 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -446,6 +446,7 @@ struct dma_buf {
 		struct dma_buf *dmabuf;
 	} *sysfs_entry;
 #endif
+	bool doing;
 };
 
 /**


