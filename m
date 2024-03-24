Return-Path: <linux-kernel+bounces-113332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21988837A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E90B23489
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503C1966BF;
	Sun, 24 Mar 2024 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuRlQqjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A1966A1;
	Sun, 24 Mar 2024 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320133; cv=none; b=gNGWfkEaEkQhp5bEUoQZgL6zkZz90wO8v5XAreejW2SaVBLu1nG/0eR6Fm+vwMJ1fyMsb5paSpe4D7vQai6g5AGXKP5B2zLwkPyGtvrAe8UFVXmAa7gsMuPvPCDwGWn0bn+GCem0l+TDxo6ULlnRMuWrJu5HKsd7NKWcaxM7G7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320133; c=relaxed/simple;
	bh=CbrICwGs1YzHutTQlHbuoeydSDNLT31WFfQBcsWuG+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3/ZfDeJZ07t0aQxbWB/UTDhmHhyH7gS/jcuoomgO5UG82fRKdiGt8Zm5ad4ajJVhQQDKKVlpOZOuw06jHekC7Kg3RFcQFeLavZ4U7cFiR+27HDDAmM5uLMivPF9Wr2NNvZRwX6kSZ9dHjoYOOpoOA266a3SpIYRhvVe9R7ur1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuRlQqjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94681C433C7;
	Sun, 24 Mar 2024 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320133;
	bh=CbrICwGs1YzHutTQlHbuoeydSDNLT31WFfQBcsWuG+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuRlQqjIyAyx+n6Nl2z1YRrzA682aCx315mRR/fuAC1mMVznqnfyyiv3JQmUyfyd7
	 Gv4sJ/4+ghpBSjAV/Eq5B34zZXDnXsSGFO/Tp4kPEhXTtN2GttlQmwfQFXsZiBGxT8
	 aJTTFaGZyri5tLMg7cI5yayVDzTGrEmmrrG1L3OoCN4uz0VDnN4TI95eB57ZkY8S/e
	 E0UovGnVpUPD771f3oHy5VClR88uDEQ+Jlpr3LzFgZxWy26krpWSppobkoKNxPjRsr
	 ZISPIvhJA2LIF7J1YnDszwh8as37wzIqT9bVFsqtf/QhcO0/HSHFVm/b99SvhMXVgP
	 KJ0MaEmL5lS6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 441/715] media: videobuf2: Add missing doc comment for waiting_in_dqbuf
Date: Sun, 24 Mar 2024 18:30:20 -0400
Message-ID: <20240324223455.1342824-442-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

[ Upstream commit 26a3a10342748862dcc8d22222563f6ca03d6ca3 ]

While at it rearrange other comments to match the order of struct members.

Fixes: d65842f7126a ("media: vb2: add waiting_in_dqbuf flag")

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Acked-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/media/videobuf2-core.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 56719a26a46c3..bec8c3a1ed824 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -72,6 +72,10 @@ struct vb2_buffer;
  *		 argument to other ops in this structure.
  * @put_userptr: inform the allocator that a USERPTR buffer will no longer
  *		 be used.
+ * @prepare:	called every time the buffer is passed from userspace to the
+ *		driver, useful for cache synchronisation, optional.
+ * @finish:	called every time the buffer is passed back from the driver
+ *		to the userspace, also optional.
  * @attach_dmabuf: attach a shared &struct dma_buf for a hardware operation;
  *		   used for DMABUF memory types; dev is the alloc device
  *		   dbuf is the shared dma_buf; returns ERR_PTR() on failure;
@@ -86,10 +90,6 @@ struct vb2_buffer;
  *		dmabuf.
  * @unmap_dmabuf: releases access control to the dmabuf - allocator is notified
  *		  that this driver is done using the dmabuf for now.
- * @prepare:	called every time the buffer is passed from userspace to the
- *		driver, useful for cache synchronisation, optional.
- * @finish:	called every time the buffer is passed back from the driver
- *		to the userspace, also optional.
  * @vaddr:	return a kernel virtual address to a given memory buffer
  *		associated with the passed private structure or NULL if no
  *		such mapping exists.
@@ -484,7 +484,6 @@ struct vb2_buf_ops {
  *		caller. For example, for V4L2, it should match
  *		the types defined on &enum v4l2_buf_type.
  * @io_modes:	supported io methods (see &enum vb2_io_modes).
- * @alloc_devs:	&struct device memory type/allocator-specific per-plane device
  * @dev:	device to use for the default allocation context if the driver
  *		doesn't fill in the @alloc_devs array.
  * @dma_attrs:	DMA attributes to use for the DMA.
@@ -553,6 +552,7 @@ struct vb2_buf_ops {
  *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers
  *		buffers will be allocated. Note that VIDIOC_CREATE_BUFS will not
  *		modify the requested buffer count.
+ * @alloc_devs:	&struct device memory type/allocator-specific per-plane device
  */
 /*
  * Private elements (won't appear at the uAPI book):
@@ -577,6 +577,9 @@ struct vb2_buf_ops {
  * @waiting_for_buffers: used in poll() to check if vb2 is still waiting for
  *		buffers. Only set for capture queues if qbuf has not yet been
  *		called since poll() needs to return %EPOLLERR in that situation.
+ * @waiting_in_dqbuf: set by the core for the duration of a blocking DQBUF, when
+ *		it has to wait for a buffer to become available with vb2_queue->lock
+ *		released. Used to prevent destroying the queue by other threads.
  * @is_multiplanar: set if buffer type is multiplanar
  * @is_output:	set if buffer type is output
  * @copy_timestamp: set if vb2-core should set timestamps
-- 
2.43.0


