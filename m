Return-Path: <linux-kernel+bounces-132189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DE489911F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CAB1C228D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578CF13C3F8;
	Thu,  4 Apr 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsjVPcO9"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38893D76;
	Thu,  4 Apr 2024 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269047; cv=none; b=kgG9WFC9MaierUp2nvsBGLrUb0YWQMpH1SxfsznLEsOgYCFaN9s9Er1y5YI6o2qt3uEIrZLsnkOUGjhHKnqQdDsRM6LPeO1czGE2Wx9Q7HNqBgOC7oIfuqhcjtIBXaUVTMA0sX/mlNw4T7hRQfY2RzT03qlHhHj+qBc+KVSSucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269047; c=relaxed/simple;
	bh=jP34MhqFFnOsapC2W1n3vR81oVx3qa/yHXS4isuKsXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQZ7/v3cyojmOwVvA2iZMdlrW4etePLYceoMXuZQgJ88r4kqRuMOooRS8zwS9/l+f9GUS2kVs0z5SVHtpYV1AQKVEsknNcLn81S17g+U/rJNDrfDD5x0Z5SavuHYda5A4+pkBHiT7KlWYBWoMKKEYyAu7tLk+wllulXUp9lwqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsjVPcO9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1204605a12.3;
        Thu, 04 Apr 2024 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712269045; x=1712873845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S9AzfKyXXro6/KcESb4RixjJwGuwM+I6fIK3FdfbMw=;
        b=QsjVPcO9WehwHAiP38lNJeq9kmeyTFw1U2NMGwOOOAE2dfcn9DqcIIaxK0NSUVvzAg
         4n8WwFiOl0z7JDDufLyJdWOugj7JPAG3X6uVJyVhx6yZEaNIoepcuLRtF0gyc6SgFnyG
         0alKMadvdAP0SK3nMBfKCKMAbgDWM/t4BgaO1Gw+eMODVg/onia0t1UW9PaMQv/3ULUz
         VsbLVdMNPK57gEO5LzFbzSqaOkEk6yhx5PJvie4yiBN+f5Et4pfVikwJoNJEWUWGkdvM
         hRWhQREyZDFCneSYPXhIrq5vUfrv8lKZXDdwNLx3FOG40KNogDhMQn77X0q99C+8NH4e
         TaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269045; x=1712873845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S9AzfKyXXro6/KcESb4RixjJwGuwM+I6fIK3FdfbMw=;
        b=dGl/gaLArP0pxAn4oOiiPtJX5C1zi9t4hC52PQfp+pHs/XaTFDIQ1scyGjQrI32E4k
         1LIuEvMWZG0aNxSVqK9DbZMhDu761ENKhqa/Z3TqxNEhUPfwKzqrmpbDS+LRPNz6apSt
         QRffjFH0cwFyrMv9hVkpHVwuE8+EUZcIyB3GIoT1vHA9aijnX6aX/q5FUzgwwEA6/NQM
         8iWgViQL/X092HOFlsrTPjTx2DtbZMR+xIyFn53ZQab1L3LmrjmmDm5VsNaMGYOfysiE
         cB6hUZm3lJAyJOAQrIIH5VApn/T2ngAnyBeXtKMyDEw8KJ63EdkF1ez8Kgy25FS0Rgbk
         tjbw==
X-Forwarded-Encrypted: i=1; AJvYcCX+x1GmBUj2n7YHFu69kYQzeEgJk8q3jr3MCrTQTMFAnt/fB+pCAY1Q5/1gnF1luFP3pzCfWla7G5aJSxju8naNRULbif5tKYcnDagHjjcLBfeF+LIYArlgY31fzy2D09R2
X-Gm-Message-State: AOJu0YzbI+YL52V9xPCr6nsaFJCAPBm8yLJp5QZ+Iksi7ciFIuC1qLmU
	4uM81d2pX0nfhAxAAiY/XOhSZc6LSH57qO9Sn59bWaB4eIGMNSG8pZ9bQw4atgJTig9BsQ1wX+E
	MxjlqTe6Jiy2QtGKfTBt1k/i+VgE=
X-Google-Smtp-Source: AGHT+IEhHqqPCiJKMvRzHHiNPR93glELvuoH2VAtNzMJK6uoUINTY9an9ck6wceOm3Y81pn0CohR7AD7YQ64ozaEZ1c=
X-Received: by 2002:a17:90a:d809:b0:2a2:73e9:c3bf with SMTP id
 a9-20020a17090ad80900b002a273e9c3bfmr3897030pjv.20.1712269045344; Thu, 04 Apr
 2024 15:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404010308.334604-1-void@manifault.com> <20240404010308.334604-2-void@manifault.com>
 <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev> <20240404163316.GA385240@maniforge>
In-Reply-To: <20240404163316.GA385240@maniforge>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 15:16:56 -0700
Message-ID: <CAEf4Bza3rGMh=S7yb_Crf8v_SBTrp+NiKn0_frZnWpEi30DkPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify calling core kfuncs
 from BPF_PROG_TYPE_SYCALL
To: David Vernet <void@manifault.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:33=E2=80=AFAM David Vernet <void@manifault.com> wr=
ote:
>
> On Thu, Apr 04, 2024 at 09:04:19AM -0700, Yonghong Song wrote:
> >
> > On 4/3/24 6:03 PM, David Vernet wrote:
> > > Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs, le=
t's
> > > add some selftests that verify as much. As a bonus, let's also verify
> > > that we can't call the progs from raw tracepoints.
> > >
> > > Signed-off-by: David Vernet <void@manifault.com>
> >
> > Ack with some comments below.
> >
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> Thanks for the review. It looks like accidentally replied directly to
> me, so I'll re-add the missing cc's.
>

And dropped bpf@vger :) adding back

> >
> > > ---
> > >   .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
> > >   .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
> > >   .../selftests/bpf/progs/cgrp_kfunc_common.h   | 21 ++++++++++++++++=
+++
> > >   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  4 ++++
> > >   .../selftests/bpf/progs/cgrp_kfunc_success.c  |  4 ++++
> > >   .../selftests/bpf/progs/cpumask_common.h      | 19 ++++++++++++++++=
+
> > >   .../selftests/bpf/progs/cpumask_failure.c     |  4 ++++
> > >   .../selftests/bpf/progs/cpumask_success.c     |  3 +++
> > >   .../selftests/bpf/progs/task_kfunc_common.h   | 18 ++++++++++++++++
> > >   .../selftests/bpf/progs/task_kfunc_failure.c  |  4 ++++
> > >   .../selftests/bpf/progs/task_kfunc_success.c  |  4 ++++
> > >   11 files changed, 83 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/to=
ols/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > index adda85f97058..73f0ec4f4eb7 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
> > > @@ -102,6 +102,7 @@ void test_cgrp_kfunc(void)
> > >             run_success_test(success_tests[i]);
> > >     }
> > > +   RUN_TESTS(cgrp_kfunc_success);
> > >     RUN_TESTS(cgrp_kfunc_failure);
> > >   cleanup:
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/to=
ols/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > index d4579f735398..3db4c8601b70 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> > > @@ -94,5 +94,6 @@ void test_task_kfunc(void)
> > >             run_success_test(success_tests[i]);
> > >     }
> > > +   RUN_TESTS(task_kfunc_success);
> > >     RUN_TESTS(task_kfunc_failure);
> > >   }
> >
> > The above RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_succes=
s)
> > will do duplicate work for *existing* bpf programs in their respective
> > files. I think we still prefer to have cgrp_kfunc_success tests
> > in cgrp_kfunc.c to make it easy to cross check. But in order to
> > remove duplicate work, one option is to make other non-RUN_TESTS
> > programs in those files not auto-loaded and their corresponding
> > prog_tests/*.c file need to explicitly enable loading the problem.
>
> Good point, and yes I agree with that approach of not auto-loading
> non-RUN_TESTS programs. Considering that we have a  __success BTF tag to
> say, "this prog should successfully load", it seems odd that we'd also
> automatically load and validate progs that _didn't_ specify that tag as
> well. At that point, I'm not sure what value the tag is bringing. Also,

Just more explicitness (if desired). Normally __success would be
augmented by __msg() or __retval(). I'd feel uncomfortable just
silently skipping programs that are not marked with __success, as it
would be too easy to accidentally forget to add it and not know that
the BPF program is not tested.

I'd say that RUN_TESTS-based programs should be kept separate from any
other BPF programs that have a custom user-space testing part, though.

About the patch itself. I don't really see much point in adding
*_KFUNC_LOAD_TEST macros. They are used once or twice in total, while
obscuring *what* is actually being tested. Unless you expect to add 5+
more copies of them, I'd just inline them explicitly.

> that was the expected behavior before RUN_TESTS() was introduced, so it
> hopefully shouldn't cause much if any churn.
>
> > Maybe the current patch is okay even with duplicated work as it
> > should not take much time to verify those tiny problems.
>
> IMO it should be fine for now as the overhead for validating and loading
> these progs is low, but it'd definitely be good to address this problem
> in a follow-up. I don't think it should take too much effort -- AFAICT
> we'd just have to mark a test spec as invalid if it didn't have any BTF
> test tags. Ideally I'd like to separate that from this patch set, but I
> can do it here if folks want.
>
> Thanks,
> David

