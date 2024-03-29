Return-Path: <linux-kernel+bounces-124310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C889157E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C243285E41
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD239FD1;
	Fri, 29 Mar 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaY/ZtZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F53BBC9;
	Fri, 29 Mar 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703453; cv=none; b=baQcKNQHaQYvjZbl41zkbNXGvObO65wparssmJf9XZxSjcfRD08WqaoxQ5U6fWBtgSv7OzLtAGpS4MLybdVtJ3km8RHRWoo6Ab9mLAyzjYdyl45vgWALBnY6hJvfGiCe8AbKEKBfTXILeh2QdIwGBDu6UqCrAcrLFNN9szPzOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703453; c=relaxed/simple;
	bh=vY/FJp6qrT1tKYNcxeFTW8hugbxrKmwQdnT/CQhbR5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzVxlZCtF+mjD3SzmhwRGLk5J+h7T8eZoqMYiI/E4aPhPxDWSg7Vg3piEgMay6Z7K4GCouKh3a/RFd5VApIfyWtpuOOneGig0T+kikN6XDJu+UL/Cp1NtjBUDLnQEY1qVZbdU8Dqz4gi8fbEyrk8dQ5guAaeLvKnWcqm62cutyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaY/ZtZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C95C433F1;
	Fri, 29 Mar 2024 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703453;
	bh=vY/FJp6qrT1tKYNcxeFTW8hugbxrKmwQdnT/CQhbR5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eaY/ZtZHjovhpyorRysQzrSvwlw75euFhSBKmnQXN4v3DgdaYp9046mnYet+XRpW3
	 UUrxLttZ7gI1jUpxEbQQjFNAiRz6I9nWbPkcba4rCc7sZG5DrddxBrsqU5WkVHSoOF
	 nSACZAw+mLwl4P4zWoBvKykmU8ETj3EN/OamHwKM8/rmKw6gs3rAIdkvqAk9isEVr+
	 1rzLlkIN3JNVSuxTuNBiyA6701F/jmtzQkGj8RkHqbbZY1jcZxV9i0erMg+H5FZ2jk
	 gsu+08acrGMvte6ez3tsgZ6iH7cUMCz1cB/n86GRorzHlrV+l13H1HrjsYEC8GHTAx
	 KLmHKeBN7f5oA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>, Samuel
 Holland <samuel.holland@sifive.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>, Jakub
 Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: RISC-V for-next/fixes (cont'd from PW sync)
In-Reply-To: <20240329-fanning-woven-7dbb6cfdde9b@wendy>
References: <87ttkro3b5.fsf@all.your.base.are.belong.to.us>
 <20240327-irrigate-unread-d9de28174437@spud>
 <CAHVXubgMTe83sYaNO+SG=90=k5scaQrpApveTCO163MhUc1tdA@mail.gmail.com>
 <20240329-fanning-woven-7dbb6cfdde9b@wendy>
Date: Fri, 29 Mar 2024 10:10:49 +0100
Message-ID: <87sf09pfmu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor.dooley@microchip.com> writes:

> On Fri, Mar 29, 2024 at 07:46:38AM +0100, Alexandre Ghiti wrote:
>> On Wed, Mar 27, 2024 at 9:32=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
>> >
>> > On Wed, Mar 27, 2024 at 08:57:50PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> > > Hi,
>> > >
>> > > I figured I'd put some words on the "how to update the RISC-V
>> > > for-next/fixes branches [1]" that came up on the patchwork call toda=
y.
>> > >
>> > > In RISC-V land, the for-next branch is used for features, and typica=
lly
>> > > sent as a couple of PRs to Linus when the merge window is open. The
>> > > fixes branch is sent as PR(s) between the RCs of a release.
>> > >
>> > > Today, the baseline for for-next/fixes is the CURRENT_RELEASE-rc1, a=
nd
>> > > features/fixes are based on that.
>> > >
>> > > This has IMO a couple of issues:
>> > >
>> > > 1. fixes is missing the non-RISC-V fixes from releases later than
>> > >    -rc1, which makes it harder for contributors.
>>=20
>> The syzbot report [1] requires fixes in mm [2], if we don't update
>> fixes on top of the latest -rcX, we'll keep hitting this bug, so
>> rebasing -fixes on top of the latest -rcX is necessary to me.
>
> No non-ff rebasing of branches unless its 101% required, please. This
> seems like a justifiable reason to merge the rc it appears in into the
> riscv branches though.

Are you talking past each other? I'm *not* saying rebase (agree with
Conor!). I'm saying "let's move fixes up to the point to include the
merge (and whatever on Linus' tip at the point of merge), i.e.
*ff-only*.

Now, rest your eyes on this fabulous cartoon:

  Linus' master
  |
  v
  o o <-- RISC-V fixes
  | |
  . .
  . .
=20=20
  Linus accepts the PR...
=20=20
  o <-- Merge tag 'riscv-for-linus-meh-rc7'...
  |\
  o o <-- RISC-V fixes
  | |
  . .
  . .
=20=20
  and then move fixes, git merge --ff-only:
=20=20
  o <-- Merge tag 'riscv-for-linus-meh-rc7'..., RISC-V fixes
  |\
  o o=20
  | |
  . .
  . .

Clearer?


Bj=C3=B6rn

