Return-Path: <linux-kernel+bounces-147804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1147C8A79E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DA2B22020
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167D17F6;
	Wed, 17 Apr 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0NdeUQc"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED29EA4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314013; cv=none; b=M2oaEMBdANsfw8hjl4Zj9UcIvh9MIPYS4dfrV+it0Ou8lXZWAA9CB2jzlZUpnWAaghKjI10/0zsGWOJYb9zP05m+S+PxEdxDJw0fwIOkKMY/z8soaxle540tSyy1441fdd9XcnENm8FhKY522tgtonkJ7O+JRsliIYr+u2WB6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314013; c=relaxed/simple;
	bh=lFprVeAVy9ebZ7jvi/XVAorRedWrrB8pQ/HYuQAsD5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoqkxyOn2y8aJbEBHxaYvyGiIMPYSd4MSp39YmfpJ5Xfe6BtrgxQ32NF626zNBiAQvzarIJ1FWsfZI9Jn/+abc9WjijMsSgDp/lfOsnw+vRuJPuhJA/986guo0CpKwEtYRnEMJyxhrmk7tOJRalHTPvJn/gAhogZ1vZxS8ejQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0NdeUQc; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6a0406438b5so3698526d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713314011; x=1713918811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nv1DibbGbw9tL8nQwAudZcQ7QqLjWRcbPgyIWw0A8Y=;
        b=b0NdeUQcCXYIHXJPW2pdxzfD5VGrZQbeSOq/ngzr7MNwN9dTcC7FnbebYe9tT6HHWj
         qq6omUCvO7rxhpnzHD32X115JmNBNydtiXimwXqtil8mlBLfC2XGGCLZ/9o1Cvdk0zIv
         7DwTr3KUEwdCSi3ixbyQe3etV/vwXP+5XC5clcSArwHSrn+mTuT9mcwSV+rzsdPGyKu5
         rCkK/5xo/A+toU+bcUJW0/3s2wiIQDJ0JKIrzoEabCktWoVhzctC3OWFgifmLtG4YXUH
         PBiCG6OT7BWrCS1ZzKiccypaurlFrnGbKwyBfJGm9ZTesAo58Nu06RHPYKZe7iO94f8p
         IVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713314011; x=1713918811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nv1DibbGbw9tL8nQwAudZcQ7QqLjWRcbPgyIWw0A8Y=;
        b=gZBtw76ffiK9brOa99FfICIyOOmxnoCdLV8Walyfp5RL2i69PUakMvyqRya1GTt35C
         fVNYFebfv64GYI3KC4l7AqoKHJkbKyJbIlrBYGROKbu+C9GYHYrZGn9C6UjM4VAmUKeE
         M66ale4jDZsZmPNQn3JDm7BJWg95731Mzlvl0WJiRf7EPGOiaYPXcyD0qAJwpl3L6dDZ
         ODePx3nvQYIHg8X8+xfyLcs7vSs/m+/1kip+0tQjzDVDh0AfVs2Fg+lQdeY99NkkVdtZ
         j0QOPQVCBA3QbNzfjucjO6TmddIH87JF7Vm0PDsuGahb3KSqVYOxyV1pDyIi7x6Ia35e
         fgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmpMzy/7k2lTKHonmykT32UzabGLbsVm268+Gs2FldNDWN2Ul9A+QIx/w6inWxA6TRXJxlyNUVbu5m31CaJcAtUZlqpXgDHaMsHNu7
X-Gm-Message-State: AOJu0YxzXQrVrmWzvKS3/YUSTZ4ZbpcfHxtQuWkM9MVpvwE2lVnkWrK9
	C9lc4cb+rxZmGnmz757C9snaZrLAQYwWKK7KSMqPGp1rP1Bxy+kbSJTxvOWZgIUfCLqRPkrHkBL
	PjGJFuPQLoxzuI3+dDFvlgsPQ4Tk=
X-Google-Smtp-Source: AGHT+IGNL91X03ok22JkcxrwPpreqi/i1SKH6E6oe/s2P/UMXmNWCE83bM19h3Cutu07tq41Fj1xIf/BtycLIUmL1xw=
X-Received: by 2002:a05:6214:564f:b0:69b:16bb:d66a with SMTP id
 mh15-20020a056214564f00b0069b16bbd66amr14628001qvb.47.1713314011404; Tue, 16
 Apr 2024 17:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
In-Reply-To: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 16 Apr 2024 17:33:20 -0700
Message-ID: <CAKEwX=PRK+J92T-nFA2tm3G4PMUnTYet7wtvfnP7Mqi2Q3mTrQ@mail.gmail.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
To: Christian Heusel <christian@heusel.eu>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>, 
	"Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:19=E2=80=AFAM Christian Heusel <christian@heusel.=
eu> wrote:
>
> Hello everyone,
>
> while rebuilding a few packages in Arch Linux we have recently come
> across a regression in the linux kernel which was made visible by a test
> failure in libguestfs[0], where the booted kernel showed a Call Trace
> like the following one:
>
> [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mai=
nline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
> [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS A=
rch Linux 1.16.3-1-1 04/01/2014^M
> [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
> [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 <=
48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
> [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
> [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 000000000=
0000002^M
> [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 000000000=
0000000^M
> [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 000000000=
0000000^M
> [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9766f=
fffe780^M
> [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff97668=
2204d80^M
> [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) knlG=
S:0000000000000000^M
> [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 000000000=
0750ef0^M
> [  218.743494] PKRU: 55555554^M
> [  218.743593] Call Trace:^M
> [  218.743733]  <TASK>^M
> [  218.743847]  ? __die+0x23/0x70^M
> [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
> [  218.744056]  ? free_unref_page+0xf6/0x180^M
> [  218.744458]  ? exc_page_fault+0x7f/0x180^M
> [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
> [  218.744684]  ? memcg_page_state+0x9/0x30^M
> [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
> [  218.744896]  do_shrink_slab+0x3a/0x360^M
> [  218.744990]  shrink_slab+0xc7/0x3c0^M
> [  218.745609]  drop_slab+0x85/0x140^M
> [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
> [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
> [  218.745912]  vfs_write+0x23d/0x400^M
> [  218.745998]  ksys_write+0x6f/0xf0^M
> [  218.746080]  do_syscall_64+0x64/0xe0^M
> [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
> [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
>
> The regression is present in the mainline kernel and also was
> independently reported to the redhat bugtracker[1].
>
> I have bisected (see log[2]) the regression between v6.9-rc4 and v6.6
> and have landed on the following results (removed unrelated test commit)
> as remainders since some of the commits were not buildable for me:
> - 7108cc3f765c ("mm: memcg: add per-memcg zswap writeback stat")
> - a65b0e7607cc ("zswap: make shrinking memcg-aware")
> - b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
>
> I have decided on good/bad commits with the relevant libguestfs tests,
> but I think the reproducer in the redhat bugzilla is simpler (although I
> only became aware of it during the bisection and therefore didn't test
> it myself):
>
>   LIBGUESTFS_MEMSIZE=3D4096 LIBGUESTFS_DEBUG=3D1 LIBGUESTFS_TRACE=3D1 mak=
e -C /build/libguestfs/src/libguestfs-1.52.0/tests -k check TESTS=3Dc-api/t=
ests
>

I have a suspect for the bug:
https://lore.kernel.org/all/CAKEwX=3DMWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3=
U3Tv2Q@mail.gmail.com/

Feel free to fact check me, but let me see if I can reproduce this bug
on my own setting based on this analysis and send a fix accordingly :)

