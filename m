Return-Path: <linux-kernel+bounces-140348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F18A1326
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAFB1F228A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28514A087;
	Thu, 11 Apr 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gplRZsKO"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0A145FEE;
	Thu, 11 Apr 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835454; cv=none; b=LujU0no0l1zSKoRZgpvoQM7zWWaG8Wbpqq2DI5PuxSPWD3qDON1nDeMFH7ai6bLx0jCVrigrUbv3PsdxxDFzao4852HFBMtW54aSBhz2iRehWGwk1DhUY65Xi9xlKCFdnx2oOHAj/4ZCnMtMAhm2EAEgR1gtnmq+AyqDMpBAn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835454; c=relaxed/simple;
	bh=WT7wkvVIHbP0Pzdy7tiBfkTaqzDPZgt5cF1NSgYRwLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRzvuahQmjvuJ3oWeSCOt+wl7rRGRZels6stnU5kbS8DgVkRTVAb4Oe00PoJDnul6FN09tQtXvu9O+ActQKwWIVUFSyKZviuuApSgr7yCvD3AOZ9a4is7EogB2XVJ+E+XMiz6eeMHadmJSPY+bUFgUa1a4UIIEHCjN1OwH3e1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gplRZsKO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=nKO/TyiA2ADxN3lG58pUofPkZZ9JfAH4uwFCinpnz4E=;
	t=1712835452; x=1713267452; b=gplRZsKOa9ADIfj2agsiCwBccF+MS/t/ACzVBloj905lp4D
	JGKyMq2ScnP49Zr8Rohfw2c2sEO74HdQj1QSK3eHY/fjAd9icm+0NeIpbqQY7htXRu01M3cWoSvbQ
	67m5p5SvheabscqVd++Kwi5T8QbuYfA9GkTlKUvxF6ClTbgGtjXdpFCQdY4TTjAasFADxVjvEsOqL
	FrQOYQVM1ufAK4xY3vWBdkq8aslfrB9FJ8M50VhQzQwzMuXC6DuvMyd11WkXdKm3qpUfTpXEPa5Wq
	wsiMfqQcnyHPUYsGoqDeAvDnxRF2MWXG6ROQWJz5gc9iBGKFauSIQNnSG/hzvvQw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ruskE-0000dt-6e; Thu, 11 Apr 2024 13:37:30 +0200
Message-ID: <6d4d3956-baf3-441c-86b6-493eb3ff72bd@leemhuis.info>
Date: Thu, 11 Apr 2024 13:37:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 0/2] x86/cpu/amd: Fixup the topology rework fallout
To: Laura Nao <laura.nao@collabora.com>, tglx@linutronix.de
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, x86@kernel.org,
 "kernelci.org bot" <bot@kernelci.org>
References: <20240410194002.909839385@linutronix.de>
 <20240411112743.232798-1-laura.nao@collabora.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240411112743.232798-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712835452;dd3a3ba4;
X-HE-SMSGID: 1ruskE-0000dt-6e

On 11.04.24 13:27, Laura Nao wrote:
> 
> On 4/10/24 21:45, Thomas Gleixner wrote:
>> Testing at Collabora unearthed two issues in the new AMD topology parser
>> code:
>>
>>    1) The CPUID 0x80000008 parser initializes the wrong topology domain
>>       level.
>>
>>    2) The NODEID_MSR parser uses bitfields in a union wrongly which results
>>       in reading out the wrong value and finally in a division by zero.
>>
>> Many thanks to Laura for helping to debug this issue.
>>
>>         tglx
>>
>>
> 
> Thanks a lot for investigating and solving the issue!> [...]
> 
> The regression was originally reported by KernelCI, so:
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Tested-by: Laura Nao <laura.nao@collabora.com>
> 
> I'll make sure to update the Regzbot tag when the series is merged.

No need to wait, we can do that now:

#regzbot fix: x86/cpu/amd: Make the NODEID_MSR union actually work

But ideally Thomas would add Link: or Closes: tag to the patch
description (e.g.

 Closes:
https://lore.kernel.org/all/20240322175210.124416-1-laura.nao@collabora.com/

) just like Linus asked him to do a while ago already[1], as then this
would not be necessary at all. ;) (SCNR)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1]
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/

