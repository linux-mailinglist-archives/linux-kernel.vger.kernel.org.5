Return-Path: <linux-kernel+bounces-103605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3987C1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604F01F2217C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6117443A;
	Thu, 14 Mar 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWbCqdJ+"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116236E610;
	Thu, 14 Mar 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436109; cv=none; b=Cty5AXw3jhE3u7s/IVcdLh0gL/myY2nP4wSGCHPTS00yjhDAFXkzYMECB9oXAUwnVaSCKwKqmoIGAxyPVTql8+8BSDSc0I65eWQtMhxkHvZCilrsx3bqUeHWysMY0PFuFEbdDJDSzkxG/HOldtb5WnUQltCjH4EywBtE1zYPz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436109; c=relaxed/simple;
	bh=fbB5AxAdKo0wy6VhS6ZRq9Tyrk+J/JRWJyQZyo4j0PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcIMcfXo2vt3kjxQM5X7FvzZk4TM5Dk5c7uOk/v+6CYBgbD7pfq1ioVdTehw1XT1JCeAjrIhEaqDYQwa3jnJvHGeZx0YfghcMw8qy6fPwjmwrLxbh9zM/okLI2fR3vX79RDDoCHfqimriSqI6I75Ar7pOpNwNwFRVkWMIwq92fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWbCqdJ+; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a466a1f9ea0so153838266b.1;
        Thu, 14 Mar 2024 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710436106; x=1711040906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IRts4rkBVcGeXEcRt2MTupfVX97nL0afashtKjZXc+M=;
        b=eWbCqdJ+B6S19Up1ODitWvyN/nMkT4YZXVBQXXUI+O+rIDc4I9QuhZxtWenPjawxC7
         buIkHMpD8xTaVRb21ZcsGnMSl1waLRixq4YJbHvierpAHlR8KzKYpaZ1FC34qVU48DIh
         fTJII3bBIbl7yk4zQhCxsZqdtTzodDBphkWcvFNWKRhU8hh9uBL8EbaVQfx01qNX7i/t
         s5QWbQ6Hr9JrXc8HJV4PArpQhT7vQLTRFMJHREJIUks9BMfv3oiWjsp4pA9CWVOOOydq
         U7CMtaQcSf+G664QZkpeLS4g1DymymFaYL7z3PTnW7RRC0tcrEM/Av389WIbZ6vdDlgN
         ETkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436106; x=1711040906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRts4rkBVcGeXEcRt2MTupfVX97nL0afashtKjZXc+M=;
        b=sWY+UhbM9Us2xWASdaM0JOmtIRWO4G02Zb065EVFYLjZN0ksBii9Yu+r20F7NoMNgU
         Tf3D4Y1B/ptmZ+g5fUTi4V0lECh2brcBy5c6dxcck+oG+FMdT/lt4KFrJNZQKO0aj2uG
         02Ai4hSB71PKfalBc7vAO1HxY3Sbl7OvstDIu86kWqIQojv74kvMaZXy8GG/TUJzQebA
         ocVQgnjEvzijIYhMvsj1JrlgVbwxvbkcMA1A2x3UoaY07JuGSY8CORrwFfkS+diwNRjW
         +NzHb/DsjSyk+1PdtJrRQbGX7JJBzrYibjKveKn1c6v8C7cjFnRLtufa0AbqckzyWH6z
         xN2w==
X-Forwarded-Encrypted: i=1; AJvYcCU96Etkq+6nzSA72QuH4WwFWoQjkB0CD761HGpOTS2G+54dmFRtGZMjc+cj58XG9u9KKCACg9tKLHere9e0keewqIq/5mOSzFDH+G80Q4H/RtIQmW5tjP8nygMsCZOeojb1
X-Gm-Message-State: AOJu0Ywhg2x5wamqQZVdfncMoL4wR4i5ciKD+6tUEDO79OugDtHE4HyU
	HRD8WX1ymwSa9Mi+AQtRA3zpHbYCbaSenv10lZLHOJudT0/UiAWtnWDBVeyr/6EtftlEilTM9q/
	ZkQgq/N03iOyr5/g+cYofeTHAheY=
X-Google-Smtp-Source: AGHT+IGqCVTYpTv8Odrmbx4dKTarYfQn2vbyLl9wbpot7Qd2LnFnZCO0voyX1zRvnG0tesx5ukz0qToe39rls0zB140=
X-Received: by 2002:aa7:c2c4:0:b0:567:2a22:6e86 with SMTP id
 m4-20020aa7c2c4000000b005672a226e86mr960099edp.22.1710436106036; Thu, 14 Mar
 2024 10:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314150003.123020-1-puranjay12@gmail.com> <20240314150003.123020-2-puranjay12@gmail.com>
In-Reply-To: <20240314150003.123020-2-puranjay12@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 14 Mar 2024 18:07:49 +0100
Message-ID: <CAP01T75tG5tXqRJsMn6iU1xvmEqeuTg=ja=LUPqqXkrJiYL2XQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add arm64 JIT support for PROBE_MEM32
 pseudo instructions.
To: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 16:00, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
> instructions.  They are similar to PROBE_MEM instructions with the
> following differences:
> - PROBE_MEM32 supports store.
> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
>   src/dst register
> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in R28
>   in the prologue). Due to bpf_arena constructions such R28 + reg +
>   off16 access is guaranteed to be within arena virtual range, so no
>   address check at run-time.
> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
>   LDX faults the destination register is zeroed.
>
> To support these on arm64, we do tmp2 = R28 + src/dst reg and then use
> tmp2 as the new src/dst register. This allows us to reuse most of the
> code for normal [LDX | STX | ST].
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---

Hi Alexei,
Puranjay and I were discussing this stuff off list and noticed that
atomic instructions are not handled.
It turns out that will cause a kernel crash right now because the
32-bit offset into arena will be dereferenced directly.

e.g. something like this:

@@ -55,6 +56,7 @@ int arena_list_add(void *ctx)
                test_val++;
                n->value = i;
                arena_sum += i;
+               __sync_fetch_and_add(&arena_sum, 0);
                list_add_head(&n->node, list_head);
        }
 #else

I will try to prepare a fix for the x86 JIT. Puranjay will do the same
for his set.

