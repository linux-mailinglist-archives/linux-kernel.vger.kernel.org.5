Return-Path: <linux-kernel+bounces-132220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC63899195
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381C51C208B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE99E130E57;
	Thu,  4 Apr 2024 22:49:25 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6B71B40;
	Thu,  4 Apr 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270965; cv=none; b=Umcr1AUu7BwaXg64Z+Rh3gknmHzHoFlLootqw08jKEmVd74zMZnLnqeQK4J56mSA0P5BsRGhvux+r3CvqRbpcsExaaEmviDvdKBEedx2/g6oNNxl26p3RGDlHbu+xRnIO4wEKYmWYea+7fNR9Kft+GcZnk9Vl+j+XoPwOsTjpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270965; c=relaxed/simple;
	bh=hOmqtaPuDcUDJb3OAuCylRtdcTYsjCjtbYP5/kyv0Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD7XPfFhe9Swosp+YVSaPCMLXp+5tkmBTBkXh+IBljior5PTNgZmflz17OMf9jW7zTwnjLu//GVYdL5SGeYoJ/3MXQFb8UTtLq1wdGGBdCfE38MUkWjNp+JQRHJRwHE5IvCQOLjge7vW7NKSRuGQVVkvfJdDkOEeALjpzIXUz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36898a6f561so6027315ab.2;
        Thu, 04 Apr 2024 15:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712270962; x=1712875762;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFFpA9bEHkRKIdpgNfnr4LrTcex60eHjwoddAW5RWRg=;
        b=quqLoWONUl3vXCUymswHrR5uPEVPcjcw/RaQxGCbtzAKHM6MedV8FIZh9XCyFMu24L
         VdzAvgiyu3lfnCaRUa7BKU+myEmAlHMQFQtpQLDhXjAFr2A0WkI/8LJw5ypEkDhlnNnV
         75wJXMw5kSC3LUeQ1tgOKqnp0AO2hhQfi3VHsS9E6kQ9uUmd2Xzp+astS6idNYP8eEA8
         pm4q1iC+aHHSk8/2Xl6cJKK/TLofq/L/UJJN336dH2tSquaFBnSQ+q5XKzFG9MzruU27
         YGN/0HyP+iNITkiROm9lvhWbZafru/zrG06B9RQcK9NR8jDoYED0PmAIHpGDdYdyf6DU
         XAVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJI0Qm5CyYEdx1U+i8gaZMuzCBs+wLaxVWxvfJEhVRxbKUcCv+OAWAsOIWuLV+W5ybIgsCiL8NI9cy4RNe+ZikuELjO4ikguRTpVsST5oMz/R8TMUvT9jXwNWARxqGaIft
X-Gm-Message-State: AOJu0YwH1Scs7nn5VZpqsQ31vHpi5ibzfTjCYmveYU+Wu/X9C6KuSz81
	JHLhAP7I2Uk11t5H0tP2O6ZGQEjUyJptUwCClryfn6gS59iPs9Cr
X-Google-Smtp-Source: AGHT+IET3/fOxC04QQbEdh4TFFQfVVzr8eZyt5HgR2603QQ1+2YDup4AXc2qQ1cIIWI8E9W0hcwvUQ==
X-Received: by 2002:a05:6e02:2168:b0:36a:64c:6d24 with SMTP id s8-20020a056e02216800b0036a064c6d24mr882930ilv.21.1712270962305;
        Thu, 04 Apr 2024 15:49:22 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id v13-20020a05663812cd00b0047f1d15a663sm189206jas.167.2024.04.04.15.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 15:49:21 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:49:19 -0500
From: David Vernet <void@manifault.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify calling core kfuncs
 from BPF_PROG_TYPE_SYCALL
Message-ID: <20240404224919.GB521321@maniforge>
References: <20240404010308.334604-1-void@manifault.com>
 <20240404010308.334604-2-void@manifault.com>
 <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev>
 <20240404163316.GA385240@maniforge>
 <CAEf4Bza3rGMh=S7yb_Crf8v_SBTrp+NiKn0_frZnWpEi30DkPg@mail.gmail.com>
 <20240404223044.GA521321@maniforge>
 <CAEf4BzbnG8QufsLmsvwHFG2JKjUCNtbKtU8c5Cb56rWR+s8UBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KS4izKu7yfk4waCZ"
Content-Disposition: inline
In-Reply-To: <CAEf4BzbnG8QufsLmsvwHFG2JKjUCNtbKtU8c5Cb56rWR+s8UBg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KS4izKu7yfk4waCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 03:35:32PM -0700, Andrii Nakryiko wrote:

[...]

> > > > > The above RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_=
success)
> > > > > will do duplicate work for *existing* bpf programs in their respe=
ctive
> > > > > files. I think we still prefer to have cgrp_kfunc_success tests
> > > > > in cgrp_kfunc.c to make it easy to cross check. But in order to
> > > > > remove duplicate work, one option is to make other non-RUN_TESTS
> > > > > programs in those files not auto-loaded and their corresponding
> > > > > prog_tests/*.c file need to explicitly enable loading the problem.
> > > >
> > > > Good point, and yes I agree with that approach of not auto-loading
> > > > non-RUN_TESTS programs. Considering that we have a  __success BTF t=
ag to
> > > > say, "this prog should successfully load", it seems odd that we'd a=
lso
> > > > automatically load and validate progs that _didn't_ specify that ta=
g as
> > > > well. At that point, I'm not sure what value the tag is bringing. A=
lso,
> > >
> > > Just more explicitness (if desired). Normally __success would be
> > > augmented by __msg() or __retval(). I'd feel uncomfortable just
> >
> > But __success really has no actual purpose, right? Isn't it identical to
> > if it's just left off? You don't need __success to specify __msg() or
> > __retval() right?
>=20
> right, it's just a more explicit documentation-like annotation, if you wi=
ll
>=20
> >
> > > silently skipping programs that are not marked with __success, as it
> > > would be too easy to accidentally forget to add it and not know that
> > > the BPF program is not tested.
> > >
> > > I'd say that RUN_TESTS-based programs should be kept separate from any
> > > other BPF programs that have a custom user-space testing part, though.
> >
> > IF we do go this way, maybe just a __skip or something tag would be
> > sufficient?
>=20
> if we go this way we wouldn't need __skip, but if we do not go, then
> sure, why not. But in general, __skip makes sense either way, I guess,
> I have no problem with it.

Sorry, by "if we go this way" what I meant was "if we continue to have
RUN_TESTS() run all progs by default." Given that we're doing that, it
sounds like we're on the same page page and that __skip is the way to
go.

>=20
> >
> > > About the patch itself. I don't really see much point in adding
> > > *_KFUNC_LOAD_TEST macros. They are used once or twice in total, while
> > > obscuring *what* is actually being tested. Unless you expect to add 5+
> > > more copies of them, I'd just inline them explicitly.
> >
> > It's not really important what's in the actual prog though -- the point
> > is that we're verifying we can invoke some kfuncs in a certain prog
> > type. But yes, it does obscure what's there, and I'm fine with
> > copy-pasting them if that's your preference. The reason I went with a
> > macro was to make it easy for us to quickly test new prog types as we
> > add support for them, or to add other negative testcases for unsafe prog
> > types. Right now we're just testing tracing progs.
>=20
> I'm always for less macro usage, if possible :)
>=20
> For the use case you are describing I'd just add static subprog that
> exercises all the kfuncs of interest, and then call this subprog from
> all the (explicitly defined) main entry program of desired program
> types

Will do for v2. Thanks!

--KS4izKu7yfk4waCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZg8ubwAKCRBZ5LhpZcTz
ZBAJAP4xft/59FVfLsetXvVi/i02GQFWrdMZaheEq03ofwyJcAD1HS3/JG6N7HgM
tRJ9O7beU7xaYuNWkRLmJw/skFjMBQ==
=AXl+
-----END PGP SIGNATURE-----

--KS4izKu7yfk4waCZ--

