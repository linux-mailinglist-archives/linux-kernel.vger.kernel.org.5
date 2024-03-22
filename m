Return-Path: <linux-kernel+bounces-111785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7578870F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095371C22714
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B55A4EF;
	Fri, 22 Mar 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmlVR3ru"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A01E88C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125344; cv=none; b=u9JWBr033/+JQgmKaxKU5afQn8qbcVYG0OJuqz7f4halTxeEIWK4zRi0uaefc5osbRL+wacoJ+HQFEg7HxHYnRvTjrX3xLtnzbvY+pm4SqNJm3tE+MeDbW4fQzF1MzESdLuUPlazrapls9r9SdCFIdkl+HpciUTC0+M+0bGYMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125344; c=relaxed/simple;
	bh=YUEpNHeIjoq6e7Mop6HEiPK3jQdLfj97kx27Pbea3lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITMe3SCsRCESlJGbr2+ynbZxZOko74oe2k73DVzxd+BZ9SKIOucNOF7q+QH4srlqMwfCm5MKgEj5u05XCzHFcpFfB6CbycVbHDgKUZdlSFsH/r/mcEerJ9j4ml5FLYBKove8ipHmZHG3K9BZ2fjpJVZ9j8i514gcHsHTOTmRwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmlVR3ru; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso2366516276.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125342; x=1711730142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdyspKgihAGQW2Y9hjAYvl8Uf1jnFBY9njd2VhIoWWs=;
        b=MmlVR3ru25Vnmo9X5gD8IP7jpxsQQfCmQ5ogBJqlXC1gytQn+I5CmE/rUibzivzuJy
         HzxLxFM2+8hSjQ4s7qndHWCBEYSOAtTeNXV6Sq8Up5MaQmgN6gFoll6uYvyvFlTjMjY1
         tHZXFs1NjuAWrOH/JgPkw55490yUT/hpQFZbXZ1clgxQBrGaaZsub8LUoe7XkP3RR23A
         mmkHr2Hd01Y3HXtRv302PkBhiMkkeO/FqtVJYzbX5bjbYN3iz8Tafrl4ZhFsSWioq0Fa
         GLoj80eSYYRGBgqF7xP7VdLPbWmMyxHUzmw60+hxCAgGBINtAo3q/ZAYVDOlgMoAT7Cx
         HDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125342; x=1711730142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdyspKgihAGQW2Y9hjAYvl8Uf1jnFBY9njd2VhIoWWs=;
        b=Ye+iEvy4vOC5gm6X1kig2yG0jM/MLEkiiQRbz58BeVfDL0gnA6Rh5G3sQM8B5jHG2O
         prpRTgn9mKkg8hXpjMk5h+uxIdyvEHxFqAKlvaxPbiFZyyqXKdH3GiCoC8c2zYk1f6AC
         oa3hQtPWOgOdzq0QL3cKLNrotXZdxdj58M+LILX7okIzFAth2H4EAB1NhDRbC9/kqAUZ
         ol7W4S0QW84VHg3CDEFdpiHgX0y6cDHs4KktJazAzUwqZcZoQ7HX6kfZZmeqobzb/N9i
         pFl7+o/S6SxlEBk/It7rR/n7V/5EP/zh4urTlRHt0vLIOnsqHM4SHxrykSFMgPzzDL52
         qRZw==
X-Gm-Message-State: AOJu0YyY/RMAD0Hb3W/NvOQkY7SE5hpLXo56TX26ON+yoID1Owh5isrH
	OMuBPbRvt4g4Bnc5MMHqqTDkWyOK1wqAUx/wpHgHL6cthyBjC4yKIzEVJ6SWOiM4+ybPOuZLRAV
	keXH2BxxvvJZyq7BMXAUJdE2gq3Q=
X-Google-Smtp-Source: AGHT+IGe+5vBDqQZIoE/At4E/vo7/bQssVZHcN7Pnuddkc4jYYT+rxPwML10rQXWMyNaM8A29JN0wVcwpJce5qLTSZQ=
X-Received: by 2002:a25:e90f:0:b0:dcc:f3fe:19c with SMTP id
 n15-20020a25e90f000000b00dccf3fe019cmr2406059ybd.59.1711125342159; Fri, 22
 Mar 2024 09:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140433.1966543-1-hjl.tools@gmail.com> <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
 <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
 <CAMe9rOq9=7hS-Ohk+5kOnstp4tFFsAF11L=EKdTm+gUt97ugbg@mail.gmail.com>
 <95a27fd1e3b263d2b002c47751b1b42b3d639bae.camel@intel.com>
 <CAMe9rOpO7=KL5XuvtR=cCSVatEsT5eFn7nuknRnDDQk9PbCb9w@mail.gmail.com> <4df8ad26255726619202eef517e0080ab75762a1.camel@intel.com>
In-Reply-To: <4df8ad26255726619202eef517e0080ab75762a1.camel@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 22 Mar 2024 09:35:06 -0700
Message-ID: <CAMe9rOo1ZONFgBkuN_Ni3REBRsedNwj3gNnXj1oxB0bQzuNipA@mail.gmail.com>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:21=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2024-03-22 at 09:07 -0700, H.J. Lu wrote:
> > > I mean it will require kernel work in the future to maintain
> > > support.
> > > That we will have to think about x32 effects when making other
> > > shadow
> > > stack changes.
> >
> > It is way more than kernel SHSTK self tests.
> >
> > > I'll paste my other comment in this thread:
> > >
> > > The main usage of shadow stack is security, and comes with some
> > > overhead. IIUC the main usage of x32 is performance benchmarking
> > > type
> > > stuff. Why would someone want to use shadow stack and x32 together?
> >
> > Improve x32 security and user space IBT will add more improvement.
>
> Please elaborate on the users that will use x32 and shadow stack
> together. How many people are we talking about? They care enough about
> performance to use x32, but also don't mind overhead to increase
> security? Perhaps I'm missing something on what x32 is used for today.

SHSTK is enabled by -fcf-protection which is the default for some OSes
where x32 binaries are SHSTK enabled already.  Enable SHSTK should
have minimum performance overhead.

>
> [snip]
>
> > >
> > > The mapping above 4G was because Peterz raised the possibility that
> > > a
> > > 64 bit process could far call into a 32 bit segment and start doing
> > > signal stuff that would encounter undefined behavior. He wanted it
> > > cleanly blocked. So by keeping the shadow stack above 4GB, existing
> > > processes that turned on shadow stack would be preventing from
> > > transitioning to 32 bit and encountering the missing 32 bit signal
> > > support (because the CPU would #GP during the 32 bit transition if
> > > SSP
> > > is above 4GB).
> > >
> > > Probably there is some interplay between the x32 mmap logic and
> > > shadow
> > > stacks mapping, where it then becomes possible to get below 4GB.
> > > Since
> > > x32 needs the shadow stack to be below 4GB, it's incompatible with
> > > that
> > > solution. So this patch is not sufficient to enable x32 without
> > > side
> > > effects that were previously considered bad.
> >
> > Mapping shadow stack below 4GB on x32 still provides security
> > improvements
> > over no show stack.
>
> Agreed on this point. I don't think x32 shadow stack has to be perfect
> to improve security of the x32 apps.
>
> But Peterz's concern (I think it could probably be re-opened) was that
> the ia32 signal stuff should not be just declared unsupported with
> shadow stack, but blocked from being used somehow. So it was really
> about being able to not have to think about the implications of the
> undefined behavior. (was my understanding at least)
>
> This patch is just turning things on and finding that nothing crashes.
> It needs more analysis.
>

It is more than that.   There are 3 glibc tests to check if SHSTK triggers
show stack violation when there is an intentional show stack mismatch:

[hjl@gnu-tgl-1 build-x86_64-linux]$ ./elf/tst-shstk-legacy-1b
[hjl@gnu-tgl-1 build-x86_64-linux]$ ./elf/tst-shstk-legacy-1b --direct
Segmentation fault (core dumped)
[hjl@gnu-tgl-1 build-x86_64-linux]$
GLIBC_TUNABLES=3Dglibc.cpu.hwcaps=3D-SHSTK ./elf/tst-shstk-legacy-1b
--direct
[hjl@gnu-tgl-1 build-x86_64-linux]$

They pass on x32.

--=20
H.J.

