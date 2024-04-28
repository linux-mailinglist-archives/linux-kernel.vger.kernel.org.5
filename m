Return-Path: <linux-kernel+bounces-161501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5787F8B4CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F5B2146F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70956FE07;
	Sun, 28 Apr 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="NW6/8fqJ"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18A73177
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322495; cv=none; b=jgWX8w2P8mkMPBP24jCeh7Cosi37jjNiL/75W+ORFWRYn4zdbi25bdDJ+Gj6DmFzOl3uVW0w/lHb22kRVSxZkPbqQarmjdL9+HFnQBsM0lbUbXdHXyATOXyLbquBuXG/oPA4qF65XGEmGFgdCcja/mFLrCvvucRmezylfQFkQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322495; c=relaxed/simple;
	bh=e9kozUVYrHIwrCQGcfpV/ZYobiatodQ1z9SiykSi/TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdp5RKjBVRtvl1E1sJMwcNsrRrv6+zqRIRWyHzyxITw81b8oolGr6tqrw0WWUzZ0tHJMh8oHO0p6KvXU9c5IFyfStRRm+4ak7uoC48hT60DCRbb7yMuhu34ZCNqW8JB3myLLXiraypYpEOi7qbd8PtzWr3EJpK/lh9rWgNZsQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=NW6/8fqJ; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dcf9659603so961177e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714322491; x=1714927291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34jZPs9Eiu4Qw7ZtmIIlooQKHvZkQc1XBH5UVUDjhOE=;
        b=NW6/8fqJ+KdO/DzZrbNCTHib82w9uzAfVxzbzF5B174BLRoEJo1OlmWTErs4rBQI1Z
         r00CQkONj79FwD5v3l1P2uOvR3yX4Tbo79HOZw1svG64XX7ksPBYy7E4HlsQb2xJG6QT
         BnkLBfFkT9qz3L6gM3Rb6YN9BQjWQof4fCOnR9DloKu7i0fBMKV+cbCiOGQbjaIO+6oF
         4VLTPAkYRktWEJmAHsJUOg1mS2scXHK1k/kr2lDgRkHbjfyBY/sTKrZjNw1eYOe36Oej
         PhcMckUbpvccKIUrq1v08nnAt5jFpYfnABQr3IOLxePNRj1mzC34SUPxgK+KWOvAQlXS
         M38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714322491; x=1714927291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34jZPs9Eiu4Qw7ZtmIIlooQKHvZkQc1XBH5UVUDjhOE=;
        b=hQK5G9fVkbDQKiXJ6c6NvTdkSfduP01VVitrpazKIQbWbboBC9aD6x6u1XcWcx2IzD
         mSZnZYb+ADVfV48BIfBYuMXbWAHPn8ELnh/oCkvbRZaxVaL7e8+mYSmn5x5ZQalfd6ds
         P7h3yUFxWw9bICYhC+8HNZuuOBR1AauMnlfamEQPmwxndVQ8aVaB8aWV4t/N4MsxZ2vG
         XOM8tIZAYkpin36w4NnZXwhNYdTbrBwf/a7YpKzeKi9uf1VUPxo2jgA7FttGDQFSO8j0
         3b4fBYNgqtca+wRb77qY8SXdBetjBoFzSLGhe7xLolrZsI6qzuEv9rl2a/kGUz6D/HxP
         Z7Ww==
X-Gm-Message-State: AOJu0Yw16s5V+hKvuBKRG9nd+26rF0i6AWkLhMnjVLT68qx+J+23zSFh
	oPkJUTg4dxJ6WyAUmwuSfbyvvZHwupa3amFWGU5tt59mbkWVpQJRgMMrSWcWIUQybGtaYwyb8Pv
	2htAjsQAef1/AFgRxkFPQD63DYjZZSN07F1LM+tw1q1urmGg=
X-Google-Smtp-Source: AGHT+IHLdpt/9XWo4+d0fq5u+aGoe2Xweu2bbEMtHa8Q4gbQxrfJ/vnch45Ynf8rpTHz6dgnxhOkWQ1+y1wLqy+FQw8=
X-Received: by 2002:a05:6122:251e:b0:4da:704f:7fc6 with SMTP id
 cl30-20020a056122251e00b004da704f7fc6mr8248281vkb.15.1714322491304; Sun, 28
 Apr 2024 09:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru>
In-Reply-To: <20240426133310.1159976-1-stsp2@yandex.ru>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 28 Apr 2024 09:41:20 -0700
Message-ID: <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Stas Sergeev <stsp2@yandex.ru>, Aleksa Sarai <cyphar@cyphar.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Apr 26, 2024, at 6:39=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wrote=
:
> =EF=BB=BFThis patch-set implements the OA2_CRED_INHERIT flag for openat2(=
) syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLO=
W
> flag. This allows the process to pre-open some dirs and switch eUID
> (and other UIDs/GIDs) to the less-privileged user, while still retaining
> the possibility to open/create files within the pre-opened directory set.
>

I=E2=80=99ve been contemplating this, and I want to propose a different sol=
ution.

First, the problem Stas is solving is quite narrow and doesn=E2=80=99t
actually need kernel support: if I want to write a user program that
sandboxes itself, I have at least three solutions already.  I can make
a userns and a mountns; I can use landlock; and I can have a separate
process that brokers filesystem access using SCM_RIGHTS.

But what if I want to run a container, where the container can access
a specific host directory, and the contained application is not aware
of the exact technology being used?  I recently started using
containers in anger in a production setting, and =E2=80=9Canger=E2=80=9D wa=
s
definitely the right word: binding part of a filesystem in is
*miserable*.  Getting the DAC rules right is nasty.  LSMs are worse.
Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly disg=
usting.  I think I
actually gave up on making one of my use cases work on a Fedora
system.

Here=E2=80=99s what I wanted to do, logically, in production: pick a host
directory, pick a host *principal* (UID, GID, label, etc), and have
the *entire container* access the directory as that principal. This is
what happens automatically if I run the whole container as a userns
with only a single UID mapped, but I don=E2=80=99t really want to do that f=
or
a whole variety and of reasons.

So maybe reimagining Stas=E2=80=99 feature a bit can actually solve this
problem.  Instead of a special dirfd, what if there was a special
subtree (in the sense of open_tree) that captures a set of creds and
does all opens inside the subtree using those creds?

This isn=E2=80=99t a fully formed proposal, but I *think* it should be
generally fairly safe for even an unprivileged user to clone a subtree
with a specific flag set to do this. Maybe a capability would be
needed (CAP_CAPTURE_CREDS?), but it would be nice to allow delegating
this to a daemon if a privilege is needed, and getting the API right
might be a bit tricky.

Then two different things could be done:

1. The subtree could be used unmounted or via /proc magic links. This
would be for programs that are aware of this interface.

2. The subtree could be mounted, and accessed through the mount would
use the captured creds.

(Hmm. What would a new open_tree() pointing at this special subtree do?)


With all this done, if userspace wired it up, a container user could
do something like:

=E2=80=94bind-capture-creds source=3Ddest

And the contained program would access source *as the user who started
the container*, and this would just work without relabeling or
fiddling with owner uids or gids or ACLs, and it would continue to
work even if the container has multiple dynamically allocated subuids
mapped (e.g. one for =E2=80=9Croot=E2=80=9D and one for the actual applicat=
ion).

Bonus points for the ability to revoke the creds in an already opened
subtree. Or even for the creds to automatically revoke themselves when
the opener exits (or maybe when a specific cred-pinning fd goes away).

(This should work for single files as well as for directories.)

New LSM hooks or extensions of existing hooks might be needed to make
LSMs comfortable with this.

What do you all think?

