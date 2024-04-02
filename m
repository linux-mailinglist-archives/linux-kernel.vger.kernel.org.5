Return-Path: <linux-kernel+bounces-128670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C46C895DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F1A283BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B1915E1E4;
	Tue,  2 Apr 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOc34ROE"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF615E1F1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090422; cv=none; b=rrcSn5BXLwRefnpHpbYbexW++1xqJK+ihy4P8vhC/ihehR8PgfT2KnBfx2U3sVMlW8Ato+Aof+uHhLp/YTQugwtkRJu3oejY+lBnkALF+LgUPgi/xFSYyclstItC5Rt6TdcNUt220F5RFbyGdFp/9CTT2jTFw8kHVIW2Ft0CANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090422; c=relaxed/simple;
	bh=SCHDDCPcyDgBF1nzsieyVO4SGQQBPTrWl+HNlOUUYXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVRVw33VZGfcIlnJZWzFV+xnOsMEvTtWGStywkXdlsz6mtpOS7d9REsJnHJfRgzaqCTIWkga1LKoCm0CmsSXNzvWbpUnR5rvNkEtT3JJF3mhg65bTQ3gIAr+MGJOH6W0al5JS57EbK261rs2R3r19EtQfCqpL66Q7htMKWSwK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOc34ROE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d094bc2244so60818391fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712090419; x=1712695219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCHDDCPcyDgBF1nzsieyVO4SGQQBPTrWl+HNlOUUYXs=;
        b=mOc34ROElBvtK/j/ghEzh6Hot6/7LYEpmVhy4b/tXVFxQ6r9r1L00lBUutApX4ElC8
         1kMC4B3Hbx7E4cHLk5KkYa9Yb5H/sHFblC/K6kLns6Y9WrO/fLDgD2/vQXPlQogrhrUi
         jLy1bQ/7zc/btKICHC9yC1HWdQQ4hHG6OZKPUV0beICwT3EZvzB7lvoB6SIE5ttbOywG
         PlKSW63muZKFs1g6E6EWJxYeNIKPPVPkd7B1RNlLFOTl/jm7hSu5Tvl/mAso5DVgn933
         kUUpCSzDp0+Ln7nyveI47/PyvSdDtsMq6533STHSOKLY44wd+AmNWq6TO4i6sXp1rQkr
         uUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090419; x=1712695219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCHDDCPcyDgBF1nzsieyVO4SGQQBPTrWl+HNlOUUYXs=;
        b=U5s6zGgHw9C8aHzb7vbqGtU6oeumDVGEe/JyftzhL2EuXjxmz5rWWAKiyc5sqL6xIw
         +lQFcKcjHVmNBrc8KC1KSFtflBnlP0EoPXq7CZ1dhKcGADKXPLVW+WqjEgupcvnYiJwi
         dA3lB7VmZ4svSLxCoP6qiOJzo8s33bEl189B4FLjLBpJ1xoL0cbdCZ050qO8iXg7OKNC
         7h/UvrcZ5XMdABHNfZGMPU60ebuKE9dN5dqgo4F+0em+wucSw1uLffCweDlk9hSEAmKg
         Ysl9zS8oqEbegLsweR7hXT/DxIMIexxIGMV0uNyM61lIKekmeDy/jhp1HfD1yW+ZShbZ
         Y3zg==
X-Forwarded-Encrypted: i=1; AJvYcCUuOJQRXHF97dYbZNtb7wd2RQHv104CTPPIfuFYyP1i/BiUdX30Xlo7UYzsiDm6LF/xZXNbEN7Luptg9M4dhqF97+JopBzO7fJ8aybE
X-Gm-Message-State: AOJu0Yyt6xHvrTtNS8DLCyRAWhyf/yADtUWL72vptApUymVvg5WoaKdc
	6fO14SzN0Mt5rXrhxDF010+4/qWRblQe9hMAfAg6CxF6IlbhFC9kNoo+VC8WBi3L219eWNzFFvZ
	zh8CrCG0UiL/AKHQDgDftCyBIBsg=
X-Google-Smtp-Source: AGHT+IGi41I5kI37rdJLpcHdRq7kLAPfWuLK29FH4a2qMT30czmDB8EBB3wZWAQu9kQGLt5BQvdXkx9TnmS9HKyQ8+0=
X-Received: by 2002:a2e:8417:0:b0:2d6:c7eb:8837 with SMTP id
 z23-20020a2e8417000000b002d6c7eb8837mr7907824ljg.46.1712090418418; Tue, 02
 Apr 2024 13:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
 <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
 <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com>
 <CAFGhKbwqrr=_bOnKW+wqtX2OyW0xpS_9wkJnHpwxmwx7MHGhfg@mail.gmail.com> <CAFGhKbzdWLw7fmRTLYPhEycWZvfjE-OCvnWct2A_kWVe94-p-A@mail.gmail.com>
In-Reply-To: <CAFGhKbzdWLw7fmRTLYPhEycWZvfjE-OCvnWct2A_kWVe94-p-A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 2 Apr 2024 22:40:06 +0200
Message-ID: <CAFULd4ahxmEiJ37hLXUg3RwZMW9GnkN=38ZuirSq_cu3VHMU0g@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:10=E2=80=AFPM Charlemagne Lasse
<charlemagnelasse@gmail.com> wrote:
>
> Am Di., 2. Apr. 2024 um 11:53 Uhr schrieb Charlemagne Lasse
> <charlemagnelasse@gmail.com>:
> >
> > Am Di., 2. Apr. 2024 um 11:43 Uhr schrieb Uros Bizjak <ubizjak@gmail.co=
m>:
> > [snip]
> > > Please try the attached patch that informs sparse about this action.
> >
> > I've tested it using
> >
> > ```
> > git reset --hard v6.9-rc2
> > patch -p1 -i ~/p.diff.txt
> > git clean -dfx
> > make allnoconfig -j$(nproc)
> > make kvm_guest.config
> > make prepare -j$(nproc)
> > touch include/linux/netdevice.h
> > make C=3D1 net/core/dev.o CHECK=3D"sparse -Wcast-from-as"
> > ```
> >
> > And it seems to work. Thanks
>
> But I found another problem which seem to have been introduced by
> commit ed2f752e0e0a ("x86/percpu: Introduce const-qualified
> const_pcpu_hot to micro-optimize code generation")
>
>
> ```
> git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
> git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
> patch -p1 -i ~/p.diff.txt
> git clean -dfx
> make allnoconfig -j$(nproc)
> make kvm_guest.config
> echo CONFIG_MODULES=3Dy >> .config
> echo CONFIG_NET_9P_VIRTIO=3Dm >> .config
> make olddefconfig
> make prepare -j$(nproc)
> touch net/9p/trans_virtio.o
> make C=3D1 M=3Dnet/9p/ trans_virtio.o CHECK=3D"sparse -Wconstexpr-not-con=
st"
> ```
>
> This now shows the warning:
>
> ```
> net/9p/trans_virtio.c:831:1: warning: non-constant initializer for static=
 object
> net/9p/trans_virtio.c:832:1: warning: non-constant initializer for static=
 object
> ```
>
> Which is from
>
> ```
> module_init(p9_virtio_init);
> module_exit(p9_virtio_cleanup);
> ```
>
> The same happens when directly switching to the mentioned commit:
>
> ```
> git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
> git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
> patch -p1 -i ~/p.diff.txt
> git clean -dfx
> make allnoconfig -j$(nproc)
> make kvm_guest.config
> echo CONFIG_MODULES=3Dy >> .config
> echo CONFIG_NET_9P_VIRTIO=3Dm >> .config
> make olddefconfig
> make prepare -j$(nproc)
> touch net/9p/trans_virtio.o
> make C=3D1 M=3Dnet/9p/ trans_virtio.o CHECK=3D"sparse -Wconstexpr-not-con=
st"
> ```
>
>
> So something for module_init and module_exit changed with this commit.
> I can't see this when switching to a version before this commit:
>
> ```
> git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e~1
> git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
> git clean -dfx
> make allnoconfig -j$(nproc)
> make kvm_guest.config
> echo CONFIG_MODULES=3Dy >> .config
> echo CONFIG_NET_9P_VIRTIO=3Dm >> .config
> make olddefconfig
> make prepare -j$(nproc)
> touch net/9p/trans_virtio.o
> make C=3D1 M=3Dnet/9p/ trans_virtio.o CHECK=3D"sparse -Wconstexpr-not-con=
st"
> ```

It's this part:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24fc3..bf9815eaf4aabf 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -212,7 +212,7 @@ void ftrace_likely_update(struct
ftrace_likely_data *f, int val,
*/
#define ___ADDRESSABLE(sym, __attrs) \
static void * __used __attrs \
- __UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)&sym;
+ __UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)(uintptr_t)&sym;
#define __ADDRESSABLE(sym) \
___ADDRESSABLE(sym, __section(".discard.addressable"))

But ... how is this not const?

Uros.

