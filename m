Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB56765752
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjG0PVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjG0PV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:21:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3031FF2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:21:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so1359008a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690471285; x=1691076085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qO6zMXaYYTVSgQL74L2Fy444v1xc+I1L+rWiKjULm/s=;
        b=qdjiHsgoQLXB6c81fQhjmKreFwfhr2RUxyoGKx+q2/KfhP5JjYiTlpF4L57KwALy1a
         hDM4fptBZXZOnxe1EnmsaytxZk5Wb+t75YKYIpYt4+CNALuMEYcjsZxSsrKg4ePoy8rc
         tTMjYv7nqhrD1gzH7RQOlL+Ie/Cw8qrgO3/+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471285; x=1691076085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO6zMXaYYTVSgQL74L2Fy444v1xc+I1L+rWiKjULm/s=;
        b=dCImT3ffTHwznpD0UfomUTwi+a1L7WoqSJyEFxxncUAGnFTA2x2c/VbqmndntLUzCt
         WrMs1iVKaid6amlaVs/AHqvVdluFGw//qQ5ZwzSJJIwiIqmEqDixN0a+caevxU524AR1
         7ZmS0cOblqgn/5FgzL1h2qIB5aMjeX3S9GljA5DQbaCPtxGV2ZK3g66DEcLOcvW0oY+r
         g8RDRTGU8DqDzz0tubTe58S8+VuNRbL6mXvYxIxDZQoARgE2MWbZLWxFJaDnOoBkxNFA
         cSCussEFI4xdtbBWB0SaUNDIs2gTCo45dt4TQMOidUCUB5MjqeL72Op4MLWcTolCVlbI
         wbaA==
X-Gm-Message-State: ABy/qLYsBPwA5owG9NwMbHS2xjUi0N6kWMbcGOGg67XRaUBcdksGQseS
        9E1+FGK5iUDI64BgX2pr1ALHIg==
X-Google-Smtp-Source: APBJJlGT9lRvF3J44vX3/X7wPObb1WUD6ovfu1m/g1z2Q2YaNJVZDWni0O7Lqdj1rcBc47LVGYb3DA==
X-Received: by 2002:a17:906:29a:b0:992:a838:a564 with SMTP id 26-20020a170906029a00b00992a838a564mr2166367ejf.28.1690471284985;
        Thu, 27 Jul 2023 08:21:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (92-249-235-35.pool.digikabel.hu. [92.249.235.35])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b00993150e5325sm895606ejb.60.2023.07.27.08.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:21:23 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:21:21 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Jaco Kroon <jaco@uls.co.za>
Cc:     Antonio SJ Musumeci <trapexit@spawn.link>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Message-ID: <ZMKLcf1r0epaev5C@miu.piliscsaba.redhat.com>
References: <20230726105953.843-1-jaco@uls.co.za>
 <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
 <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
 <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link>
 <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:25:48PM +0200, Jaco Kroon wrote:

> glibc uses a 128KiB buffer for getdents64, so I'm not sure >128KiB here
> makes sense.  Or if these two buffers are even directly related.

Definitely related.  See how the dir_emit() works: if the entry doesn't fit in
the userspace buffer, then ->readdir() returns.  If entries remain in the fuse
buffer at that time, they are simply discarded.  Simply put, making the
buffer too large is going to be a waste of resources and at some point will be
slower than the single page buffer.

Note: discarding received entries is the only possible action if caching is
disabled.  With caching enabled it would make sense to pre-fill the cache with
the overflowed entries and use them in the next iteration.  However the caching
code is not prepared for using partial caches at the moment.

The best strategy would be to find the optimal buffer size based on the size of
the userspace buffer.  Putting that info into struct dir_context doesn't sound
too complicated...

Here's a patch.  It doesn't touch readdir.  Simply setting the fuse buffer size
to the userspace buffer size should work, the record sizes are similar (fuse's
is slightly larger than libc's, so no overflow should ever happen).

Thanks,
Miklos


---
 fs/exportfs/expfs.c    |    1 +
 fs/overlayfs/readdir.c |   12 +++++++++++-
 fs/readdir.c           |   29 ++++++++++++++---------------
 include/linux/fs.h     |    7 +++++++
 4 files changed, 33 insertions(+), 16 deletions(-)

--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -286,6 +286,7 @@ static int get_name(const struct path *p
 	};
 	struct getdents_callback buffer = {
 		.ctx.actor = filldir_one,
+		.ctx.count = INT_MAX,
 		.name = name,
 	};
 
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -347,6 +347,7 @@ static int ovl_dir_read_merged(struct de
 	struct path realpath;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_merge,
+		.ctx.count = INT_MAX,
 		.dentry = dentry,
 		.list = list,
 		.root = root,
@@ -557,6 +558,7 @@ static int ovl_dir_read_impure(const str
 	struct ovl_cache_entry *p, *n;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.ctx.count = INT_MAX,
 		.list = list,
 		.root = root,
 	};
@@ -658,6 +660,7 @@ static bool ovl_fill_real(struct dir_con
 	struct ovl_readdir_translate *rdt =
 		container_of(ctx, struct ovl_readdir_translate, ctx);
 	struct dir_context *orig_ctx = rdt->orig_ctx;
+	bool res;
 
 	if (rdt->parent_ino && strcmp(name, "..") == 0) {
 		ino = rdt->parent_ino;
@@ -672,7 +675,10 @@ static bool ovl_fill_real(struct dir_con
 					  name, namelen, rdt->xinowarn);
 	}
 
-	return orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
+	res = orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
+	ctx->count = orig_ctx->count;
+
+	return res;
 }
 
 static bool ovl_is_impure_dir(struct file *file)
@@ -699,6 +705,7 @@ static int ovl_iterate_real(struct file
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
+		.ctx.count = ctx->count,
 		.orig_ctx = ctx,
 		.xinobits = ovl_xino_bits(ofs),
 		.xinowarn = ovl_xino_warn(ofs),
@@ -1058,6 +1065,7 @@ int ovl_check_d_type_supported(const str
 	int err;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_check_d_type,
+		.ctx.count = INT_MAX,
 		.d_type_supported = false,
 	};
 
@@ -1079,6 +1087,7 @@ static int ovl_workdir_cleanup_recurse(s
 	struct ovl_cache_entry *p;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.ctx.count = INT_MAX,
 		.list = &list,
 	};
 	bool incompat = false;
@@ -1163,6 +1172,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *
 	struct ovl_cache_entry *p;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.ctx.count = INT_MAX,
 		.list = &list,
 	};
 
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -184,6 +184,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned in
 	struct fd f = fdget_pos(fd);
 	struct readdir_callback buf = {
 		.ctx.actor = fillonedir,
+		.ctx.count = 1, /* Hint to fs: just one entry. */
 		.dirent = dirent
 	};
 
@@ -215,7 +216,6 @@ struct getdents_callback {
 	struct dir_context ctx;
 	struct linux_dirent __user * current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -234,7 +234,7 @@ static bool filldir(struct dir_context *
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
@@ -259,7 +259,7 @@ static bool filldir(struct dir_context *
 
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 efault_end:
 	user_write_access_end();
@@ -274,7 +274,7 @@ SYSCALL_DEFINE3(getdents, unsigned int,
 	struct fd f;
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
-		.count = count,
+		.ctx.count = count,
 		.current_dir = dirent
 	};
 	int error;
@@ -293,7 +293,7 @@ SYSCALL_DEFINE3(getdents, unsigned int,
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	fdput_pos(f);
 	return error;
@@ -303,7 +303,6 @@ struct getdents_callback64 {
 	struct dir_context ctx;
 	struct linux_dirent64 __user * current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -321,7 +320,7 @@ static bool filldir64(struct dir_context
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	prev_reclen = buf->prev_reclen;
 	if (prev_reclen && signal_pending(current))
@@ -341,7 +340,7 @@ static bool filldir64(struct dir_context
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 
 efault_end:
@@ -357,7 +356,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int
 	struct fd f;
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
-		.count = count,
+		.ctx.count = count,
 		.current_dir = dirent
 	};
 	int error;
@@ -377,7 +376,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int
 		if (put_user(d_off, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	fdput_pos(f);
 	return error;
@@ -442,6 +441,7 @@ COMPAT_SYSCALL_DEFINE3(old_readdir, unsi
 	struct fd f = fdget_pos(fd);
 	struct compat_readdir_callback buf = {
 		.ctx.actor = compat_fillonedir,
+		.ctx.count = 1, /* Hint to fs: just one entry. */
 		.dirent = dirent
 	};
 
@@ -467,7 +467,6 @@ struct compat_getdents_callback {
 	struct dir_context ctx;
 	struct compat_linux_dirent __user *current_dir;
 	int prev_reclen;
-	int count;
 	int error;
 };
 
@@ -486,7 +485,7 @@ static bool compat_filldir(struct dir_co
 	if (unlikely(buf->error))
 		return false;
 	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
+	if (reclen > ctx->count)
 		return false;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
@@ -510,7 +509,7 @@ static bool compat_filldir(struct dir_co
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
-	buf->count -= reclen;
+	ctx->count -= reclen;
 	return true;
 efault_end:
 	user_write_access_end();
@@ -525,8 +524,8 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigne
 	struct fd f;
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
+		.ctx.count = count,
 		.current_dir = dirent,
-		.count = count
 	};
 	int error;
 
@@ -544,7 +543,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigne
 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
 			error = -EFAULT;
 		else
-			error = count - buf.count;
+			error = count - buf.ctx.count;
 	}
 	fdput_pos(f);
 	return error;
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1719,6 +1719,13 @@ typedef bool (*filldir_t)(struct dir_con
 struct dir_context {
 	filldir_t actor;
 	loff_t pos;
+	/*
+	 * Filesystems MUST NOT MODIFY count, but may use as a hint:
+	 * 0	    unknown
+	 * > 0      space in buffer (assume at least one entry)
+	 * INT_MAX  unlimited
+	 */
+	int count;
 };
 
 /*
