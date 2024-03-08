Return-Path: <linux-kernel+bounces-97689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CB876DDB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE0C283272
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5153BBED;
	Fri,  8 Mar 2024 23:24:44 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC61DA3A;
	Fri,  8 Mar 2024 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709940283; cv=none; b=edUNyWsUNYG9pcpIqWJV4FJ6RwJ1BS+jam/vOkBTz9Z4/D73u+GGLHDgzbgDAQG9WtxuruX5/BYDWXZl9l2MFFMjs7UryrZglGO/eNO8tFt2IpO3oFOkF/cv0aZ2M/AeCRHoUpahAt4IXwZKmvqLqadRSrZH0JqieyvL2AebtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709940283; c=relaxed/simple;
	bh=/m+XJfrnXGihUnyC7uap36ib/wCqtej25a0oxz3sQAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmuGb78W/cwCLjRdJhFDCI374lpwasAIjRFew+AK+fsWwZ3Lbz6Vbw8mj+cIVsn37GwCP+eZHFaFBzRz6/1x3KG+nAysuXiOW5EEo9ethCee0S+0j9fc0IrI5Bt4Zwd8x/4Pob9DppgTCu199RveEYKrsG+lC+XUrpqCVZeGWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so991408a91.2;
        Fri, 08 Mar 2024 15:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709940281; x=1710545081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0Xcf7CrCjRB3+pRQptNkSt1J5ww8uUmTJ/VMHdtLlY=;
        b=Sp+kfW6oBqh0FT2azGxahXFQ35N4L/CVL9mt+/Ck7q++QcfGBT48VX757L1yEgn2/U
         bkTEeJG4dBDtJH4eUn2FF7k875ONZvjqPmRVvYquhrpXVgXsvnc/chT++ZGzxvQ8ZJOw
         3LIQyfZSxO26/QkpWmgYoDTgjWGbkTjoX6SbzILcF71rdK2ABihJpgrRwZ4NX7VS/ccP
         EgbRJwc1FQQBBL5q7XrMpmjAfo/lCyMgW2G/t6ruaL9J3i0w4m8vKXlUYYUI3uov44c/
         rsAGT50fkpy0iw2jf1cAajHwJ1Q4BCUNW56Q3UUCzS6Jhbwl1BeFPdV856wWQLeVKfsz
         ZmOw==
X-Forwarded-Encrypted: i=1; AJvYcCWWU2N+X7S/uw7wx+0hEyC32PVpthCy6WkU9MRe3gn6jNeKWyy+OmlCSVWtyXneQW6kuqXAfJzL6sdylI/CV9oKBO66Fli87ktN3Uy95rYpAkLDR3pJHwoJNn71XRRILHRWMvWh3fiS1hZt1pMEcQ==
X-Gm-Message-State: AOJu0Yys8pPoViDIWhFgXumn1KlsmVVmZH/hEFZjD4932hUesZj/jdyg
	O7f2jfIL/IkK0WotrPyEqTQwPM0pNwscnuGd8SVtpYxz3SUXU9UAeClFgDjYpNZqVNlS7sbC6pS
	oAJtUCI24D60FGPGflGyU5RJExOc=
X-Google-Smtp-Source: AGHT+IGJ7nRkgOWgiV5hYc6ZMEnlG7ogWLtr6wGF/ID+tNZuGZZ85l6PkUrYq82ycQvm4iS66yCMpsY7x7S7QKbPMX4=
X-Received: by 2002:a17:90a:c684:b0:299:5b95:cd7d with SMTP id
 n4-20020a17090ac68400b002995b95cd7dmr548883pjt.45.1709940281323; Fri, 08 Mar
 2024 15:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308120332.372810-1-retpolanne@posteo.net>
 <Zeto8ShG406K6cnD@x1> <m2jzmc318b.fsf@posteo.net>
In-Reply-To: <m2jzmc318b.fsf@posteo.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 8 Mar 2024 15:24:29 -0800
Message-ID: <CAM9d7cjxNsOcGYAY4mi8-4+0w6YCAmQJCBdUFwW8q7_wh33EpQ@mail.gmail.com>
Subject: Re: [PATCH v0] perf lock contention: skip traceiter functions
To: Anne Macedo <retpolanne@posteo.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:42=E2=80=AFPM Anne Macedo <retpolanne@posteo.net>=
 wrote:
>
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
> > On Fri, Mar 08, 2024 at 12:03:31PM +0000, Anne Macedo wrote:
> >> The perf lock contention program currently shows the caller of the loc=
ks
> >> as __traceiter_contention_begin+0x??. This caller can be ignored, as i=
t is
> >> from the traceiter itself. Instead, it should show the real callers fo=
r
> >> the locks.
> >>
> >> When fiddling with the --stack-skip parameter, the actual callers for
> >> the locks start to show up. However, just ignore the
> >> __traceiter_contention_begin and the __traceiter_contention_end symbol=
s
> >> so the actual callers will show up.
> >>
> >> Before this patch is applied:
> >>
> >> sudo perf lock con -a -b -- sleep 3
> >>  contended   total wait     max wait     avg wait         type   calle=
r
> >>
> >>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __tra=
ceiter_contention_begin+0x44
> >>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __tra=
ceiter_contention_begin+0x44
> >>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __tra=
ceiter_contention_begin+0x44
> >>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace=
_contention_begin+0x84
> >>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __tra=
ceiter_contention_begin+0x44
> >>          1     13.54 us     13.54 us     13.54 us        mutex   trace=
_contention_begin+0x84
> >>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __tra=
ceiter_contention_begin+0x44
> >>
> >> Before this patch is applied - using --stack-skip 5
> >>
> >> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
> >>  contended   total wait     max wait     avg wait         type   calle=
r
> >>
> >>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_ep=
oll_wait+0x5a0
> >>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_ex=
it+0x338
> >>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_s=
ignal+0x108
> >>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   relea=
se_task+0x68
> >>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgrou=
p_kn_lock_live+0x58
> >>          1     24.71 us     24.71 us     24.71 us     spinlock   do_ex=
it+0x44
> >>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_=
mm_and_find_vma+0xb0
> >>
> >> After this patch is applied:
> >>
> >> sudo ./perf lock con -a -b -- sleep 3
> >>  contended   total wait     max wait     avg wait         type   calle=
r
> >>
> >>          6      5.27 s       1.76 s     878.55 ms     rwlock:W   relea=
se_task+0x68
> >>          2      2.99 s       2.99 s       1.50 s      spinlock   do_se=
nd_sig_info+0x3c
> >>          2      1.77 s       1.77 s     884.39 ms     spinlock   sigpr=
ocmask+0x98
> >>          2      1.76 s       1.76 s     878.56 ms     rwlock:W   do_ex=
it+0x338
> >>          2      1.76 s       1.76 s     878.55 ms     rwlock:W   relea=
se_task+0x68
> >>          5      1.76 s       1.76 s     351.41 ms     rwlock:W   do_ex=
it+0x338
> >>          1     48.10 ms     48.10 ms     48.10 ms        mutex   trace=
_contention_begin+0x84
> >>          4    257.80 us    119.34 us     64.45 us     spinlock   get_s=
ignal+0x108
> >>          1      9.33 us      9.33 us      9.33 us     rwlock:W   do_ex=
it+0x338
> >
> > Testing it on the ARM64 board sometimes also show that
> > trace_contention_begin+0x84, maybe we need to skip that one as well?
> >
> I can skip trace_contention_begin and trace_contention_end as well.
>
> Question: I have 1409 __traceiter symbols on my kernel build, should we
> ignore them all? Or is __traceiter_contention_begin and
> __traceiter_contention_end the only ones that concern the lock contention=
?
>
> cat /proc/kallsyms | grep -P '\b__traceiter*' | wc -l
> 1409

Currently it's only __traceiter_contention_begin, we don't collect
stacktrace at contention_end for now.  Also we cannot guarantee
if __traceiter_contention_end is right after the contention_begin
so I think you should use sym->end of the contention_begin for
text_end.

And, traceiter functions don't belong to their own section so the
comment should be removed.  But I hope we can move them to
a section to make things clearer. :)

Thanks,
Namhyung

