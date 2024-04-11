Return-Path: <linux-kernel+bounces-139636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B338A059E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139F71C228A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76A605CD;
	Thu, 11 Apr 2024 01:38:49 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C47651AE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799528; cv=none; b=T9PDGoHMWwtyxoilQ4NUueL3+IYc/wjEGp1l7m4zF8IcRYnmroSqiFGBbF5JEhRSgF4GxHSpuvzKDodNHLK6uB8OttA/MjDtUBEGOinCIle29hKoYUy/muYj7h8TwPqTnQGgCkVkdFL84uNqBS3t3j1Fx4bCYzweNnifGwBi6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799528; c=relaxed/simple;
	bh=MCCB7pBGruwYdMlJw665wOkukt6AwC+vb1JVK5cpg54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu1SL882ZT84GnENdvFPEw+Gaz/BWDVf1TWGDWHBFprhEt6W/W5dY+Q+4XzoHwuIpth9ClVDmpoSR5QqLyl/1ov/ya0zHU+PBgNPVwKFTsmQdH70o3+leoVU1iIDCF8gqYadPUCCSNitWjqyBCmOQdtrqFVFm/CEW/ZlGNiJn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so4530002a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712799525; x=1713404325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5DCUyb/Xc4qjbfnJ52wsfA9f/5eaB6rvPGsloDB4HU=;
        b=ZCN5BMQQTbCgkQhW7iSFlvidN6AknkEXi64MwDFUTQs3hLVYsio9MmxiZb48G4j3WV
         GuwVAZ7B4kgXunbWhfzRppJgbHJyKwUP5HIb53I/esbui1BpoIfq+pQYGk3Ky0as9FB5
         cBvqeXidlhg4cmXkcPw6UYdifZRIk1Dg0pp5KYbGvBIp6xKsb9daUaHdVk/8/6dvL+Gx
         Sfl0+dNWbBXXUYGFQ4roThd30v1K7q3afsGiAnm5Oe8IFxzjhi1LA5Fn3wmPb1ANlYTU
         JWtVseUHp6N2YPuhXmdvY6XMQG+Uk0DBWJKJ7B6tA9IwUfhk+6N8Gd5FZGFwuux45tEs
         x7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Rt7utiPcLDopRIe/dawtL6/2d4B58lLwNZNteyYpnbDpNoPxBdHt6enm/UzPTHqOjZ/02myOgnaUaMtnjMMM1cQob6OOyV1glHxE
X-Gm-Message-State: AOJu0YzPd/7OvaHQZtKu+HThGxvYblXhSbKSBO7LXHF0z3fnQq/CU8Wy
	1lPaNSUcrcYu6JLTje7GXZ8+lJqL/dVHKhmQ/FV5F/9lkFftZb3ub6qV+VxBsP4=
X-Google-Smtp-Source: AGHT+IHlaMb30HuScqnrEz767lWtRNTajx92t6GUFBO//6OL93ng5PArwmzrPJc7q6qWQgovsEKeGw==
X-Received: by 2002:a50:d7c6:0:b0:56e:2b31:b111 with SMTP id m6-20020a50d7c6000000b0056e2b31b111mr2978473edj.7.1712799524804;
        Wed, 10 Apr 2024 18:38:44 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id dd15-20020a056402312f00b005689bfe2688sm208271edb.39.2024.04.10.18.38.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 18:38:44 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so849182366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:38:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDaalCiw2UemOpZyCojOBkv7qzNd+VF0EqbUAgdXkJc7Zz6s8+xSF59KTV8oZcax5yl3n1xNjm/JCu6x7BV8ooqea1wL7OD6/96INw
X-Received: by 2002:a17:906:cb8a:b0:a51:d7c8:300c with SMTP id
 mf10-20020a170906cb8a00b00a51d7c8300cmr2914356ejb.17.1712799503901; Wed, 10
 Apr 2024 18:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
In-Reply-To: <20240411-tso-v1-0-754f11abfbff@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 10 Apr 2024 21:37:47 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8Y8+n5N-vLh0icELgWm+L1eRchqxX28Hg_mi9Bam+xRA@mail.gmail.com>
Message-ID: <CAEg-Je8Y8+n5N-vLh0icELgWm+L1eRchqxX28Hg_mi9Bam+xRA@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Hector Martin <marcan@marcan.st>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
	Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>, 
	Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>, 
	Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Florent Revest <revest@chromium.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
	Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>, 
	Zev Weiss <zev@bewilderbeest.net>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:51=E2=80=AFPM Hector Martin <marcan@marcan.st> wr=
ote:
>
> x86 CPUs implement a stricter memory modern than ARM64 (TSO). For this
> reason, x86 emulation on baseline ARM64 systems requires very expensive
> memory model emulation. Having hardware that supports this natively is
> therefore very attractive. Such hardware, in fact, exists. This series
> adds support for userspace to identify when TSO is available and
> toggle it on, if supported.
>
> Some ARM64 CPUs intrinsically implement the TSO memory model, while
> others expose is as an IMPDEF control. Apple Silicon SoCs are in the
> latter category. Using TSO for x86 emulation on chips that support it
> has been shown to provide a massive performance boost [1].
>
> Patch 1 introduces the PR_{SET,GET}_MEM_MODEL userspace control, which
> is initially not implemented for any architectures.
>
> Patch 2 implements it for CPUs which are known, to the best of my
> knowledge, to always implement the TSO memory model unconditionally.
> This uses the cpufeature mechanism to only enable this if *all* cores in
> the system meet the requirements.
>
> Patch 3 adds the scaffolding necesasry to save/restore the ACTLR_EL1
> register across context switches. This register contains IMPDEF flags
> related to CPU execution, and on Apple CPUs this is where the runtime
> TSO toggle bit is implemented. Other CPUs could conceivably benefit from
> this scaffolding if they also use ACTLR_EL1 for things that could
> ostensibly be runtime controlled and context-switched. For this to work,
> ACTLR_EL1 must have a uniform layout across all cores in the system.
>
> Finally, patch 4 implements PR_{SET,GET}_MEM_MODEL for Apple CPUs by
> hooking it up to flip the appropriate ACTLR_EL1 bit when the Apple TSO
> feature is detected (on all CPUs, which also implies the uniform
> ACTLR_EL1 layout).
>
> This series has been brewing in the downstream Asahi Linux tree for a
> while now, and ships to thousands of users. A subset have been using it
> with FEX-Emu, which already supports this feature. This rebase on
> v6.9-rc1 is only build-tested (all intermediate commits with and without
> the config enabled, on ARM64) but I'll update the downstream branch soon
> with this version and get it pushed out to users/testers.
>
> The Apple support works on bare metal and *should* work exactly the same
> way on macOS VMs (as alluded to by Zayd in his independent submission [3]=
),
> though I haven't personally verified this. KVM support for this is left
> for a future patchset.
>
> (Apologies for the large Cc: list; I want to make sure nobody who got
> Cced on Zayd's alternate take is left out of this one.)
>
> [1] https://fex-emu.com/FEX-2306/
> [2] https://github.com/AsahiLinux/linux/tree/bits/220-tso
> [3] https://lore.kernel.org/lkml/20240410211652.16640-1-zayd_qumsieh@appl=
e.com/
>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> To: Marc Zyngier <maz@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> Cc: Zayd Qumsieh <zayd_qumsieh@apple.com>
> Cc: Justin Lu <ih_justin@apple.com>
> Cc: Ryan Houdek <Houdek.Ryan@fex-emu.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Miguel Luis <miguel.luis@oracle.com>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Christoph Paasch <cpaasch@apple.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Dawei Li <dawei.li@shingroup.cn>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Florent Revest <revest@chromium.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Stefan Roesch <shr@devkernel.io>
> Cc: Andy Chiu <andy.chiu@sifive.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Zev Weiss <zev@bewilderbeest.net>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Asahi Linux <asahi@lists.linux.dev>
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Hector Martin (4):
>       prctl: Introduce PR_{SET,GET}_MEM_MODEL
>       arm64: Implement PR_{GET,SET}_MEM_MODEL for always-TSO CPUs
>       arm64: Introduce scaffolding to add ACTLR_EL1 to thread state
>       arm64: Implement Apple IMPDEF TSO memory model control
>
>  arch/arm64/Kconfig                        | 14 ++++++
>  arch/arm64/include/asm/apple_cpufeature.h | 15 +++++++
>  arch/arm64/include/asm/cpufeature.h       | 10 +++++
>  arch/arm64/include/asm/processor.h        |  3 ++
>  arch/arm64/kernel/Makefile                |  3 +-
>  arch/arm64/kernel/cpufeature.c            | 11 ++---
>  arch/arm64/kernel/cpufeature_impdef.c     | 61 +++++++++++++++++++++++++=
+
>  arch/arm64/kernel/process.c               | 71 +++++++++++++++++++++++++=
++++++
>  arch/arm64/kernel/setup.c                 |  8 ++++
>  arch/arm64/tools/cpucaps                  |  2 +
>  include/linux/memory_ordering_model.h     | 11 +++++
>  include/uapi/linux/prctl.h                |  5 +++
>  kernel/sys.c                              | 21 +++++++++
>  13 files changed, 229 insertions(+), 6 deletions(-)
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240411-tso-e86fdceb94b8
>

The series looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

