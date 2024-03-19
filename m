Return-Path: <linux-kernel+bounces-107320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6287FB05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B9D281DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF37D095;
	Tue, 19 Mar 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="can44KZ3"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C47C0B2;
	Tue, 19 Mar 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841421; cv=none; b=IoeEeWZpGfH8YPBXLjd3Unc71Xymw+PRC8mByLquXHUrBZ7W9ytnq5xdipfUWNkUgFyIuMEtE+F9VxlNlyJRheH8Jrmp5nT740WTXLe1oJOdzJur0LLtvM8tpIeS0WqSJl+6S/wJpMUWiwJ7jLeaUIJ+5Fy6RRHQrZr91XbS6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841421; c=relaxed/simple;
	bh=tZrMPUpSUEU7+/wAovQ4fuYqq0PFfpqDVV8cAoNm9So=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iJY4yZz24Y54d7d5VnYKFmni5VhulWvpHxE4R05URTV0hyefylSTKIYPB3auNrlV1kWXaEXv3kNoOOvu1VvhjP8vH7AlMFzGYeypzfQ4pyVaNjQglhiwQRukiwDPrefEK1EK/1GbqZfgw0vVCIwVanyDG285VUI5YIeISV2V/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=can44KZ3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c39bc142edso87060b6e.0;
        Tue, 19 Mar 2024 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841419; x=1711446219; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C45NETgBBINnVz5gYFapJ2sUx+OVUwgq5wHBDlDkcP8=;
        b=can44KZ3pqSt3jZru6STF8PUcz2X6BIlvxIiIyJfXrOhm05eWuW2EgP2qxGdQa1IwZ
         N0erq+Cg6Tj+fzTFVZJswUtbLwpTVZH5F8heuKA7gHdDcJcICTtDPUCFQK1OJ2FPGXWN
         gzdDZOehuPLKKiqcN5T0MabwZ1WwCYoabr54RI7S6rTD7Ca+LGBJRf4XCGyBntJVRDHr
         /+y15TjJm9oL6TKWaIfMBIhNNbNRLBuVq75P+oFtKzY9wgxdWSQCHQgMzclIOeb93rCp
         eVJRvTnPR3MSwIEZ927+3bInFoGzOOOL4uU1zUL8sNsmG9jjj6HJZLM2Pq3UlYZOGFtW
         Ez1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841419; x=1711446219;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C45NETgBBINnVz5gYFapJ2sUx+OVUwgq5wHBDlDkcP8=;
        b=jKXJnc8hWnpg3bffqDyCT194QMUYcSzJVf5mHnLu5ZdcA9xFSZwd+6riPLxop0qyJD
         PJPz+FVvfuAOL9YtwNzMoBkdlGd/W6QM6W5r9cKdj3CkeBzvuR2heWsg3VRxbcQZ5jqG
         FTPMwYnKwXHalMP/I3uxVMQkxblorACFuDfflhAOZEF2a0SHsNtC1sZRHgxHVqVMkZEv
         +CkLDAQp7ALvjAzVEg5xhV5M6/f3FMeNAKq9wtmvxe3AWRzL1WlNpIDmrJVyzlfuBzbM
         eWfuSfM/kf8C8XbIVgZAemJQlYWSwRqT9l6qE9ab268QFZ1jfREQa+X4liUMqXwRNum4
         w3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4CBBuJZQ+cgLiuMqAmf8JKxcDpH3GSWawKiIH1yEYzLZMgvx2CgXX2eUF1RAcX2CRNnyuuxQlr85ZPFwXY1+tnD4G8djYo2t8KCnlLdicYpsybv+lSE/8tTW0VCgq/zim7tXLeCRZLjMUlKedOQ==
X-Gm-Message-State: AOJu0Yx9wYSYDdAeDYS34Bow2eRuRYVJSlbs/5vupjt11B/U3u01DVFd
	8/pTxeEZ88InyO9BrfDgpZLysEQhUJfyMk2xUdVZg6wb5CYD/hmdcBnayPax99fFBQ==
X-Google-Smtp-Source: AGHT+IEmWzEJuZYtdWV3gIS7NqMrntxS9uTnpBN85AAIikIEd2okw0k8r5PwtShsCUhdKgfok78zhQ==
X-Received: by 2002:a05:6808:bcb:b0:3c1:e580:12a with SMTP id o11-20020a0568080bcb00b003c1e580012amr17999141oik.38.1710841419376;
        Tue, 19 Mar 2024 02:43:39 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id y125-20020a62ce83000000b006e6b2ba1577sm9737576pfg.138.2024.03.19.02.43.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:43:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2] perf evlist: Fix 'perf record -C xx' failed issue
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <20240319091429.2056555-1-spring.cxz@gmail.com>
Date: Tue, 19 Mar 2024 17:43:17 +0800
Cc: yangchen11@lixiang.com,
 Jerry Zhou <zhouchunhua@lixiang.com>,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B585813-A300-4793-AC65-8C69086508CE@gmail.com>
References: <20240319091429.2056555-1-spring.cxz@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com,
 acme@kernel.org,
 Namhyung Kim <namhyung@kernel.org>,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com
X-Mailer: Apple Mail (2.3731.700.6)

Sorry, I'm a little out of it, maybe because I didn't sleep at noon. =
This version is deprecated, v1 is correct.

v1: =
https://lore.kernel.org/linux-kernel/20240319084022.2036296-1-spring.cxz@g=
mail.com/T/#u

Best wishes
Chunxin


> On Mar 19, 2024, at 17:14, Chunxin Zang <spring.cxz@gmail.com> wrote:
>=20
> The cpu has 8 performance-cores and 8 efficient-cores on my pc.
> 0-15 are performance-cores
> 16-23 are 8 efficient-cores
>=20
> When I run "perf record -C xxx", the command fails if xxx all belong =
to
> performance cores or efficient cores
>=20
> The results are as follows
>=20
>  # perf record -C 12
>  WARNING: A requested CPU in '12' is not supported by PMU 'cpu_atom' =
(CPUs 16-23) for event 'cycles:P'
>  Error:
>  The sys_perf_event_open() syscall returned with 22 (Invalid argument) =
for event (cpu_atom/cycles:P/).
>  /bin/dmesg | grep -i perf may provide additional information.
>=20
>  # perf record -C 14-17
>  WARNING: A requested CPU in '14-17' is not supported by PMU =
'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>  WARNING: A requested CPU in '14-17' is not supported by PMU =
'cpu_core' (CPUs 0-15) for event 'cycles:P'
>  ^C[ perf record: Woken up 1 times to write data ]
>=20
> The reason is that the cpu_map of 'cpu_atom'-evsel is empty, causing
> the sys_perf_event_open() result to fail.
>=20
> Changes in v2:
> - fix memory leak about 'intersect'
>=20
> Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
> ---
> tools/perf/util/evlist.c | 24 +++++++++++++++++-------
> 1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 55a300a0977b..babbde29341f 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2499,7 +2499,7 @@ void evlist__check_mem_load_aux(struct evlist =
*evlist)
> void evlist__warn_user_requested_cpus(struct evlist *evlist, const =
char *cpu_list)
> {
> struct perf_cpu_map *user_requested_cpus;
> - struct evsel *pos;
> + struct evsel *pos, *tmp;
>=20
> if (!cpu_list)
> return;
> @@ -2508,18 +2508,28 @@ void evlist__warn_user_requested_cpus(struct =
evlist *evlist, const char *cpu_lis
> if (!user_requested_cpus)
> return;
>=20
> - evlist__for_each_entry(evlist, pos) {
> + evlist__for_each_entry_safe(evlist, tmp, pos) {
> struct perf_cpu_map *intersect, *to_test;
> const struct perf_pmu *pmu =3D evsel__find_pmu(pos);
>=20
> to_test =3D pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
> intersect =3D perf_cpu_map__intersect(to_test, user_requested_cpus);
> - if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
> - char buf[128];
> + if (!intersect) {
> + evlist__remove(evlist, pos);
> + evsel__delete(pos);
> + perf_cpu_map__put(intersect);
> + continue;
> + }
> +
> + if (!perf_cpu_map__is_subset(user_requested_cpus, intersect)) {
> + char buf_test[128];
> + char buf_intersect[128];
>=20
> - cpu_map__snprint(to_test, buf, sizeof(buf));
> - pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU =
'%s' (CPUs %s) for event '%s'\n",
> - cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
> + cpu_map__snprint(to_test, buf_test, sizeof(buf_test));
> + cpu_map__snprint(intersect, buf_intersect, sizeof(buf_intersect));
> + pr_warning("WARNING: A requested CPU '%s' in '%s' is not supported =
by "
> +   "PMU '%s' (CPUs %s) for event '%s'\n", buf_intersect, cpu_list,
> +   pmu ? pmu->name : "cpu", buf_test, evsel__name(pos));
> }
> perf_cpu_map__put(intersect);
> }
> --=20
> 2.34.1
>=20


