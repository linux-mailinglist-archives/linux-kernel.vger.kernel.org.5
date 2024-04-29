Return-Path: <linux-kernel+bounces-162972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542878B62DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A653283894
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7D13F00B;
	Mon, 29 Apr 2024 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7h0AcIp"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C812D1E9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420250; cv=none; b=F3HQW5sWmnwmsFkM/pqx8bVQNa4Yrb4WPNQdZnMO2jXWySO1IZxlabHahmn88nwWHcERZqlLJ9ogCPe1yNULMgWibbdeaechNm0HXnxm4GaV0k4tICVmklB5g7mNyIwQBGPHzQqb+oB1N98NyHixHZrDfALB26fbfYs4nQ/w3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420250; c=relaxed/simple;
	bh=GQ+JFS1Jk+xndYHzEiOndheElZ95SLwVPHB0du1f+3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9HUS5CdfcE2U/xJfRCmHzWT0CKhtZMZZNAR3yC2dkjlB+EDUcd9v03xM8Zi7AXWVwNoKaclhe9c6Wop+FqQta2B4F5BNCInSyQklUwNhtRY/qHYXAc149+SqvQyCHYb60Gohe+2g+vTntooy9yVPVKEjHQo2OdWzHwZF+CIryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7h0AcIp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-436ed871225so5071cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420247; x=1715025047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HGhfVpQjOVkb9HLWtg2vngpQ4aBVDIOd0yGR7/N4Vs=;
        b=V7h0AcIpb0mr8K5iIIbY/8lQy8hYt/RS+GzW637Q/3OLFqKuF0AEf1Kq5yunU3CybQ
         gnUl8UsP4FR20G19U7D3ROBMf7vPo8AOSeqeX7abud/NPaWcB7X94WaV2NnTGyppIRuE
         1hjxcyAJrZz2+cAkZ3krsDljKxQ7w/14Dd2/AI0ZoewzE5Mvzw9Si/rgNxtNKpsFsdnx
         RLJXrJhGyaHaBepawJc2Xmolqk5wgsi8IECaAkrSvj5BQwwkO+v3wFimq0a3fbVtsGA1
         JAEZwWKwlTuBktNEoJsZG9DV3SJJkJoP4XOxE/LBRvZM8E/r9Zno21r8hCeaKoOdrFGy
         oebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420247; x=1715025047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HGhfVpQjOVkb9HLWtg2vngpQ4aBVDIOd0yGR7/N4Vs=;
        b=E1EHWHU1+u5NzrtuNvVazjDOxVx3KIcP5nUaI9Fh/+z2QrQPjJuf9X8yRDq1wFr+DQ
         LsSeDMPkjJmFf3WeiWGeweJnv1kBp4JRaGIzK/kifQVrn3V06pfaI53pG+s6n7/yqSF/
         aGobXCSFFZ56bXR/uQE/pWhuoFGfBB/A9USHzuIUNgfzOQlRZYVw0tTetF/4gA5Z5aZg
         +Bh9zaqFrVMGiF7n88/Tqk36BjVIp7oOxZyjndTDJyQEo8V6v96smxtpXXUTKw5biFCr
         hv9ZxSi5yvkll3zk/sfdZxMmrU9B3knv6NQpXX7pvqt7xyshzvpW/zii+N8vrrdZBD2A
         F9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcqIjPVjpWgh68yjJqIFyaFiZGMx9+z+Q2SuzPAQcBxO3r3gOLIAy1ZzdbCjCVKuv0/HO7W2xZ5uF1oM1BpnKOCsd/iFOUIGp8VTPN
X-Gm-Message-State: AOJu0YwnqhA2r7zKTfpnIdZvGyL+JVVc2yPnj8o/9HWSIZJawH9E8zc4
	mRe1uayVkTsd5DfeuUxnQPc5Uqdqk5SOBdMWKETN3cbYyGrW/cfBqPH4eJ6S9NkZcad1veYKMSd
	xz5+6cLPyC7ktYgUtYSdCo+78At4dFMNPSIWZ
X-Google-Smtp-Source: AGHT+IFLhTw258uz7gSs0I6QVFEnndIkAvJYJGfQm2ewdk5b9QVKe9+CKSEDAc/GfpSIxD3aSkejpIPzKmi+/XgMHyI=
X-Received: by 2002:a05:622a:1207:b0:43a:4745:ddcc with SMTP id
 y7-20020a05622a120700b0043a4745ddccmr44722qtx.11.1714420246500; Mon, 29 Apr
 2024 12:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com> <Zi_yKzGMoDU0-L3K@x1>
In-Reply-To: <Zi_yKzGMoDU0-L3K@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 12:50:34 -0700
Message-ID: <CAP-5=fUETVGR+BVsHPyEAPFHcAQNRE0BJjXFyaqFtmwt8PY2HA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] dso/dsos memory savings and clean up
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, nabijaczleweli@nabijaczleweli.xyz, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yang Jihong <yangjihong1@huawei.com>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:17=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 29, 2024 at 11:46:07AM -0700, Ian Rogers wrote:
> > 7 more patches from:
> > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.co=
m/
> > a near half year old adventure in trying to lower perf's dynamic
> > memory use. Bits like the memory overhead of opendir are on the
> > sidelines for now, too much fighting over how
> > distributions/C-libraries present getdents. These changes are more
> > good old fashioned replace an rb-tree with a sorted array and add
> > reference count tracking.
> >
> > The changes migrate dsos code, the collection of dso structs, more
> > into the dsos.c/dsos.h files. As with maps and threads, this is done
> > so the internals can be changed - replacing a linked list (for fast
> > iteration) and an rb-tree (for fast finds) with a lazily sorted
> > array. The complexity of operations remain roughly the same, although
> > iterating an array is likely faster than iterating a linked list, the
> Th> memory usage is at least reduced by half.
> >
> > As fixing the memory usage necessitates changing operations like find,
> > modify these operations so that they increment the reference count to
> > avoid races like a find in dsos and a remove. Similarly tighten up
> > lock usage so that operations working on dsos state hold the
> > appropriate lock. Note, since this series is partially applied in the
> > perf-tools-next tree currently some memory leaks have been introduced.
> >
> > v5. Rebase, adding use of accessors to dso as necessary. Previous
> >     versions were all rebases or dropping merged patches.
>
> So, on an Intel machine:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -8
> fb401385575211e6 (HEAD -> perf-tools-next) perf dso: Use container_of to =
avoid a pointer in 'struct dso_data'
> 0fe118d129ab1c77 perf dso: Reference counting related fixes
> 35e44adf6103a407 perf dso: Add reference count checking and accessor func=
tions
> 35673675ebbbac5d perf dsos: Switch hand code to bsearch()
> 654d60f2f5c737cd perf dsos: Remove __dsos__findnew_link_by_longname_id()
> 94b0ba802e090b66 perf dsos: Remove __dsos__addnew()
> 47692286dd856469 perf dsos: Switch backing storage to array from rbtree/l=
ist
> 8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-to=
ols-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the=
 default
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> When I'm at:
>
> 8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-to=
ols-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the=
 default
>
> root@x1:~# perf -v
> perf version 6.9.rc5.g8c618b58c89c
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : Ok
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : Ok
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : Ok
> root@x1:~# time perf test "lock contention"
>  87: kernel lock contention analysis test                            : Ok
>
> real    0m9.143s
> user    0m5.201s
> sys     0m4.812s
> root@x1:~#
>
> Moving to the first patch in this series:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -2
> 47692286dd856469 (HEAD) perf dsos: Switch backing storage to array from r=
btree/list
> 8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-to=
ols-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the=
 default
> =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m
> alias m=3D'rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=3D1 O=3D/tmp/b=
uild/$(basename $PWD)/ -C tools/perf install-bin && perf test pythond'
> =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PW=
D)/ ; mkdir -p /tmp/build/$(basename $PWD)/ ; m
> <SNIP>
>
> root@x1:~# perf -v
> perf version 6.9.rc5.g47692286dd85
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test -vvv "lock contention"
>  87: kernel lock contention analysis test:
> --- start ---
> test child forked, pid 2279518
> Testing perf lock record and perf lock contention
> [Fail] Recorded result count is not 1: 2
> ---- end(-1) ----
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~#
>
> This breaks bisectability, but then lets see if at the end of the series
> it works:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -8
> fb401385575211e6 (HEAD -> perf-tools-next) perf dso: Use container_of to =
avoid a pointer in 'struct dso_data'
> 0fe118d129ab1c77 perf dso: Reference counting related fixes
> 35e44adf6103a407 perf dso: Add reference count checking and accessor func=
tions
> 35673675ebbbac5d perf dsos: Switch hand code to bsearch()
> 654d60f2f5c737cd perf dsos: Remove __dsos__findnew_link_by_longname_id()
> 94b0ba802e090b66 perf dsos: Remove __dsos__addnew()
> 47692286dd856469 perf dsos: Switch backing storage to array from rbtree/l=
ist
> 8c618b58c89ce4c2 (perf-tools-next.korg/perf-tools-next, acme.korg/perf-to=
ols-next) perf test: Reintroduce -p/--parallel and make -S/--sequential the=
 default
> =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PW=
D)/ ; mkdir -p /tmp/build/$(basename $PWD)/ ; m
>
> root@x1:~# perf -v
> perf version 6.9.rc5.gfb4013855752
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test "lock contention"
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~# perf test -vvv "lock contention"
>  87: kernel lock contention analysis test:
> --- start ---
> test child forked, pid 2289060
> Testing perf lock record and perf lock contention
> Testing perf lock contention --use-bpf
> Testing perf lock record and perf lock contention at the same time
> [Fail] Recorded result count is not 1: 2
> ---- end(-1) ----
>  87: kernel lock contention analysis test                            : FA=
ILED!
> root@x1:~#
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ gcc --version | head -1
> gcc (GCC) 13.2.1 20240316 (Red Hat 13.2.1-7)
> =E2=AC=A2[acme@toolbox perf-tools-next]$ rpm -q gcc
> gcc-13.2.1-7.fc39.x86_64
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> root@x1:~# grep -m1 'model name' /proc/cpuinfo
> model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> root@x1:~# free
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:        32507912     9081644     3531432     1987616    22554868    2=
3426268
> Swap:        8388604      314112     8074492
> root@x1:~#

Thanks, will check. Will likely need a v6 to fix. v5 was just
addressing the rebase issues.

Ian

> - Arnaldo

