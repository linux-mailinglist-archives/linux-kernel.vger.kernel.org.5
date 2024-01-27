Return-Path: <linux-kernel+bounces-41107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264E83EBF6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA57284B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB31DA53;
	Sat, 27 Jan 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoxHQRwq"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4E17721;
	Sat, 27 Jan 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706342813; cv=none; b=nXFkc5ESkYirk5ythpDHbnIc7JGws3GYvpb2cRc2cAnlxCzjH2k9rzPxbqVkQIes8jg1sAorJu9U0YHNyncuxeSBzVxiIU5E5E37cq/qpfq3aG35F/+MjoD1eqj34TRtK3cdthK7N6ntLP/1C/t8+RXZTo3MWoalUcr0HIOIwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706342813; c=relaxed/simple;
	bh=xJZ2TcuXVx0HQfLG7ro+wBJ7/ZMJJMbceBk/8o2W1nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xv1sAC+r7bll5aRtdzg0sK4OnZHyYoqfD59NtEnDsFpPmuNerOPsq40QkdVk/fvj1T2Rpg5uFadl3LofoUjqVbkTVUDa82Z4sjZ1qUcVoNFALij4aQ/W8nVhRg1VdPp1d6m7aHf9EIFQhashamHutZoR7FuZTHpqPdwti2w95sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoxHQRwq; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc642cd955fso924300276.0;
        Sat, 27 Jan 2024 00:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706342811; x=1706947611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJZ2TcuXVx0HQfLG7ro+wBJ7/ZMJJMbceBk/8o2W1nA=;
        b=DoxHQRwq5RUczHmUgyw5taKgb0aK66V023c6Q+uj3h2TPKbd78fS13gqHxswooMNjy
         1176ZdcE3zrY/oUUeU+JOlN8ONamX2YpdsXj5EWPWauzgnLbmwx4OfLVPDatSz/IzN8m
         y1sOheFE3uGpSbnWm1xJ9nASaEWeydbD7+NAbiA5L57vy5UjLjsknafyQbr/UsrNgJY9
         lnh3N5nK5hxjqnTP8yQfpsZ+LWDtXAYzoC+GQ9/MNDl+7wNQdgMDLnbvWnZNnTRYwSxA
         63V4wPFPSnOUbM4Ory5AtCuoMEaPTRMr7festCP2WHgh9Jtc+I6HiGuiwxHz43yZaen1
         6WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706342811; x=1706947611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJZ2TcuXVx0HQfLG7ro+wBJ7/ZMJJMbceBk/8o2W1nA=;
        b=th0oWFkB52+RJ4yMGqWz38ZqoJXM66k4xc4ia8GOkwlr+LInc0nCvsAum4ajnexcc0
         7wvS4v2DRttHtrINP7GpMgx3TovCm9BASKvJCB/dt9J7ZmBaJ8cmw5wwOUN0h8YBik1S
         xZ+0uTqmtJKjQSy+hkoqroRV29tM3lfa9y184rxG2cgKtXUlMsjjmhlJE4Cq30/pY0DF
         dzBymlpfS4NURM3yvpzIPylboOATyNs+o+uaMLUVOyKAr1IG88yQF5AAisCoRKkIxNKE
         Dye0j6m8+buWDwm1Nf5Gcb2+faZp0uWgWN9KQa+7YUANAiuFhYzO/icdr0ZOfl9Z2B4I
         dYIQ==
X-Gm-Message-State: AOJu0YzcZWjzIDZyYbIsaX6BQlus11Lly+yI4T/HhlN5tO6S1fRYFJnz
	sOke0trErtzE2qHAkc+fcugnuRvAmiqUCPxjs7U2WIHukUyM0pSOBFYbXcMaWoBHIHOM/vLXbhy
	jbGqlvCpXck2IiZ3LgRVe5sqsuByRnscsBKfCTZl3
X-Google-Smtp-Source: AGHT+IE445rhgCPgk3Ky3+sDSrPR8Aq6mhKsin3MfmkfiDsbyxUYk8hj4tB88oSHwDfLTHQaYrrNcfHA626LSQFPk20=
X-Received: by 2002:a81:b716:0:b0:602:b725:c762 with SMTP id
 v22-20020a81b716000000b00602b725c762mr797845ywh.56.1706342810937; Sat, 27 Jan
 2024 00:06:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
 <ZapwWuVTIDeI3W8A@tiehlicka> <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
 <Za5yvjZWVyYjgyfh@tiehlicka> <CAK1f24n+pTw=7atKGAbgBh8qKOTBPq-BEV7ZkLcgN3P0n3h3ug@mail.gmail.com>
 <CAK1f24=7fKU-+xRSOhrJrZ56=YoVfnkONZwNOJRS4yY4SzhANA@mail.gmail.com> <CAAa6QmRLfwhyh66bVVakp__Rkzpkt3zq2kAe9F-KN5sdFdqLAg@mail.gmail.com>
In-Reply-To: <CAAa6QmRLfwhyh66bVVakp__Rkzpkt3zq2kAe9F-KN5sdFdqLAg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 27 Jan 2024 16:06:39 +0800
Message-ID: <CAK1f24=tfxgUpdPix1n-4fre70UVFhLbzEqEj7SthUMRJtT59g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How about MADV_F_COLLAPSE_NODEFRAG?

On Sat, Jan 27, 2024 at 7:27=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> On Mon, Jan 22, 2024 at 6:35=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > Hey Zach,
> >
> > What do you think about the semantic?
>
> Hey Lance,
>
> Sorry for the late reply.
>
> I can see both sides of the argument; though I would argue that
> "non-blocking" is equally as vague in this context. E.g. we'll "block" on
> acquiring a number of different locks along the collapse path.
>
> If you really want to talk about not entering direct reclaim /
> compaction, then keeping with the sys/kernel/vm/thp notion of "defrag"
> would be better, IMO. I don't feel that strongly about it though.
>
> But I see you've provided some more use cases in another mail, so let
> me pick up my thoughts over there.
>
> Best,
> Zach
>
>
>
> > Thanks,
> > Lance
> >
> > On Mon, Jan 22, 2024 at 10:14=E2=80=AFPM Lance Yang <ioworker0@gmail.co=
m> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 9:50=E2=80=AFPM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Sat 20-01-24 10:09:32, Lance Yang wrote:
> > > > [...]
> > > > > Hey Michal,
> > > > >
> > > > > Thanks for your suggestion!
> > > > >
> > > > > It seems that the implementation should try but not too hard alig=
ns well
> > > > > with my desired behavior.
> > > >
> > > > The problem I have with this semantic is that it is really hard to
> > > > define and then stick with. Our implementation might change over ti=
me
> > > > and what somebody considers good ATM might turn int "trying harder =
than
> > > > I wanted" later on.
> > > >
> > > > > Non-blocking in general is also a great idea.
> > > > > Perhaps in the future, we can add a MADV_F_COLLAPSE_NOBLOCK
> > > > > flag for scenarios where latency is extremely critical.
> > > >
> > > > Non blocking semantic is much easier to define and maintain. The ac=
tual
> > > > allocation/compaction implementation might change as well over time=
 but
> > > > the userspace at least knows that the request will not block waitin=
g for
> > > > any required resources.
> > >
> > > I appreciate your insights!
> > >
> > > It makes sense that a non-blocking semantic is easier to define and m=
aintain,
> > > providing userspace with the certainty that requests won=E2=80=99t be=
 blocked.
> > >
> > > Thanks,
> > > Lance
> > >
> > > >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs

