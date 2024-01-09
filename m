Return-Path: <linux-kernel+bounces-20421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE75F827E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FD21F24734
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A963CF;
	Tue,  9 Jan 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9LVulfT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F8612E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33687627ad0so2378475f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 22:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704780309; x=1705385109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgmCi2T8RlV9jzAdMCLfEOSGOV4Nrq6cyyUig0fKmGU=;
        b=C9LVulfTnF2k8vrtVnSI8/OewdJMaHZVC+eOpAqeLtDeGlKAi3CTnOM550zQCsMJS1
         wukzHP6UX4WJ1cWOPx+lCpPOHhPdgbOR6BHrYSbZ93zzlxvpkBHjJmVHAyJrwYZez4Hh
         ytg5b8P4kuImTjWJwllWKTWbG7dvYJdFadW8O/ZZF9Co48Fj7P+GRbvXhRmhVihBmzi3
         1j9iqz8na/OVLouHcf9LLyVABCFIJMJnRhBh0HHKkC8IN1NlJ+PlLDCwSwKwg89ra/Xv
         /2TCSBGbk7u+iaC37Cq7Nan87P/sMKY3bq/EKhi+k1k3dgidkN4rz7iOtmzLnS6uZckJ
         qW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780309; x=1705385109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgmCi2T8RlV9jzAdMCLfEOSGOV4Nrq6cyyUig0fKmGU=;
        b=cNpxJcay9+rdT2abcuIaW/gtBx2MDgKRp+J0TJ3uZtvaXQJuiAwv8+HZfXbKQ0/uDz
         UH8DzXuuy/+Wr05wPGiYVmYxlzjqDM1X4SKnOAfU5KM6A9MsruiQdZWV2mzfCNALagU4
         VQDLBpf7TzE6qDDCXDUmcNEbe+8ERjip4O58Fym7Bq352opQPisUktA1RqhKDnvbdYAS
         ZNOKdfWiBHaix0QelBur7NhHshscKAJ98/neTJFgMPAcBLUJHPrdEJHYjCy7cdZCOfuC
         2nkxE3oq7sChssIoPNg8jiGHVqMnZE3MMs3YHYZj4ZEIztJwSWRWtBgQ0t3tyvH2Rm+u
         3Y0g==
X-Gm-Message-State: AOJu0YyxrgQg8F+FqmUXQqrAWBStYmFp6dsyXrUmeMC7VITtligb+ABr
	Bu1iimU5hL8rl57tdwybgImL0MEL9zAnhe8aOcCict+MpY8=
X-Google-Smtp-Source: AGHT+IH0zpm5vmuRa9n/ACK4SI9H3f7AKZvmJ5TJueJvqZzMHXyKCVNUg9jvuF0o/Bk4ZB7LzAaeCdHb8D+jssrgJVI=
X-Received: by 2002:a5d:5f90:0:b0:337:400c:e0b8 with SMTP id
 dr16-20020a5d5f90000000b00337400ce0b8mr239142wrb.98.1704780308462; Mon, 08
 Jan 2024 22:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
 <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
 <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com> <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
In-Reply-To: <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 9 Jan 2024 14:04:57 +0800
Message-ID: <CAJNi4rOU_Mohtam0Zce=tymUy52W_ik4kezNsX-f8on76aX1Rw@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Xi Ruoyao <xry111@xry111.site>
Cc: Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:06=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Tue, 2024-01-09 at 10:55 +0800, richard clark wrote:
> > On Mon, Jan 8, 2024 at 6:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> > >
> > > On Mon, 2024-01-08 at 10:51 +0000, Mark Rutland via Gcc-help wrote:
> > > > > AFAIK, the native build for the kernel will not link to the libc.=
so
> > > > > but the userland application does, the builtin atomic primitives =
are
> > > > > implemented in the glibc:
> > > > > target-host $ objdump -t /lib/aarch64-linux-gnu/libc.so.6 | grep =
__aarch64_cas4
> > > > > 0000000000130950 l     F .text 0000000000000034 __aarch64_cas4_re=
lax
> > > > > 0000000000130a10 l     F .text 0000000000000034 __aarch64_cas4_re=
l
> > > > > 0000000000130990 l     F .text 0000000000000034 __aarch64_cas4_ac=
q
> > > > > seems the '__sync_val_compare_and_swap' used in the application w=
ill
> > > > > be renamed to _aarch64_cas4_{relax, rel, acq}. so the kernel will
> > > > > complain it will
> > > > > link to an 'undefined reference'. But interesting, why the
> > > > > cross-compile kernel will not generate the 'undefined reference',=
 the
> > > > > cross-compile/build kernel will link to the glibc?
> > > >
> > > > This is due to a difference in default options between the two comp=
ilers; the
> > > > kernel isn't linked against libc in either case.
> > >
> > > And even if it's not the kernel but a normal application, it still
> > > cannot use these functions from Glibc as the objdump output contains
> > > "l", meaning these symbols are local symbols and they cannot referred
> > > somewhere out of the libc.so.6 itself.
> > Actually you can call those builtin atomic functions in you normal
> > application without link time error, even execute the output binary in
> > the target machine in case of cross-compile, only if the linked .so is
> > in your target environment.
>
> Because these functions are provided by libgcc.a:
>
> xry111@defiant:~$ objdump -t /usr/lib/gcc/aarch64-unknown-linux-gnu/13.2.=
0/libgcc.a | grep cas
> cas_1_1.o:     file format elf64-littleaarch64
[...]
> 0000000000000000 g     F .text  0000000000000038 .hidden __aarch64_cas1_s=
ync
> cas_2_5.o:     file format elf64-littleaarch64
> 0000000000000000 g     F .text  0000000000000038 .hidden __aarch64_cas2_s=
ync
> cas_4_5.o:     file format elf64-littleaarch64
[...]
>
> It seems libc.so.6 just get these functions from libgcc.a (a hidden
> global symbol becomes local when you link it into a shared library).

I think libgcc.a should be built with '-fvisibility=3Dhidden' option and
hidden symbols, then as you said it will become a local sym when
linked with the libc.so.6.

> But the Linux kernel cannot use neither libc.so nor libgcc.a.  (I know
> some non-Linux kernel developers are overusing libgcc.a for kernels, but
> IMO this is just wrong and Linux developers also do not do this.  If the
> Linux kernel needs a symbol from libgcc the developers just provide
> their own implementation.)
Right, kernel should use its own implementation while not the one from
libc.so...
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

