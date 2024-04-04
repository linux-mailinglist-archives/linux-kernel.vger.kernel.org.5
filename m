Return-Path: <linux-kernel+bounces-131821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3912898C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58718284448
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38BD1B948;
	Thu,  4 Apr 2024 16:33:22 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554718039
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248402; cv=none; b=eL4vo84NenF+X1opTKETaQK1jBYld+bezlt8g+IjNt948tTdAQ6OQ/CB+4ifG2BNUdE+N1F+Gt0eoP9LNakI37Ss1vgHziFPyeHDmVJtVf//HnLaCBmOWA4KWQriRGNwa0MKHhzVJgvIMqDxPuEfusiHsOn9f3bMCx1HApfxYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248402; c=relaxed/simple;
	bh=vGeDMYxhIQMCz/6Ex+E0kSB/hxh7WfNOnL3GWD9KoLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2ig0wpdSNXAHxPbU1Hb0uxGcQz2Od2+rf7GpPtIaU9MyP27DDSe6OAYet1QnHqJRGwiEZMm7IB1CO+11LMNl3JtuV692Bj9v/2VGd7oj+IzCG3p4ID8F64u0DMgGZFJGC0/JoC/iB5te07kozJAHSm2ccFbaZdESu4e8xl+nV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8b777ff8bso45612939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248400; x=1712853200;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0q2ZaGBSP2grqbQnWREndiCOj94gUHk70M1Euz3N7I=;
        b=B609UfcQMTW8CwVrokMKkt5qagGdBnfYneZjXRum2GnHpza6WnESsWaE1XwC/KRlW7
         ljPwZEzunSt30qRjmr5JYyjvVFcz8n83gmrRANAVheJZXgrWafiIxul/C2vA2crd5g88
         hqmtQofSxn55D8v2P8N/i706fiANR0TeTiwrKtDue4hY3FsfIGjpAUSiWeJ89SRA6xqa
         2dyfMFLELGE4iwOgLZ3dhBWkelhSqkg3rJcYVefFtJ52U/rRBTrxHnQCF1mpqgxpsZgN
         zm95iE4XeiJqKdnIZNayXhZVHePCGetRE4Ami5+4wk5zhQhZQuz59noAHJTFyOvRPQVD
         2aqA==
X-Forwarded-Encrypted: i=1; AJvYcCU+TPdDAShaSOxz6ZnKmUaJ3pQn6MoLIQc+h01L1ARx2xSc3LA11Gm4uX7Rr+CuUYUqN5rLmD264lkDL5fS5mtl6q+r0+gPTy5niRqk
X-Gm-Message-State: AOJu0YwAzali8s2Yhn/Gh4CbISDUt3g80LCh3nlTq9PPry/REuOi7LK6
	zTJ5hBFMG6OG8HzuSVDlc5i67BFCjJItr0SIhktAg2ibtFHjg05v
X-Google-Smtp-Source: AGHT+IHnvc9JR4IOuY+kL+dDqEVHCvwNIsTvWTKOgm/ZvgUffUYXodMAbSL1DcVtPWkQO1Te4oj7dg==
X-Received: by 2002:a05:6602:80f:b0:7d3:919b:691a with SMTP id z15-20020a056602080f00b007d3919b691amr340970iow.2.1712248399658;
        Thu, 04 Apr 2024 09:33:19 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id q9-20020a6bf209000000b007d4b04c6d63sm29950ioh.12.2024.04.04.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:33:19 -0700 (PDT)
Date: Thu, 4 Apr 2024 11:33:16 -0500
From: David Vernet <void@manifault.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify calling core kfuncs
 from BPF_PROG_TYPE_SYCALL
Message-ID: <20240404163316.GA385240@maniforge>
References: <20240404010308.334604-1-void@manifault.com>
 <20240404010308.334604-2-void@manifault.com>
 <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tv6BS8qXzcVxLJbx"
Content-Disposition: inline
In-Reply-To: <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Tv6BS8qXzcVxLJbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 09:04:19AM -0700, Yonghong Song wrote:
>
> On 4/3/24 6:03 PM, David Vernet wrote:
> > Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs, let's
> > add some selftests that verify as much. As a bonus, let's also verify
> > that we can't call the progs from raw tracepoints.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
>
> Ack with some comments below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks for the review. It looks like accidentally replied directly to
me, so I'll re-add the missing cc's.

>
> > ---
> >   .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
> >   .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
> >   .../selftests/bpf/progs/cgrp_kfunc_common.h   | 21 +++++++++++++++++++
> >   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  4 ++++
> >   .../selftests/bpf/progs/cgrp_kfunc_success.c  |  4 ++++
> >   .../selftests/bpf/progs/cpumask_common.h      | 19 +++++++++++++++++
> >   .../selftests/bpf/progs/cpumask_failure.c     |  4 ++++
> >   .../selftests/bpf/progs/cpumask_success.c     |  3 +++
> >   .../selftests/bpf/progs/task_kfunc_common.h   | 18 ++++++++++++++++
> >   .../selftests/bpf/progs/task_kfunc_failure.c  |  4 ++++
> >   .../selftests/bpf/progs/task_kfunc_success.c  |  4 ++++
> >   11 files changed, 83 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > index adda85f97058..73f0ec4f4eb7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > @@ -102,6 +102,7 @@ void test_cgrp_kfunc(void)
> >             run_success_test(success_tests[i]);
> >     }
> > +   RUN_TESTS(cgrp_kfunc_success);
> >     RUN_TESTS(cgrp_kfunc_failure);
> >   cleanup:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > index d4579f735398..3db4c8601b70 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > @@ -94,5 +94,6 @@ void test_task_kfunc(void)
> >             run_success_test(success_tests[i]);
> >     }
> > +   RUN_TESTS(task_kfunc_success);
> >     RUN_TESTS(task_kfunc_failure);
> >   }
>
> The above RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_success)
> will do duplicate work for *existing* bpf programs in their respective
> files. I think we still prefer to have cgrp_kfunc_success tests
> in cgrp_kfunc.c to make it easy to cross check. But in order to
> remove duplicate work, one option is to make other non-RUN_TESTS
> programs in those files not auto-loaded and their corresponding
> prog_tests/*.c file need to explicitly enable loading the problem.

Good point, and yes I agree with that approach of not auto-loading
non-RUN_TESTS programs. Considering that we have a  __success BTF tag to
say, "this prog should successfully load", it seems odd that we'd also
automatically load and validate progs that _didn't_ specify that tag as
well. At that point, I'm not sure what value the tag is bringing. Also,
that was the expected behavior before RUN_TESTS() was introduced, so it
hopefully shouldn't cause much if any churn.

> Maybe the current patch is okay even with duplicated work as it
> should not take much time to verify those tiny problems.

IMO it should be fine for now as the overhead for validating and loading
these progs is low, but it'd definitely be good to address this problem
in a follow-up. I don't think it should take too much effort -- AFAICT
we'd just have to mark a test spec as invalid if it didn't have any BTF
test tags. Ideally I'd like to separate that from this patch set, but I
can do it here if folks want.

Thanks,
David

--Tv6BS8qXzcVxLJbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZg7WTAAKCRBZ5LhpZcTz
ZN4gAP90V5S5vd7CuqZm6mofUeuq5mm/kMhfW9bBet5JoQBDugD/fsW+fYqnaO17
5idK41x/IUMxA1OcM/UDvRH72sKRtwU=
=iNe9
-----END PGP SIGNATURE-----

--Tv6BS8qXzcVxLJbx--

