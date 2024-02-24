Return-Path: <linux-kernel+bounces-79705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E498625A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5355B1C21134
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F638FA1;
	Sat, 24 Feb 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MJC1Wulx"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8D14B820;
	Sat, 24 Feb 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708785092; cv=none; b=Y7rudEiOpBMSMDATLwer5lfr/mpxpBeMtqdusiIHfZpuq0t+ayM/s4SXYLsunhYCsGwIIZ24tipnw52hq0UzPJ/t4Qwj4SMwQZTtMmSfc7Ls/sr2tj3GG0Vn2a6EmxLzBzShEqZqQi7jAn1ga/+BoYbxq0SJWKYYloUyeLPdoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708785092; c=relaxed/simple;
	bh=rp/h+IP7q6vVjrjiIaB/eBbUj7Tff2g1IBWRmxNzmlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSObhiVzADI3n4fcwpsdMZ+4NMFK4qqTEp9lE/yHQT4+IGuYGJn/O5fslIrsax1vW1fn8uFb5fKi7SO6hrS0P+lZwRPhO4ugKA4o17woc5/XLKExb/oGU/6vU1vtVnlXbzuDlwgXzPRfCQd177zVhprtCBbQssA+6O8vfuXZffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MJC1Wulx; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=YEmV7dFKFaJpVYI86wjLhEPnZQ01RauyXSO8LRhg7dM=;
	t=1708785090; x=1709217090; b=MJC1WulxB5Mc0AYrTa35NmOhpJqLs2qcfORCTj6TWhJ4uNp
	pT3dR4tfBJ+VCHNBnN/H8mM8+11ubCbZF552G3/jMW0YmT9ORJWXIa1x2cUOcamItal9A/Ea/dZmd
	51lgq0lMJAODy4j5K6PVMgmKe2ITbeYH5IacO3tM6sHuAmbtiAFfaME/jzgP7f+swgP7nrI5F5t4Q
	VqwTF9j906i6FWG4YZ/Iihu6cb85i5oIHEIoAmObwrYWbbOkKMgQvylqKWb1AyRKX/m7jRro6M3jh
	A1Ni3pqg1fcqVEDsXUi8Q9xr2wlAQSqi3fqp0Dmuj1g6ZYMJrQpfAHRP5VqlvGCw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rdt3m-0003og-Om; Sat, 24 Feb 2024 15:31:26 +0100
Message-ID: <a831a69f-fa75-4ae2-b7d5-a2bbfd6bd9dd@leemhuis.info>
Date: Sat, 24 Feb 2024 15:31:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
Content-Language: en-US, de-DE
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Doug Smythies <dsmythies@telus.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
 <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net>
 <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
 <000b01da5d09$8219f900$864deb00$@telus.net>
 <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com>
 <001b01da5ea7$86c7a070$9456e150$@telus.net>
 <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
 <003001da6061$bbad1e30$33075a90$@telus.net>
 <CAKfTPtC82YXOw5yYPNkHHyF+DYSG+Ts9OjnwsVjbd_HcUsZQMg@mail.gmail.com>
 <c03533dc-73fc-4d97-8248-0affbddbed32@leemhuis.info>
 <CAJZ5v0hfMuiZCFU6e9TZ7yZV1qER2ymOM7d=AAf5beyMOyHg+g@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAJZ5v0hfMuiZCFU6e9TZ7yZV1qER2ymOM7d=AAf5beyMOyHg+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708785090;92a8baa2;
X-HE-SMSGID: 1rdt3m-0003og-Om

On 24.02.24 15:11, Rafael J. Wysocki wrote:
> On Sat, Feb 24, 2024 at 2:44 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 16.02.24 14:17, Vincent Guittot wrote:
>>> On Thu, 15 Feb 2024 at 23:53, Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> This email thread appears as if it might be moving away from a regression
>>>> caused by your commit towards a conclusion that your commit exposed
>>>> a pre-existing bug in the intel_psate.c code.
>>> Ok
>>
>> Well, even in that case it's a regression that must be fixed -- ideally
>> before 6.8. Did anything happen towards that?
>>
>> I noticed that Doug send the fix "cpufreq: intel_pstate: fix pstate
>> limits enforcement for adjust_perf call back":
>> https://lore.kernel.org/all/20240217213010.2466-1-dsmythies@telus.net/
>>
>> Is that supposed to fix the problem? Looks a bit like it, but I'm not
>> totally sure. In that case I'd say it likely should be applied to 6.8,
>> but Rafael apparently applied it to 6.9.
> 
> This hasn't reached linux-next yet, so I rebased it on top of -rc5 in
> order to push it as a 6.8 fix.

Ahh, great, many thx!

>> I'd also say that a Fixes: would be good as well (to ensure that fix is
>> also backported in case anyone backports 9c0b4bb7f630), but I know that
>> subsystems handle this differently.
> 
> So I added a Fixes: tag to it, but it points to the original change
> that missed the check.

Yeah, that totally works for me as well. Again: many thx!

Ciao, Thorsten

