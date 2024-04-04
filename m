Return-Path: <linux-kernel+bounces-132205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9804A899153
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1C61C21F41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6CA6A01E;
	Thu,  4 Apr 2024 22:30:50 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD612E71;
	Thu,  4 Apr 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269850; cv=none; b=a8xkraMS8oYTBFzMhaMU0yaYHdA3zNfMN/C5KcpkifU/+y3oFl6DLpDis8GFsjrE4g7JIb0ielqzs0hXYTZLM4Vr0xi7dPR1qclpOALBBUOR+qKBWoE1JcdHkImyIjJNLgeEFFiOKnYEpRUlpjQTsDVymxLumoXHSJ/GojbBH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269850; c=relaxed/simple;
	bh=RsAcx9Znss3UI/v6xG0a1+3qv8k0leUxOrv/V5dBbsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im8iB6czzszi+42rn7m7W/6NfkwvJRr+vWZEzMfwdhSjU1YIy+zUU+OkTntlkSNcNYwS2vUsy3JarqPfqfC5So9rM16DjjW+LNXj6a6aKWGrrcM5HxZu2/2vzjeZ0BkwGnKomlrucqQtEeGpyOA0eDKPziA8lI3z5gmOGa7ozew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d33ccdb531so71802339f.0;
        Thu, 04 Apr 2024 15:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269847; x=1712874647;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSelu9ePRHzAjK8EEcbffo/jkUgtGSViK/2Yc47Rxng=;
        b=OOozQlFT2VVa/upWXgeXVbFkuzQuNz0Q0NsM5dWO92cdUT24zQdSqSJ3/3CdEPtGCt
         eVhIMtL5FdnCaKFpi3EmCmB7CqAKhDqOKI2jY9DvYMUQacXZQSyLf00jA2aCz/+fX9BZ
         pkXxaggdiZ1asvVk3Z5Jg0xvfnJNAYVGfXRBAtprZGjkJsN87q00p4GxxWo/Ics1Z+y/
         Bsg2NHPtDNb3g/h07IkuNosfDel7V26JZEkgvUr2sEPys6s2+Bv2burNHpbqpQV5t2Ku
         sUHvdKHJnZ6FzUrLdkwlqlFwMGQFMDyU2DbpPXL9fvMHymMYmSFkJ3QhrCxtDwtzERyn
         VJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWb/WXRORMXMD2f6eKTNt1+4JEKGrC1psjsXTHD3SICM4e/hYsxJZapX73hfi719VScG84v9gSbuPY5mpnCAleNYfp+kXGD4z+Ibglwz3pnE+oMzyOeS+1mEUfUFCENQ4iM
X-Gm-Message-State: AOJu0YyLSNjpQoEN+6j7BiRF31oU1Z92tzrP/fvnRzTveuuyyficFKPN
	IFI5Mg7AID2dhSouLh5w/wCygWt5qYzk1dhx1P2B9NUq2hkCkDt0
X-Google-Smtp-Source: AGHT+IHDfIj9WduqsuFaIpAxWueppSRPhBG4XE9lUWx32V6VPsLztuw1hNNDOs3b+KeHbIsOWrryYQ==
X-Received: by 2002:a6b:e20c:0:b0:7d0:5034:855a with SMTP id z12-20020a6be20c000000b007d05034855amr4667567ioc.17.1712269847280;
        Thu, 04 Apr 2024 15:30:47 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id m35-20020a05663840a300b0047a3ac10c62sm183042jam.25.2024.04.04.15.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 15:30:46 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:30:44 -0500
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
Message-ID: <20240404223044.GA521321@maniforge>
References: <20240404010308.334604-1-void@manifault.com>
 <20240404010308.334604-2-void@manifault.com>
 <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev>
 <20240404163316.GA385240@maniforge>
 <CAEf4Bza3rGMh=S7yb_Crf8v_SBTrp+NiKn0_frZnWpEi30DkPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5MxFGT/d2mJJJzb"
Content-Disposition: inline
In-Reply-To: <CAEf4Bza3rGMh=S7yb_Crf8v_SBTrp+NiKn0_frZnWpEi30DkPg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--k5MxFGT/d2mJJJzb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 03:16:56PM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 4, 2024 at 9:33=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
> >
> > On Thu, Apr 04, 2024 at 09:04:19AM -0700, Yonghong Song wrote:
> > >
> > > On 4/3/24 6:03 PM, David Vernet wrote:
> > > > Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs, =
let's
> > > > add some selftests that verify as much. As a bonus, let's also veri=
fy
> > > > that we can't call the progs from raw tracepoints.
> > > >
> > > > Signed-off-by: David Vernet <void@manifault.com>
> > >
> > > Ack with some comments below.
> > >
> > > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >
> > Thanks for the review. It looks like accidentally replied directly to
> > me, so I'll re-add the missing cc's.
> >
>=20
> And dropped bpf@vger :) adding back

*facepalm*, thanks!

>=20
> > >
> > > > ---
> > > >   .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
> > > >   .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
> > > >   .../selftests/bpf/progs/cgrp_kfunc_common.h   | 21 ++++++++++++++=
+++++
> > > >   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  4 ++++
> > > >   .../selftests/bpf/progs/cgrp_kfunc_success.c  |  4 ++++
> > > >   .../selftests/bpf/progs/cpumask_common.h      | 19 ++++++++++++++=
+++
> > > >   .../selftests/bpf/progs/cpumask_failure.c     |  4 ++++
> > > >   .../selftests/bpf/progs/cpumask_success.c     |  3 +++
> > > >   .../selftests/bpf/progs/task_kfunc_common.h   | 18 ++++++++++++++=
++
> > > >   .../selftests/bpf/progs/task_kfunc_failure.c  |  4 ++++
> > > >   .../selftests/bpf/progs/task_kfunc_success.c  |  4 ++++
> > > >   11 files changed, 83 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/=
tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > > index adda85f97058..73f0ec4f4eb7 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > > @@ -102,6 +102,7 @@ void test_cgrp_kfunc(void)
> > > >             run_success_test(success_tests[i]);
> > > >     }
> > > > +   RUN_TESTS(cgrp_kfunc_success);
> > > >     RUN_TESTS(cgrp_kfunc_failure);
> > > >   cleanup:
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/=
tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > > index d4579f735398..3db4c8601b70 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > > @@ -94,5 +94,6 @@ void test_task_kfunc(void)
> > > >             run_success_test(success_tests[i]);
> > > >     }
> > > > +   RUN_TESTS(task_kfunc_success);
> > > >     RUN_TESTS(task_kfunc_failure);
> > > >   }
> > >
> > > The above RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_succ=
ess)
> > > will do duplicate work for *existing* bpf programs in their respective
> > > files. I think we still prefer to have cgrp_kfunc_success tests
> > > in cgrp_kfunc.c to make it easy to cross check. But in order to
> > > remove duplicate work, one option is to make other non-RUN_TESTS
> > > programs in those files not auto-loaded and their corresponding
> > > prog_tests/*.c file need to explicitly enable loading the problem.
> >
> > Good point, and yes I agree with that approach of not auto-loading
> > non-RUN_TESTS programs. Considering that we have a  __success BTF tag to
> > say, "this prog should successfully load", it seems odd that we'd also
> > automatically load and validate progs that _didn't_ specify that tag as
> > well. At that point, I'm not sure what value the tag is bringing. Also,
>=20
> Just more explicitness (if desired). Normally __success would be
> augmented by __msg() or __retval(). I'd feel uncomfortable just

But __success really has no actual purpose, right? Isn't it identical to
if it's just left off? You don't need __success to specify __msg() or
__retval() right?

> silently skipping programs that are not marked with __success, as it
> would be too easy to accidentally forget to add it and not know that
> the BPF program is not tested.
>
> I'd say that RUN_TESTS-based programs should be kept separate from any
> other BPF programs that have a custom user-space testing part, though.

IF we do go this way, maybe just a __skip or something tag would be
sufficient?

> About the patch itself. I don't really see much point in adding
> *_KFUNC_LOAD_TEST macros. They are used once or twice in total, while
> obscuring *what* is actually being tested. Unless you expect to add 5+
> more copies of them, I'd just inline them explicitly.

It's not really important what's in the actual prog though -- the point
is that we're verifying we can invoke some kfuncs in a certain prog
type. But yes, it does obscure what's there, and I'm fine with
copy-pasting them if that's your preference. The reason I went with a
macro was to make it easy for us to quickly test new prog types as we
add support for them, or to add other negative testcases for unsafe prog
types. Right now we're just testing tracing progs.

>=20
> > that was the expected behavior before RUN_TESTS() was introduced, so it
> > hopefully shouldn't cause much if any churn.
> >
> > > Maybe the current patch is okay even with duplicated work as it
> > > should not take much time to verify those tiny problems.
> >
> > IMO it should be fine for now as the overhead for validating and loading
> > these progs is low, but it'd definitely be good to address this problem
> > in a follow-up. I don't think it should take too much effort -- AFAICT
> > we'd just have to mark a test spec as invalid if it didn't have any BTF
> > test tags. Ideally I'd like to separate that from this patch set, but I
> > can do it here if folks want.
> >
> > Thanks,
> > David

--k5MxFGT/d2mJJJzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZg8qFAAKCRBZ5LhpZcTz
ZNKkAQD6mUZSIrtesSlM70yQ4aRp1xVkW/8MPgSzIVKKz60XCwD9EZI5Hh0d/3gE
EYbdUZbeI9eaNobZQv99U2afSKWFNQc=
=mXpL
-----END PGP SIGNATURE-----

--k5MxFGT/d2mJJJzb--

