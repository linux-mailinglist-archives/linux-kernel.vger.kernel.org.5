Return-Path: <linux-kernel+bounces-146553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD628A671D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C969B21D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE785624;
	Tue, 16 Apr 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="OxbjDehD"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A71F19A;
	Tue, 16 Apr 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259606; cv=none; b=gtCcZTHFSntfMj6F1RMtp/ZGt6BPiZAoBqB89mHxdpufcYJ80q3H2mGZfh0uQyUukd/71UvXV04/y/UkqDHxK0pHHflB4rHLSinn7Md4kkI9ox5deaoaPfpHVHI8g/Lae49BugZ2Vxo9hYmksjTU0Es6v5DNUP4whcTRlCzL3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259606; c=relaxed/simple;
	bh=i/eO1ladMzDhxr4IiDBZVKgCu3NyVU9E79C81S9wN9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqHfDHfv00thJkT/zsCw11wj/DHnlTTIG3g+T3gUEBSzbnWjTFPj6AfOcIcUcYUmHxv39oWXSx4Df7peogFtRHuPVEDhUOWQ2BbRph1L7Lr01NqCEHdPtLH6Gv7zCp82LUuC8/S5z4eXLrHUzgxbVUSTil5hzKjw6UqImiT41Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=OxbjDehD; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=S9r7NiX06CEUmKV7VYAgowLdLkXFzpLNrB4rEaa86Jo=;
	t=1713259603; x=1713691603; b=OxbjDehDaAGSYT1/7TOgp/x/JMM71arg5ufeFlOEX4hjdnw
	bOEm0Q7gNhj4Ctr/z24JvNxXY+GRQlue0dYm0FWTo+aiI9sXLtdmvXjCUgoF7tS+bwFgf9CHzI+ch
	pxtKeh4h8BQzuWaS7vd1o+BIr2bCz3vLaYbXhVQZN/flPTI1JspxImyTIPDp07aZHQv+llvFG/L4k
	Wiv3B1VTwpQ3VK1IBSCbufozkl7BQsafxzC12REFdL5SUB9/zQ+3dXCgZqhsQpvA1hfpu2V/DVX6i
	gexABD2iSQAlXBaL46O9fwapxwcfu8YFMbV/0zIw1ygABAeIfOfFKGYw36AHZuqQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rwf5N-0001ip-Gn; Tue, 16 Apr 2024 11:26:41 +0200
Message-ID: <1bf9be9a-4d05-4d3b-ab76-13a825cd1758@leemhuis.info>
Date: Tue, 16 Apr 2024 11:26:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: API break, sysfs "capability" file
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Lennart Poettering <mzxreary@0pointer.de>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de>
 <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713259603;2ae83ce4;
X-HE-SMSGID: 1rwf5N-0001ip-Gn

On 09.04.24 17:17, Jens Axboe wrote:
> On 4/9/24 8:15 AM, Christoph Hellwig wrote:
>> On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
>>> All I am looking for is a very simple test that returns me a boolean:
>>> is there kernel-level partition scanning enabled on this device or
>>> not.
>>
>> And we can add a trivial sysfs attribute for that.
> 
> And I think we should. I don't know what was being smoked adding a sysfs
> interface that exposed internal flag values - and honestly what was
> being smoked to rely on that, but I think it's fair to say that the
> majority of the fuckup here is on the kernel side.
>  
>> At this point we're just better off with a clean new interface.
>> And you can use the old hack for < 5.15 if you care strongly enough
>> or just talk distros into backporting it to make their lives easier.
> 
> We should arguably just stable mark the patch adding the above simple
> interface.

I might have missed something, but it seems nothing has happened since a
week. Sure, this is hardly a new regression, so it's not that urgent;
still it would be good to see this fixed rather sooner than later after
all the publicity this got. So allow me to quickly ask:

Is anyone (Christoph?) already working on such a patch or is it at least
somewhat high on somebody's todo list?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

