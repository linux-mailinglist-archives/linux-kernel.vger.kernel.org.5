Return-Path: <linux-kernel+bounces-123999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38F8910F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7309E28C7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ED854BFA;
	Fri, 29 Mar 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0fNtm81"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AF52F80
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677284; cv=none; b=cL0f5SumpdMyVR8ZhRscAZPyIj+taNZFuWlaA8Y7cp70Aj3ZP9fGzxBwL/1Xu/jXtQJW/rSVeFYKfr7ZFavTQzlZDzR4V+Sv4heYuogRJqCWtFCH7yaAr5M0LVuFORKpn635T08x3WtgeESLVVRoXnPxwN1yPQ3U79y9XMk+IIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677284; c=relaxed/simple;
	bh=Hn0JISNtHd2dK7T/S9cZiUrLHJgQGwSGwBy9K2nI0lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/jNpiIioIUi9fwXlmFXjIb4qrlc6rMMRUpuHgZ0QVE4Kl6WX3gqLLtaXPl9NYRWofHLwEinHXqRRliLG9K2M6yAwGkmzY5yBgK0TmLroJIN9ArCEGEHJeBuEgX0c6LkT76rDln/RLPnBgTMzKz3fp5UKdxFN6uZIwUdQex2EEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0fNtm81; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso2278176276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677281; x=1712282081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfFiI8vNK8vS8NsLoc6ESuQdhSeANMB/sBc7Z4XDU0M=;
        b=m0fNtm81d8rHFywtRkzbsp20ONif/i9jipiRPNNWAqSRu6jc5vbd8F2K/A37obDYJI
         hhjFnV6KGHIzsaSP+J71sJrM29pC1s8QSyFIo8OWpv8d5MP45Gpr8WM+N8zt3oPIy0S8
         /Ny8RIEd/3SZjTQlHwaeDX8hQ5k6AgVBufY1xJQ0htaDBOCXZTAfieYsFmBsfFC99XVR
         JJ3d4x3JzB7lg6P81L9Ca9ogW00KabaUtN83tvjhZ7eryaiqRy1ZD/fzpWap6q6iDp1P
         lME6w82jKwLRPCEJ8til4/WAnNcwIlmq6lXrPSOu4asA6fC0L1PVLbQvFj14LUTq7RJg
         g8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677281; x=1712282081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfFiI8vNK8vS8NsLoc6ESuQdhSeANMB/sBc7Z4XDU0M=;
        b=LePU2TRYymIy77aiimQ6nEAcrElre2SKqiSuJ3SUg67l1XR7SJNJjwD+TCnP6rdRc1
         QHGFlja+zjocrho6uYDAaQqkJlurxw5GEw/gJKNzb7WalIxIwtes6c+wrCFL3q3xFmKQ
         yy6K/LxOxmoLv5abbNQ2UvW6VoObwuqTr0yf1Zl8IypkD07CkcdDRl9j/zxEDDi+2qPC
         /JuXK58wVgVi3MYVcskF8yDcAvYtjsBomBc9wPCT6ZMNpZVnXZo9ThfrT2dab/dXg4mw
         CFFZh9beJfFgVQwiZG5lzjZvSeUmkkq5fRDgg0S2kCVZvgPFhKMhjoNlAb433f0Rnm4j
         gtPA==
X-Forwarded-Encrypted: i=1; AJvYcCVyyhYf08bEBkdSVFwqH/MpNn2FYmRQyJHNpuXvus/b40uy3mCF9rn/j4HLkQ5GBKps8V2yudyTeWVIyKI+E1WE6Z0DmhYsd1MRIANC
X-Gm-Message-State: AOJu0YzL8O4+6Pd31XMdBCi+fwjeRySZlUGNLEGveoJQQ86r3aIoWHQ2
	lmEN1a5EXpksXr3RcWzzM7SFGf9GJND1t20EfEmqTiBKZGbfwBDqjY0aWzoP0uasqC5oC7QRe52
	SHA==
X-Google-Smtp-Source: AGHT+IEEbm0qNA0/E1KnvsxrRtVriN0Qzj4b4P0HvmZKpVXzPmDJsYuuIVjd3Q4CdJv6SA5mEs9pfQvES3o=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:e0f:b0:dc6:44d4:bee0 with SMTP id
 df15-20020a0569020e0f00b00dc644d4bee0mr85420ybb.7.1711677281466; Thu, 28 Mar
 2024 18:54:41 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:34 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-20-drosen@google.com>
Subject: [RFC PATCH v4 19/36] fuse-bpf: Add xattr support
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds support for FUSE_GETXATTR, FUSE_LISTXATTR, FUSE_SETXATTR, and
FUSE_REMOVEXATTR

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  30 ++++
 fs/fuse/xattr.c   |  18 +++
 3 files changed, 397 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 2363f392e915..3390ce66e393 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -959,6 +959,355 @@ int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t
 				file, start, end, datasync);
 }
 
+struct fuse_getxattr_args {
+	struct fuse_getxattr_in in;
+	struct fuse_buffer name;
+	struct fuse_buffer value;
+	struct fuse_getxattr_out out;
+};
+
+static int fuse_getxattr_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_getxattr_args *args,
+				       struct dentry *dentry, const char *name, void *value,
+				       size_t size)
+{
+	*args = (struct fuse_getxattr_args) {
+		.in.size = size,
+		.name = (struct fuse_buffer) {
+			.data =  (void *) name,
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_MUST_ALLOCATE | BPF_FUSE_VARIABLE_SIZE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_GETXATTR,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_getxattr_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_getxattr_args *args,
+					struct dentry *dentry, const char *name, void *value,
+					size_t size)
+{
+	fa->flags = size ? FUSE_BPF_OUT_ARGVAR : 0;
+	fa->out_numargs = 1;
+	if (size) {
+		args->value = (struct fuse_buffer) {
+			.data =  (void *) value,
+			.size = size,
+			.alloc_size = size,
+			.max_size = size,
+			.flags = BPF_FUSE_VARIABLE_SIZE,
+		};
+		fa->out_args[0].is_buffer = true;
+		fa->out_args[0].buffer = &args->value;
+	} else {
+		fa->out_args[0].size = sizeof(args->out);
+		fa->out_args[0].value = &args->out;
+	}
+	return 0;
+}
+
+static int fuse_getxattr_backing(struct bpf_fuse_args *fa, int *out,
+				 struct dentry *dentry, const char *name, void *value,
+				 size_t size)
+{
+	ssize_t ret;
+
+	if (fa->in_args[1].buffer->flags & BPF_FUSE_MODIFIED) {
+		// Ensure bpf provided string is null terminated
+		char *new_name = fa->in_args[1].buffer->data;
+		new_name[fa->in_args[1].buffer->size - 1] = 0;
+	}
+	ret = vfs_getxattr(&nop_mnt_idmap,
+				   get_fuse_dentry(dentry)->backing_path.dentry,
+				   fa->in_args[1].buffer->data, value, size);
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR)
+		fa->out_args[0].buffer->size = ret;
+	else
+		((struct fuse_getxattr_out *)fa->out_args[0].value)->size = ret;
+
+	return 0;
+}
+
+static int fuse_getxattr_finalize(struct bpf_fuse_args *fa, int *out,
+				  struct dentry *dentry, const char *name, void *value,
+				  size_t size)
+{
+	struct fuse_getxattr_out *fgo;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR) {
+		*out = fa->out_args[0].buffer->size;
+		return 0;
+	}
+
+	fgo = fa->out_args[0].value;
+
+	*out = fgo->size;
+	return 0;
+}
+
+int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry, const char *name,
+		      void *value, size_t size)
+{
+	return bpf_fuse_backing(inode, struct fuse_getxattr_args, out,
+				fuse_getxattr_initialize_in, fuse_getxattr_initialize_out,
+				fuse_getxattr_backing, fuse_getxattr_finalize,
+				dentry, name, value, size);
+}
+
+static int fuse_listxattr_initialize_in(struct bpf_fuse_args *fa,
+					struct fuse_getxattr_args *args,
+					struct dentry *dentry, char *list, size_t size)
+{
+	*args = (struct fuse_getxattr_args) {
+		.in.size = size,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_LISTXATTR,
+		},
+		.in_numargs = 1,
+		.in_args[0] =
+			(struct bpf_fuse_arg) {
+				.size = sizeof(args->in),
+				.value = &args->in,
+			},
+	};
+
+	return 0;
+}
+
+static int fuse_listxattr_initialize_out(struct bpf_fuse_args *fa,
+					 struct fuse_getxattr_args *args,
+					 struct dentry *dentry, char *list, size_t size)
+{
+	fa->out_numargs = 1;
+
+	if (size) {
+		args->value = (struct fuse_buffer) {
+			.data = list,
+			.size = size,
+			.alloc_size = size,
+			.max_size = size,
+			.flags = BPF_FUSE_VARIABLE_SIZE,
+		};
+		fa->flags = FUSE_BPF_OUT_ARGVAR;
+		fa->out_args[0].is_buffer = true;
+		fa->out_args[0].buffer = &args->value;
+	} else {
+		fa->out_args[0].size = sizeof(args->out);
+		fa->out_args[0].value = &args->out;
+	}
+	return 0;
+}
+
+static int fuse_listxattr_backing(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+				  char *list, size_t size)
+{
+	*out = vfs_listxattr(get_fuse_dentry(dentry)->backing_path.dentry, list, size);
+
+	if (*out < 0)
+		return *out;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR)
+		fa->out_args[0].buffer->size = *out;
+	else
+		((struct fuse_getxattr_out *)fa->out_args[0].value)->size = *out;
+
+	return 0;
+}
+
+static int fuse_listxattr_finalize(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+				   char *list, size_t size)
+{
+	struct fuse_getxattr_out *fgo;
+
+	if (fa->info.error_in)
+		return 0;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR) {
+		*out = fa->out_args[0].buffer->size;
+		return 0;
+	}
+
+	fgo = fa->out_args[0].value;
+	*out = fgo->size;
+	return 0;
+}
+
+int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry,
+		       char *list, size_t size)
+{
+	return bpf_fuse_backing(inode, struct fuse_getxattr_args, out,
+				fuse_listxattr_initialize_in, fuse_listxattr_initialize_out,
+				fuse_listxattr_backing, fuse_listxattr_finalize,
+				dentry, list, size);
+}
+
+struct fuse_setxattr_args {
+	struct fuse_setxattr_in in;
+	struct fuse_buffer name;
+	struct fuse_buffer value;
+};
+
+static int fuse_setxattr_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_setxattr_args *args,
+				       struct dentry *dentry, const char *name,
+				       const void *value, size_t size, int flags)
+{
+	*args = (struct fuse_setxattr_args) {
+		.in = (struct fuse_setxattr_in) {
+			.size = size,
+			.flags = flags,
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) name,
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+		.value =(struct fuse_buffer) {
+			.data = (void *) value,
+			.size = size,
+			.max_size = XATTR_SIZE_MAX,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_SETXATTR,
+		},
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->value,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_setxattr_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_setxattr_args *args,
+					struct dentry *dentry, const char *name,
+					const void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+static int fuse_setxattr_backing(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+				 const char *name, const void *value, size_t size,
+				 int flags)
+{
+	// TODO Ensure we actually use filter values
+	*out = vfs_setxattr(&nop_mnt_idmap,
+			    get_fuse_dentry(dentry)->backing_path.dentry, name,
+			    value, size, flags);
+	return 0;
+}
+
+static int fuse_setxattr_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+				  const char *name, const void *value, size_t size,
+				  int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
+		      const char *name, const void *value, size_t size, int flags)
+{
+	return bpf_fuse_backing(inode, struct fuse_setxattr_args, out,
+			       fuse_setxattr_initialize_in, fuse_setxattr_initialize_out,
+			       fuse_setxattr_backing, fuse_setxattr_finalize,
+			       dentry, name, value, size, flags);
+}
+
+static int fuse_removexattr_initialize_in(struct bpf_fuse_args *fa,
+					  struct fuse_buffer *in,
+					  struct dentry *dentry, const char *name)
+{
+	*in = (struct fuse_buffer) {
+		.data = (void *) name,
+		.size = strlen(name) + 1,
+		.max_size = XATTR_NAME_MAX + 1,
+		.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_REMOVEXATTR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = in,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_removexattr_initialize_out(struct bpf_fuse_args *fa,
+					   struct fuse_buffer *in,
+					   struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
+static int fuse_removexattr_backing(struct bpf_fuse_args *fa, int *out,
+				    struct dentry *dentry, const char *name)
+{
+	struct path *backing_path = &get_fuse_dentry(dentry)->backing_path;
+
+	/* TODO account for changes of the name by prefilter */
+	*out = vfs_removexattr(&nop_mnt_idmap, backing_path->dentry, name);
+	return 0;
+}
+
+static int fuse_removexattr_finalize(struct bpf_fuse_args *fa, int *out,
+				     struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
+int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, const char *name)
+{
+	return bpf_fuse_backing(inode, struct fuse_buffer, out,
+				fuse_removexattr_initialize_in, fuse_removexattr_initialize_out,
+				fuse_removexattr_backing, fuse_removexattr_finalize,
+				dentry, name);
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a95d543c79ae..127758575ddc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1459,6 +1459,13 @@ int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *fil
 			     size_t len, unsigned int flags);
 int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry,
+		      const char *name, void *value, size_t size);
+int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry, char *list, size_t size);
+int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
+		      const char *name, const void *value, size_t size,
+		      int flags);
+int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, const char *name);
 int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
@@ -1553,6 +1560,29 @@ static inline int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file
 	return 0;
 }
 
+static inline int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry,
+				    const char *name, void *value, size_t size)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry, char *list, size_t size)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
+				    const char *name, const void *value, size_t size,
+				    int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 5b423fdbb13f..394441397a8a 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -118,6 +118,9 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_listxattr(&ret, inode, entry, list, size))
+		return ret;
+
 	if (!fuse_allow_current_process(fm->fc))
 		return -EACCES;
 
@@ -182,9 +185,14 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *dentry, struct inode *inode,
 			 const char *name, void *value, size_t size)
 {
+	int err;
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_getxattr(&err, inode, dentry, name, value, size))
+		return err;
+
 	return fuse_getxattr(inode, name, value, size);
 }
 
@@ -194,9 +202,19 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 			  const char *name, const void *value, size_t size,
 			  int flags)
 {
+	int err;
+	bool handled;
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (value)
+		handled = fuse_bpf_setxattr(&err, inode, dentry, name, value, size, flags);
+	else
+		handled = fuse_bpf_removexattr(&err, inode, dentry, name);
+	if (handled)
+		return err;
+
 	if (!value)
 		return fuse_removexattr(inode, name);
 
-- 
2.44.0.478.gd926399ef9-goog


