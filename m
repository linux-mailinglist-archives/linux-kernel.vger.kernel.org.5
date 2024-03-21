Return-Path: <linux-kernel+bounces-110460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14845885F40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41A5284224
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF313774B;
	Thu, 21 Mar 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx4Ksm6O"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE61369BD;
	Thu, 21 Mar 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040694; cv=none; b=cY6owSIc/QHAWoPl2l/YDhjij0UNiEZlLHlbRRACxQixgytm6NlsfX5GrLqbwOrzHyotdZsGoJBQ+hMXwaBnPE61WMqPo6IPkmdnnjnAFOsaT15HL5OOuNTzoIroEYnbjj4itYEpDuf6coab25oQGytquurwuNgXn9TJ1AztMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040694; c=relaxed/simple;
	bh=PBNP6ds/R2JFLiTQd4E4yXtbSLugDnfByIKQ6LMQ4sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IdHS2x80S6xQjdDPQyO0YrowiwI/Ww+66JecnYCm3/FjLJa8vd85LiG/rdbhv64UOnz0udQIdNeXwJmO42h8dwi3LlXUSoADeUutjR6B9nrmHMkMufWeRzyYLOj/EWRfMU5zR3yCKAxJOBRGsG7wd/QaP+UKOGLQjkkDaErDLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx4Ksm6O; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def3340682so9361055ad.1;
        Thu, 21 Mar 2024 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711040692; x=1711645492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwuoi6LShktW7yNyxvXZVkItWwfCGlWBNcmXdYgjQDY=;
        b=bx4Ksm6O5LYDsvAMKc5SXJXjXVecj15SetXpdXKdVXKEmCkepGNDE/wt+H4wV9xcTd
         EmGi2t1GeiQE67gfN+gYOIwNns+An66+pbvDZDr1GszIk10CqFibjSWcSDT/VmgT/DdU
         Gf9vhlU2mNisixl4XEua0EY4QGn9qId3IT7YJlmxoMjFfjaX90RKNEhZ34oeWMWYp2ke
         l7TnrrA0Hj1Whb6rH241aXQDG7udEpsuoALg+HSRVK8NMWT4ugdmaR0UFknR6SCk5gDx
         NBYGJT3OzUKhJYuBSQy39+FQ/8Y+cMzBmDmlpgwUYJLkopuHXKq8vwBiVsYLgSqJlo5q
         wW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040692; x=1711645492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nwuoi6LShktW7yNyxvXZVkItWwfCGlWBNcmXdYgjQDY=;
        b=aQaQmpyN5h7yy2cRzuVkkRaaGr82OXVMRHjx/HdmCVqlkGhunCqXxoaKelSjViIFnM
         5Vm9w7t8/zHy6yTUlK6hDkB5iWX7wUlF2C/OyJA3geFZcUsKxOVNtp4alTzpa285D1sK
         SUq0AqZ60NZlQ3d427HZVAakFDSnZCIowdQ7Ke9QrwcOOEiIg4Zul6dF60qplXLel/i+
         Fch28wmV6vQsd4/ttZufEqYse/rsgAyDi0F3I16x8+li2VzJzKkoXWh+BA+Jw/weKVyI
         Otblcs8PCH90yCE6+My3DigzPW5tKgALScOX/JcI9dHNZ5A+ufYxwbPtnpn0UTGbIQqj
         l0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWwnZznPgK4UhTHJQwzFBevI2hBeO+zKTL88U7ZoZ4EzLZ6a9IXex5rYhUncTo9Ac6BmbcViW8ZfPhZ1s9QJAxyBUeRMOUrsbbaVjP
X-Gm-Message-State: AOJu0YyvkHlBHTIQnm8za1mb5hc4u9XJcFtdWatZ5ETx6dUzZA3VG0OO
	82g18ilUcQ3GzRwbQ+QzIfX+ZF/8mPrIpnXKmSGb6XRJaTuilYiOdUw+pZqB
X-Google-Smtp-Source: AGHT+IETbuZGN+thpS4knTRUkn8uk19B26i5JrBb28L79bH1+IP1U6ZmmWFEQggw9iJ/NzCF+F7raw==
X-Received: by 2002:a17:903:32d0:b0:1df:ffe3:f787 with SMTP id i16-20020a17090332d000b001dfffe3f787mr6939579plr.48.1711040691789;
        Thu, 21 Mar 2024 10:04:51 -0700 (PDT)
Received: from localhost ([117.147.31.37])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902c70a00b001dfffed6058sm59809plp.64.2024.03.21.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 10:04:51 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH] libbpf: add specific btf name info when do core
Date: Fri, 22 Mar 2024 01:04:44 +0800
Message-Id: <20240321170444.388225-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changed, just add specific btf name when core info
print, maybe it seems more understandable.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index afd09571c482..b32154288b4a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5653,7 +5653,8 @@ static int load_module_btfs(struct bpf_object *obj)
 }
 
 static struct bpf_core_cand_list *
-bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 local_type_id)
+bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 local_type_id,
+		    const char *targ_btf_path)
 {
 	struct bpf_core_cand local_cand = {};
 	struct bpf_core_cand_list *cands;
@@ -5680,7 +5681,8 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
 
 	/* Attempt to find target candidates in vmlinux BTF first */
 	main_btf = obj->btf_vmlinux_override ?: obj->btf_vmlinux;
-	err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf, "vmlinux", 1, cands);
+	err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf,
+				 targ_btf_path ?: "vmlinux", 1, cands);
 	if (err)
 		goto err_out;
 
@@ -5793,7 +5795,8 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 				 int relo_idx,
 				 const struct btf *local_btf,
 				 struct hashmap *cand_cache,
-				 struct bpf_core_relo_res *targ_res)
+				 struct bpf_core_relo_res *targ_res,
+				 const char *targ_btf_path)
 {
 	struct bpf_core_spec specs_scratch[3] = {};
 	struct bpf_core_cand_list *cands = NULL;
@@ -5813,7 +5816,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
 	    !hashmap__find(cand_cache, local_id, &cands)) {
-		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
+		cands = bpf_core_find_cands(prog->obj, local_btf, local_id, targ_btf_path);
 		if (IS_ERR(cands)) {
 			pr_warn("prog '%s': relo #%d: target candidate search failed for [%d] %s %s: %ld\n",
 				prog_name, relo_idx, local_id, btf_kind_str(local_type),
@@ -5920,7 +5923,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			if (prog->obj->gen_loader)
 				continue;
 
-			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
+			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res,
+						    targ_btf_path);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
 					prog->name, i, err);
-- 
2.34.1


