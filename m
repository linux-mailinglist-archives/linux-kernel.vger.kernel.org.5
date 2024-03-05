Return-Path: <linux-kernel+bounces-92389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD1871F69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99549283438
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8E8592A;
	Tue,  5 Mar 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBNBeAhD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EA8564B;
	Tue,  5 Mar 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642378; cv=none; b=LvXV5nHkoqlkqhmSadSyhYyQ1ze3kjQ1Qa1kvqW5QchQGHZj8VEfG50Jh5YJJd8muBtEJwEZzndMY13xVppiqd7Y2gIIgAyvADyCEDXCa8vrBxhETahnwYQai9DAZWufl49FRyFpXGQ1WUUOGsDZZNF47ZFLqhpG2VCl2xNoHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642378; c=relaxed/simple;
	bh=ezLq/SOYCqGkMfTLNXZrH22S0sro4+1Jl1Dyq+wOc2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKnmGUD7+1l57jMFDZIY8y2DahvV16fpCiiE6hysvaZzyldbxi4Zpf9dj27zc4LWDOg4zwwYUEMMlz82hf4SoN5Mqqy+T/O5Ir9Hcm4OBN9N0uycxIgzO09lNGRFlRejZVYN4ia1LEgNVZ7MAjCt1vnR5XYHcFlcI5o/PETv7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBNBeAhD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44628725e3so709386866b.0;
        Tue, 05 Mar 2024 04:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709642375; x=1710247175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yezJlEM16+CfY6EoOA0jjgo+Cql82JRNjKq4aNy4a4=;
        b=iBNBeAhDNNviqHFnZP6bBTYqlBKnq+TOz2mOZ0pd9RNRFi65HvRRUxISiRHqOJK0h8
         6eJ4VxsHx9I5KCxFnGp7ykbAJXgdlfWW+3VYPQFu+ZcOJfhv0/86JnxlW6yomKmBopqR
         ygETol6gA17sIwybB0y22Qxi1s2wYFc7682fbo7mV03dVkMM8NwjQNHre+cmP2Gc6dYT
         DXzgU1YxRFbCvHSR0OSV9OIMXDCOj6gfW8OlKUvylME5z6drQGhH40TW0SwCK96qNvXa
         qQF0dE+A31PytTKKrYJSMVTd7NL/Y9KrL3FSR0o7rz2361iAlwo72/3maFCDauI172E/
         K6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642375; x=1710247175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yezJlEM16+CfY6EoOA0jjgo+Cql82JRNjKq4aNy4a4=;
        b=T0Ba1zBSVFfFwtrkKn61w86DsMp3d+y+N+1UeOFSWaUC7YTqjzJLYdr19GOzUOQLbi
         nYYeEnjJcm0fLyrT972C4zzSvFVGY/8ogRIzNSz8SYdfWbsThS96w9pjoDEB6TwOwc9Y
         dxUnQ2tWuRhxZ8/8LwdXUQRw5Zy+6iHK8HLizcmUJNz9LQpUEUc5p55IE0lAV5FVhrM9
         VavrbistpVkLSUxNh4JGczf6D8iuRGeWrVxPvM706tfoGOSKsKlolh34ot06aFIMuMMu
         cw4pLgGAY27ujtHEMfs5K2U+Rl7agkXQJ6Z6WPS+gD36y8prtYYW4zs57rEHbqG3ETpR
         /TEw==
X-Forwarded-Encrypted: i=1; AJvYcCXGfJ6naZ79MlQ78Tu4UgQQpJtrZLlruJ+Md71h6jFqosGGCJnk6Bu4zLmHNvejkTv3+xLmu1mMQgLOx+DRszcFC7zoUMs81QlAMZwDQmb7UXiaivsohNZL+4Fh2cru7vsk2LLTCE/m7lqfS0b2yYzQtXAqHoirV/cxNXvAAX7fuoLJNhzDTH5U
X-Gm-Message-State: AOJu0YzdAEb97xfrX2LnWTu5FXxlgLwVdoxjrddqYkLTyVmyQMVc2sNw
	O1iiE1zEUCux/yV+ONr8IntHLD4sZk1xvRofnazKljYtB5PNb1ANkg7PZahADbZvqW3LXAm+koD
	zK7AA2hEfpsGX98757QPS52vTTini5LvUrgw=
X-Google-Smtp-Source: AGHT+IE9M+7eueWU9j7NIyeP0waYnHpZODoF/MgltiSqasKcB+g9ydSe32wCWJiPFKmICPWxFT6J4Wp1eHko7PeQSr8=
X-Received: by 2002:a17:906:1517:b0:a45:4448:4376 with SMTP id
 b23-20020a170906151700b00a4544484376mr3985527ejd.74.1709642374719; Tue, 05
 Mar 2024 04:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com> <87plwbxon7.fsf@meer.lwn.net>
In-Reply-To: <87plwbxon7.fsf@meer.lwn.net>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 5 Mar 2024 13:39:23 +0100
Message-ID: <CAKXUXMypvMeiRGCXbX2ogJQ4KDBc6v-s7cH4t8Tk9=5NerBN1w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Towards a re-organized submitting patches
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 5:31=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>
> > Dear Jonathan,
> >
> > I wanted to clean up the development-process documentation. There is
> > however no easy way to break the ice here:
> >
> > The elephant in the room is that there is some unclear relation between
> > 5.Posting.rst, 6.Followthrough.rst and submitting-patches.rst.
> > (Yes, I know each document has its own history...; but let us put the
> > history aside for now.)
>
> FWIW, the objective of those two documents is quite different; one is a
> high-level overview of how the development process as a whole works, the
> other is a detailed guide to submitting work for consideration.
>

Yes, that _objective_ is clear when reading the documents.
However, unfortunately, the detailed guide to submitting work for
consideration in submitting-patches.rst really is not that much more
detailed than what 5.Posting and 6.Followthrough already recommend.
A lot of the "details" in submitting-patches.rst is then also just
details on topics that are much more an explanation than actual
recommendation for specific actions.

Let me clean things up in submitting-patches, and then start a proper
comparison.

> > Submitting-patches.rst contains information largely put together from
> > different initial starting points and is partly outdated due to common
> > workflows with git format-patch and git send-email.
>
> You should have seen it before I thrashed it a few years back :)
>
> > For a simple experiment, I moved the larger parts on the tags
> > (signed-off-by, co-developed-by, acked-by, reported-by, etc.) into a
> > separate document and then ran the numbers on submitting-patches again:
> >
> >   4329 submitting-patches.rst
> >
> > Nowt, the size of submitting-patches is actually below Posting and
> > Followthrough.
>
> I don't think we should be driven by word counts.  I do think that
> moving a bunch of information on tags to its own document could make
> sense.
>
> > So, the difficult task to reach a coherent process description is to se=
e
> > some relation between these documents and then go through the editorial
> > changes. I have come up with this kind of vision:
> >
> > Phase 1: Clean up submitting patches
> >
> >   Topics/Statements that can be easily cleaned up first do not get in
> >   the way (at least mentally) when trying to understand the next steps.
> >
> >   E.g., as an experiment I moved the details on tags into a separate
> >   document.
>
> Fine.
>
> > Phase 2: Make submitting-patches have one clear temporal flow.
> >
> >   The top-level structure should basically be along the temporal order =
of
> >   things: Prepare a patch, Post a patch, Respond to review, Send rework=
ed
> >   patches, Be patient before resending
>
> This makes sense as well.  I wonder if splitting the document along some
> of those lines might also be a good idea, with submitting-patches.rst
> becoming a relatively short overview deferring details to the others.
> This is one of the most important docs we have, and it's far too much
> for people to engage with all at once.
>

I understand that people nowadays do not read prose from top to
bottom, as soon as it exceeds a certain length. So, for sure, we can
consider splitting the current content into multiple pieces and add
links between them. However, I also want to avoid that we have say 15
documents of a hundred lines, and you are always jumping
back-and-forth in your web browser while reading. I think the split is
going to be into two or three documents if at all.

I will do some experiments and suggest some splitting.

> > Phase 3: Merge the pieces of content from Posting and Followthrough int=
o
> > submitting patches if it adds something to that document.
> >
> >   When both documents roughly cover the topics of similar depth, we loo=
k
> >   fine-grained into how to construct the one document that has the best
> >   from both documents.
> >
> > Phase 4: Remove Posting and Followthrough and simply replace it in the
> > process description with submitting patches.
>
> In broad terms, this seems like a good direction to me.
>
> Again, let's remember the different purposes of these documents.  The
> development-process document is an overall description of the process,
> so it doesn't need the details.  But when you say:
>
> > Posting will not be missed.
>
> I don't entirely agree.  But I don't doubt it could be a fraction of
> what it is now.
>

When I say "Posting will not be missed", I mean the name
"5.Posting.rst" will not be missed, as the future submitting-patches,
partially existent on my hard disk right now, includes the best of
5.Posting.rst as it is now, namely the natural flow of the
explanation, the good style of writing, being precise and concise and
the ability to address all audiences with a suitable text, e.g.,
newcomers and experienced kernel developers enjoy reading it. Some
important information in 5.Posting.rst should really also be mentioned
in submitting-patches.rst.

I think if submitting-patches.rst is structured and written well, the
development process description can go from 4. Getting the code right
to "5.Submitting patches" and the readers would not even notice that
they once originated from very different sources and authors.

> > So, here are some first changes to Phase 1 and Phase 2.
>
> At a first glance, these changes seem fine.  I think I'll hold them
> until after the merge window so that others can think about what you're
> up to, but I suspect there will be no reason not to apply this first set
> then.
>
> Thanks for working on this material; it's some of the most important we
> have and it definitely needs some attention.
>

I will continue working on it and see what I consider stable enough in
moving around that it deserves to be posted to the mailing list. While
working on the document, it is unfortunately a lot of temporary
movement back and forth, or huge changes at once and it is a bit
difficult to then extract the next natural change to propose, but I
will see how I can present this best piece by piece.


Lukas

