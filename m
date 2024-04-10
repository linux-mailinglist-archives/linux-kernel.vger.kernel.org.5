Return-Path: <linux-kernel+bounces-138212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA889EE29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B53284F48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5941552FE;
	Wed, 10 Apr 2024 09:07:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CF19BA6;
	Wed, 10 Apr 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740053; cv=none; b=K+p90tKzVV+pSdWEXvshyya9F38v5dE25JFf4aEtAq67BI8YoPTrgg1U2bxWzZdTYIBIZhdtxt0fUXzenfmtvd1WCWlU4PK88h08fom2+2r6qk5JSbuHukUIPPXqW8ti17/clztQx2bHyabswvfZqz4kUSaa4U9eiyMvfFhZEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740053; c=relaxed/simple;
	bh=DCFRPg6qIxiB1ACreiHrvx9LkKXCawxI0vGuJQNuNrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH0Z5pizymuyzUOGKRZpCSeX8j4lo7TyB47NormIdBzBvEsuk51VCrM2lkXT88KakRaKC953WFjhaYKlSGplGScIHaWXxz4K2ZXRXBV5ymFu5p+6IZLRXldV9c5No8BlNDbGXvpLhzWPG2Absh+B/UeUzKEudfnoM6Pe9RuPmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98140139F;
	Wed, 10 Apr 2024 02:07:59 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0143F6C4;
	Wed, 10 Apr 2024 02:07:27 -0700 (PDT)
Message-ID: <8d776c30-0e5c-4caf-9b7e-52adb6115eab@arm.com>
Date: Wed, 10 Apr 2024 10:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf tests: Skip "test data symbol" on Neoverse N1
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>,
 linux-kernel@vger.kernel.org
References: <20240409084741.405433-1-james.clark@arm.com>
 <20240409084741.405433-4-james.clark@arm.com>
 <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
 <CAM9d7cio+JYnzwtiVSpsmGrxJWyqv3m0ppmqGidHs5psZdi93w@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cio+JYnzwtiVSpsmGrxJWyqv3m0ppmqGidHs5psZdi93w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/04/2024 00:17, Namhyung Kim wrote:
> Hi Ian and James,
> 
> On Tue, Apr 9, 2024 at 8:39 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, Apr 9, 2024 at 1:48 AM James Clark <james.clark@arm.com> wrote:
>>>
>>> To prevent anyone from seeing a test failure appear as a regression and
>>> thinking that it was caused by their code change, just skip the test on
>>> N1.
>>>
>>> It can be caused by any unrelated change that shifts the loop into an
>>> unfortunate position in the Perf binary which is almost impossible to
>>> debug as the root cause of the test failure. Ultimately it's caused by
>>> the referenced errata.
>>>
>>> Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testing")
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>
>> This change makes me sad :-( Is there no hope of aligning the loop? We
>> have little enough testing coverage for memory events and even precise
>> events on ARM that anything take away testing coverage feels like we
>> should try to do better.
> 
> Can we just add some noise in the loop?
> 
> Thanks,
> Namhyung
> 

Yes that would probably work. I decided to skip rather than touch the
test because I didn't want the errata on one specific core to affect
testing everywhere else.

But if we don't think that it's too hacky to include that in the test
then I can add it. To be honest maybe it makes the test more "realistic"
because a very short infinite loop doesn't really represent a real workload.

> 
> diff --git a/tools/perf/tests/workloads/datasym.c
> b/tools/perf/tests/workloads/datasym.c
> index ddd40bc63448..e2514bf393cd 100644
> --- a/tools/perf/tests/workloads/datasym.c
> +++ b/tools/perf/tests/workloads/datasym.c
> @@ -16,6 +16,8 @@ static int datasym(int argc __maybe_unused, const
> char **argv __maybe_unused)
>  {
>         for (;;) {
>                 buf1.data1++;
> +               if ((buf1.data1 % 100129) == 0)
> +                       buf1.data1++;
>                 buf1.data2 += buf1.data1;
>         }
>         return 0;
> 

