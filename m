Return-Path: <linux-kernel+bounces-161561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D482F8B4DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4076A1F2126D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5174BE8;
	Sun, 28 Apr 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="IOsJQkew"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41297350E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335562; cv=none; b=LBgaCnmnp2LhhebpsOpBYLynTZyvnu0lvTMaURI2iVoT/e1dCM1Ft/s7o4n+Vv1iS3GI1UJGqx3ko5DeRHdITZOrLwYEyNU4PF6GKooBwJraOHJkpP080BTtbJD3k5StLIi5alFC0+1aPoO3EBFTIDo8UTijL00XXJnqbn5KvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335562; c=relaxed/simple;
	bh=1D4BeQM6t2ZEoGkKh0mFVZL/ht0rUhCq2wB6mxulAM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izwmx5pVnNIIRCAXrUb2C809cFtX8m7fXWdMBAecwvltiDwL8eJJq1IWbYsUp0UgG48x6Xf4FJyRPQraPio9c8oVAKvoh5leAvlVO8X66pvxLwDLF0dyLcYoCHw/F1fz4oQXlqdP9b/rh0xU4CV3+5hTN3nnKrG1Bz6VCqt80KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=IOsJQkew; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7f00a9fc1f4so604093241.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714335559; x=1714940359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36fCDwL4QpR+lpjC88HY7LLvBoa6Q/B+CIUJ2PbdlPg=;
        b=IOsJQkew67z2J8MFeJ728IHno/MCipwRfQ/47FeuyrLveN9+30o7j+pZutU92aD9Mu
         InZq/1ZC2TgCOBnPvWGZglEGabMML1snqaxsAAmw9EQs5ITmadiqiK0Y17ZV/Q3TPOcF
         hnhktkwf5R0FKh8bUGoqP/bNh8FHpZKtRZbEXAIhQROVcKH+BXw9KFIazLOQjpjMMIw2
         QpdKVHLG8gxWsj4e0usKeGwH6eG+aEFD8e7BE20C+YptUaxUdBEuTO77QpLZKwh+c5km
         6S/0drlFLHMwmVshu8wSV3llXje+/0Hz7SXntbl4bQtvMCYKMDXVu32O8riQiAQJm3/e
         B1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714335559; x=1714940359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36fCDwL4QpR+lpjC88HY7LLvBoa6Q/B+CIUJ2PbdlPg=;
        b=sNynLnZcm13K1GF4GIPkkz5ykVaKqWAcPPq09rvVawqJv5grGfm9MD1OkDtGbU6oOS
         gYYifgz+llGgaNmjY4NstMVnrPzUCQ6RXLefHtvAdtHx7sTdl2C+dAmwSihKniM/gP1l
         d/oSzAIQ5cyWk8k28yLktrVs2eB6IYJbfoxuZrsQYUuiKQJbSkqJ5bopf9qbf2ApplVo
         WIHYT4g5y3rynQ8uU1d+HDhNxzT7SGsU9+8YaohUI4LOZrX4RXa78jWRjsQSldldCosi
         JVBqQojYzKTrGiGY/1Tc7VbA1nSe/NkesYJub1r9Jxc8JDPUwZQLSBl442PupFWVZZTV
         c0PA==
X-Forwarded-Encrypted: i=1; AJvYcCXBLL3TUGm504LyvX0O8j5QMOrkYlSijq1kE0PH6/loL+UntM7HSyTu44AbFziA+FCrBXS2Rab+p7Y+lKiIWnEHkVWPjAI8lNmODWU0
X-Gm-Message-State: AOJu0YwAFH6qzYv2XSFZF/KftaZhS97eHRVoT7MnBe+yr02Y8feGl1x6
	ZYfdCsH/AaegAhBwB1BWRTVRg4yoxnSxYeFZdTMYBMh+A7uJmDzCxl29ba1M2yYEK58Tu4LqS5Y
	JyuqYYSUZLoZH9uZ6xI8oZRGAeUp8aNK3ydv/
X-Google-Smtp-Source: AGHT+IG0My1Hqbni+IOGNwO0pySC/admrMzXzXRHBEODkcWXia6GGjbJ6CRgLufp99V4j0nvPduiCBXFwutwjlar0/s=
X-Received: by 2002:a05:6122:99e:b0:4dc:fbc5:d47 with SMTP id
 g30-20020a056122099e00b004dcfbc50d47mr7210015vkd.16.1714335559590; Sun, 28
 Apr 2024 13:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru>
In-Reply-To: <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 28 Apr 2024 13:19:08 -0700
Message-ID: <CALCETrVioWt0HUt9K1vzzuxo=Hs89AjLDUjz823s4Lwn_Y0dJw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: stsp <stsp2@yandex.ru>
Cc: Aleksa Sarai <cyphar@cyphar.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Apr 28, 2024, at 10:39=E2=80=AFAM, stsp <stsp2@yandex.ru> wrote:
>
> =EF=BB=BF28.04.2024 19:41, Andy Lutomirski =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>>>> On Apr 26, 2024, at 6:39=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wr=
ote:
>>> =EF=BB=BFThis patch-set implements the OA2_CRED_INHERIT flag for openat=
2() syscall.
>>> It is needed to perform an open operation with the creds that were in
>>> effect when the dir_fd was opened, if the dir was opened with O_CRED_AL=
LOW
>>> flag. This allows the process to pre-open some dirs and switch eUID
>>> (and other UIDs/GIDs) to the less-privileged user, while still retainin=
g
>>> the possibility to open/create files within the pre-opened directory se=
t.
>>>
>> Then two different things could be done:
>>
>> 1. The subtree could be used unmounted or via /proc magic links. This
>> would be for programs that are aware of this interface.
>>
>> 2. The subtree could be mounted, and accessed through the mount would
>> use the captured creds.
> Doesn't this have the same problem
> that was pointed to me? Namely (explaining
> my impl first), that if someone puts the cred
> fd to an unaware process's fd table, such
> process can't fully drop its privs. He may not
> want to access these dirs, but once its hacked,
> the hacker will access these dirs with the
> creds came from an outside.

This is not a real problem. If I have a writable fd for /etc/shadow or
an fd for /dev/mem, etc, then I need close them to fully drop privs.

The problem is that, in current kernels, directory fds don=E2=80=99t allow
access using their f_cred, and changing that means that existing
software that does not intend to create a capability will start to do
so.

> My solution was to close such fds on
> exec and disallowing SCM_RIGHTS passage.

I don't see what problem this solves.

> SCM_RIGHTS can be allowed in the future,
> but the receiver will need to use some
> new flag to indicate that he is willing to
> get such an fd. Passage via exec() can
> probably never be allowed however.
>
> If I understand your model correctly, you
> put a magic sub-tree to the fs scope of some
> unaware process.

Only if I want that process to have access!

> He may not want to access
> it, but once hacked, the hacker will access
> it with the creds from an outside.
> And, unlike in my impl, in yours there is
> probably no way to prevent that?

This is fundamental to the whole model. If I stick a FAT formatted USB
drive in the system and mount it, then any process that can find its
way to the mountpoint can write to it.  And if I open a dirfd, any
process with that dirfd can write it.  This is old news and isn't a
problem.


>
> In short: my impl confines the hassle within
> the single process. It can be extended, and
> then the receiver will need to explicitly allow
> adding such fds to his fd table.
> But your idea seems to inherently require
> 2 processes, and there is probably no way
> for the second process to say "ok, I allow
> such sub-tree in my fs scope".

A process could use my proposal to open_tree directory, make a whole
new mountns that is otherwise empty, switch to the mountns, mount the
directory, then change its UID and drop all privs, and still have
access to that one directory.

But even right now, a process could unshare userns and mountns, map
its uid as some nonzero number, rearrange its mountns so it only has
access to that one directory, drop all privs, and seccomp itself, and
only have access to that directory, as it still has the same UID.
Take your pick.

