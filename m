Return-Path: <linux-kernel+bounces-22686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88682A196
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AF71C25928
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28D4EB3E;
	Wed, 10 Jan 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fT5Mq6ZE"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2D4EB41
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed85ec5b5so3294931276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704916480; x=1705521280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/hfrnVExDYqMdaTvnynkIXfxZrxfgxNKbtbeKbU3kM=;
        b=fT5Mq6ZEvZz3g1c0g6hl115h6xwHXmlj2XF4oViJMCd5RqCeDWWzElaBxHEaRVCCTs
         kcV4A+Sudpq8E9effGebMYeVZjuS6DcRIMFrf8yWL1Kyz3s3gYumDoQzI5OwlOLkzwWB
         NaHPGbJqARi0mYfkt85JWxba83fF8+y1D2GsqbrAOqQZu1EbidIPEGGL1ZsDACCRb5QB
         +q3N7F+Rm87giNpxHEX6EcI1/Azkb0P9Xb15qAaYFSbj2dg7TRDG/vgPZV8meUHZm68X
         mQtShDsaDvSScjQ7phHdtTidMAOkFZMP8oxOvS/LJ13pgjAK6zzMwp7BcB7fhl1ed70r
         Vn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916480; x=1705521280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/hfrnVExDYqMdaTvnynkIXfxZrxfgxNKbtbeKbU3kM=;
        b=kqwvv3wfP2R9jv3B+Dh5TvoOrL0zSJe+LJhEPzBeDNMAnplif7oOOK5UIEqGcygrAu
         ev2dOHyCwZJSmxzdvvG3R4aImaRCWs7g22akdCHwECQFLqp8x7pBZJgqQQ1vDyzjzGfq
         mHs5IU94EC/M5Af2QjbDT2FmAUvaKs7vEmwxOVT8To1o7jHV5gUHZnmSskkSFNITOqpM
         bGGAxYYhmFUa+whiFMnWocRRjCwPHtGNS8Uu+GkpNUbOm+/q9zLjUpClkRexQNOgfpMD
         fRokaBi2GuTbCqHZs6T9dutEODYsQgy52qwDzuWK1Ds1dHOq7dDWnVw3ASeucVZ3ByCt
         AIcA==
X-Gm-Message-State: AOJu0Yz/+nID0mm8KXsPmv4AT+veWe6bGQf+JejwdINesBra4rsv5r06
	A2nHtYWPf1qeyvsbXxFlbQlNCn4tANpDa5rcxZRAOZynmixaWaUzDabAdXc=
X-Google-Smtp-Source: AGHT+IGvZCI+F+FwpL/ZIhlX7CQPQ5vAvxAFE+gVVi4dDNySfAgDpRAdF8JtZ8KeMWQg+aT7Kmy/w22fIW/M4+oIgyE=
X-Received: by 2002:a25:738f:0:b0:dbd:98c4:9358 with SMTP id
 o137-20020a25738f000000b00dbd98c49358mr110765ybc.91.1704916480297; Wed, 10
 Jan 2024 11:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com> <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
In-Reply-To: <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jan 2024 14:54:29 -0500
Message-ID: <CAHC9VhRxG2jYayjpC=bLuBpfZsXnfYj_GoDBeK527sZWRe0ZrQ@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 5 Jan 2024 at 15:21, Paul Moore <paul@paul-moore.com> wrote:
> >
> >             The hightlights of the LSM pull
> > request are below, but before we get to that I want to mention that I
> > expect you will hit merge conflicts in the arch-specific syscall
> > tables as well as in the doc userspace-api documentation index.  Some
> > of these conflicts exist in your tree now (syscall tables), with some
> > others likely depending on what is submitted from linux-next and the
> > order in which you merge things.  All of the conflicts that I've seen
> > have been rather trivial and easily resolved, but I wanted to give you
> > a heads-up; if you want me to resolve any of these let me know.
>
> The tooling header file updates by the LSM tree were particularly annoyin=
g.
>
> Not because the conflicts were hard per se, but because you had done
> the header files wrong in the first place.
>
> Your version of the tooling header files just didn't match the real
> ones, as you had added your new system calls at the end mindlessly,
> without noticing that others had *not* done so, so all your tooling
> header system call number additions were just the wrong numbers
> entirely.
>
> I fixed it up, but it added an extra layer of "this is just annoying".
> You'd have been better off not touching the tooling headers at all,
> rather than touch them incorrectly.

Thanks for pulling the changes, I'm sorry the syscall table entries
for the LSM syscalls were not how you want to see them, but I'm more
than a little confused as to what exactly we did wrong here.  A more
detailed explanation would be helpful; if there is a doc somewhere
that explains the process, feel free to just drop a pointer.

I did provide a note in the pull request that based on linux-next
there were likely to be some conflicts in the syscall tables, but that
was evidently not sufficient, or we just added the syscall tables the
wrong way.  Your reply makes me believe we added the syscalls to the
arch tables the wrong way, but looking at your merge commit and the
files themselves (no helpful comments) I don't see anything obvious.
Quickly scanning the kernel docs doesn't reveal anything related
either, although I might be missing it.  The patches also didn't get
any comments regarding the syscall tables during review, and aside
from the numbering conflicts in linux-next, there were no comments
along the lines of "you need to do it this way" there either.

I want to do things The Right Way the next time around, but I need
some help to understand what that is ... ?

--=20
paul-moore.com

