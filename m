Return-Path: <linux-kernel+bounces-79407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73058621AC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68440B2344B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638BA53A6;
	Sat, 24 Feb 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp4KSLCQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32717FE;
	Sat, 24 Feb 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737303; cv=none; b=XGtwkJvIm7cWHc13rX+0jGQ4DvokLVxUUHU5PawGVS3epdpjMAF0mrTMGbCT9JjFw/gGe5qv0j2Gq25G2f0tHztMJUkKuU4msjnoK640j3yUX+batRmfOeYA7v+rfE/26Ym9QURrrUWFruY7Zx1RmMhkJAlcYxq8acuYzBPZsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737303; c=relaxed/simple;
	bh=5yQIyVqpWQrFoHd5KjccM3zKxOtIF5WCoB+ju21X2Zo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAjPAgrWVTtpLaUb9F3Um6BZpd2k92DRyLlQtZQIRnaVRKQJO2pkSb+pEzbIQuR5esB2ChX1IiKO/I+t4rJPVSEDMoBqbnCJMTB73dQwbULFsP77ghlYNfBvKpYRyQ/Vn0fB+S58/tWdJFs25fcx1Wtroc3Egi+GwQmlLGBl+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp4KSLCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E01C433C7;
	Sat, 24 Feb 2024 01:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737303;
	bh=5yQIyVqpWQrFoHd5KjccM3zKxOtIF5WCoB+ju21X2Zo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Zp4KSLCQJ0jF7mwO0/PiYYwwqUlSIqJueOWx27wzftDP2h1/o9iDqsFnvwKFogqk9
	 lCe8EEL7hsaP1CX2kNNzrjWwoTd3flo3pBgIOuCGED3Yyvs7g1daIJI82D13kaHc+5
	 eQ3EwTGy6wvpx3nqF6PC6+pt+j/yNegxD1vIH/Hp/mF/HTB9ZUqnwLQPai0qFlKFMB
	 Pb0SpNjgIbFSNEjxOQ0gpGyoSTC+7W5RlKYvR1fQBsCpt58WQS1KhmmXn213Y/jsfM
	 TwhlAYdlcFBnJO8uXkv2hh6Cw5DNBpHSpzGNeHiv6TSAZA9+vL3UsLhE5gYl2H0Iwx
	 Swn3wMNMbEb1Q==
Date: Fri, 23 Feb 2024 17:15:02 -0800
Subject: [PATCH 05/10] bcachefs: Thread with file documentation
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668966.1861398.3623023711677925127.stgit@frogsfrogsfrogs>
In-Reply-To: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
References: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/bcachefs/thread_with_file.c |   15 ++++++++-------
 fs/bcachefs/thread_with_file.h |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)


diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index 830efb06ef0be..dde9679b68b42 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -76,16 +76,16 @@ static bool stdio_redirect_has_output(struct stdio_redirect *stdio)
 	return stdio->output.buf.nr || stdio->done;
 }
 
-#define WRITE_BUFFER		4096
+#define STDIO_REDIRECT_BUFSIZE		4096
 
 static bool stdio_redirect_has_input_space(struct stdio_redirect *stdio)
 {
-	return stdio->input.buf.nr < WRITE_BUFFER || stdio->done;
+	return stdio->input.buf.nr < STDIO_REDIRECT_BUFSIZE || stdio->done;
 }
 
 static bool stdio_redirect_has_output_space(struct stdio_redirect *stdio)
 {
-	return stdio->output.buf.nr < WRITE_BUFFER || stdio->done;
+	return stdio->output.buf.nr < STDIO_REDIRECT_BUFSIZE || stdio->done;
 }
 
 static void stdio_buf_init(struct stdio_buf *buf)
@@ -171,11 +171,12 @@ static ssize_t thread_with_stdio_write(struct file *file, const char __user *ubu
 		}
 
 		spin_lock(&buf->lock);
-		if (buf->buf.nr < WRITE_BUFFER)
-			darray_make_room_gfp(&buf->buf, min(b, WRITE_BUFFER - buf->buf.nr), __GFP_NOWARN);
+		if (buf->buf.nr < STDIO_REDIRECT_BUFSIZE)
+			darray_make_room_gfp(&buf->buf,
+				min(b, STDIO_REDIRECT_BUFSIZE - buf->buf.nr), GFP_NOWAIT);
 		b = min(len, darray_room(buf->buf));
 
-		if (b && !copy_from_user_nofault(&buf->buf.data[buf->buf.nr], ubuf, b)) {
+		if (b && !copy_from_user_nofault(&darray_top(buf->buf), ubuf, b)) {
 			buf->buf.nr += b;
 			ubuf	+= b;
 			len	-= b;
@@ -338,7 +339,7 @@ void bch2_stdio_redirect_vprintf(struct stdio_redirect *stdio, bool nonblocking,
 		return;
 
 	spin_lock_irqsave(&buf->lock, flags);
-	bch2_darray_vprintf(&buf->buf, nonblocking ? __GFP_NOWARN : GFP_KERNEL, fmt, args);
+	bch2_darray_vprintf(&buf->buf, nonblocking ? GFP_NOWAIT : GFP_KERNEL, fmt, args);
 	spin_unlock_irqrestore(&buf->lock, flags);
 
 	wake_up(&buf->wait);
diff --git a/fs/bcachefs/thread_with_file.h b/fs/bcachefs/thread_with_file.h
index 66212fcae226a..f06f8ff19a790 100644
--- a/fs/bcachefs/thread_with_file.h
+++ b/fs/bcachefs/thread_with_file.h
@@ -4,6 +4,38 @@
 
 #include "thread_with_file_types.h"
 
+/*
+ * Thread with file: Run a kthread and connect it to a file descriptor, so that
+ * it can be interacted with via fd read/write methods and closing the file
+ * descriptor stops the kthread.
+ *
+ * We have two different APIs:
+ *
+ * thread_with_file, the low level version.
+ * You get to define the full file_operations, including your release function,
+ * which means that you must call bch2_thread_with_file_exit() from your
+ * .release method
+ *
+ * thread_with_stdio, the higher level version
+ * This implements full piping of input and output, including .poll.
+ *
+ * Notes on behaviour:
+ *  - kthread shutdown behaves like writing or reading from a pipe that has been
+ *    closed
+ *  - Input and output buffers are 4096 bytes, although buffers may in some
+ *    situations slightly exceed that limit so as to avoid chopping off a
+ *    message in the middle in nonblocking mode.
+ *  - Input/output buffers are lazily allocated, with GFP_NOWAIT allocations -
+ *    should be fine but might change in future revisions.
+ *  - Output buffer may grow past 4096 bytes to deal with messages that are
+ *    bigger than 4096 bytes
+ *  - Writing may be done blocking or nonblocking; in nonblocking mode, we only
+ *    drop entire messages.
+ *
+ * To write, use stdio_redirect_printf()
+ * To read, use stdio_redirect_read() or stdio_redirect_readline()
+ */
+
 struct task_struct;
 
 struct thread_with_file {


