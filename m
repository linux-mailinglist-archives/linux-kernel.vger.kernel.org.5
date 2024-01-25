Return-Path: <linux-kernel+bounces-38394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4BB83BECA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EDE1C23921
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787E1CAA7;
	Thu, 25 Jan 2024 10:28:46 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB81C6B5;
	Thu, 25 Jan 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178525; cv=none; b=g7RkdFaBb0R0aVx15NsLjBK4kEzT2ZC5y5L7q8isTI+bgLb7ggYJDO3IZJ/zOwa/Ziq6l80J+kxWU6ebji9gdS3FUqJJIWUKiMFyN6/5bePvdATrSOu5RPfM+SrggsN+qjtmSrZ4kx/Qrlx4xlr652O6a/yp5hWIJYBlfacgqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178525; c=relaxed/simple;
	bh=CenqYOd1xt/Ush7B45mfMjIcgvqgSyN512XFCJsBrvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lseSpfYiqIZHnq1+8HNNZTZ6Sfk90vm8+UicRjSUJzUptXpIVQMBVVoH4AZ+mu8xfUVZNwTgLwPTCITLaOgehxsuTQDUNm74plbgfB4dLI9fw32BBevqiaiUeQFayDfXrB6Lge61ehdNzX44H3vPA/FXvWgLi4jL+KsQb5EYBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rSwyF-000713-JQ; Thu, 25 Jan 2024 11:28:31 +0100
Message-ID: <5cfc34c7-8298-4639-bb81-8b95392279ba@leemhuis.info>
Date: Thu, 25 Jan 2024 11:28:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: More detailed text about bisecting Linux kernel regression --
 request for comments and help
Content-Language: en-US, de-DE
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
References: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
 <87fryllpp5.fsf@intel.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <87fryllpp5.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1706178523;5c576dff;
X-HE-SMSGID: 1rSwyF-000713-JQ

On 25.01.24 10:36, Jani Nikula wrote:
> On Wed, 24 Jan 2024, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> Hi! Find below a WIP text on bisecting Linux kernel regressions I plan
>> to submit for inclusion in the Linux kernel documentation in a month or
>> two. I could do so now, but chose to write this mail instead, as the
>> text would really benefit from a few people actually testing the given
>> instructions. Hence if you notice somebody that faces a regression that
>> needs bisecting, consider poiting them them to this text, asking them to
>> play through this and provide feedback to me.
>>
>> Ideally point users to the following rendered version:
>> https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html
>>
>> It is (a) a lot easier to read (b) has no odd or broken line breaks,
>> like the text below has a few (sorry!) (c) is updated when I improve
>> something.
>>
>> Anyone who might be willing to provide feedback can do so in a reply
>> here
> 
> Hi Thorsten, first of all, thanks for doing this. I think it'll be good
> to have a document on kernel bisection to point people at.

Thx for saying that and also thx for taking a look and providing feedback!

> The one thing I find problematic is the use of shallow clones by default

FWIW, some of what is in that text is a result of similar discussion
that happened when
Documentation/admin-guide/quickly-build-trimmed-linux.rst was submitted
about a year ago, which also uses shallow clones by default.

Further a quick reminder, as it's easy to forget: most of us live in
areas where downloading a lot of data is not something that bothers us
or will take a lot of time. But it is different for some people that
will need this document.

Out of curiosity I just gave it a rough try with my 100 MBit (aka
neither-slow-nor-fast) connection.

Shallow clone:
 246.67 MiB, 0m48,015s

Deepening the shallow clone to v5.18 while adding linux-6.1.y:
 171.79 MiB, 1m47,510s

Full torvalds clone (just for completeness):
 2.77 GiB, 7m36,892s

Full stable clone:
 4.82 GiB, 12m12,093s

(reminder, those are just rough numbers, nothing else that was using the
connection much was going on, but this was not a lab setup!)

> and, well, the use of git in ways that I myself can't figure out without
> resorting to the man pages. I think it's a lot of dark corners of git
> that's overwhelming and really unrelated to the bisection itself.
> 
> If I point people at that, and they have problems, I'm just going to
> tell them to:
> 
>   git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   cd linux
>   git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>   git fetch stable

This could be simplified, as linux-stable.git includes mainline, it's
just sometimes a few hours behind.

> And I can tell them to 'git checkout v<GOOD>' and 'git checkout v<BAD>'
> and proceed from there.
> 
> To me, that's the TL;DR.

FWIW, I earlier today considered changing this myself. But then I
noticed the bundle clone instructions (more on that below) are complex
as well. :-/

Hmmm. Maybe switching to "do a full clone of linus' repo (without using
bundles) and just telling users to add the stable branches they might
need" by default would be a good middle ground for this document. Guess
then I'd switch quickly-build-trimmed-linux.rst over myself.

> And then you can have a section on "what if I
> really can't do full clones" and various options to save bandwidth.
> 
>> Downloading the sources using a full git clone
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> If downloading and storing a lot of data (~4,4 Gigabyte as of early
>> 2023) is nothing that bothers you, instead of a shallow clone perform a
>> full git clone instead. You then will avoid the specialties mentioned
>> above and will have all versions and individual commits at hand at any
>> time::
>>
>>   curl -L \
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
>> \
>>     -o linux-stable.git.bundle
>>   git clone linux-stable.git.bundle ~/linux/
>>   rm linux-stable.git.bundle
>>   cd ~/linux/
>>   git remote set-url origin \
>>     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>>   git fetch origin
>>   git checkout --detach origin/master
> 
> I mean seriously, even the full clone instructions use curl, without
> rationale. Why?

That was the result of the discussion back then, can't remember all the
details and all the places where that happened. Part of it was reducing
the server load, but that IIRC is mainly a concern for CI systems and
something this document can ignore. Unstable internet connection might
have been the main reason -- in combination with the redirection thing
kernel.org does, which *IIRC* prevents us from using "git clone
--bundle-uri=".

Ciao, Thorsten

