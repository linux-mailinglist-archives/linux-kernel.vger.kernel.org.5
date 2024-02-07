Return-Path: <linux-kernel+bounces-56308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666A84C886
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A408284525
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879425618;
	Wed,  7 Feb 2024 10:23:03 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C725570;
	Wed,  7 Feb 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301383; cv=none; b=B4Oa5+5nGZYtkPTk2d4lEhMN05InLO2tSH2bcjMhP6qb+6/rcgZqWvnyw6JgS+2A6RnbdYPmlVD/cybNB0jiYHaWvquyKZpzRUavzbSoe8ti28oJgqaC+FpJbIJrdu1QB67rLwKNXFxrws8ujMTkkizmAJjOHksRqbGukTyqRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301383; c=relaxed/simple;
	bh=CmleNf792cQSMYSiQYUDV7WGzGydPRVj5b7vpmPTNxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+sfRLjaKuR4oBazcpyTnfJRJ0lbzKpbXts37feiifOTWTJsv/D+wmRfpRY99jn6avXdQGgu0qgNgZnHQ5YWjDl2YOq3bUKyBCTh7pbyT21+uypLNWEEm+zeB1mi3RBBr4YkvUj/uMjfo3VBoOhIepCx7zSTh60AshqyPg5KmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rXf50-0002L3-Iu; Wed, 07 Feb 2024 11:22:58 +0100
Message-ID: <1f46035e-d21d-4033-a43a-3fbb2ae89f7f@leemhuis.info>
Date: Wed, 7 Feb 2024 11:22:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Content-Language: en-US, de-DE
To: Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <e4305f3d-ede8-44fc-8bd4-eae899284f56@leemhuis.info>
 <2024020758-judo-stardom-80f5@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2024020758-judo-stardom-80f5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707301381;2313da1d;
X-HE-SMSGID: 1rXf50-0002L3-Iu

On 07.02.24 11:09, Greg KH wrote:
> On Wed, Feb 07, 2024 at 08:04:49AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 04.02.24 05:43, Стас Ничипорович wrote:
>>> After trying again to create the ipset with timeout option I get a kernel panic
>>> # ipset create throttled-ips hash:ip family inet hashsize 1024 maxelem
>>> 100000 timeout 600 bucketsize 12 initval 0x22b96e3a
>>> ipset v7.20: Set cannot be created: set with the same name already exists
>>
>> To be sure the issue doesn't fall through the cracks unnoticed, I'm
>> adding it to regzbot, the Linux kernel regression tracking bot:
>>
>> #regzbot ^introduced fdb8e12cc2cc
>> #regzbot title netfilter: WARNING when using ipset with timeout option
>> #regzbot fix: netfilter: ipset: Missing gc cancellations fixed
>> #regzbot ignore-activity
> 
> Note, this did not get applied to the stable kernels, so it's an issue
> in Linus's tree only, with a proposed fix already posted (and might be
> in linux-next already, haven't checked...)

Thx, but don't worry, I know. It's just that the patch didn't make any
progress in the last few days, that's why I decided to now add it to the
tracking.

As I just noticed I apparently did so with the wrong commit-id, which I
just picked from the proposed fix without verifying. :-/ Will fix this
up for regzbot and tell Jozsef.

#regzbot 97f7cf1cd80eee
#regzbot monitor
https://lore.kernel.org/all/20240204152642.1394588-1-kadlec@netfilter.org/

Thx again. Ciao, Thorsten

