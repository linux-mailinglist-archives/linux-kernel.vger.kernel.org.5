Return-Path: <linux-kernel+bounces-94542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF187412B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3493E28892F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14C143758;
	Wed,  6 Mar 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzbTbw7N"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FE14372D;
	Wed,  6 Mar 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755550; cv=none; b=JVIFquYcNvdzvesgE8k5RF1Osy4YBk1LhPX9jBkHtMuxKevp51Y/dm6HHRreX3kZLGUBhO4IopBBZqFNoPfXLNU6Qf/EO21IhsiPEXd2XdIUDAec7R2jDDPOtDtr3B9HKI69nxI7WWMhBFuKI/7cqxA0pkMkss0xnjwnp0rTZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755550; c=relaxed/simple;
	bh=joPS7aRxwYa4hZZkszZGFWj2FC8Fr3qNLAdjdoRuogw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2hlIhUpxrl2Er1l/Jk405YCNAhWBDRLErV1pGrk6FUx1MioLCe7la2v0hbLN7FuMiqYguNdFtuA+Q4KxKXzklzF3qo2R+ic/SSp57LkWGJMGa+K5tVY1kIlznivdpJmOppuJ2jzERw3r/LdZjxijuqKv6O5+VOLpbJLhb1bSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzbTbw7N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso827655ad.3;
        Wed, 06 Mar 2024 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709755548; x=1710360348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I57kyg6eTucwv8eo/E5FOHR5MopFsB/omhETuWjxqlw=;
        b=kzbTbw7N5F1WNBI3IUy+6lXpkbSV6Scc0Ag6udfuKbKVLEQOkzKh7yWylDtB29TG4k
         Rb/TT+CkWEOFVkW2MYuvBlx+Xm1vRbBH1LUxXCWQIdsICt4RAxKvuRQyy+Fq2HC9U9VJ
         fTWN8uXpD9FJCCLfj3lxn7IeqmBMl1gTcQf93Xr1Pmr3WlZbolzO5o+oliAdjBxr4ZmM
         xXU0eLDQUGWyOHvhFZHrM/bo2DJUTpUqel0+zNqYEAzZtE659mEh+7+abU2mmSRKPGy4
         75MNwnN8CfaN7rtCtjndRSwSvMCvRkPQqaU8ZOiFAxFHuOd7iSgXHbe/NkssPgIEAto/
         q4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755548; x=1710360348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I57kyg6eTucwv8eo/E5FOHR5MopFsB/omhETuWjxqlw=;
        b=V9Z4rdVKoedOh+6VI4ooeivZQ02iBXzN2LowWK5LkUyZ7ZNzxlOJTA2jM4koLT7AW7
         8RQiveKyGZHRBPLktl+DklYrWFgq//ehiHZIk1TCIXQAcvGnEWJ2fdrkoSTNg+KsXIKs
         kGkoebbJNWjwvZ9/j47gLjE4NSQNIZBFC4C9c/W0ysLUuSRiLjWPVgyQ1ZoqZD1xS59I
         I0mbUfQIt1Jg5xkClzZ1ZJUH/a6bpUleVnFfNowiFqaO46BLw2H2Y9NeYlQ0R0xiK7kA
         xG95tupyW17gxSyuILhsA72ZNQFGVjeBWO3DgLY62L1AofwKF4oFg37xhAB3SFw5III8
         G9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAtccP+lpUTJ+tLwV4R74HdSRxoud0GfuKMt4S7LFg50K2jyAOVq0MfreuyDWtryjHwVmIMzayVcDca39l7tIM3VDLSTNkXqckCvNfCq6FxOPUS0KYd8Eo2VUmHi/0xAr4akii06faODywmHAJz9YyAKizBpMnzKC+Z0BXKVdhsA==
X-Gm-Message-State: AOJu0Yz0a0ZWPGK/ZMKk5OihMz7aNFtGue8ZSFNhlB9U/0pnT4t/UnmZ
	EuBkPoEGWEpdFxEEWjV3azcwrKVLGYn/Bn7ZSaiUVTeJNTcY8z3g
X-Google-Smtp-Source: AGHT+IH8zfganj5XWPVSBbSsHDUFg52F70PkgfZSuw9plNsQY5H+gIvjYq7zI0Mzm73ysjj5eI88rQ==
X-Received: by 2002:a17:902:650b:b0:1dc:c93e:f5f5 with SMTP id b11-20020a170902650b00b001dcc93ef5f5mr5840853plk.12.1709755548504;
        Wed, 06 Mar 2024 12:05:48 -0800 (PST)
Received: from mozart.vkv.me ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001dcfc88ccf6sm8869341plf.263.2024.03.06.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:05:48 -0800 (PST)
From: Calvin Owens <jcalvinowens@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Calvin Owens <jcalvinowens@gmail.com>,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/4] bpf: Allow BPF_JIT with CONFIG_MODULES=n
Date: Wed,  6 Mar 2024 12:05:09 -0800
Message-ID: <afebd15dd032f908e46871bec5be438063ae7458.1709676663.git.jcalvinowens@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709676663.git.jcalvinowens@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No BPF code has to change, except in struct_ops (for module refs).

This conflicts with bpf-next because of this (relevant) series:

    https://lore.kernel.org/all/20240119225005.668602-1-thinker.li@gmail.com/

If something like this is merged down the road, it can go through
bpf-next at leisure once the module_alloc change is in: it's a one-way
dependency.

Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
---
 kernel/bpf/Kconfig          |  2 +-
 kernel/bpf/bpf_struct_ops.c | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 6a906ff93006..77df483a8925 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -42,7 +42,7 @@ config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
 	depends on BPF
 	depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
-	depends on MODULES
+	select MODULE_ALLOC
 	help
 	  BPF programs are normally handled by a BPF interpreter. This option
 	  allows the kernel to generate native code when a program is loaded
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 02068bd0e4d9..fbf08a1bb00c 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -108,11 +108,30 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 #endif
 };
 
+#if IS_ENABLED(CONFIG_MODULES)
 static const struct btf_type *module_type;
 
+static int bpf_struct_module_type_init(struct btf *btf)
+{
+	s32 module_id;
+
+	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
+	if (module_id < 0)
+		return 1;
+
+	module_type = btf_type_by_id(btf, module_id);
+	return 0;
+}
+#else
+static int bpf_struct_module_type_init(struct btf *btf)
+{
+	return 0;
+}
+#endif
+
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
-	s32 type_id, value_id, module_id;
+	s32 type_id, value_id;
 	const struct btf_member *member;
 	struct bpf_struct_ops *st_ops;
 	const struct btf_type *t;
@@ -125,12 +144,10 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 #include "bpf_struct_ops_types.h"
 #undef BPF_STRUCT_OPS_TYPE
 
-	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
-	if (module_id < 0) {
+	if (bpf_struct_module_type_init(btf)) {
 		pr_warn("Cannot find struct module in btf_vmlinux\n");
 		return;
 	}
-	module_type = btf_type_by_id(btf, module_id);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops = bpf_struct_ops[i];
@@ -433,12 +450,15 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 		moff = __btf_member_bit_offset(t, member) / 8;
 		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
+
+#if IS_ENABLED(CONFIG_MODULES)
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
 				goto reset_unlock;
 			*(void **)(kdata + moff) = BPF_MODULE_OWNER;
 			continue;
 		}
+#endif
 
 		err = st_ops->init_member(t, member, kdata, udata);
 		if (err < 0)
-- 
2.43.0


