Return-Path: <linux-kernel+bounces-374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4F81402A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B44F288395
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A046B1;
	Fri, 15 Dec 2023 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faxRcA7U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362C10FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so139767f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 18:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702608273; x=1703213073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9XDBQt8NyASWBhHRtYhXwFukuH9acGC67RiibDyL7E=;
        b=faxRcA7UdzXClMiW76LNr0Y0o+QVJnLyY5T+ZP0gc/WrxA9JPmg3G/0cRO6aOYQhV9
         d4FoCqbX5vmJg6yUJ9LRwQ29zeuSQn3QsH8a7mqentnWC70wpd1ZdhgHphTOEy2dDI6e
         9tjg+4TXGqE9/2fbChqp+LU0fFpgx4Q3EvrgNbMYuCTfrx6kkXY7FS9GiOOBKgp8AalL
         5exfrim2Ge+ww1vVd896aY398OvVIjloN7NRKhgkcFisIARajr02cdVtu9GUOqPgxsIZ
         HLFMC+sMvrpfSH2E8mhuOoHCpt8i3ZfYlAyina5lnHE4BYivd2VTGhKi5uerJi1Q5dsa
         +QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702608273; x=1703213073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9XDBQt8NyASWBhHRtYhXwFukuH9acGC67RiibDyL7E=;
        b=lpMRxf4bOK0VEjU8jWAwntevHVQP9dIlv+muQ7BxvdAgIKHRLwss3TugRafmBqDn9E
         kTWpdmYjQ33QNy7yH8cxxOS7kD9qF7uFv1qAbClhkzzU2m+DtK9sbZMIS7XbzOQLfTEc
         HwPEXx6PxHTgaJxQ9YaEIlTwisl8CDPUvq/kKUnxWgSDF+VZth9ZkhB0Dq3/YL5Rj2iq
         B7YQqVz6L4diMdmmH7zCx1f7sZrWROrQkaE0AxYlM9wnFiuTAQfOOzTxd5Eakob5/KW3
         rpt0D6ute4NeT0rKT/SF7IYoTqg4RySyZdO/Sg2mRdgO06I9OQM4Qc6l+AWvFXjK7756
         4hdQ==
X-Gm-Message-State: AOJu0YywypFBJ5Mmrj96rVS/mI15pyvx+JoxDkpvJxMNdqYKZ+Lq7Ql1
	vNqhb0iuvcP72p1AD+UaaAFvvkxW0VL1Jfa5yXUB2Q==
X-Google-Smtp-Source: AGHT+IEHYFogUObtxR5bOjWEUZN9INgCImPWqK70oIiDi+VdLrk3rRhfc+3EQJvaALO54EkeT7OruMofARK/eN/0O5A=
X-Received: by 2002:a05:6000:1d97:b0:336:26d3:8819 with SMTP id
 bk23-20020a0560001d9700b0033626d38819mr2973326wrb.41.1702608273373; Thu, 14
 Dec 2023 18:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA0N8zYyGKraVW8v3roMNakuJxQJOo3ddsB=e0D_KaD+Ji=81A@mail.gmail.com>
In-Reply-To: <CAA0N8zYyGKraVW8v3roMNakuJxQJOo3ddsB=e0D_KaD+Ji=81A@mail.gmail.com>
From: Chris Koch <chrisko@google.com>
Date: Thu, 14 Dec 2023 18:44:15 -0800
Message-ID: <CAA0N8zaYjfxJ7eTWU-t0qGRN7rsU9_O8+7XPNW5iejtmr57s3A@mail.gmail.com>
Subject: Re: The conflict between PHYSICAL_START and MIN_KERNEL_LOAD_ADDR
To: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Cloud Hsu <cloudhsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies, I didn't realize x86@ wasn't a mailing list earlier.
Adding the list.

On Thu, Dec 14, 2023 at 6:37=E2=80=AFPM Chris Koch <chrisko@google.com> wro=
te:
>
> Hi all,
>
> we ran into some memory clobbering on kernel boot, and there seems to
> be a bit of a conflict between the documentation and reality, and
> CONFIG_PHYSICAL_START (default 0x1 000 000) and MIN_KERNEL_LOAD_ADDR
> (default 0x100 000).
>
> First observation: bzimage's pref_address is listed as "preferred" in
> the boot documentation for relocatable kernels, but what is not
> mentioned is that if the kernel is loaded below pref_address, it will
> relocate itself there [1]. The default CONFIG_PHYSICAL_START seems to
> be 0x1000000, and a review of bootloaders shows that in every case but
> GRUB a kernel will get loaded below that, and then relocate itself
> there. (ipxe 0x10000 or 0x100000 depending on config, kexec-tools
> 0x100000, kexec_file 0x100000)
>
> This means in all default cases except GRUB, the kernel will relocate
> itself and decompress in an area of memory it was not intended for,
> and which may hold reserved data in the memory map. (This is what
> happened in our case. It was clobbering reserved stuff.)
>
> This suggests the following:
> 1) This pref_address behavior should be documented in boot.rst.
> Something like "A relocatable kernel will relocate itself to
> pref_address (which is equal to CONFIG_PHYSICAL_START) if it was
> loaded below that address."
>
> 2) Documentation for PHYSICAL_START should be updated. It states
>
> > If kernel is a not relocatable (CONFIG_RELOCATABLE=3Dn) then
> > bzImage will decompress itself to above physical address and
> > run from there. Otherwise, bzImage will run from the address where
> > it has been loaded by the boot loader and will ignore above physical
> > address.
>
> 3) Some patches should be sent to ipxe, kexec-tools and kexec_file to
> respect pref_address as a minimum address, not just a preferred
> address.
>
> 4) The default values of MIN_KEXEC_LOAD_ADDR and CONFIG_PHYSICAL_START
> should align to reduce the chances of this happening for users who
> aren't messing with these values. Given what current boot loaders do,
> should CONFIG_PHYSICAL_START be lowered to 0x100000, at least for
> relocatable kernels? This might be the most controversial of the
> changes.
>
> 5) Should PHYSICAL_START be ignored in relocatable kernels like its
> documentation suggests? Is the relocation above that unnecessary?
>
> Regardless of which change we make for the future, existing boot
> loaders & kernels conflict in their behavior for relocatable kernels.
> What is most likely to fix this issue for users & prevent breakage of
> existing workflows?
>
> If I see agreement on 1 to 3, I will start sending patches. Would love
> to hear opinions on 4 & 5.
>
> Thanks,
> Chris
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/arch/x86/boot/compressed/head_64.S?h=3Dlinux-6.6.y#n333

