Return-Path: <linux-kernel+bounces-15919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD268235AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359062872D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15A1CFB7;
	Wed,  3 Jan 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m89O3CLD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB21CABB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so45809845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704310610; x=1704915410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q+wleYTjlKVw1gwa6bQnfYoG2GXCx6G//S/6xsORHU=;
        b=m89O3CLDyqD/4YB+DM7HqkmkA4JJfy9GN0lkw3ixKrBcO1wB5SsRzTrvLVDT4WTdp5
         FvWbDQVCRFhFgwVDemsFhaW8Mo71xKwWm0xhAPapM/mo5COOlaWcsQJD9kAYf+DwlG0t
         hvQLFvLricfEr20taZaNNQRIFnYNsyaF5S2BOVWGDjaWw2ldbS2f3eQKhocGAK9O4Nj+
         8kPp9sFGv/ayjsHz24H9GmZ32ovAn2jpLTI73ILXOS8cCtICr6/X0dDAdVLQNrWzLLwj
         AtDMJIuJuO8Y1THmG4pKHdvu+eWQy3rL18nWHS9Xhdbg6hRpr2bBqcNFWmpvjWxO0W7U
         tVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704310610; x=1704915410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q+wleYTjlKVw1gwa6bQnfYoG2GXCx6G//S/6xsORHU=;
        b=Pg80iHWGqAxnSPWm/iA8voKGICCfGbRKxamPjuEFBjE3nsXHBCyNVo5w8kDHUe3S8Z
         8ftKf3DcVqUX3CHy+8v6J7hZeaLWk2F96k6/Luk0EhpTMh8Yw6zVxdC+fvJO8nxyYxFb
         DdSoO7kGM0ya90W5KkeKZXhveAh9C0E3Ccpr5mxHNA4ntbkMQl4FJU8ih1ZOcCq5N3d7
         SM9Od46yR0wAYMU7jT694cN8GN4NKG7x08IEI/io60SYrAlHTo5ERghHkRAB6ZeCMAyw
         2zqKdzdnfKdjeVPGe3UyL1CfrDoshjcTMVsBypddzEvcXSJIrILRO2eJxjyjOL045s03
         OmMw==
X-Gm-Message-State: AOJu0YyNyPSKYeQmXGz97hRRwPFfF35Tj+KsV+burQ+dWn9CEKTqBRt7
	KRTqbQ7pPK9GRJHNsmknir59QVHZ/FjVVDEOFt24EdjwrtHN
X-Google-Smtp-Source: AGHT+IHNA6ayZz1sCFRyPvatEBkiwUADp9akDwlFEFBI80rwJBQ9lPFtacKq4ZCpqLY2bvFzW3mGB/DyUDJLJ66sSNk=
X-Received: by 2002:a05:600c:3492:b0:40d:8f77:d463 with SMTP id
 a18-20020a05600c349200b0040d8f77d463mr833953wmq.103.1704310610212; Wed, 03
 Jan 2024 11:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228-extable-v1-1-32a18c66b440@google.com>
 <20231228212511.GCZY3nt3gKI+aDvSF1@fat_crate.local> <CAE-cH4rEWU-+ovwo8_-i3b2F8pK17kORJ3gV5tnjnUpRJA+B0Q@mail.gmail.com>
 <20231229093942.GBZY6T3knaGKpeRA9a@fat_crate.local>
In-Reply-To: <20231229093942.GBZY6T3knaGKpeRA9a@fat_crate.local>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 3 Jan 2024 11:36:35 -0800
Message-ID: <CAKwvOd=aSQq3mcxGe-csNcygFWCbq03CPYFyc5DhjyvL_qYPAQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: shrink vdso/extable.i via IWYU
To: Borislav Petkov <bp@alien8.de>, Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 1:40=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Dec 28, 2023 at 02:01:20PM -0800, Tanzir Hasan wrote:
> > The intention with these changes is to add up the impact of these small=
 changes
> > over time to improve build time and also use more direct inclusions whe=
re
> > possible.
>
> The problem I see with such "changes" is that it'll be a never-ending
> stream of them because over time, headers get reworked, moved, changed,
> split, etc and one would have to do such reorganization again.

By being more precise in what's necessary via making more specific use
of includes (making "indirect" includes into "direct" includes) in the
.c files, it will allow us to more easily refactor the header files
themselves.  Otherwise changing the .h files may necessitate updating
multiple .c files to fix this anyways first.

And yes, these inclusion lists will change over time.  As you say
below, they can be cleaned up again every couple of releases.  Though
right now most files have never been cleaned up at all.  If smaller
translation units like arch/x86/entry/vdso/extable.c don't change
often, I don't expect churn to those files even between multiple
releases.

> And I'd understand it if the benefits were higher than what you're
> seeing. But right now it looks like unnecessary churn.

Over time, they will add up. But not if we reject the patches as
unnecessary churn.

> Dunno, perhaps one could do those in one single patch for, say,
> on arch/x86/ or so, and show a before and after wrt numbers.

Maybe the overall numbers are interesting, but landing one patch that
updates numerous .c files' inclusion lists seems error prone.  I
suspect it's more likely that a more incremental approach of smaller
patches allows progress if there are any issues; a build
failure/mistake doesn't block the whole thing from landing.

Overall numbers can also be collected after the fact.

> And then do it
> again in a couple of releases, when it becomes necessary again.

That's the use case I had in mind.  Though I suspect the initial run
of this tooling will result in the most changes, as some files in tree
are hardly touched between releases. For those, I don't expect any
automated tooling to be churning those files after the initial
cleaning.

> Or one could run that tool on patches which haven't been applied yet,
> patches on lkml.
>
> Patches which touch headers or add #include directives and then reply
> with an automatic report to them, saying something along the lines of
>
> "your patch has a suboptimal include - if you include this and that,
> it'll improve build time by this and that"
>
> and then people would incorporate those changes and right then and
> there.

Yeah, the idea is that the tooling results in repeatable processes by
others.  One could imagine build bots running this, or integrating it
into checkpatch, or git presubmit hooks, or w/e.

But Tanzir's internship ends Friday, so he won't be building such a
service by then.  Something for me to keep in mind though for sure.

> But let's see what the others think first.

I have some feedback on the v1; I'll post it inline in another reply.
--
Thanks,
~Nick Desaulniers

