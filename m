Return-Path: <linux-kernel+bounces-106392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD487EDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944F0283A33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6694454BE1;
	Mon, 18 Mar 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sj/4pM/O"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32F52F6E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780464; cv=none; b=T5hdUd1UtqqYJoYoVzOCI06nZsty/9/dWji5y5qWRRdUsu5JTqcPJbAd/8OrHgaulNtZ41uznwGLIjJBZy5NELgfKFMFskkyuuQvamt5g0YFynDocFdlPZ/ajE0/PK8IslxAcK/Nrr0aIjwEGobZEkxovFsVC8Wazom8gbHEgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780464; c=relaxed/simple;
	bh=2KRhCZz/uSPQoTKLxaJ1IgbzSJtrA34u3Mz24bBvxhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRjw8h3KvB/L5zasjXGFaQXijT0NDq9lhA4pi+F1m/poWIn9mkUfzFlx5CS+B6dg9eyF3Hh4pqWMuWo7TSko5klNSDF1zYrHuJLSF0Ox43J9iC7ZnHKvz10uSly/C2pT8hsiXy2EMYScbqiTxZlEfv7g2/KblzVhp8um89+A9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sj/4pM/O; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3438714a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710780462; x=1711385262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tciC+72lNO2/RHNfK0tZAqNDfMQbukWuw4O4aZHQZuI=;
        b=sj/4pM/OblBkFVe3dh+F+cLh/DmUhEcef9K1BLkVCfOxsXydOhrHLasAEI+naniTja
         vh/askAJOmpKmByNmsUNd3ClvVindJ3OFaG7x2lljftPE9VGTda0bnDLPEQpoSLSbNmE
         bljZXQTSys9iMsp9On5HTjgHn0JBLj+pnFioycyrQ0E139kH4nhzuOeNHlzyRDJWA8wk
         A8pE4y50s9CIphh35vob8KamZ4KiEDDPRBCPHoFoEYz2Q1p2claD29ap1xaV16iGQsEe
         tdSHpDmzf/MnUXSbzWYIq8cff6Oihh29j+WqYPtoIuMQdgwA+kYDGORemETn8UsDDepP
         jRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780462; x=1711385262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tciC+72lNO2/RHNfK0tZAqNDfMQbukWuw4O4aZHQZuI=;
        b=RniWh2ld5VkTHqmLuqRtBJ29UkB5ZUj7F9vpgRMA8ujkudkrhuder/nosN4/EVFC0v
         AvC5C9xjV/yCcLD5vzrFD3e1ZWx/9iXzg2Pe0u5DoZQflZaZYGze6zey/Ec20+HcbGma
         +fZXfY7tw0PzXpT9ArUcs3cfyLC9lFkZOmYtaSa/SSoUVfKWWbeem+iPbVp3caZRy5uk
         zkkXYYUXglOSwmtMeWneIRLMtji9q9i8+5z6iB+DNYD4KIavF9tivs1ljS//Jf4k3+l1
         FaZgOe0p3EgLKo9UXPowaOdbysSanYogaqfzjr9N+SaUTM8ldWJHU/UkYxWmnX4bxpt7
         Mekg==
X-Forwarded-Encrypted: i=1; AJvYcCWO4lQ/oK6p+z8Om1UsCpkIxDk+mVgZGpkIaH+eNarhJ8yPU6v8XCmVjMtyrmBP/x4NTeHtPVCKY3oRwtqAncuM72/MKWKe1b1bwZkA
X-Gm-Message-State: AOJu0YzM3LZYfmsZpfX29MudpBExpkz0hJLWQ+i6ueYAdHlVg1D0eD8M
	f3YJw46U9aYuYb2X9UhgasAGbJZGgB5ln8vkShpzdm5ZrsruCjs0bzLNqOZKOUq0dw==
X-Google-Smtp-Source: AGHT+IFZFID2ubnuYDG98tZMvBGxdL8iBAeLt/b23eAn6urwd2N9uaKdLhXjiZFEPcT2wDXaU2C8pc0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:56cb:0:b0:5dc:368f:9855 with SMTP id
 w11-20020a6556cb000000b005dc368f9855mr381pgs.3.1710780462451; Mon, 18 Mar
 2024 09:47:42 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:47:40 -0700
In-Reply-To: <20240318031625.193590-1-zhangmingyi5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240318031625.193590-1-zhangmingyi5@huawei.com>
Message-ID: <ZfhwLIphSEY5IWB6@google.com>
Subject: Re: [PATCH] libbpf: Fix NULL pointer dereference in find_extern_btf_id
From: Stanislav Fomichev <sdf@google.com>
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com, 
	xiesongyang@huawei.com, kongweibin2@huawei.com, liuxin350@huawei.com
Content-Type: text/plain; charset="utf-8"

On 03/18, zhangmingyi wrote:
> From: Mingyi Zhang <zhangmingyi5@huawei.com>
> 
> During our fuzz testing, we encountered the following error:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000005915bb in __interceptor_strcmp.part.0 ()
> (gdb) bt
>     #0  0x00000000005915bb in __interceptor_strcmp.part.0 ()
>     #1  0x000000000087dc65 in __wrap_strcmp ()
>     #2  0x0000000000951ded in find_extern_btf_id () at libbpf.c:3508
>     #3  0x000000000094d7a1 in bpf_object.collect_externs () at libbpf.c:3712
>     #4  0x000000000092be3b in bpf_object_open () at libbpf.c:7433
>     #5  0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
>     #6  0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
>     #7  0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
>     #8  0x000000000087ad92 in tracing::span::Span::in_scope ()
>     #9  0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
>     #10 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
>     #11 0x00000000005f2601 in main ()
> (gdb)
> 
> tname = btf__name_by_offset(btf, t->name_off);
> if (strcmp(tname, ext_name))
>         continue;
> 
> tname is passed directly into strcmp without a null pointer check.
> When t(btf_type)->name_off >= btf->hdr->str_len, tname is NULL. normally,
> that's not likely to happen.
> Considering that the bpf_object__open_mem interface is a direct API
> provided to users, which reads directly from memory. There may be an
> input similar to this fuzzing, leading to a Segmentation fault.

Are you trying to parse completely bogus elf obj files?
I don't think we have been hardening against those cases. I see
a bunch of other places where we assume the return of btf__name_by_offset
is non-null. Do we need to audit all those places as well?

