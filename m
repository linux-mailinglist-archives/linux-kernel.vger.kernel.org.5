Return-Path: <linux-kernel+bounces-83164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7177868FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241F41C21B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDB13A88F;
	Tue, 27 Feb 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DK1hxBmg"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849C13A866;
	Tue, 27 Feb 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035721; cv=none; b=jydQYmAwGndLlv1K304iDINgAlvDmTFU+5ieMm/h2joUtY5J8c/Cx+eQToXMFZEnH61P7JWc29pzFiExN6qAZr5n0bQwJ0mykC7OEv2/XHz3Bh4pwHduAA1Et7+CsbY65iAoXtsC7zlQ+k0mAJyn435y9CE9R99moCm84HWMrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035721; c=relaxed/simple;
	bh=/eKmoNSePZ5CJhcNccLURR3henqSYG/8XWt380u7RTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YasxrPPbY4BtZthsaqMyvlFdoHq9JLQA33vSyrewPQDwtSIAObyRffONzlyfi1+m+CiaXEpJINjo7HEYshq27T0Dl2W+kaEeY8GQIgLu2plvEflLDT5hnXfQ2o4oT7vy9zuK4YMFBRAbeYXtA1JCh3v7XU1FoAglKM8mWHB8kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DK1hxBmg; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hg3gurSqb69fI8sw7A+fZUJxpI6FFw4keYJjAHYqPP8=;
	t=1709035719; x=1709467719; b=DK1hxBmg0Arres16FEO6HpE4UNlMUuEamzGGuZvTDg8s6xE
	1yA2ri/tU7rzaBMPsLP4Awg75OU63bW52Ho76Dxw08inFNFokinlN9rVdH9clEtDE+VyvYW0PB2kE
	rEAX6G7IJluMcH30AKYAQsKQyV9V5ndjvH5NMlV2HmljHlNRddYAVT5BuZ7+l221vfIF5c3p88eg0
	4e5BE452BvzRue1okUZD70XvuTdyqezmTD+Jiyh7otGo8CX5YfdAlgf7GDwYQVmExaeHXIKU5E0eV
	6HDT8aUItED/lfpns6OdSExB4u8ruz6FOsT+iRRupJ2qyl/3S+rrj/tTSUJ/NTqQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rewGD-00051Z-Iy; Tue, 27 Feb 2024 13:08:37 +0100
Message-ID: <59c10cfd-2f31-42cd-aec0-217127aee228@leemhuis.info>
Date: Tue, 27 Feb 2024 13:08:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2024-02-25]
Content-Language: en-US, de-DE
To: Johan Hovold <johan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709035719;4b52b170;
X-HE-SMSGID: 1rewGD-00051Z-Iy

On 27.02.24 11:20, Johan Hovold wrote:
> On Sun, Feb 25, 2024 at 01:21:46PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> 
>> Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
>> X13s, but he send out patch series to fix some or all of those[1], so
>> with a bit of luck those issues will soon be fixed as well.
>> https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
> 
>> [1]
>> https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
> 
> This series addresses a use-after-free in the PMIC glink driver caused
> [...]

Thx for the updates. Due to the various issues I got a bit lost here,
but seems you are at least somewhat on top of this and fixes are in sight.

> (I just tried updating the regzbot title).

Great (and yes, that worked).
 > But also with these fixes, there are still a couple of regressions
> related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
> separate reports to track those.

Thx again.

Ciao, Thorsten

