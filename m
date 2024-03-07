Return-Path: <linux-kernel+bounces-95975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F4875589
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C01F21569
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E7130E23;
	Thu,  7 Mar 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSwh0OUa"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA9130E46
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833853; cv=none; b=sNeRB6DDMfc+cDIXTByLwVKIQ5TSxcgmmcqemRkeI5OcXKP67KfmXeOx3GKbt77110qS1ENnm9xdCviGYLVLq9luEshOPp3wI+nuu3Padlx0bH/GJEUmb7CpeEt1avFYN83YZ4J4th0eDHJuxINb0lS2ygCW/jwWXvZYyH2syxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833853; c=relaxed/simple;
	bh=yVR9gOO591PhdWNViVKaVO3Dc6HRM0Gnaf6jh1DBhVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC4jP5b+ARAvzU6EBEAXB/1oOMc1AVfHwSKXsSvS8Nvm6zVSjNAj2qDA0GYtAOoTsIAi8EzXaW/5/fOuB0iyJtWwX4GXK5CEGPnujcYYCtSr9w4JqsYAlb/Qc6FyeYxzaL6+wNsVm4N/jEKHMvGryIJ9H/lo+2UYaL+AzASL/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSwh0OUa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so747023a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709833851; x=1710438651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nud+ektoz1i5+ZtYiRnd5giJ9AEuUsNnJvPUlZgCtfQ=;
        b=QSwh0OUaz3F/caLmBiRHZEM2n/J5MKBeWfED7pHvKDqbyxoAdrgFM2oRUvP56pdcKZ
         MWjSIHRrmZTYUKSQSt7xu53TptDfjwYo3LQjS/vQ7rreTaH6+ZCCi8gL2vKElAFvsISw
         dxqxGSrmxx7ekU2xgvk4mteFICIXpNM1KE7bPg7IAWcDlmhbr2QR/G5HA6ZvFZSeM/+u
         mX3p0t7UWrbPQm0QlB9xYSvF0TBXYmga//A7S4C76iHs6JyuZUsTWN8wE0pXIgFEQ06S
         SLapaeRXwONnb6YPcxf+WyI3ZbLU6avAWEmM6REcBvEbIQYEUBsTrIOBX8j8Cv94B/5F
         qQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833851; x=1710438651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nud+ektoz1i5+ZtYiRnd5giJ9AEuUsNnJvPUlZgCtfQ=;
        b=alZD/nrRW3MO61MTlNLiaXIlZScL1bYZqxV0Um1M44RYuVvA4k/4DxFUlXcfBAQpUR
         oYilVPAJ9Fpj2Y7SmsDwMqF3z4m8Gjaq9qdVZGK5xQTmhnz7rsZIabX+NYjWzTx+p1yg
         oUwh/Eal1IIQjv5g7UkGfoCvN6DJpwn3AyPUNy/sV+PWWo0OKXMIn3IngbkNIJsK9YgS
         tIMQEgXJ8CEV8KRdDmEaImL3PVSiaSZ+HDj0XtVAgujLrDHPwb07X4pZKeuJrWf0Qa2J
         zeYWwpY6I57b5l6WQavM20G7T+xTfApXYq3IvVo7y2N24YNPVypTuNHE3PL42/Zjqlzh
         NWtw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Y3K95ByYQct9bGS0fx7Rfy2SgJSvjOnbHi4agTMzVelwBapu2MMrzuYzYMi79cmzlcWzaB8+w18P4BHs0A7eVe8anvU4ejfH/ePM
X-Gm-Message-State: AOJu0YyA2lRAmd74CtYBvwlcDQD7NHnYYyY0F1suMY5NF6amVPYM+bOh
	V4EvyO2XP2bIrX68SDMvH4zqpPgUAxZF0VEPfdnzJ1eE/DUUiw+GolP5r/egR+XIt7HaYLvQjTg
	R97327sDbCr0PqkXiJy/iTAdymHY=
X-Google-Smtp-Source: AGHT+IF0ZQ7HwQ4D2qXgjsxk5AzG+wH4I16G7HlIBJ4RSrb5zXyfkpc/TeQ2+/kJOtwWh242uLtu1diULqr1GHqH9UM=
X-Received: by 2002:a17:90a:d58a:b0:29a:2860:28b9 with SMTP id
 v10-20020a17090ad58a00b0029a286028b9mr15805875pju.48.1709833851221; Thu, 07
 Mar 2024 09:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024030645-CVE-2023-52592-4693@gregkh> <ZemPuxhM_ZZ-khTh@tiehlicka>
 <2024030706-unscathed-wilt-e310@gregkh>
In-Reply-To: <2024030706-unscathed-wilt-e310@gregkh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Mar 2024 09:50:38 -0800
Message-ID: <CAEf4BzbvmwmAmZMvzo9gxyUwy9SQvC_2gFQ1wO-Zvw=9BT=J2g@mail.gmail.com>
Subject: Re: CVE-2023-52592: libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 07, 2024 at 10:58:19AM +0100, Michal Hocko wrote:
> > On Wed 06-03-24 06:45:50, Greg KH wrote:
> > > Description
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >
> > > libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relo=
s
> > >
> > > An issue occurred while reading an ELF file in libbpf.c during fuzzin=
g:
> > >
> > >     Program received signal SIGSEGV, Segmentation fault.
> > >     0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.=
c:4206
> > >     4206 in libbpf.c
> > >     (gdb) bt
> > >     #0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libb=
pf.c:4206
> > >     #1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:=
6706
> > >     #2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
> > >     #3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> > >     #4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-ob=
ject-fuzzer.c:16
> > >     #5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_on=
e ()
> > >     #6 0x000000000087ad92 in tracing::span::Span::in_scope ()
> > >     #7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir =
()
> > >     #8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{cl=
osure}} ()
> > >     #9 0x00000000005f2601 in main ()
> > >     (gdb)
> > >
> > > scn_data was null at this code(tools/lib/bpf/src/libbpf.c):
> > >
> > >     if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >=3D scn_data->d=
_size) {
> > >
> > > The scn_data is derived from the code above:
> > >
> > >     scn =3D elf_sec_by_idx(obj, sec_idx);
> > >     scn_data =3D elf_sec_data(obj, scn);
> > >
> > >     relo_sec_name =3D elf_sec_str(obj, shdr->sh_name);
> > >     sec_name =3D elf_sec_name(obj, scn);
> > >     if (!relo_sec_name || !sec_name)// don't check whether scn_data i=
s NULL
> > >             return -EINVAL;
> > >
> > > In certain special scenarios, such as reading a malformed ELF file,
> > > it is possible that scn_data may be a null pointer
> > >
> > > The Linux kernel CVE team has assigned CVE-2023-52592 to this issue.
> >
> > OK, so this one is quite interesting. This is a userspace tooling
> > gaining a kernel CVE. Is this just an omission or is this really
> > expected.
>
> "omission"?  I don't understand the question.
>
> We are responsible for assigning CVEs to stuff that is in the "Linux
> kernel source tree" (some have tried to get us to assign CVEs to
> programs like git that are just hosted on kernel.org), so for now, yes,
> this includes libbpf as well as stuff like perf.
>
> > Also what is the security threat model here? If a malformed ELF file is
> > loaded then the process gets SEGV which is perfectly reasonable thing t=
o
> > do.
>
> Again, we do not do "threat modeling", we do "does this fix a weakness",
> and I think this does as causing SEGV might not be a good thing, right?
>
> But we'll defer to the libbpf maintainers on this, if they feel this is
> just a "normal bugfix" then we can revoke this (added them to the cc:
> here.)

Libbpf isn't meant to be fed untrusted ELF files, as it's normally
used under root to perform BPF operations. So we generally treat these
issues of malformed ELF crashing libbpf as just normal bugs, not as a
security vulnerability. We even had issues where libelf crashed before
libbpf could do anything at all. But this happens only for
fuzzer-generated artificial test cases. In practice compilers produce
valid ELFs and that's what real world applications are ever going to
use.

Also note, in-kernel libbpf sources are only used for kernel
build-time tooling (resolve_btfids) and for running BPF selftests. In
both cases incoming ELF files are valid and created in a controlled
environment. All the out-of-kernel users are supposed to use Github
mirror of libbpf ([0]), which is used for packing libbpf in distros.

tl;dr: I wouldn't assign CVE for such issues, thanks.

  [0] https://github.com/libbpf/libbpf

>
> thanks,
>
> greg k-h

