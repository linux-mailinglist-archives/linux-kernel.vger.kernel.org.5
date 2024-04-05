Return-Path: <linux-kernel+bounces-133160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA2C899FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B581F232A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683116F857;
	Fri,  5 Apr 2024 14:30:52 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417B16F856;
	Fri,  5 Apr 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327452; cv=none; b=iBE2s96AVWRGKem1bP7Nxvqv4NRXerIRw3xDWlVl4QIRXhdoPNl+sXulBGHeboXi6/ZMMg5eo6puw8risuzNYis/60eVHdFVCsG4N9qLwtK9eyuy9FwZDUSXa6ood3fNeXRRkg3+lEMrn3G6S+7HfKRLWL/vg3YcrlNe7GzVX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327452; c=relaxed/simple;
	bh=LFtBoVTcSa0WoZ4hT+3gROUd9+4JFFOPzrtM0DkuNNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEHuyNSML4YODl/JXJMMHa3+vBbpa64BQ1IEXOTH06FBnJYmtUlLgd8XhvyOTKZN2JpHrNK60ly3DUh9L91yy2Lnp4gDK+PnuEynlbYldSBa6aB2FY0oVzpUYo5bGAxOiDZioifgEXUkEFh4hiQGtk9vZi9z99OOjKZaJvqSiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a0d09e6ffso3945665ab.0;
        Fri, 05 Apr 2024 07:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327450; x=1712932250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfXRwZpB8GnNWQ39P82k01Aag/6u7hx54JnENyAlqhI=;
        b=tw/vgfu778Q5TiSnD2FxOi7fxj8n2JoOeLn1QEjUkRHC/F6Uq8LHwbMI8sW1e8DWDK
         V+jM9vglg699o3qTopkdneGQJ8Pc3E7UCDsJnzh3YCD2G8CKiTbNNCazLgfWL9XbmCep
         iEYpJ6P23TvKHM9XfGA7FJ4h+ZxUhUIEXEniTDH6IzV4Yj1mSujxI2yROeKKv0hSl66O
         VN/rN0nXdgL18Zwyg2tuYEi7FlfWohNollqDjjtWYgCSVXHJwfMxQQVDR7SZoHk+uMRY
         Y9yg+Qbq9tGll7KeKry5Lo1FZxnxEop740dSVXPVGxbjqW7Yt4b8zZurIIlG5s63eMWe
         t07Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKxAT4oroxKQt0DXdPnJcP5ISarYCLWu6+yWRkO/LQkqPgaBfUSWMY9KvbhYQwzW7N1z4jK+rIkm/vMcpLyivjyOnRuPQvN9+9UKSX
X-Gm-Message-State: AOJu0Yz6GXAWJrMGwqYg1EEw0usTVyQe2cvn/y675nd+pXT1Jec9+3Zz
	lV9AX3EqolNGpfg4/Ei6MK77UTnb7+lorB+9juo7MyXikKS0AK+t9uQuHL5AfIM=
X-Google-Smtp-Source: AGHT+IEz5IjsSZ0rwrqyeaT3VLrS3vSgQpobPv7oPx/vy/q5pxyJq5zwjafs/cRXnl7Zn6ITFBKQYA==
X-Received: by 2002:a05:6e02:1ca6:b0:368:99a9:3f1c with SMTP id x6-20020a056e021ca600b0036899a93f1cmr1562352ill.9.1712327444873;
        Fri, 05 Apr 2024 07:30:44 -0700 (PDT)
Received: from localhost (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id r11-20020a056638300b00b0047bed8cd9cesm584114jak.81.2024.04.05.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:30:44 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
Date: Fri,  5 Apr 2024 09:30:40 -0500
Message-ID: <20240405143041.632519-2-void@manifault.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405143041.632519-1-void@manifault.com>
References: <20240405143041.632519-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a set of core BPF kfuncs (e.g. bpf_task_*, bpf_cgroup_*,
bpf_cpumask_*, etc) cannot be invoked from BPF_PROG_TYPE_SYSCALL
programs. The whitelist approach taken for enabling kfuncs makes sense:
it not safe to call these kfuncs from every program type. For example,
it may not be safe to call bpf_task_acquire() in an fentry to
free_task().

BPF_PROG_TYPE_SYSCALL, on the other hand, is a perfectly safe program
type from which to invoke these kfuncs, as it's a very controlled
environment, and we should never be able to run into any of the typical
problems such as recursive invoations, acquiring references on freeing
kptrs, etc. Being able to invoke these kfuncs would be useful, as
BPF_PROG_TYPE_SYSCALL can be invoked with BPF_PROG_RUN, and would
therefore enable user space programs to synchronously call into BPF to
manipulate these kptrs.

This patch therefore enables invoking the aforementioned core kfuncs
from BPF_PROG_TYPE_SYSCALL progs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 1 +
 kernel/bpf/helpers.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index dad0fb1c8e87..33c473d676a5 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -474,6 +474,7 @@ static int __init cpumask_kfunc_init(void)
 	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
 						   ARRAY_SIZE(cpumask_dtors),
 						   THIS_MODULE);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d9e7aca8ae9e..8cde717137bd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2653,6 +2653,7 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.44.0


