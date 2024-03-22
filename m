Return-Path: <linux-kernel+bounces-111707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA79886FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299E01F231AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8A56763;
	Fri, 22 Mar 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWD9L+bR"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4C53E3D;
	Fri, 22 Mar 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121869; cv=none; b=AFlLgfuJam2V6B1JgFrHQE5aDSLsIatn6UvUj8MubsTScyEApOzjx+o6Tx0KXgL8FA94u9OKLRB3Rl/ibKgWGcFvBuslKwKxSj9bfFl4k7HesZKL+c+drPt7TPlVZnFM7xw9EHQrkuDaST+nN/C8fShAhxQN9kHV2J3oEN39PEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121869; c=relaxed/simple;
	bh=qzAtLWR4uG/zMQJ4/Ed/+W2vNKKDuKxDafwKCEnZqUI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2rl9yd5YMlKghiSYSUSkgxKgZ9scAUmbYEX7WTEB6C9AKOKgRnhAYBVrA0me4oeRQkGmfnFwDF+zK6CKAwzNx8HfXyWiGW8nSEx98LlAV+Ca6+8+ioKR/52ilIeO858WMLmPzzeQdROthO+NvHTYHzs9R9ECoA+n5ca5gcvxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWD9L+bR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4147e907143so2436435e9.0;
        Fri, 22 Mar 2024 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711121866; x=1711726666; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MS4tNqN5q9dWj+4x8Dlm5CxbpEbr8JLgxekArGzXyyY=;
        b=gWD9L+bRiR+6FVn/TqoTT5OzwYzYkA9pVoOZxSjh6n+/ACDG1coTwTKq4AGzQAxzPj
         d7NeZ7FRR3ZkAw1WbLTjhvojxLjfmivXQDXh+rO0kCrrU37rQ6sD5wGKU4S3wBneRray
         COtkW58GuoE8WLEjx4fLpnVhfz7Ygs2PvQZg4FsUQAfDUJwHhV/ykKLFwBlcKWf52ewF
         3otkLSSMq+Wu9Dagp5KMVr9nYUP0svZgpG0yfYGRPD12w5hddwSjnxAntRtQb7I3WvWW
         Z0PCZ7dVOc8uhbRgfMVdBryKeo0bYelvubJUidL+MZmXrLdSDgCoaZXacJ8ED6wI3E1a
         /Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711121866; x=1711726666;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MS4tNqN5q9dWj+4x8Dlm5CxbpEbr8JLgxekArGzXyyY=;
        b=mNeDrbn5NE7dFTlSRFjiRJX4kQu8oWH1wf6OWEVd9iYscBgfoSNmS2unXk1jSiLy+W
         qEACkJ8nwz5CWhNwD5yLV2OEoIKk7DBp9Y00sUCFXEShNewEfFe4zELC6+sU4gM8BTQS
         Nv0+LoYUF7WFpNVwhT7wjxfAUn1NTKclKeKu3GlXVprwheaDwQua4sP5WaIQE2T3wW/m
         WbNIdoJu4SVRzLNTlnXnHXIRGuvhqeYHIrr2i07DG2jXsK1668wF9nbGaApnLFY5FF3v
         sEFfolPiMArkdVmqGxbKlVfduvpqAQeGt5efIERya/lm+ZSUx9VlVSgh64DFpyrH4tlr
         sjXw==
X-Forwarded-Encrypted: i=1; AJvYcCVzjbtWSVEoutzB+YbogDKZMpFdChAimTWogdlYkpEPQzI4Yeh0DVeGvbwxYskxbNG4m9rN7MMnWPutn6ATe6lbV6odCcNqFsOmOxEvyScZv4tXd9LU98319XuVFivsfcC9
X-Gm-Message-State: AOJu0YyW1QVWvdzvpRKgofBtPVoagAEUznICV+sum9kcD7DpvNqFL0mh
	qadMyqKewa2ANE5ceDcBFuH2IqHUuOmjNrj73KIRtWle0f2r1Sa8
X-Google-Smtp-Source: AGHT+IGNKvIOVPGwG4lgNEbYfQOdJ2P5rE9Hv5fMSBgCsjfpyUD+q+3Q5qSdMHJhExZxC3kT0iRsHg==
X-Received: by 2002:a05:600c:5487:b0:414:92e:3b81 with SMTP id iv7-20020a05600c548700b00414092e3b81mr1885946wmb.3.1711121865645;
        Fri, 22 Mar 2024 08:37:45 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id jh2-20020a05600ca08200b004146dd6bfe2sm3322444wmb.47.2024.03.22.08.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 08:37:45 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf] bpf: verifier: fix NULL pointer dereference in
 do_misc_fixups()
In-Reply-To: <20240322143829.40808-1-puranjay12@gmail.com>
References: <20240322143829.40808-1-puranjay12@gmail.com>
Date: Fri, 22 Mar 2024 15:37:42 +0000
Message-ID: <mb61p1q82xoop.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay12@gmail.com> writes:

> The addr_space_cast instruction is convered to a normal 32 bit mov by the
> verifier if the cast from as(0) to as(1) or if the user has set the flag
> BPF_F_NO_USER_CONV in the arena.
>
> If the BPF program doesn't have an associated arena
> env->prog->aux->arena is NULL and the verifier currently doesn't check
> for it being NULL before accessing map_flags. This can cause a NULL
> pointer dereference:
>
> root@rv-tester:~# ./reproducer
>  Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000030
>  Oops [#1]
>  Modules linked in: sch_fq_codel drm fuse i2c_core drm_panel_orientation_quirks backlight configfs ip_tables x_tables
>  CPU: 2 PID: 265 Comm: reproducer Not tainted 6.8.0 #3
>  Hardware name: riscv-virtio,qemu (DT)
>  epc : do_misc_fixups+0x43c/0x1168
>   ra : bpf_check+0xda8/0x22b6
>  epc : ffffffff8017eeaa ra : ffffffff801936d6 sp : ff200000011bb890
>   gp : ffffffff82293468 tp : ff60000084fcb840 t0 : ff60000084e38048
>   t1 : 0000000000000048 t2 : ff5fffff80000000 s0 : ff200000011bba60
>   s1 : ff2000000101d058 a0 : ff6000008b980000 a1 : 0000000000000004
>   a2 : 00000000000000e1 a3 : 0000000000000001 a4 : 0000000000010000
>   a5 : 0000000000000000 a6 : 0000000000000001 a7 : ff2000000101d000
>   s2 : 0000000000000002 s3 : 0000000000000000 s4 : 0000000000000000
>   s5 : 0000000000000002 s6 : 0000000000000000 s7 : ff6000008b980aa0
>   s8 : 0000000000010005 s9 : 0000000000000004 s10: ff6000008b980000
>   s11: 0000000000000000 t3 : 0000000000002000 t4 : 0000ff0000000000
>   t5 : 00ff000000000000 t6 : ff20000000000000
>  status: 0000000200000120 badaddr: 0000000000000030 cause: 000000000000000d
>  [<ffffffff8017eeaa>] do_misc_fixups+0x43c/0x1168
>  [<ffffffff801936d6>] bpf_check+0xda8/0x22b6
>  [<ffffffff80174b32>] bpf_prog_load+0x486/0x8dc
>  [<ffffffff80176566>] __sys_bpf+0xbd8/0x214e
>  [<ffffffff80177d14>] __riscv_sys_bpf+0x22/0x2a
>  [<ffffffff80d2493a>] do_trap_ecall_u+0x102/0x17c
>  [<ffffffff80d3048c>] ret_from_exception+0x0/0x64
>  Code: b345 9783 0024 4685 8b63 16d7 3783 008d 7f9c 7fdc (5b9c) 83c9
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Fatal exception
>  SMP: stopping secondary CPUs
>
> Add a check for NULL pointer before checking map_flags.
>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/bpf/CABOYnLz09O1+2gGVJuCxd_24a-7UueXzV-Ff+Fr+h5EKFDiYCQ@mail.gmail.com/
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca6cacf7b42f..78945e7b856d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19607,7 +19607,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  	for (i = 0; i < insn_cnt;) {
>  		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
>  			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
> -			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
> +			    (env->prog->aux->arena &&

Kumar made me aware of the fact that env->prog->aux_arena should never
be NULL if the program has an addr_space_cast instruction. This means
that rather than checking for the NULL pointer here and leaving the
addr_space_cast as it is, We should reject programs that contain an
addr_space_cast instruction but don't have an associated arena.

Sent v2 doing the above: https://lore.kernel.org/bpf/20240322153518.11555-1-puranjay12@gmail.com/


