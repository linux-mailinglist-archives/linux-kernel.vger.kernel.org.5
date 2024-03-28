Return-Path: <linux-kernel+bounces-123349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F808906F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF5129FBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875040842;
	Thu, 28 Mar 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="T46JQNJ9"
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C13BBC5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645871; cv=pass; b=kEvcUbia8HKpjwsjAqyDZgoUsRA/wBeitDU6RVD09/LXfCWpDddu7q8f3bL/fAareD/bs8UabIEYIY4+uA/sUI0QvhuLjizw60j9zA1KQSKduT50N+pd3NINrBqqWsd/URSXLM4/dtxCWZEJnFC1guVNdcZHX/1Sw6tU3SUzkGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645871; c=relaxed/simple;
	bh=6APAIIP6Iu8uhBPiP4+nplcZGdT+3EuubTzekx7NgQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd1rdGS9RmN0RYZZZFFhIvXJbFFP1JsYLYPUrosDXtMu/T8LBzAPdeIJJJqQaypLOe4uvlnzFgU8czwo0ZRUhfcA8OazRNcSs+iNTx88XNHpS+Tkqb3q7ih+iGFS59ujnoQT0PdBjagBWPGLLqDoQ0s4ZBQQAK9aLeHZL5I4xGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=T46JQNJ9; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711645844; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PyVQ+2/h8Sz170gJhF8C4cm1S8Pooes3SI5S1Yx3wAoumwaLRXjEkJ6KDwqYn9FloDkq07JcvTjzNRuF+d2xRltZ+u+rBOJjlRD3TSTQt0PeiVEdjP7aEVXaRyR7JVmG0p/20h0HOLiypVt1YUYmh76dqslMFJy/hsP/iRkk9KI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711645844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZPoFcPyLcDvpSZuEBD9w5JR4kbrua7Xy19ysxDlZfiE=; 
	b=chR8VfbqxON2PPMqRKfp47eVgBSpRnNLIHZado/RfA3BKXFebRPKrwApFXuLEAAtmj0nOpVfgS6rRc8mwtdWK43T/nPVyhSJM4keT35BMnXRj8evmUPkCcjtCR0DYDqppfxo1cyGGL/Vsr47Et2yHRQlEq+vG9JLN4kVN+TElw4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711645844;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZPoFcPyLcDvpSZuEBD9w5JR4kbrua7Xy19ysxDlZfiE=;
	b=T46JQNJ9AhgRY8pJJ3lt2pOZcITbuQjRCIrsufsl+T0PVNhj5a5Nh/4Xep+NMzz/
	au4kmfzsjgAgzqCtuq+cL4xC5euxOa2LPmJhzBhsNPw29wsubqIiEPVG6VwzaUkffWU
	vDGNftWthgQZHqBe4leueIovKD4XA6rDuKjFfeas=
Received: from [192.168.11.99] (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711645842705803.0613795359005; Thu, 28 Mar 2024 18:10:42 +0100 (CET)
Message-ID: <163e1980-41ff-4a5f-9d93-431e65fd3a9d@bursov.com>
Date: Thu, 28 Mar 2024 19:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with
 sched_relax_domain_level
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <cover.1711584739.git.vitaly@bursov.com>
 <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
 <CAKfTPtCux6diCArXcF11w+D1VMKLwj-eWUeXQq3d=2=2Xfe8uw@mail.gmail.com>
 <1679cb16-a4a1-4a5f-9742-3523555d33f9@bursov.com>
 <CAKfTPtDbRUNEQ4g3rBxuC8daa6Dj_Eba8mHhVr+9UZ9eAFTPkw@mail.gmail.com>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <CAKfTPtDbRUNEQ4g3rBxuC8daa6Dj_Eba8mHhVr+9UZ9eAFTPkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 28.03.24 18:48, Vincent Guittot wrote:
> On Thu, 28 Mar 2024 at 17:27, Vitalii Bursov <vitaly@bursov.com> wrote:
>>
>>
>> On 28.03.24 16:43, Vincent Guittot wrote:
>>> On Thu, 28 Mar 2024 at 01:31, Vitalii Bursov <vitaly@bursov.com> wrote:
>>>>
>>>> Change relax_domain_level checks so that it would be possible
>>>> to exclude all domains from newidle balancing.
>>>>
>>>> This matches the behavior described in the documentation:
>>>>   -1   no request. use system default or follow request of others.
>>>>    0   no search.
>>>>    1   search siblings (hyperthreads in a core).
>>>>
>>>> "2" enables levels 0 and 1, level_max excludes the last (level_max)
>>>> level, and level_max+1 includes all levels.
>>>
>>> I was about to say that max+1 is useless because it's the same as -1
>>> but it's not exactly the same because it can supersede the system wide
>>> default_relax_domain_level. I wonder if one should be able to enable
>>> more levels than what the system has set by default.
>>
>> I don't know is such systems exist, but cpusets.rst suggests that
>> increasing it beyoud the default value is possible:
>>> If your situation is:
>>>
>>>  - The migration costs between each cpu can be assumed considerably
>>>    small(for you) due to your special application's behavior or
>>>    special hardware support for CPU cache etc.
>>>  - The searching cost doesn't have impact(for you) or you can make
>>>    the searching cost enough small by managing cpuset to compact etc.
>>>  - The latency is required even it sacrifices cache hit rate etc.
>>>    then increasing 'sched_relax_domain_level' would benefit you.
> 
> Fair enough. The doc should be updated as we can now clear the flags
> but not set them
> 

SD_BALANCE_NEWIDLE is always set by default in sd_init() and cleared
in set_domain_attribute() depending on default_relax_domain_level
("relax_domain_level" kernel parameter) and cgroup configuration
if it's present.

So, it should work both ways - clearing flags when relax level
is decreasing, and not clearing the flag when it's increasing,
isn't it?

Also, after a closer look at set_domain_attribute(), it looks like
default_relax_domain_level is -1 on all systems, so if cgroup does
not set relax level, it won't clear any flags, which probably means
that level_max+1 is redundant today.

