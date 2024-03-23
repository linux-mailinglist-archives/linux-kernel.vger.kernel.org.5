Return-Path: <linux-kernel+bounces-112461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE2E887A22
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EDF1C20BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78D59165;
	Sat, 23 Mar 2024 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAc0XgNl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7241A85;
	Sat, 23 Mar 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221200; cv=none; b=XxIUdMxmasrFJ4ikKwvBfgcd02CTjZEh3tJsH+hbMG3iVHb5+h2pq86rAkZ+PleOSNvh3t29OcZ8xXxJpPKoY6ZBEgmsEz9A1zlG6NzInkW/UF2vG8tgO2/B9MRvRRhle2kXrGoi6pHqi2cykTQNJ3WAcvCQnUR6cbsLIypJI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221200; c=relaxed/simple;
	bh=zHRblCkiuo8/H4paSUgyFpR9Eg5vekpRlutX0CYazKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udQ9ZdaWx8wCQ6tWmg0+dObAIbrPfaXvYuOaQgEV93bty/eCgZPgwjnSPiYJUeeh1OrCmRUkmY6ihA/0/+cICFFT0F9EnTWmss+3AlcTDoPIpk1hGNwsRS00gI1TQ3tfv8Gk05JJ+eBaXAB5W5Ws/4RQ83Qeip/mJ5Pf/iO3XBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAc0XgNl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41482aa8237so3912795e9.2;
        Sat, 23 Mar 2024 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711221197; x=1711825997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQAPf2oDxn8ACJCwdYBh/RfidZ+NxZc7Gv33EcxYc4E=;
        b=bAc0XgNlVZo/28gH6CURHUVSJ/JNONJ6f3LkduoXWYrdOgRfJwNuq2u6LLILUm2KgQ
         xkLG6r/4YWW5MZdhWM0UTER6+cm7Z1JPVbK1ixGcqmTAh3PzreAm6p099xXQNFwuhBSd
         LATHEIuTJkYqtlZYnGeewkAXXtFtKRJpOp1+F7LUHKLnUZP3coyTIYuutqf2x7OuiVQH
         W2bLSrbxAMVvjQsCkGXJ9IJxAXc40AtTi5vJrGk+ue4SVsfVLNA2VbpFi/N5aonWZbaJ
         LdN9H3iipkgb9AlhQkWMxqYNGSn4NxvG1P3G5+e961fIHanTO2Bk6hFzzaZw1Ib3cvp1
         sZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711221197; x=1711825997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQAPf2oDxn8ACJCwdYBh/RfidZ+NxZc7Gv33EcxYc4E=;
        b=eCbs2t1RBUXvWC62QG8ea81qywKY6q20UuCRYZRlO4XCtkPpEICLi1s/Jty9a9Ze54
         DdRQNJIug9ivSFU3MwVMIqGqwjZTrfDWcUvC05WXVSzy8SXgO4pYpHpVLiBz/Y4aJHhR
         EZ29FSa1F353uhn/BwwIwAOi+tYVuuhog+5gBFnaOkZc75xRSngSXKVSXL1wRr+YzdO6
         MHS1bCyv7ywfkfFeVP8ljPkZc/wPWPPYHSCnyD+rr2PxPeijpov02ccTCro9SxUQJroh
         3TXW6cQYT8O4eLOULSHp6yeExQaQCUvBHNs8HCp13gzm3/XtePD1TSCSFQyCm3IskrII
         bQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1YiU/r5IUc0JKUVSIA4CAuOGcgjYSJAWU4zGR91of/Sgl5lhoWwBAIRpsZeOmw7NL7UbGtCkl4bv03MycVfhbGxPbBG9vtphGjLqICKYp0hAz7tut7k9MqlpS3SB8pW/FAMmL5AqHuZMxAkPKWF+GdlUoJHzwsW/n
X-Gm-Message-State: AOJu0YwJZUFHmYnusVd4UovHYBCwvWKhGRxW1nzybAfxoQxvuQOzY1Pp
	NwA8jpYdQVMmJ61oWAQO8rCemz1bFhIViugw0hytcFRSkq90X/W4V15sTZM3fNEf/6qC/p8oi2U
	R6/5MsLYwtxdI7kSpTymgonbdf/w=
X-Google-Smtp-Source: AGHT+IGo47dPiuvVsByOeK1OBCQLAK2uBJGjcKscF1mmwIUcz7SfQhwIkXechtkvmpac/ySiNdCGjEP//B0jUCW1Lno=
X-Received: by 2002:a05:600c:470a:b0:413:15ec:6f25 with SMTP id
 v10-20020a05600c470a00b0041315ec6f25mr2208645wmo.25.1711221197371; Sat, 23
 Mar 2024 12:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321124640.8870-1-puranjay12@gmail.com> <9f2b63b5-569c-1e00-a635-93d9cd695517@iogearbox.net>
 <mb61p4jcyxq5m.fsf@gmail.com> <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
In-Reply-To: <15ba79e3-14b2-d92e-3f94-e4f5f963e15d@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 12:13:06 -0700
Message-ID: <CAADnVQJhxQV0xBJDWVkTGXJ+XYpsq5kFmMsuMEHBEaqUmkh0iw@mail.gmail.com>
Subject: Re: [PATCH bpf v4] bpf: verifier: prevent userspace memory access
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay12@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:28=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 3/22/24 4:05 PM, Puranjay Mohan wrote:
> [...]
> >>> +           /* Make it impossible to de-reference a userspace address=
 */
> >>> +           if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
> >>> +               (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
> >>> +                BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX)) {
> >>> +                   struct bpf_insn *patch =3D &insn_buf[0];
> >>> +                   u64 uaddress_limit =3D bpf_arch_uaddress_limit();
> >>> +
> >>> +                   if (!uaddress_limit)
> >>> +                           goto next_insn;
> >>> +
> >>> +                   *patch++ =3D BPF_MOV64_REG(BPF_REG_AX, insn->src_=
reg);
> >>> +                   if (insn->off)
> >>> +                           *patch++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_R=
EG_AX, insn->off);
> >>> +                   *patch++ =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 3=
2);
> >>> +                   *patch++ =3D BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uad=
dress_limit >> 32, 2);
> >>> +                   *patch++ =3D *insn;
> >>> +                   *patch++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> >>> +                   *patch++ =3D BPF_MOV64_IMM(insn->dst_reg, 0);
> >>
> >> But how does this address other cases where we could fault e.g. non-ca=
nonical,
> >> vsyscall page, etc? Technically, we would have to call to copy_from_ke=
rnel_nofault_allowed()
> >> to really address all the cases aside from the overflow (good catch bt=
w!) where kernel
> >> turns into user address.
> >
> > So, we are trying to ~simulate a call to
> > copy_from_kernel_nofault_allowed() here. If the address under
> > consideration is below TASK_SIZE (TASK_SIZE + 4GB to be precise) then w=
e
> > skip that load because that address could be mapped by the user.
> >
> > If the address is above TASK_SIZE + 4GB, we allow the load and it could
> > cause a fault if the address is invalid, non-canonical etc. Taking the
> > fault is fine because JIT will add an exception table entry for
> > for that load with BPF_PBOBE_MEM.
>
> Are you sure? I don't think the kernel handles non-canonical fixup.

I believe it handles it fine otherwise our selftest bpf_testmod_return_ptr:
   case 4: return (void *)(1ull << 60);    /* non-canonical and invalid */
would have been crashing for the last 3 years,
since we've been running it.

> > The vsyscall page is special, this approach skips all loads from this
> > page. I am not sure if that is acceptable.
>
> The bpf_probe_read_kernel() does handle it fine via copy_from_kernel_nofa=
ult().
>
> So there is tail risk that BPF_PROBE_* could trigger a crash.

For this patch let's do
return max(TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR)
to cover both with one check?

> Other archs might
> have other quirks, e.g. in case of loongarch it says highest bit set mean=
s kernel
> space.

let's tackle loongarch with whatever quirks it has separately.

