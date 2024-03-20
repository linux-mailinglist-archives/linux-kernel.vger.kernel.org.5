Return-Path: <linux-kernel+bounces-108918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C11428811E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3B1B23749
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0640845;
	Wed, 20 Mar 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et5KKZq6"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AE38DDB;
	Wed, 20 Mar 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939234; cv=none; b=CKiYopC2+iV16sgv3uuantpEyUqs3ziHsbEJyjb/uaIeYF34m7HvD6qmKI6fU1msNfm9Vwr1vTeWyJ02Eh9Q1eGI4EhR2XlJUvhnHS/S9FwKqy5puLoEdcxC+mtoeykkE4fBtZljlDL69Bqxai+FtEKVVZIFILih4dI88APKDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939234; c=relaxed/simple;
	bh=s274gaJ1NhQohm9McL6xe/KLOg8dYsXUoESS/CGuzFY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D/IlYeWLb5V6EyEdwcOPuO9cH3XKkWK9g/gvqACn51+aMONvve4+aA2GGoDwWRcdw5pMg5O9GyU+6HEZJ+j6n3opFkkpxm/t3yUXzIRB1+BN18WoAg2V9UJ+lFD0FGro+SCmcKM+0Z1R63D/yvQsxtMhJvFCFpug1RAkrSgSADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et5KKZq6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4981572a12.3;
        Wed, 20 Mar 2024 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710939232; x=1711544032; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr/y39LOiO4VbZgOU/reGyh3L3lYOwau2uEBbou0DZ4=;
        b=et5KKZq6bIuW8bHjVwl7lB3EtFsvifLiozJpPVaaoHj+jH2Sbu0J0krcdfsGKnfoti
         LqP3FMz9LeSZy+etO/ZgAVs1ez7TQrefjQrGjW86foLBZN6HEL0l9Q1mI09jGhDOeLHJ
         tFw6onvKC83Sej5jBjaPSWfg7Meb+D/UgxBeQh6jc0kRtDjwnXVpz50piGYAe+ykFXrc
         MmJL1QFbwijUtWuJvHUSmM3QTvPweD111Sdz0w84T+/znmjziQa5Hp6kd7oU7YZvHZiZ
         hfVATW6Sf3OipJhCSwgyvsmEy+wn7JfaU0n8muO2v3Fwli8vwfXtHiiCfATiKmqXUZ1M
         FtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710939232; x=1711544032;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr/y39LOiO4VbZgOU/reGyh3L3lYOwau2uEBbou0DZ4=;
        b=a0Zy3+wIRGZZBoTXC2LcOPPYUZJyHPPlDpLvoq1pJjYMfWes0CwwKgdolzH9X/6gsp
         49OP3/r+jS+I0iv7pmSW4JVHfXa/CZ32exXTli5x1p/mwN/sGZPmevzlsRv3c8rsHO1v
         qIO+ncJqOctrQbFU1FGZk86MdXWNj/2Wih1Poh4ovKFbeq3vpnZ+3zRBA2t7db1i3EhW
         FHaOkVUqyQVhqXq8AngXPWI0oTkUGdKwkfM4XgbogFpG/AHS8+4CjocZNEZTvZFI+sXG
         8PL8Ah+QBf8j6ggYx6howRp7WZWSOolZwMDxQm0/w1KVA+dZqL3UHEM9V/IphVZPoiIO
         YM7g==
X-Forwarded-Encrypted: i=1; AJvYcCXuFEciPEtljEPbh27JwI+Mp8hfRjNejPGgCdypo8Un8xngYE1YVvlhKvcK1ZTEbt01hFmnuJYyqOJ1psoAezhAFfGFSxSHdam01WJyZ1oVqMxwoDZpJhPaOMDtXDauO2BH2rfqUsJ6UyabqPAnZA==
X-Gm-Message-State: AOJu0Yyv5z74J7YR/WcFte8q8G+U/2QaIZhv8Xi6qT4v+BqiQDHgyDPk
	kIQp5Zt7ACZzOwD3LSAdJ+B2/Y42/gIb7D9PI/XGnoJf5fPVwnYs
X-Google-Smtp-Source: AGHT+IF3EbX+FPbs4PMhwE/78UEwivIQq/RrRkod5PBe/ZI7oboWPXphKuvnqw7OMxkpj6rfrxg9WA==
X-Received: by 2002:a17:90a:69c3:b0:29b:90e6:cd8b with SMTP id s61-20020a17090a69c300b0029b90e6cd8bmr16332768pjj.37.1710939232457;
        Wed, 20 Mar 2024 05:53:52 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a348b00b0029c19285192sm1600467pjb.44.2024.03.20.05.53.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 05:53:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2] perf evlist: Fix 'perf record -C xx' failed issue
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <CAP-5=fWD3bmeDoG626gds_R85JrWEAKrd_6hau6LfZXGnD=_NQ@mail.gmail.com>
Date: Wed, 20 Mar 2024 20:53:32 +0800
Cc: Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com,
 acme@kernel.org,
 Namhyung Kim <namhyung@kernel.org>,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 adrian.hunter@intel.com,
 yangchen11@lixiang.com,
 zhouchunhua@lixiang.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDDDB07E-5C58-445B-80C6-8BD8E520A9CA@gmail.com>
References: <20240319091429.2056555-1-spring.cxz@gmail.com>
 <CAP-5=fWD3bmeDoG626gds_R85JrWEAKrd_6hau6LfZXGnD=_NQ@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Mar 20, 2024, at 04:33, Ian Rogers <irogers@google.com> wrote:
>=20
> On Tue, Mar 19, 2024 at 2:14=E2=80=AFAM Chunxin Zang =
<spring.cxz@gmail.com> wrote:
>>=20
>> The cpu has 8 performance-cores and 8 efficient-cores on my pc.
>> 0-15 are performance-cores
>> 16-23 are 8 efficient-cores
>>=20
>> When I run "perf record -C xxx", the command fails if xxx all belong =
to
>> performance cores or efficient cores
>>=20
>> The results are as follows
>>=20
>>  # perf record -C 12
>>  WARNING: A requested CPU in '12' is not supported by PMU 'cpu_atom' =
(CPUs 16-23) for event 'cycles:P'
>>  Error:
>>  The sys_perf_event_open() syscall returned with 22 (Invalid =
argument) for event (cpu_atom/cycles:P/).
>>  /bin/dmesg | grep -i perf may provide additional information.
>>=20
>>  # perf record -C 14-17
>>  WARNING: A requested CPU in '14-17' is not supported by PMU =
'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>>  WARNING: A requested CPU in '14-17' is not supported by PMU =
'cpu_core' (CPUs 0-15) for event 'cycles:P'
>>  ^C[ perf record: Woken up 1 times to write data ]
>>=20
>> The reason is that the cpu_map of 'cpu_atom'-evsel is empty, causing
>> the sys_perf_event_open() result to fail.
>>=20
>> Changes in v2:
>> - fix memory leak about 'intersect'
>>=20
>> Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
>> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
>> ---
>> tools/perf/util/evlist.c | 24 +++++++++++++++++-------
>> 1 file changed, 17 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 55a300a0977b..babbde29341f 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -2499,7 +2499,7 @@ void evlist__check_mem_load_aux(struct evlist =
*evlist)
>> void evlist__warn_user_requested_cpus(struct evlist *evlist, const =
char *cpu_list)
>> {
>>        struct perf_cpu_map *user_requested_cpus;
>> -       struct evsel *pos;
>> +       struct evsel *pos, *tmp;
>>=20
>>        if (!cpu_list)
>>                return;
>> @@ -2508,18 +2508,28 @@ void evlist__warn_user_requested_cpus(struct =
evlist *evlist, const char *cpu_lis
>>        if (!user_requested_cpus)
>>                return;
>>=20
>> -       evlist__for_each_entry(evlist, pos) {
>> +       evlist__for_each_entry_safe(evlist, tmp, pos) {
>>                struct perf_cpu_map *intersect, *to_test;
>>                const struct perf_pmu *pmu =3D evsel__find_pmu(pos);
>>=20
>>                to_test =3D pmu && pmu->is_core ? pmu->cpus : =
cpu_map__online();
>=20
> Perhaps this would be clearer if we just made sure requested uncore
> CPUs were online. Uncore cpu maps are weird, they say the default CPU
> but other CPUs are valid. It'd be worth testing the impact of this
> change on uncore events.

Hi  Ian,

I tested the "uncore_clock" event and it seems to work fine.
The results are as follows:

   $ ~/perf stat  -e uncore_clock/clockticks/  -C 12


    ^C
     Performance counter stats for 'CPU(s) 12':

           740,036,624      uncore_clock/clockticks/

           4.135909502 seconds time elapsed

>=20
>>                intersect =3D perf_cpu_map__intersect(to_test, =
user_requested_cpus);
>> -               if (!perf_cpu_map__equal(intersect, =
user_requested_cpus)) {
>> -                       char buf[128];
>> +               if (!intersect) {
>> +                       evlist__remove(evlist, pos);
>> +                       evsel__delete(pos);
>> +                       perf_cpu_map__put(intersect);
>=20
> evlist__warn_user_requested_cpus seems like a wrong function name if
> evsels are being removed. Perhaps something like
> evlist__remove_empty_cpu_map_evsels. It seems this change will remove
> warnings in cases like:
>=20
> $ perf record cpu_atom/cycles/ -C 0 ...
>=20
Yes ,I will fix it.

> I wonder that we need a flag in the evsel to say when an event comes
> from wildcard expansion so we only don't warn/remove in that case.
>=20
That sounds very reasonable. Furthermore, if the event is not from =
wildcard and it's=20
cpu maps is empty, the evsel needs to be deleted and the process should =
be stoped.
I tried to implement it in v3 patch.

> Wrt memory leaks, try compiling with EXTRA_CFLAGS=3D"-fsanitize=3Daddres=
s"
> which also incorporates leak sanitizer.

Got it,  thanks.


Best wishes
Chunxin

>=20
> Thanks,
> Ian
>=20
>> +                       continue;
>> +               }
>> +
>> +               if (!perf_cpu_map__is_subset(user_requested_cpus, =
intersect)) {
>> +                       char buf_test[128];
>> +                       char buf_intersect[128];
>>=20
>> -                       cpu_map__snprint(to_test, buf, sizeof(buf));
>> -                       pr_warning("WARNING: A requested CPU in '%s' =
is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
>> -                               cpu_list, pmu ? pmu->name : "cpu", =
buf, evsel__name(pos));
>> +                       cpu_map__snprint(to_test, buf_test, =
sizeof(buf_test));
>> +                       cpu_map__snprint(intersect, buf_intersect, =
sizeof(buf_intersect));
>> +                       pr_warning("WARNING: A requested CPU '%s' in =
'%s' is not supported by "
>> +                                  "PMU '%s' (CPUs %s) for event =
'%s'\n", buf_intersect, cpu_list,
>> +                                  pmu ? pmu->name : "cpu", buf_test, =
evsel__name(pos));
>>                }
>>                perf_cpu_map__put(intersect);
>>        }
>> --
>> 2.34.1
>>=20


