Return-Path: <linux-kernel+bounces-156523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E99F8B03E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902AE1C236A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF14158851;
	Wed, 24 Apr 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pVAmmGFp"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AB36D;
	Wed, 24 Apr 2024 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946180; cv=none; b=angnFDT+vhtbWCbRGkGEZ8WjcOHs+XR4/rDNVv1DxxVnTAaOWCHxN3Pe+muzThSvDph7/ii30/Pv1oR1rgJOH74pzH8AX3wMQDcN1jMYJgkSz+ZygXWiDBhuYnSqy6B3xeRVM7iliclmGz4z6gtRXtd4staLTXNDfuI6YHU8rT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946180; c=relaxed/simple;
	bh=A9OVYBwzn9mh+suuk7UPlPFT2pggBVcyxifse9t5Nh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idQzWFlyEKhaK9Iec/9LKC8Us8PEpW4ykKkOGqiAJp2xno9dwnUX7bsrAb2ZmazhvEaDFof3wGsKVVd/JkN0Ae8qc/lXvw+TXOPqOnTPDAMz6QFPZdQ5VPx7eYYkP/I5yp031erPnmQwgibpIcEAP9vjibyK9nc8b0QeORi0lYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pVAmmGFp; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=A9OVYBwzn9mh+suuk7UPlPFT2pggBVcyxifse9t5Nh4=;
	t=1713946178; x=1714378178; b=pVAmmGFpGTWDOzC3+COv2MCZpsvGXNLElvxY5cJN+hdVrMc
	/ujogRIuor/zod0mOkCh6u02jr4YdwV96/ppUg6sQ4+PmFTSP5pMs1QJ092oXJKFuscrrjb9rs5l8
	//CqTvGMGpYdT6mjMvmS9WkMO7WGCDarnc8aVQfZgTwwPcqilQ/Cp9cV7SvWv1ymWdVou26gB2OUA
	f8mx51QmhiPJswFIKfLYo2+vBhTNPvjHDxLlkXika4TNpe/W3xouhhtOlZgOzG04gCSr7fals1oOi
	RtyoVymK4zviNmevXqfsp0kp3Omde2Pjm1X3sS6dwiaqEOY1CiSaGJch8Ptj11UQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzXh9-0002qV-QH; Wed, 24 Apr 2024 10:09:35 +0200
Message-ID: <5ef0ac71-21dd-46d7-a0c1-1b1b391e51a8@leemhuis.info>
Date: Wed, 24 Apr 2024 10:09:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: API break, sysfs "capability" file
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
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
 <Zh6IpqnSfGHXMjVa@gardel-login>
 <b74f99e8-5a50-4e93-987f-0bcfc0c27959@kernel.dk>
 <Zh6KZ7ynHuOd0mgQ@gardel-login>
 <c3a6a639-bf15-4f8b-abbd-978d9836d93c@kernel.dk>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c3a6a639-bf15-4f8b-abbd-978d9836d93c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713946178;73e32188;
X-HE-SMSGID: 1rzXh9-0002qV-QH

On 16.04.24 16:33, Jens Axboe wrote:
> On 4/16/24 8:25 AM, Lennart Poettering wrote:
>> On Di, 16.04.24 08:22, Jens Axboe (axboe@kernel.dk) wrote:
>>> On 4/16/24 8:18 AM, Lennart Poettering wrote:
>>>> On Di, 09.04.24 09:17, Jens Axboe (axboe@kernel.dk) wrote:
>>>>
>>>>> On 4/9/24 8:15 AM, Christoph Hellwig wrote:
>>>>>> On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
>>>>>>> All I am looking for is a very simple test that returns me a boolean:
>>>>>>> is there kernel-level partition scanning enabled on this device or
>>>>>>> not.
>>>>>> And we can add a trivial sysfs attribute for that.
>>>>>
>>>>> And I think we should. I don't know what was being smoked adding a sysfs
>>>>> interface that exposed internal flag values - and honestly what was
>>>>> being smoked to rely on that, but I think it's fair to say that the
>>>>> majority of the fuckup here is on the kernel side.
> [...]
> Doesn't really change my conclusion from earlier. As mentioned, this is
> clearly a kernel fuckup, and honestly since it's being presented as ABI,
> we definitely need to rectify this and provide an alternative. Even
> though I'm not a huge fan of it, might just be best to re-introduce
> 'capability' and just have conversions of the flags so we retain the
> user side of it the same. That can then also go into stable, so we'll
> end up with something that at least looks cohesive on the user side.

Jens, quick question: what's the plan forward here and who will realize
what you outlined?

I'm asking, as afaics nothing happened for a week (hope I didn't miss
anything!). Sure, it's not a regression from the last cycle or so, so
it's not that urgent. But hch's "It is not a regression at all" last
week made me worry that this in the end might not be solved unless
somebody has it on the todo list. Normally I would have CCed Linus at
that point anyway to get his stance, but from your statements it sounds
like this is unnecessary here.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

