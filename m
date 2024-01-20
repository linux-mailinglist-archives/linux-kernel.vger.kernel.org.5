Return-Path: <linux-kernel+bounces-31675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B0833264
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B65B22A76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D42EC0;
	Sat, 20 Jan 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDNHZ8mZ"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C5A4D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705716587; cv=none; b=O1HmDrapQ+XO9j+/hBwbV2e82ENO8j2dPweHnzftYdmi0m2gnmgOiBOM79GENm+BxLmLMlQ/qpdkGo0iGbbu09bgyUqjCa5llRZnc1RQm4s91MA4gmk74A+LVdCoQJJ5VHl6IGoBCHwtOYIrStpm2vlBM+FC+CY0cfDPSer3oX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705716587; c=relaxed/simple;
	bh=Z0dTd6MRCU5KWfJPW01fq42KBfk3Nx8D3X3vKSY1Rxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwejfsCf1qYgIRzV2KaRSFGXpRXrc2ksGr5BDcAdcw3PIEm1DfWEX8L15RmAaNIKCAG6zZ0GfbuZtsEWa5jEcU2mePG9qr4ElFErvgS+s7EJDMg28LcQoXdTibp5Bpu1AqfPXK7ZDjGLE2WNkk5nIMHvjSL8GQusEaiDV3f0H5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDNHZ8mZ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc227feab99so1472748276.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705716583; x=1706321383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0dTd6MRCU5KWfJPW01fq42KBfk3Nx8D3X3vKSY1Rxo=;
        b=DDNHZ8mZ0wjA4Fosk9aE/cwj2Bg8zfo0yWo5zMEfrgDFjUuoyXpxX9PqdwlJ5RMaW+
         2+2jCr6tq5RJoqyYUufg8NLFdu5Rpf5XUJj7RW/nqWWwLAxdyoc36/vGYZOFqKVxjzaQ
         X+u0adqLPOzWZGl8W568K1NiXI3Nnb6gJ8hEH7rf7WbL8vut7Kafxk8+eS8xhx0xikOm
         ZcHw1NYiHuUAnkr3sRBhjiTUUxYiE4tFUzpVLosuDpHnlZQevSTXS1TflTIXBDO8Cze7
         dRI1kvqMelyQ0Tb6e2XPS+VLnCVubTKFLea/59TzbOwQbJ8BSYT5qz0Imy2jmdNW8Qsn
         sy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705716583; x=1706321383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0dTd6MRCU5KWfJPW01fq42KBfk3Nx8D3X3vKSY1Rxo=;
        b=V/PQjCS5n5Z2ieFD3UL8dV+ED5xQfVT0WM0+nmqwqT5Q4eEf1uVxiVgTZtW04S9StI
         CdJGIB3hjJKFIIlzwed2JA7HlbZQAAslurcdAP7aylqDAmgzy2F8/bGNv7HgG0R6x8PE
         usUsd7wmMVLOhp24KwoE+LYOhpMM1yqQoe7kAdYGLxkHdYIjFgJVv49caTiDFB3uaBXw
         849uRut8PkQ1XzGm3TXw7pYL+FGSKEyUOCv2tG8yz4tB28OQpgvgMzXhEjdnvHtTacW2
         dt8uRJiK1I7gihNW8cl7WnRJyEFFHzub/6j5wotTUu0saf617XR6kgGawGuJ7iJ5JY3j
         tW1Q==
X-Gm-Message-State: AOJu0YzA1mwHvDtudb1eP62mMk7t7LsaD3i062x+ieu/pdamwIRwEJsl
	HFPgHzrDpfZay97SiGwGxP4mus7rwfdsrf09diImCv4s1J5pt5Vgr97VCGUPsi2sB99TEBzwr+4
	81iBqmZ2mUqP35M7S4FLuJdvlJ8s=
X-Google-Smtp-Source: AGHT+IHEcW2qLgtQkeTqlQvEvwlyO/nGg+bxkQXGmBFiKo2xBstXNd3UgwuF1BPoZzh3HljOFBWcjS5rmnAhy123joE=
X-Received: by 2002:a25:9191:0:b0:dc2:66ab:bb6e with SMTP id
 w17-20020a259191000000b00dc266abbb6emr761725ybl.20.1705716583259; Fri, 19 Jan
 2024 18:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com> <ZapwWuVTIDeI3W8A@tiehlicka>
In-Reply-To: <ZapwWuVTIDeI3W8A@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 20 Jan 2024 10:09:32 +0800
Message-ID: <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 8:51=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 19-01-24 10:03:05, Lance Yang wrote:
> > Hey Michal,
> >
> > Thanks for taking the time to review!
> >
> > On Thu, Jan 18, 2024 at 9:40=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > > [...]
> > >
> > > before we discuss the semantic, let's focus on the usecase.
> > >
> > > > Use Cases
> > > >
> > > > An immediate user of this new functionality is the Go runtime heap =
allocator
> > > > that manages memory in hugepage-sized chunks. In the past, whether =
it was a
> > > > newly allocated chunk through mmap() or a reused chunk released by
> > > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back mem=
ory with
> > > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPS=
E)[3]
> > > > respectively. However, both approaches resulted in performance issu=
es; for
> > > > both scenarios, there could be entries into direct reclaim and/or c=
ompaction,
> > > > leading to unpredictable stalls[4]. Now, the allocator can confiden=
tly use
> > > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of=
 huge pages.
> > >
> > > IIUC the primary reason is the cost of the huge page allocation which
> > > can be really high if the memory is heavily fragmented and it is call=
ed
> > > synchronously from the process directly, correct? Can that be worked
> >
> > Yes, that's correct.
> >
> > > around by process_madvise and performing the operation from a differe=
nt
> > > context? Are there any other reasons to have a different mode?
> >
> > In latency-sensitive scenarios, some applications aim to enhance perfor=
mance
> > by utilizing huge pages as much as possible. At the same time, in case =
of
> > allocation failure, they prefer a quick return without triggering direc=
t memory
> > reclamation and compaction.
>
> Could you elaborate some more on why?
>
> > > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> > > e.g. non blocking one to make sure that the caller doesn't really blo=
ck
> > > on resource contention (be it locks or memory availability) because t=
hat
> > > matches our non-blocking interface in other areas but having a LIGHT
> > > operation sounds really vague and the exact semantic would be
> > > implementation specific and might change over time. Non-blocking has =
a
> > > clear semantic but it is not really clear whether that is what you
> > > really need/want.
> >
> > Could you provide me with some suggestions regarding the naming of a
> > more relaxed (opportunistic) MADV_COLLAPSE?
>
> Naming is not all that important at this stage (it could be
> MADV_COLLAPSE_NOBLOCK for example). The primary question is whether
> non-blocking in general is the desired behavior or the implementation
> should try but not too hard.

Hey Michal,

Thanks for your suggestion!

It seems that the implementation should try but not too hard aligns well
with my desired behavior. Non-blocking in general is also a great idea.
Perhaps in the future, we can add a MADV_F_COLLAPSE_NOBLOCK
flag for scenarios where latency is extremely critical.

Thanks again,
Lance
>
> --
> Michal Hocko
> SUSE Labs

