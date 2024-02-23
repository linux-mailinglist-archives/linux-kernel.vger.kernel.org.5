Return-Path: <linux-kernel+bounces-79109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14C4861DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508121F27AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D6146E6E;
	Fri, 23 Feb 2024 20:34:55 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3F10A11;
	Fri, 23 Feb 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720494; cv=none; b=mRUCSLzJD3sVB/UtFQLgxmv2Y7Ph5PzjPdukZRzMzNShVUg+Jd2+dN4Q3Xo7Ml3sIyLwAH/oRqelmzrePfeMsPQDBHAJbGqDlShkquOzwx9GWvfEp57/hr7hsbE91w/CVNCH7fmm7dRduIEZyuGvStixZilr3wgmXtyk90Nuav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720494; c=relaxed/simple;
	bh=rPPJ2L/RRzBV/p4jhRpBz6hSBChY4V2Ci3lmwX/T1Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3dr9FIj/ojNr41OTRbT6RWf0SUYIvaPMfy+KqawQ+7ozEfejLWV4CaVNqSC9B4B41p6mcluay8A2c0B2I1nR7SzJJA+4n4tf8DXQziK5a6/Zyxq7BOfpw2y7oraUPKPql3xiWOtjiNhnwV8qO1D47akMBapt8YhMk06Un/uPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2997cb49711so468083a91.3;
        Fri, 23 Feb 2024 12:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720492; x=1709325292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcSK7lktycGUq3TCMwXiTLhn36wJtNMvHXvTtj8Eb6M=;
        b=dLajL/0cv/bGP6S5nvXVjNKW9L0Om3naJ9nBiLut53DYT1mNEyxF7avwhi15yruwsj
         oiSkuvfiScLjv3YuWXmU3x7WmieJzMMIvTuUd49QUgwM6Uio5QfJnvRFXNkl1ZyeW3ej
         chkORGrJ5ccuMSXXS13hY3ijq0EtYpNPUZFandxJgXz4IuFu5d6lQKLfs8Z5xVR1QGNB
         ++D91wExL+odTy378SRhSLn5rZFQnZXJpl2FNi6C3i6oT+Wx6UEcy/Lx/ykCiWkNEvZG
         C/rOJk8pcrrxcCG3Ytqo1hFBlljHVdEqNHnylIcqAa/B5XBf1QqyCbZBmGviP5OH9ZPS
         OZPA==
X-Forwarded-Encrypted: i=1; AJvYcCWDjnBt5vFMVAvKZDP9boRdhjd99YGki59BcFJoW75Yj8e463aV1VgIwVomQDbmPRM6HEbHtRndzSuulpRYK9ges94sOjHzJNYm5N2CVlCNf/rl5oLZRCBD9yNOf/qsGiy1RTtPsp+A1Q==
X-Gm-Message-State: AOJu0YzV+cSL9RG7r7ZCAdT7NE7yEihkc8rjKFOQslutISn7c66TWXk/
	WDtF1t7hAHE4scRPsMGPp20bpEJIy5wq/KZMwNn3F7Gmpb/wVJpT/CHYI26ybLpNIsJYhDvPVhk
	GWp72YpKAduuXw3zcbrH77BXiLLZCdpl7ZNg=
X-Google-Smtp-Source: AGHT+IFOdigC3SxxyWtae1xXbC4lmWhve0smF+kir/IdQxFCJuiP1g7uHgs3wF+fLU5mUnBfTqBljCR9WoNG3oTobxs=
X-Received: by 2002:a17:90a:420b:b0:29a:4239:6893 with SMTP id
 o11-20020a17090a420b00b0029a42396893mr1013909pjg.6.1708720492297; Fri, 23 Feb
 2024 12:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222100656.0a644254@canb.auug.org.au> <Zdj3FyPjE5ezyfsM@x1> <Zdj74Zo10vYTZNMl@x1>
In-Reply-To: <Zdj74Zo10vYTZNMl@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 23 Feb 2024 12:34:40 -0800
Message-ID: <CAM9d7ciaj80QZL0AS_T2HNBdMOyS-j1wBHQSYs=U3kHQimY1mQ@mail.gmail.com>
Subject: Re: [solved] Re: linux-next: build failure after merge of the perf tree
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Fri, Feb 23, 2024 at 12:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Feb 23, 2024 at 04:50:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Feb 22, 2024 at 10:06:56AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the perf tree, today's linux-next build (native perf)
> > > failed like this:
> > >
> > > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid app=
lication of 'sizeof' to an incomplete type 'struct timespec64'
> > >         __u32 size =3D sizeof(struct timespec64);
> > >                      ^     ~~~~~~~~~~~~~~~~~~~
> > > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward decl=
aration of 'struct timespec64'
> > >         __u32 size =3D sizeof(struct timespec64);
> > >                                    ^
> > >
> > > Caused by commit
> > >
> > >   29d16de26df1 ("perf augmented_raw_syscalls.bpf: Move 'struct timesp=
ec64' to vmlinux.h")
> > >
> > > This is a ppc64 le build.
> > >
> > > I have used the perf tree from next-20240221 for today.
> >
> > Ok, finally I managed to secure a ppc64 machine to test this and
> > sometimes I reproduce just like you reported, but sometimes I can't do
> > it, didn't manage to isolate what is that makes it fail sometimes, make
> > -C tools/perf clean, nuking the O=3D target directory, etc, when I
> > reproduce it:
>
> So I think I see the problem, I now left the build directory with a
> previous build from torvalds/master, then switched to the
> perf-tools-branch and tried to build from there, without first removing
> the old build, it fails:
>
>   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_sys=
calls.bpf.o
> util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid applica=
tion of 'sizeof' to an incomplete type 'struct timespec64'
>   329 |         __u32 size =3D sizeof(struct timespec64);
>       |                      ^     ~~~~~~~~~~~~~~~~~~~
> util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declarat=
ion of 'struct timespec64'
>   329 |         __u32 size =3D sizeof(struct timespec64);
>       |                                    ^
> 1 error generated.
> make[2]: *** [Makefile.perf:1161: /tmp/build/perf-tools-next/util/bpf_ske=
l/.tmp/augmented_raw_syscalls.bpf.o] Error 1
> make[1]: *** [Makefile.perf:264: sub-make] Error 2
>
>
> Because it will use what was installed before in the build dir:
>
> [acme@ibm-p9z-16-lp5 perf-tools-next]$ ls -la /tmp/build/perf-tools-next/=
util/bpf_skel/vmlinux.h
> -rw-r--r--. 1 acme acme 4319 Feb 23 14:59 /tmp/build/perf-tools-next/util=
/bpf_skel/vmlinux.h
> [acme@ibm-p9z-16-lp5 perf-tools-next]$
>
> And that one doesn't have 'struct timespec64':
>
> [acme@ibm-p9z-16-lp5 perf-tools-next]$ grep timespec64 /tmp/build/perf-to=
ols-next/util/bpf_skel/vmlinux.h
> [acme@ibm-p9z-16-lp5 perf-tools-next]$
>
> If I remove that directory contents:
>
> [acme@ibm-p9z-16-lp5 perf-tools-next]$ rm -rf /tmp/build/perf-tools-next/
> [acme@ibm-p9z-16-lp5 perf-tools-next]$ mkdir /tmp/build/perf-tools-next/
> [acme@ibm-p9z-16-lp5 perf-tools-next]$
>
> And then try to build again:
>
> make -k O=3D/tmp/build/perf-tools-next/ -C tools/perf install-bin
>
> It works.
>
> I reproduced the problem on x86_64, so, on this transition period, the
> problem happens, probably we need to robustify the installation of
> tools/perf/util/bpf_skel/vmlinux/vmlinux.h in the O=3D target directory,
> but if you just make sure the build directory is clean before trying to
> build it, this time, it should work, wdyt?

Can we add a dependency to the minimal vmlinux.h?

Thanks,
Namhyung

---8<---
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3cecd51b2397..33621114135e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1147,7 +1147,7 @@ ifeq ($(VMLINUX_H),)
   endif
 endif

-$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
+$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) $(VMLINUX_H)
 ifeq ($(VMLINUX_H),)
        $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
 else

