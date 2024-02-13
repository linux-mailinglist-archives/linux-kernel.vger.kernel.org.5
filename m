Return-Path: <linux-kernel+bounces-64041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE2585394B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB14C286E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6D60872;
	Tue, 13 Feb 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsbetFnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7760869
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847126; cv=none; b=BTYbLByXuwgWxd3pBfv4kdMHnnl9IQHwWhUsiptCXNePb4mPzj2+1kpspJr9+4osJGr40W6k+R5o3Z7drZs1Hrzq9ufcleU+d/Qv0IbZHu3ENQjQTZIIa5T5brkK+Y3yl4AxhHE9ceahIAVy7JGDh7XVDkbiaH2M9MRhkUq2UEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847126; c=relaxed/simple;
	bh=WyK93sqYjZ1EHmECDHUlXwi1w9yv7ko8zYeRsLJ56fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og8bE2wdvRUJOkuFpbRzFwOK7OXKNs+09jGchi/YVdxcJMcAq4s0wiYKhvuYEf47UGbDZZ4Q0hzss1F6u5MN7RYoZNR8sPAzDzzuC9qPpPnJpXcTg42jcKqwmPVsm9NlBNgZqA9vHZwb5d9oiGpOJ8+sZDIp7fd3VgEHf+VfTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsbetFnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442E9C433F1;
	Tue, 13 Feb 2024 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847125;
	bh=WyK93sqYjZ1EHmECDHUlXwi1w9yv7ko8zYeRsLJ56fQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FsbetFnbi7X5Tetwvs1GAJUCzGI7rx6T2v22JXzPbuCkYku4bJh3p765MmIE+cTPM
	 BZUGbpaPOCbARXF4Y05fCkFyayFPAmAz7fTcc3O49NabGGyFSusx9ve8VOhmpxxrx8
	 Hr2H3PGEylU5zBMxiPzx9Ve3vuRHi4gDgwTXvb3DJgs62BbKRM0Z/6v6/i5lxOKkBm
	 axShJ3LqwqeXgseZjrEl4WKmbxUargI6BmTpxU11aNhXdXctQCyNsNzdQni3J0rvCJ
	 jafD4xh5Im6hsOvz/VIOy1K3cIZ59imYChhe+nVcdJ7tIE8pnaxXGrfnsH9tgN8j71
	 jwK4Xp/MPXz1g==
Message-ID: <705ebfb9-e9a6-4dc1-8974-2fa8d93ca45a@kernel.org>
Date: Tue, 13 Feb 2024 18:58:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tracing/tooling: Fixes for v6.8-rc4
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, John Kacur
 <jkacur@redhat.com>, limingming3 <limingming890315@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240212170107.60da326a@gandalf.local.home>
 <CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com>
 <20240213124858.0faf6207@gandalf.local.home>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240213124858.0faf6207@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 18:48, Steven Rostedt wrote:
> On Tue, 13 Feb 2024 09:32:26 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Mon, 12 Feb 2024 at 14:00, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> Tracing tooling updates for 6.8-rc4:  
>>
>> Bah. I've pulled this, but since I did a new system install due to a
>> disk upgrade some time ago, I once again don't have libtracefs-devel
>> installed.
>>
>> And guess what? The dependency rules are - once again  - completely
>> broken, and trying to build this gets the bad old unhelpful error
>>
>>    latency-collector.c:26:10: fatal error: tracefs.h: No such file or directory
>>
> 
> Hmm, that's not from this pull request. But still needs to be fixed.

I did not catch that because it is in the tracing dir, but not on rtla. It is an old
sample code, still... bad it was not covered. Sorry for that :-(.

> 
>> with no help for the user.
>>
>> Yes, I know what to do. That isn't the point. And no, this isn't new
>> to this pull request, it's just that on this machine I haven't tried
>> building the tracing tools in a while.
>>
>> Let's not make the user experience for people who want to do kernel
>> builds any worse than it has to be.
>>
>> Side note: instead of the (clearly broken) special Makefile rules, can
>> you please just take a look at the perf code instead?  In fact, maybe
>> it's time for the kernel tooling people to try to unify and come to an
>> agreement about these things, and share more of the code.
>>
>> Because unlike the tracing tools, the perf tools seem to generally get
>> this part of the build system right, despite (or probably due to)
>> having a lot *more* (and more complex) library dependencies.
> 
> Daniel is mostly maintaining this work.
> 
> Daniel, can you talk with Arnaldo and be able to collaborate with him on
> consolidating the build process?

Sure, I have a good relation with Arnaldo, and he is aware of my work as well.

-- Daniel


