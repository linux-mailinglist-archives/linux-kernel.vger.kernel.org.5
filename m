Return-Path: <linux-kernel+bounces-49453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E56F846A89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D714D1F2322D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E14A99F;
	Fri,  2 Feb 2024 08:15:06 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745B48CD2;
	Fri,  2 Feb 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861705; cv=none; b=hI2nYd+FKw8mIv0/63v88Inz/wUYPzniE7jnMRi9yzm1qa1dkFKCebLl6ZvnUClQtdjZNow2BTKuhhNvauzqvcQ822UBUS1d1SlCRtijs/sV05aGFUKbY1Iuph6+G0pIjox+rKm3OQxmWZYwpuLQh2sZZkG5ldZPFhc/7YKXsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861705; c=relaxed/simple;
	bh=i4db+4fXLLc4iBdxESAdEOMW07qa5OKHK6f1hxgRkck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW1k+nktr2iG5BGR8opwKXWGFWqRelyUcbD9vYs3g2j7MTailjtUHh0nqtu60HwE50m3yVHU96A8r37QYsZG1g+D603cYbYe8Uxh5R/CZ+IRFzn2tA+b7DI0lhLbMHMk2m/0HPhro8Tq+yEZE6gqBB53aLVwoS0dWjHyvYtcrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rVohL-0002ck-Sz; Fri, 02 Feb 2024 09:14:55 +0100
Message-ID: <ccbb3aeb-daa1-49ba-b729-964bd97748bc@leemhuis.info>
Date: Fri, 2 Feb 2024 09:14:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] ath11k broken in v6.7
Content-Language: en-US, de-DE
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
 <878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
 <94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
 <87fryp3he0.fsf@kernel.org>
 <0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info>
 <871qa0xtk6.fsf@kernel.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <871qa0xtk6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706861703;a1282543;
X-HE-SMSGID: 1rVohL-0002ck-Sz

On 29.01.24 12:33, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>> On 22.01.24 09:24, Kalle Valo wrote:
>>> "Linux regression tracking (Thorsten Leemhuis)"
>>> <regressions@leemhuis.info> writes:
>>
>> That "#regzbot link:" will vanish as well (at least from the docs, it
>> will remain to be supported), as people use it wrong in various
>> different ways: for duplicates, reports (like your did), patch
>> submissions fixing the issue (then 'regzbot monitor' should have been
>> used) among others. Which is totally understandable now that I look at
>> it. That's why it will be replaced by "#regzbot related: <url>" to avoid
>> any connection with the Link: tag used in commits; for duplicates
>> "#regzbot dup:" will stay around.
> 
> So, in the new interface, how should I handle a situation that a
> regression is first reported on the mailing list, added to regzbot and
> later there's also a bug report opened for the issue?

You will have to options: reply to the first report with a "#regzbot
duplicate https://bugzilla.kernel.org/show_bug.cgi?id=325423423423542"
or add a comment to the bugzilla ticket pointing to a report already
tracked by regzbot, e.g. "#regzbot duplicate
https://lore.kernel.org/not_relevant/msgid-423423423423423423/"

>>> I wish there would be a person who could follow stable
>>> releases from wireless perspective and make sure everything is ok there.
>> Maybe at some point regression tracking can help somewhat with that. But
>> I still have to fix a few things to make people use it and scale it up.
> I just feel it should be more than that, I'm worried that randomly
> taking wireless commits to stable releases is risky. There really should
> be someone looking after wireless (read: reviewing patches) in stable
> releases. This would be a good role for someone who is interested to
> learn how kernel.org development works and helping the community. Do we
> have a way to announce these kind volunteer vacancies somewhere? :)

Not that I know of. Guess kernelnewbies might be the best place for that
(and maybe they have something like that already...).

Ciao, Thorsten

