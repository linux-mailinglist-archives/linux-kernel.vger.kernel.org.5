Return-Path: <linux-kernel+bounces-6074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680C819440
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889D71C240C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2B3D0D8;
	Tue, 19 Dec 2023 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nI3bK0KZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA33D0CB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so55767285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703026842; x=1703631642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZwm6JZ4sNLkRRVAKkvheMbMEQKEA6/K7E70Hl7Hv90=;
        b=nI3bK0KZHuuYrQYjZ4Ui3o7Qn6H1AvP7cyIHFSj7XWv1ykGLB6EWaFvRFywRG5r087
         5+rnc6ZhxbmXjRGm6n0zZYJUCiyWVX4kfySvWKhHZw2gBFsyZqSEnGu0PcnH/ytz64Lq
         1oERebigTAx5qYhL+HvF7zVURd8nGIqJ2nf6Hdu9EfPyZ0T19EHnQ1T8Zc7q8sGCKWU3
         S9Aaay9CncZVMYht/J2+m/l85y90XcFXLp0OCgisokaim7k+yZOxXVrQWcQY9yw0MvzG
         JnFxPl1saIALU8Sky/zNKC2G+sZnJgs/bvM8p1s4ex7RQD2cyCk99tXY3klTui6R3Pg/
         CF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703026842; x=1703631642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZwm6JZ4sNLkRRVAKkvheMbMEQKEA6/K7E70Hl7Hv90=;
        b=kwTTI2nYwOlxznT3s7av58qabW1Dbi9wy9Eif9gBhaAWaC7iIe8mw6Eac9kHYXrzUd
         Afy0J2iQBg/e+83u8RKnr/BrgtjNzJTkk7JYWRrs0UKPwBbWm9qhR+BnLueRTsanHoiX
         8luZG006b3aFd1A4RJbfwQhQdUUtAbrDtDW20svTbgGEIavLwg1+Uek4pnb9Vn4vrfKD
         UcipOlOJRZBmz0SMEQLt2Pb5Y4bXFPrafbrSEDEgxE8Of5Vbt/EgYsWgKjsw1tXa+uDz
         aL3gO4J7MGrWqmvmjdvCegS3HKQGeOEbW3GzAfaDLkGkcuoBIdRTO5LXLHYKHFv9Wa5Z
         ZV0A==
X-Gm-Message-State: AOJu0YzjOfRuS5UinLeJrvmwBUbElScqLL1DktsKUS41aHu6vJTpCu6I
	3/8lBQz/yEClobR6yOMiZianVmuW8u/i27huj0nh9Q==
X-Google-Smtp-Source: AGHT+IFDk+YH98DmlhP5rDwghASFHtsZ/cHCbLg8dD2/9C72D6slrbK8ZNqM/SwdSooilIR08O9ljo3i9+rmU7rlaP4=
X-Received: by 2002:a05:600c:5486:b0:40c:6e0b:69e4 with SMTP id
 iv6-20020a05600c548600b0040c6e0b69e4mr4366526wmb.18.1703026842524; Tue, 19
 Dec 2023 15:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
 <20231219-libstringheader-v4-1-aaeb26495d2f@google.com> <2023121938-stargazer-purse-0dc1@gregkh>
 <CAE-cH4p-TzH3zyJfmSg3r=fw78j8y-0t0dp-NvaLyVYAMULw1w@mail.gmail.com> <2023121928-propose-florist-5898@gregkh>
In-Reply-To: <2023121928-propose-florist-5898@gregkh>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 19 Dec 2023 15:00:22 -0800
Message-ID: <CAKwvOdnW_vZyiO3BE=Vce4OrcX4+pb6QrEFbmeya0Z+w_5d=zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
To: Greg KH <gregkh@linuxfoundation.org>, Tanzir Hasan <tanzirh@google.com>, 
	Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> > > Legal note, this file is NOT copyright Google as no Google employe
> > > actually wrote the logcal contents of it.
> > >
> > > Please be VERY careful when doing stuff like this, it has potentially
> > > big repercussions, and you don't want to have to talk to lots of
> > > lawyers a few years from now and explain how you messed it all up :(
> > >
> > > Nick, odds are there's a Google copyright class that Tanzir should ta=
ke
> > > here, if not, I recommend the free LF one that anyone can take online
> > > that explains the issues here:
> > >         https://training.linuxfoundation.org/training/open-source-lic=
ensing-basics-for-software-developers/
>
> Please take the time to either learn what the Google-specific rules are,
> or take the above training, before submitting a new version of the
> patch.

It was my mistake to suggest to Tanzir to add his copyright to this
newly created header. I'm sorry; we do have such resources available
and I should have reviewed them.

I've:
1. reviewed our internal training materials on copyright assignment
  - go/gti-os-self-study
  - go/patching#license-headers-and-copyright-notices
2. reviewed kernel docs:
  - Documentation/process/1.Intro.rst
  - Documentation/process/kernel-enforcement-statement.rst
3. asked Tanzir to do the same
4. discovered who to ask internally for further questions
<opensource-licensing@google.com>

Is there further due diligence you would like to see?

---

For Google specific guidance, I'll quote what they have:

> License Headers and Copyright Notices
> Googlers should add Google's copyright notice (or a "The Project Authors"=
 style copyright notice) to new files being added to the library if permitt=
ed by the project maintainers.

Then the relevant section of 1.Intro.rst:

> Copyright assignments are not required (or requested) for code contribute=
d
> to the kernel.

Shall I interpret those together to mean that the "project
maintainers" don't permit copyright assignments for "new files being
added," and thus Tanzir SHOULD NOT be adding a copyright assignment to
the newly created header?

Or shall I leave the interpretation up to an explicit discussion with
opensource-licensing@google.com?

---

While I think we have the answer for Tanzir's patch, I don't think we
do for if we intend to split other header files in the future if those
have explicit copyright assignments.  I wonder if this question has
come up in Ingo's header refactoring work, and if so, what the
guidance is there?

For example, consider include/linux/sysfs.h.  It's 600+ lines long and
contains 4 copyright assignments explicitly in sources. If we split
that header file in half, which copyright assignments do we transfer
to the new half, if any?
--=20
Thanks,
~Nick Desaulniers

