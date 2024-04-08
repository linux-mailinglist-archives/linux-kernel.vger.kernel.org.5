Return-Path: <linux-kernel+bounces-135763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C389CAF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4E71C225F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915F143C7E;
	Mon,  8 Apr 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="oxkRMRYM"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAA1428EE;
	Mon,  8 Apr 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598197; cv=none; b=kKraY/sbYGrG7DTDS/SD3Nm1mW2tP9/QPa10j0RlQW3MOsvj25RVEo0PMcUD5c5xVAmYy+2VYzvVjbaW/lpMAOiu5k9IsltAVp9hpiKmbMgIdDfU2kBsv6u84ScXO2EDlql6IK9SK/JoRP78dXNWePkX93kv5MPXvasCpR6nlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598197; c=relaxed/simple;
	bh=g8oRrmqr8moeiS6NyhsxZoH2oLpqqx/XzuJgezEW82Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=munimllX7Z59tfZCPn1/9KFnjIPrsAfdkbsomo2y8tNwj5b8ZgVLOWIRPWlFItPRvsh3S63udMbdjDo3jnHZA+AXhVAczEUdcmxe5Z1S8sa6idLkUYeHAXg+CYaUejGGn98wTdnTnN3zakXpeuF/Sbe0yJLNYmxQJyDOQf44Zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=oxkRMRYM; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=PVTh6s7jgrS2WQwtxkgKnCwtY7ergCKyjU5evv0ZKQk=;
	t=1712598194; x=1713030194; b=oxkRMRYMehUWVASB8d6wgt5BwaF3M6nQPigWtDy8hvRgsR0
	GxuC7iNeCOYJkJ7f8V3neGnFjA4wMeui3vtClTgjNxJYx9UyxP3FkbCIrBvB11KQBi3fE6PuIb9pA
	C4WQRKszYEFh7wFxg0aOHBJh3lEk6KMrCIT+C1R1nf2YB6zn7djzvTFi7RifgFBp0tvJkXAI3ixoS
	drtWDAmkBz8574szLsVKVjJsWn4zssHsXZYEGly7iRIPVtgB2tOJzQ/3+vPNdZtlpRFmSF3BGmfEk
	FSuHF17zr9Sw5Ldz2XCKl4tNzElensm380ORu1c/6Be0kJSIo4i+ie1S0vMjik4A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rtt1O-0000vP-Oe; Mon, 08 Apr 2024 19:43:06 +0200
Message-ID: <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
Date: Mon, 8 Apr 2024 19:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: API break, sysfs "capability" file
To: Christoph Hellwig <hch@lst.de>
References: <ZhQJf8mzq_wipkBH@gardel-login>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Lennart Poettering <lennart@poettering.net>, linux-block@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZhQJf8mzq_wipkBH@gardel-login>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712598194;2e400a9a;
X-HE-SMSGID: 1rtt1O-0000vP-Oe

[adding the culprit's author to the loop; also CCing everyone else in
the Signed-off-by chain and a few lists that should be in the loop, too]

On 08.04.24 17:13, Lennart Poettering wrote:
> 
> So this broke systemd:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e81cd5a983bb35dabd38ee472cf3fea1c63e0f23

FWIW, that is e81cd5a983bb35 ("block: stub out and deprecated the
capability attribute on the gendisk") [v6.3-rc1]

> We use the "capability" sysfs attr to figure out if a block device has
> part scanning enabled or not. There seems to be no other API for
> this. (We also use it in our test suite to see if devices match are
> expectations, and older systemd/udev versions used to match agains it
> from udev rules.)
> 
> The interface was part of sysfs, and documented:
> 
> https://www.kernel.org/doc/html/v5.5/block/capability.html
> 
> While it doesn't list the partscan bit it actually does document that
> one is supposed to look into include/linux/genhd.h for the various
> bits and their meanings. I'd argue that makes them API to some level.
> 
> Could this please be reverted? Just keeping the relevant bits (i.e. at
> least the media change feature bit, and the part scanning bit) is
> enough for retaining userspace compat.
> 
> (Please consider googling or a github code search or so before removing
> a public API like this. This compat breakage was very much avoidable
> with a tiny bit of googling.)

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e81cd5a983bb3
#regzbot title block: sysfs "capability" file broke systemd's checking
for part scanning
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

