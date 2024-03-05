Return-Path: <linux-kernel+bounces-92010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A148719AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366891C227B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937252F85;
	Tue,  5 Mar 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="3Q5pX8xn"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4850272;
	Tue,  5 Mar 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631224; cv=none; b=gZ+Q8rXaKQT5wCsw7w0tntc0EARvbP1kKBDwQlmXq/R/jcrj/D1/7U9apMM16VNOHOkmNcauI/xBtsAbYk0q/QyL1tDbb1y2F7VULle04dYCQ9BGObdF94R+J54OuPEi2qsosgegcQOn63B9lAvnZBQJqssf8mti9DXyz+nmkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631224; c=relaxed/simple;
	bh=tyXjWQ6oTfBc0STjbgaI+jZeYhzMh6HZOelWe8HPHi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brjQh8WLN/9gU0Q/E34DprCxz0vRKsgtxYGiHWcXfXSHD7KSamxDTePTxtQmaDV/XnTzq6KEeTw9L1CeHsmk/CdYQBT4UMH27bf56xvDQ/+kHZq1+X+DDOTRGKfoABClh34DaiQbm8yKx1FljLS5kKukbpHHuN7pPeyY0519q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=3Q5pX8xn; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=U2WukJ7OKv2T/LS0xNPodSXzP9djVjo0sK1RH9RhhXM=;
	t=1709631222; x=1710063222; b=3Q5pX8xnp4vhCJafC/7EhGcPbbYzvPQ+sQd6BN8UUKeewTo
	DYjylOb1Eql64Oc3Pt+rYks/aI8+0WtG6G4t5yrM1cCtUR7/hZsWp27+XFyfQ8vIoRvYn+sSbPpGB
	WZ0+nb4x7x0QnQ7vrRZ+PwjjOgKiV6oywvH2tF1pNF1wy/RH3TCtieiR+35x/u/3D7V1OmC/DR8qv
	80G+JnZueQkHgZKSflC08jWHW2pj63s0eBWlJOk8oqjltKL8jBJ6RHFAbsNbpxZaTYoa2gkxmxj2D
	XMkbkmBQr2oytZI83RtxzIshO4JmJOcqAhENsO4yUrEmEfQIwHXf0lZH/ocUwrew==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhRB5-0007zv-JF; Tue, 05 Mar 2024 10:33:39 +0100
Message-ID: <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>
Date: Tue, 5 Mar 2024 10:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Lenovo ThinkPad X13s regerssions (was Re: Linux regressions report
 for mainline [2024-02-25])
Content-Language: en-US, de-DE
To: Johan Hovold <johan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709631222;c7dc2368;
X-HE-SMSGID: 1rhRB5-0007zv-JF

[dropping Linus from CC, we can add him back later when needed]

On 27.02.24 11:20, Johan Hovold wrote:
> On Sun, Feb 25, 2024 at 01:21:46PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> 
>> Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
>> X13s, but he send out patch series to fix some or all of those[1], so
>> with a bit of luck those issues will soon be fixed as well.
>> https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/

As 6.8 final might be just five days away, could you please help me out
with a short status update wrt. unresolved regressions from your side if
you have a minute? It's easy to get lost in all those issues. :-/ :-D

>> [1]
>> https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
> 
> This series addresses a use-after-free in the PMIC glink driver caused
> by DRM bridge changes in rc1 and which can result in the internal
> display not showing up on boot.
> 
> The DRM/SoC fixes here have now been merged to drm-misc for 6.8.

What about the others from that series? Can they wait till 6.9? Or are
they on track for 6.8?

> [...]

> But also with these fixes, there are still a couple of regressions
> related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
> separate reports to track those.

Any decision yet if they are going to be reverted for now?

Am I right assuming those would fix
https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
which did not get even a single reply?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

