Return-Path: <linux-kernel+bounces-133439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A814D89A3BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206631F23EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18758134AC;
	Fri,  5 Apr 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvF4Uok+"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F716C858;
	Fri,  5 Apr 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339445; cv=none; b=CvMfPYBeyOUtETmbSv/dmc1mpzfWCgymdZxgNG8t1F2Ttvau5B9/a0IwFEkxcB4/+n3oFoa+G221udxCNpb0TE2MY2NEnwZau2NU7OJ4kINOx+piVMs67hLTKx1Objkj/20dB9hCJJ2ILLoijcPzzFTz1luSyC6kXIPuuL2lv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339445; c=relaxed/simple;
	bh=7xRtyC2oGbip6V/1vKy7bPkAqN5vTVKOSEEb4uMls2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWF+wGVTXeCc5NLex4DHYCVHtXgS1UnYh7BmKDYCe65qEzCilD+r+aBCzA5i0cEiwOEqbhHOywt9WrW0OtP1kJhb1/5E5MZVvsdh7y23J3HjREicdud44VK5Hr1V73fvleQYlkXTqwdLrTk74khIIPAT4AzzLsvMjPxjAfTdY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvF4Uok+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1657597a12.0;
        Fri, 05 Apr 2024 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712339443; x=1712944243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NSsPU5M48s4rI658F1csJu8k2YCO+6QQmL+k7+e88M=;
        b=PvF4Uok+dOJP4vQHN8iHxGLSM7qHIVJcMB65S3EP7u/DeY2qk3IwQM0we450MckwT1
         97Uo2d66U9GqGzCkicEg4rDRF/1V0OXhT3YvtYMhUFJ5JqlKeVrl/glfOeIHTX38wBsA
         Lw4R8OBKQi4RGMz2EOMG5B8lBDMDDZrIZeDc2anzQmEIcU9ORG/8w69D8uU3CqO0kAQz
         KjvWh9+XJosevEFjwvga4+24Kox8M3Fzk2XdERKKETKeLz6YABVwjILe3yWbF2lEZ721
         Qwd9c20TQaMC1c7/xol+B6SZzhjlSXy4aeRNItWyYKRveSmw7m1D6JtWv/k7OVdOogDH
         Xy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339443; x=1712944243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NSsPU5M48s4rI658F1csJu8k2YCO+6QQmL+k7+e88M=;
        b=tm0PrMYaq0nglm5iu3zG6IV+gw+rmzabo5PpM/Eq1dH8YtjJBGsoLYbOzuTXYz8Zs0
         Qc7wguV9ysgA/67pBqo7ZNfHooAFI/688NUOZbZk0BHYmChpASoytfXi82vFnYcWu19Z
         LQjg9Pz9VKb+Py6Vu2irP6gZnz6cAFdlwMzpCBpOfhPaC21V1y3cZkWVsT40opZeIUbe
         kaKxGdsk/J3jOMrXdFHIjXWDVwDbMfwziHsqEZALpnUA45ECNHmdLEjNhSSjjqPLjcl3
         3xIfDoYrRo1bVJpqZHT4uBBrYFSkXIrsF0GBzoLigG8gmzlat+L5/A1fkzhlmY3gAQvN
         t3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVcgXqaCfR+2z55tugPubpeH/JgabwFfTvB+cvM8RtUdpr3/5zg/KT/q354EIYwkWkK0x1DcoXGdOWHJECJYN83L+a9FvletiJWmVPVRjLmNuRcjYX9FDoQ8q4AYlT6BUkV
X-Gm-Message-State: AOJu0YzVYyyYSaDv/d+LlTqXBFZx7IQIkMHdheVICLgEnBGXrnqxP1/W
	nmdPuaSFvc5sTPMLc8ZyIiAdWWVFxdFv/WFOv0kHyAbu7/lmfbhwciqFv7FEJiMeNcI7YnU8z7J
	In0AIS/mb4GQgKurm4Tc1D4nOVoI=
X-Google-Smtp-Source: AGHT+IHKQ+e01QOfkUkTera7rsG656oXJGAD0wnuG6VEuN3Uejzja8J1dcKtLGIYjOdUs+eEZNSEyCxHzHghnqJZ6D4=
X-Received: by 2002:a17:90a:eacf:b0:2a0:39e8:91b5 with SMTP id
 ev15-20020a17090aeacf00b002a039e891b5mr2134652pjb.33.1712339443199; Fri, 05
 Apr 2024 10:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e9a8d80615163f2a@google.com> <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N> <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk> <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
In-Reply-To: <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 10:50:30 -0700
Message-ID: <CAEf4BzYNc-cxRu9qEe2DWdCBNwXAvpSBHKtUhXtoEhB_XNc1Gg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Puranjay Mohan <puranjay12@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 9:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 5, 2024 at 4:36=E2=80=AFAM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
> > > On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Apr 3, 2024 at 6:56=E2=80=AFPM Andrew Morton <akpm@linux-fo=
undationorg> wrote:
> > > > >
> > > > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e67226=
92d86@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > > Hello,
> > > > >
> > > > > Thanks.  Cc: bpf@vger.kernel.org
> > > >
> > > > I suspect the issue is not on bpf side.
> > > > Looks like the bug is somewhere in arm32 bits.
> > > > copy_from_kernel_nofault() is called from lots of places.
> > > > bpf is just one user that is easy for syzbot to fuzz.
> > > > Interestingly arm defines copy_from_kernel_nofault_allowed()
> > > > that should have filtered out user addresses.
> > > > In this case ffffffe9 is probably a kernel address?
> > >
> > > It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
> > >
> > > 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
> > >
> > > > But the kernel is doing a write?
> > > > Which makes no sense, since copy_from_kernel_nofault is probe readi=
ng.
> > >
> > > It makes perfect sense; the read from 'src' happened, then the kernel=
 tries to
> > > write the result to 'dst', and that aligns with the disassembly in th=
e report
> > > below, which I beleive is:
> > >
> > >      8: e4942000        ldr     r2, [r4], #0  <-- Read of 'src', faul=
t fixup is elsewhere
> > >      c: e3530000        cmp     r3, #0
> > >   * 10: e5852000        str     r2, [r5]      <-- Write to 'dst'
> > >
> > > As above, it looks like 'dst' is ERR_PTR(-EINVAL).
> > >
> > > Are you certain that BPF is passing a sane value for 'dst'? Where doe=
s that
> > > come from in the first place?
> >
> > It looks to me like it gets passed in from the BPF program, and the
> > "type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
> > means for validation purposes, I've no idea, I'm not a BPF hacker.
> >
> > Obviously, if BPF is allowing copy_from_kernel_nofault() to be passed
> > an arbitary destination address, that would be a huge security hole.
>
> If that's the case that's indeed a giant security hole,
> but I doubt it. We would be crashing other archs as well.
> I cannot really tell whether arm32 JIT is on.
> If it is, it's likely a bug there.
> Puranjay,
> could you please take a look.
>

I dumped the BPF program that repro.c is loading, it works on x86-64
and there is nothing special there. We are probe-reading 5 bytes from
somewhere into the stack. Everything is unaligned here, but stays
within a well-defined memory slot.

Note the r3 =3D (s8)r1, that's a new-ish thing, maybe bug is somewhere
there (but then it would be JIT, not verifier itself)

   0: (7a) *(u64 *)(r10 -8) =3D 896542069
   1: (bf) r1 =3D r10
   2: (07) r1 +=3D -7
   3: (b7) r2 =3D 5
   4: (bf) r3 =3D (s8)r1
   5: (85) call bpf_probe_read_kernel#-72390
   6: (b7) r0 =3D 0
   7: (95) exit

