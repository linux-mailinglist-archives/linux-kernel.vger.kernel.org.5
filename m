Return-Path: <linux-kernel+bounces-89822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6E86F61E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06761F21066
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A226D52F;
	Sun,  3 Mar 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tHI62Hum"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1067C53;
	Sun,  3 Mar 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483519; cv=none; b=Rukedr/ceOa74q5o98/KrVEcCWDz+GwvzYC2ey2VCps6UvM+WIkx/1KmHDaLQUy0iNI1hjsvDt7BUSF/bxhbUW1KxL+XGx/h8v9K9xaT+Jh5AprP7Dc0yyI1UhQbXZFVfuBlSJbbb1CorU8rYZqP607vGEFmKY5i/OhPyvui5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483519; c=relaxed/simple;
	bh=6Yvhhe2kjbUCk6x50Jaz3f46pJmaSnkE5sEIvbMqGzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErrUoO5KZ6dkMqY7BCWSjIsiF3X4agazCsEYSWoVjCkQGs/sd8rzeNMGveTy3dgPViATw7N9C07lfvvGomT7jeaOPWLRQ7ONustNpEHU5rN6fesNUJDtXlT23152nooF59YwTjNBroFdCDzCehMdLNGLbDukS0PLyhs1vzB8VNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tHI62Hum; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A1C9418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709483517; bh=RZ9QyPPIEU1uTzfgh2H7LHMcSBo6RADiP6Tsyr7H0jE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tHI62HumxKmk0icQ7uEOX6tt5aOVeBDD6Q02eKLt4aUFCyiazduBLsZJrntHEUjdv
	 Qk9XmtYSHw6nT31aHQeug8j6DzUuSHJWj2xiKvoz1ASLLoB5+7EKhoYpkWTuXgTf21
	 0BRQUyO0Pegvbu8rjmt+93t0MwIzsgTbEZykWGQwNLNnoYiJiGDEG8BUkfGZs5dRLY
	 KgsheT4iebUvC+FF1bP5EVmo9gIAHLxgy3NQG4ign94DE+HFb8ktEQaP315xbB8apn
	 zfbYICVjO/Jy2pqEhq6Ch4Yq8ckZQM8STXpGiODKyG17Jlp7K03TYvSJwW61BMSvio
	 ts0bPDx/snxAQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4A1C9418B6;
	Sun,  3 Mar 2024 16:31:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 0/3] Towards a re-organized submitting patches
In-Reply-To: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
Date: Sun, 03 Mar 2024 09:31:56 -0700
Message-ID: <87plwbxon7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Dear Jonathan,
>
> I wanted to clean up the development-process documentation. There is
> however no easy way to break the ice here:
>
> The elephant in the room is that there is some unclear relation between
> 5.Posting.rst, 6.Followthrough.rst and submitting-patches.rst.
> (Yes, I know each document has its own history...; but let us put the
> history aside for now.)

FWIW, the objective of those two documents is quite different; one is a
high-level overview of how the development process as a whole works, the
other is a detailed guide to submitting work for consideration.

> Submitting-patches.rst contains information largely put together from
> different initial starting points and is partly outdated due to common
> workflows with git format-patch and git send-email.

You should have seen it before I thrashed it a few years back :)

> For a simple experiment, I moved the larger parts on the tags
> (signed-off-by, co-developed-by, acked-by, reported-by, etc.) into a
> separate document and then ran the numbers on submitting-patches again:
>
>   4329 submitting-patches.rst
>
> Nowt, the size of submitting-patches is actually below Posting and
> Followthrough.

I don't think we should be driven by word counts.  I do think that
moving a bunch of information on tags to its own document could make
sense.

> So, the difficult task to reach a coherent process description is to see
> some relation between these documents and then go through the editorial
> changes. I have come up with this kind of vision:
>
> Phase 1: Clean up submitting patches
>
>   Topics/Statements that can be easily cleaned up first do not get in
>   the way (at least mentally) when trying to understand the next steps.
>   
>   E.g., as an experiment I moved the details on tags into a separate
>   document.

Fine.

> Phase 2: Make submitting-patches have one clear temporal flow.
>
>   The top-level structure should basically be along the temporal order of
>   things: Prepare a patch, Post a patch, Respond to review, Send reworked
>   patches, Be patient before resending

This makes sense as well.  I wonder if splitting the document along some
of those lines might also be a good idea, with submitting-patches.rst
becoming a relatively short overview deferring details to the others.
This is one of the most important docs we have, and it's far too much
for people to engage with all at once.

> Phase 3: Merge the pieces of content from Posting and Followthrough into
> submitting patches if it adds something to that document.
>
>   When both documents roughly cover the topics of similar depth, we look
>   fine-grained into how to construct the one document that has the best
>   from both documents.
>   
> Phase 4: Remove Posting and Followthrough and simply replace it in the
> process description with submitting patches.

In broad terms, this seems like a good direction to me.

Again, let's remember the different purposes of these documents.  The
development-process document is an overall description of the process,
so it doesn't need the details.  But when you say:

> Posting will not be missed.

I don't entirely agree.  But I don't doubt it could be a fraction of
what it is now.

> So, here are some first changes to Phase 1 and Phase 2.

At a first glance, these changes seem fine.  I think I'll hold them
until after the merge window so that others can think about what you're
up to, but I suspect there will be no reason not to apply this first set
then.

Thanks for working on this material; it's some of the most important we
have and it definitely needs some attention.

jon

