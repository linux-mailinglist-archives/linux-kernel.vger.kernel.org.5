Return-Path: <linux-kernel+bounces-13825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B978212F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7BE280EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA584A0F;
	Mon,  1 Jan 2024 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S8Zb/QSA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2E469E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704082179; bh=EAWbts1UfbZbtzWsloZ7v8ZRt6WChQIrav53bt3lJbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8Zb/QSAEKJZpeCIPa/mpQT8ORIFsBbL+s7+r+x+lycZMhteMly9kBR9ZxVl4N+3j
	 dyvOoUMX/eWUTZeQJVmEN0/+owOFncZl1xyB97rcNSyYk5B7g6IEqNIMibV90mbJZp
	 zJJiqwATi/MCvdVT0t5aJeyGtz3WEJ5MJsK/sMZg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 5C22667; Mon, 01 Jan 2024 12:01:28 +0800
X-QQ-mid: xmsmtpt1704081688t0x4yoqld
Message-ID: <tencent_A9576F5763C6CBF3660361296723B2A44605@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoQTH+nO5NxAPtCrnSlZ01978F9e5VinuxsQzr2Nmn1gHa4JliGn
	 elyCu32lQ0nscFZYDcpMw/4kNXCEUWtska3de0OSa1LbtrW97r4WOv0ds8ib4ZNZlexPG1xBu8/9
	 CFwpbO2rTgf7MZAKnHfGZdHj8PTJPX4M8Ubyc3Scl6lvL7PN/48ipJW0cLhoJ8ynHQCNABcFd7QO
	 xEkT78/AGZ+QnMnStR/pGsDz+MQYsHa6lR3Yg1no+JeZN6bEk1f+rec9M9fjKtP4LECzCi8TmADE
	 nRPOvvHWQcSdcctJZVTbPXFAsow3krjUDZunmGDNnNvJJTfZruuMAG/ohDTMpCOdjBOloghqslUk
	 hkAOwxVqb+rrXI9lT5D0gMkrWClFLkVvIMLdrVpSdMRRhjJo/3fDZg7/3Xuvh9OPIeClk/H9/uVF
	 ekLb6+GtjpNUOIeOE1j7xZuOqUpf9I+O+xYd7i3Zj/xfvAJoyGAY7olHKYoDiZp5pTNRSIixwU+D
	 FbSO4oRd2nznEWEd5M7uDnjMbzUZtueGz+FnzCOpbhAcGqQ29fg1YyAaVT877YletLCaz29y3aY6
	 Wk/o9kXc+Uc1o6tQ5IrR4OrjHv/l8z4DwAy+MzPjTJDjEiS83O/VbJeFHW2P4Our2hJDdvWJq4zo
	 NE4+H6b9TLu6WZj9FzBLB4tmiukt3nUBVBXxQDCsNUQn5Ci0rjW0CGtVx+gtDUkC/aEf1Ju2Kr8F
	 NJZHzCad6fruJ/HILMl39T4WdjKP34W1nLpkp+fALdwUZjhnSWH8H5OH+NSlogDqYkuocT69cfG4
	 C7ea1hFSLNfGonzRST7OF8padTBb2QR8DQWM6JpPx6MLTNCRR07AVwNSMSkQt9fWlRppQk904hPZ
	 EEy6Ef7szu1uSoOshu9+tc934jSAaE9vG+KYut4SRp01mFKwZho0g7GGMYs5JxF71S+0tEEKrX
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
Date: Mon,  1 Jan 2024 12:01:29 +0800
X-OQ-MSGID: <20240101040128.213722-2-eadavis@qq.com>
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
index c40645999648..ff49e5cf7d07 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -151,7 +151,10 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 	struct udmabuf *ubuf = buf->priv;
 	struct device *dev = ubuf->device->this_device;
 	int ret = 0;
+	static DEFINE_MUTEX(lock);
 
+	mutex_lock(&lock);
+	buf->doing = true;
 	if (!ubuf->sg) {
 		ubuf->sg = get_sg_table(dev, buf, direction);
 		if (IS_ERR(ubuf->sg)) {
@@ -162,6 +165,8 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
 				    direction);
 	}
+	buf->doing = false;
+	mutex_unlock(&lock);
 
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


