Return-Path: <linux-kernel+bounces-133321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0189A22D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FEE28A4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF0171094;
	Fri,  5 Apr 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzg7iVIh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776416ABC3;
	Fri,  5 Apr 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333566; cv=none; b=oGA9Y7BtyBlBTnhLoHg4Of32F7drTWPPxo5QjhDUbtVM6Sytu9nNBwHvmcvuGCTIVZwHO8WLXl3hyWHSdZIfHUWoZcyUaVZupUl2IpbEek5OFZbBhOCNFyBpMw+WneDuDYmVq+cj9zBh9pKOlmX9ogx29vDqrV6WHF2KZMgWhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333566; c=relaxed/simple;
	bh=rU+WWRBhnpDb+ZVPBQ1akIc9YzS46xtRBAG/iooGCgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLVzsdXAihs1uQWzQIKiqfJnY+aVQ33E2A269uY76EeJH+1zqt/m0J4xsE23wSPtFU0/8DgIKhMwazPVAA649ylUf+J5+hS4PvJ670qN3Gu643wZi9ib7xYw3PEgEVaebAK0CnMg0h3iXD6cOs3ZRMYoqgMHyXuNuR+r6QlO6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzg7iVIh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ff53528ceso1705007f8f.0;
        Fri, 05 Apr 2024 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333563; x=1712938363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUFHJXNP6ohiRivChPDINRMxOHKnXBAWCJDuEaDGAZE=;
        b=Gzg7iVIhHFeDrfYiFc1IgNkzVU2VOm/L2bNquYoeZhBoM2DrG8x+dHVsiDdclE2QDx
         zOeaKoqnUYP8S80wp9J1ZGtDd8iNf+ATr5bLY2o5XDYG7adDkygUQFJMqCnJmJIobyqg
         OxOrF4nQFNmM/CnSjf1OQ3tJD/XybkIKlf0/pJHcU9k9k6d6ZWJ9KcpS0P5tvXMrNFXi
         Qwg0gqTM2tvAChOM4o/ZpudJi/N+0DSFVbHnEZGMGJQObNbPWIzwBo7h81WMILSsdwX9
         byY+rTmr6G+zIbRhcDjiZqsuUYyLnVA52kp9fBFuk/tKaCxwqJhhaCuTnF5YGRdRT1hB
         RdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333563; x=1712938363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUFHJXNP6ohiRivChPDINRMxOHKnXBAWCJDuEaDGAZE=;
        b=DE7oMu5u1WsS+Xy8cH4C1nClI4YGzIV/s1q0FzVVsRS9D0P/Sv3xof3PTWmZDrMeQi
         vWHPw/aSflRfIswIsvV9JpIZNTcRxD/2ccqF8JZdQM5Tz9q9mDrtpgb7wtgBf5+lBsjq
         7gHCBSU5lTwxNYQFEOf81oDgrcoPOuYtcFiDYMAu6GUCPTKc5uE17tDdKpv0HfSeOHD2
         rgv74Xb+YJTBAXvpkV7Kll1GOIUawyr4IndPSeriyCDGwz2X41OxGAsw+Gbx4ch6q3iZ
         Od47pGGhAh0dBebydXLYnpocjqHRkZVikp6d5Nbelx2GJQOIz80URDFXC7Zf2xocoDCh
         piCw==
X-Forwarded-Encrypted: i=1; AJvYcCUQlMGELGR8LgOpbLCdbX1uVWWJxWaXPnj69Do8+2DbsA7/MNxwIwGzRRiwrBydgTPIb50jCKgz/WHlZaNIyQmJZT+FbVugJhXhrsca0pshig55FdNNjuV7wu6mUnhAZYk3
X-Gm-Message-State: AOJu0YzKHSLhMjFEndzoyeKVGZkKgYZP9XXwjCZH0UjSL/DsMv+VxlKe
	P43cA6nz2VmYPd6AXEILyv2CBuJZRDU3rGxIkTNrcwnYiNZXTSDvp9c4rihAzHH/7936pBJ1Nja
	Y3c8dWLiL5UZBrXpDtuCDvIR2Tn4=
X-Google-Smtp-Source: AGHT+IHDzXqsB0ENEHKgEDGCUOYAAZXEOJWZIaAYbWlqfC+cN0ZrmyRYp5VZr8mACDNm8TQInLyYUsp8d7YaYFFkrXo=
X-Received: by 2002:a5d:5225:0:b0:341:ba31:b8ba with SMTP id
 i5-20020a5d5225000000b00341ba31b8bamr1464775wra.57.1712333562610; Fri, 05 Apr
 2024 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e9a8d80615163f2a@google.com> <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
 <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
 <Zg_aTFoC2Pwakyl1@FVFF77S0Q05N> <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
In-Reply-To: <Zg/iGQCDKa9bllyI@shell.armlinux.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Apr 2024 09:12:31 -0700
Message-ID: <CAADnVQ+LKO2Y90DVZ4qQv3dXyuWKkvFqqJ0E_p_=qwscsvnaVg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Puranjay Mohan <puranjay12@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:36=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Apr 05, 2024 at 12:02:36PM +0100, Mark Rutland wrote:
> > On Thu, Apr 04, 2024 at 03:57:04PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Apr 3, 2024 at 6:56=E2=80=AFPM Andrew Morton <akpm@linux-foun=
dationorg> wrote:
> > > >
> > > > On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e6722692=
d86@syzkaller.appspotmail.com> wrote:
> > > >
> > > > > Hello,
> > > >
> > > > Thanks.  Cc: bpf@vger.kernel.org
> > >
> > > I suspect the issue is not on bpf side.
> > > Looks like the bug is somewhere in arm32 bits.
> > > copy_from_kernel_nofault() is called from lots of places.
> > > bpf is just one user that is easy for syzbot to fuzz.
> > > Interestingly arm defines copy_from_kernel_nofault_allowed()
> > > that should have filtered out user addresses.
> > > In this case ffffffe9 is probably a kernel address?
> >
> > It's at the end of the kernel range, and it's ERR_PTR(-EINVAL).
> >
> > 0xffffffe9 is -0x16, which is -22, which is -EINVAL.
> >
> > > But the kernel is doing a write?
> > > Which makes no sense, since copy_from_kernel_nofault is probe reading=
.
> >
> > It makes perfect sense; the read from 'src' happened, then the kernel t=
ries to
> > write the result to 'dst', and that aligns with the disassembly in the =
report
> > below, which I beleive is:
> >
> >      8: e4942000        ldr     r2, [r4], #0  <-- Read of 'src', fault =
fixup is elsewhere
> >      c: e3530000        cmp     r3, #0
> >   * 10: e5852000        str     r2, [r5]      <-- Write to 'dst'
> >
> > As above, it looks like 'dst' is ERR_PTR(-EINVAL).
> >
> > Are you certain that BPF is passing a sane value for 'dst'? Where does =
that
> > come from in the first place?
>
> It looks to me like it gets passed in from the BPF program, and the
> "type" for the argument is set to ARG_PTR_TO_UNINIT_MEM. What that
> means for validation purposes, I've no idea, I'm not a BPF hacker.
>
> Obviously, if BPF is allowing copy_from_kernel_nofault() to be passed
> an arbitary destination address, that would be a huge security hole.

If that's the case that's indeed a giant security hole,
but I doubt it. We would be crashing other archs as well.
I cannot really tell whether arm32 JIT is on.
If it is, it's likely a bug there.
Puranjay,
could you please take a look.

