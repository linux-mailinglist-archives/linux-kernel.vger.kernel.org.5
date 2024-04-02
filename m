Return-Path: <linux-kernel+bounces-128672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F17895DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21D31C22443
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37F15E1ED;
	Tue,  2 Apr 2024 20:42:19 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2E15ADB1;
	Tue,  2 Apr 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090539; cv=none; b=Zy+6DMa1rhD+7A5aPwNUeZl4jCETdIm3ql5B+4GDfcQeLb3plQlZMv7nhhDp06ZyfvbgIf+6LtC8djEQTPNKh9fCbAnlB7ZNUfGAtmbv+u9YslwWf6ov+ON2q4kWbrzECMfyroqAQgTXgeqT6knHP+JFZgXLSk7azveS6Liu6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090539; c=relaxed/simple;
	bh=1P+GlGkD9m8hfVX1chHE40TikKKNL8DKwYPzhGMLehI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCeoEcuRC+jiREvxetIJeZ8a41/KSALEamTnABBFtK3S4trqxRlXPhmlbIIjZmgVW0YVzoLGcauQcbeRaP/CgAetdkWXjWOz991ASREy8GgKAgpz0Am9ITLfXJNEU9Npa+r7oxeGnS6B8qrMgNuPymi+XxTfRkwAJV2E8iCWJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3410708a12.3;
        Tue, 02 Apr 2024 13:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090537; x=1712695337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIwFBC2rK0p1PhemtWYBiHcMNF/WCdSgeYAe4DBroDE=;
        b=qDwv/aXizn4yEIufAi9Wi57KYi2b7A5q25nNWTbBEaeSrv9uVUpcqjkJT8wYxDh1Xg
         ckA17ewfWLMacU/pCIT3E31Yn3cuS2u912dzqzL1ubEoQjqOCgNl6wKMxM2kjfhdeGoC
         XwVRqTHo/5hYCukshVNOHtwV4GzyE6eTzfUd73DGwwkd3DWB7/Acyjbbw5KTTg+/0QD5
         zonzm0HzU1mbEg4mGXRhmcq/LHlATV4d0lxrOeCirhbJtk39hpxZqyZXGcICZRTU5VGa
         9Vy4JG5gNBSHsNl33j/KRQurk9rayKoGRJtRZ3akwr1ZVBzd1Z9gbAq4UF2ID/aaJXrm
         jfIA==
X-Forwarded-Encrypted: i=1; AJvYcCUXz7MEg8mchPeubZXYq54NTiH2kfYuarSK0R1bMcU0J6JfI35lDvwTRt6rMaz4/nLPCT23a8cUTvnA/yTdqErzNq7mYXSlfzXwuFO1H10VUbf9Ev4xo0BDzYgEl7Ty9rzFQaHyi3z2vi6QMzcpaUcnR2rO4fU3SRJzbBdyW4M+IFluqg==
X-Gm-Message-State: AOJu0YyKkldVdjH6kn4aJj1fb7GaaSuaHYRXXtl661UbOQuwNiqds+6X
	EMg3gTNDQvBH1OXVnpKukpsb9AQbjM5Ijt3E5VXoubeq0OlmSKOQMpicxFOMB7d1W5Ayh1rry3V
	Po5VCTQJhdVwcuPw+R7jsk+mJ2g8=
X-Google-Smtp-Source: AGHT+IFGFE9nHZZm6EYHEp2qkcumt2dykEh+sd3cAoUH1ELBmsajMFIgqiVNdRg6NFqNpdW0b+FynSCPtQF4KlRfsLU=
X-Received: by 2002:a05:6a20:158b:b0:1a3:6dbb:f072 with SMTP id
 h11-20020a056a20158b00b001a36dbbf072mr12114278pzj.8.1712090537213; Tue, 02
 Apr 2024 13:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402184543.898923-1-namhyung@kernel.org> <ZgxgRJdFlwfESwKF@x1>
In-Reply-To: <ZgxgRJdFlwfESwKF@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 2 Apr 2024 13:42:05 -0700
Message-ID: <CAM9d7ci7a2dbn1cz-OBkYF7P1fFA3yoBMuTzXRx=KP-yEnyfnQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:45=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Apr 02, 2024 at 11:45:43AM -0700, Namhyung Kim wrote:
> > I got a report for a failure in BPF verifier on a recent kernel with
> > perf lock contention command.  It checks task->sighand->siglock without
> > checking if sighand is NULL or not.  Let's add one.
> >
> >   ; if (&curr->sighand->siglock =3D=3D (void *)lock)
> >   265: (79) r1 =3D *(u64 *)(r0 +2624)     ; frame1: R0_w=3Dtrusted_ptr_=
task_struct(off=3D0,imm=3D0) R1_w=3Drcu_ptr_or_null_sighand_struct(off=3D0,=
imm=3D0)
> >   266: (b7) r2 =3D 0                      ; frame1: R2_w=3D0
> >   267: (0f) r1 +=3D r2
> >   R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it f=
irst
> >   processed 164 insns (limit 1000000) max_states_per_insn 1 total_state=
s 15 peak_states 15 mark_read 5
> >   -- END PROG LOAD LOG --
> >   libbpf: prog 'contention_end': failed to load: -13
> >   libbpf: failed to load object 'lock_contention_bpf'
> >   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
> >   Failed to load lock-contention BPF skeleton
> >   lock contention BPF setup failed
> >   lock contention did not detect any lock contention
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Are you going to have this merged into perf-tools?
>
> A Fixes: tag isn't perhaps needed as it worked in the past?

Fixes: 1811e82767dcc ("perf lock contention: Track and show siglock
with address")

It was introduced in v6.4 and it should be fine to have this
even without the error.  I'll queue it to perf-tools.

Thanks,
Namhyung

