Return-Path: <linux-kernel+bounces-43870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78468841A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33309288B68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE01376E2;
	Tue, 30 Jan 2024 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuA+NNc9"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A737157
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584103; cv=none; b=Fdiur32KXIRflMzw+xZB5SLcTuhhw12T6iGSuvus55+Arhj7lLSdGp69ooW1hmMjwasG4j80S/OX0vYnZTve+Q4r4HSdbD3ZxiVWkVabKtEM1LefPpzTxdk8Jc/Nkaqjix0YM6tjWT+cdr0pguJKx+lwrSco5/dI/c8/8ZEYLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584103; c=relaxed/simple;
	bh=kj+P9xrjx2fVS1ypKdmJNYGvbVzBBTf7MJvPcLc0yRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BshlDESs/xICJZIGXRm2VhsfbAUfCOmjXpFqWD817HC9WcopByX6Qv0MWpRArb5YRZOIffI/55fAgwXX2Z9gn1vlS9DfvJ+Ybbnpz6JuXR3WwrJx7KD9i5fyzrPsYy88qwJ1pno6DW3Ap82HoTjIWdNwMYPNyhQKn2pkAp/+JpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuA+NNc9; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc68150f46fso1529783276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706584101; x=1707188901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj+P9xrjx2fVS1ypKdmJNYGvbVzBBTf7MJvPcLc0yRI=;
        b=DuA+NNc9amhCyUP02j3MK9spe1JfUcXkknEkxqnn8cLrPFIcQ21fQ/oaWK9E3y9109
         czX9KX97gYl1RJjxNoUmfndmZWR7z/ewY7BxKilK0ajrswUymy9zV9fhPZIP8l6C4vt0
         l72v+CCbcGjY6sQhEU3TluoKFCzVkpGBEqWN0s6NwTVobWpprwbPJk4alD1+afNPU8U3
         vHtNsGgVXVPYjS7M9ErpUXT+y0snYZp0lWnq7jRQhj2TF0wBfputmGFuuFy61iFKvNVG
         Bm16J6Ik18wu/lAFM9qLqsGMvq/Bmiy6N/owbJ6/0OxBk9V0adZ03GJhUjG1gkT47kGP
         itBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584101; x=1707188901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj+P9xrjx2fVS1ypKdmJNYGvbVzBBTf7MJvPcLc0yRI=;
        b=kMg6Zeu/ZcvxgtAnvGShZoKmE6OJjb4XpQpG9p+U4UNenLbdo24LMBoV+jsZpCbZpV
         SpCXObVtQ+2u5AOupmkknZi7fcefs9Zvgo0K/deOS0AGsJsIGDFj6Luad7EpSA+QUgtQ
         yw4cNg3CYAGf7LrAashZxN0K1MsL2sgZd/n9aMGUpuuAIweyH3VHOybWk/gNQwkB9ic0
         sKGyif8UlWVHKJEGiFA3FQAy8Wv65XDBDvxfepPWNt+OWEK8Xzfg/QuR44q5ifxTQfgx
         ZwOA6EP1AAzAJkvaNYbtPhDP8VfCszAzY97/ufYWSN95JH9U3wWXCD7YIyHLJwQ+7tdw
         frNg==
X-Gm-Message-State: AOJu0Yz9O8OXWnmMIHPG0dW9lOa8JrPXUZ3kkG8l+/uQKqgeRpX6PK9u
	cRUY0b7Q1E5aTBuZPIjFeESYQez05afLGU85xWuKKA7RBGLaBbfU2z44xx5PuhxCMWpIhxQM33n
	klUJFBheS6GQ6qNRTpt45FjIrJ80=
X-Google-Smtp-Source: AGHT+IEUBwGdagOtNNDXnC/PkslqtTnUcalzOpaQ6iXfk8Y75IeUUiEjJkcKdHRkmkh3SiBuFcgOP3JPXkmJHjLmEC0=
X-Received: by 2002:a05:6902:2307:b0:dc2:252b:d937 with SMTP id
 do7-20020a056902230700b00dc2252bd937mr5586928ybb.60.1706584101022; Mon, 29
 Jan 2024 19:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <ZbfSP6xt6JAE2NrH@tiehlicka>
 <CAK1f24miiADZCpugOa4QUmerG70kOsMT97Zvmy=5ifOG4mW=+g@mail.gmail.com>
In-Reply-To: <CAK1f24miiADZCpugOa4QUmerG70kOsMT97Zvmy=5ifOG4mW=+g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Jan 2024 11:08:10 +0800
Message-ID: <CAK1f24=2YE+BCYiizkqc8rmN8NaFv_Q6ZtE+4DiFK0PpcefOrQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:12=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hey Michal,
>
> Thanks for taking time to review!
>
> On some servers within our company, we deploy a
> daemon responsible for monitoring and updating
> local applications. Some applications prefer not to
> use THP, so the daemon calls prctl to disable THP
> before fork/exec. Conversely, for other applications,
> the daemon calls prctl to enable THP before fork/exec.
>
> Ideally, the daemon should invoke prctl after the fork,
> but its current implementation follows the described
> approach.

In the Go standard library, there is no direct encapsulation
of the fork system call. Instead, fork and execve are
combined into one through syscall.ForkExec.

>
> BR,
> Lance
>
> On Tue, Jan 30, 2024 at 12:28=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> >
> > On Mon 29-01-24 13:45:51, Lance Yang wrote:
> > > khugepaged scans the entire address space in the
> > > background for each given mm, looking for
> > > opportunities to merge sequences of basic pages
> > > into huge pages. However, when an mm is inserted
> > > to the mm_slots list, and the MMF_DISABLE_THP flag
> > > is set later, this scanning process becomes
> > > unnecessary for that mm and can be skipped to avoid
> > > redundant operations, especially in scenarios with
> > > a large address space.
> >
> > Is this a real problem? I thought that the prctl is called
> > on the parent before fork/exec. Or are you aware of any
> > applications which do call prctl late enough that the race
> > would be actually observable?
> > --
> > Michal Hocko
> > SUSE Labs

