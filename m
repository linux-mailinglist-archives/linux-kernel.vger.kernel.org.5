Return-Path: <linux-kernel+bounces-66318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0828855A41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30F91C24718
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0AABA29;
	Thu, 15 Feb 2024 05:59:51 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C394A12;
	Thu, 15 Feb 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976791; cv=none; b=XlBXA2PbuBmzDtsDNHh/9UUH9EO2/a3t3mrXQXIbQ80M2mQC8tdqfYLCLYUCcfLZF3vkLjNYEAw4VFYCpqSkN59k0lcpbQKsoMnkIO3B9HA5NHXaUPpn87+yVn/lgDbgM4d8is4r8d2es/6gZ26N7vC9VVZLtZ2xLsBu5YLCDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976791; c=relaxed/simple;
	bh=8g7W4dZOG39FnSpecZxtEgLFJI5RUtz/Zzqt/HjtKYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtaRxEBsnNxigZTeBvqQiUcopdsXOAQrRFBm6efneNVeGGCKzVXaMqHXwrBgPNbbIcEZuA8waqjaErzu61IvwoWqJYwRAcXbq499YQelmmic+YAlspvYzb4WFMVFIeBOqQvMB4VTk+5Rl39cp3jw2coEpEbQAea97C4JWFoRqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1raUmg-0001pd-LG; Thu, 15 Feb 2024 06:59:46 +0100
Message-ID: <e65c6dc4-9b43-4c97-bb4c-d9c14655835d@leemhuis.info>
Date: Thu, 15 Feb 2024 06:59:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1061449: linux-image-6.7-amd64: a boot message from amdgpu
Content-Language: en-US, de-DE
To: regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <170612149675.7169.757906919183146487.reportbug@kos-moceratops.home>
 <ZbUB0YWxEET3Y0xA@eldamar.lan>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZbUB0YWxEET3Y0xA@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707976789;a1ba730d;
X-HE-SMSGID: 1raUmg-0001pd-LG

On 27.01.24 14:14, Salvatore Bonaccorso wrote:
> 
> In Debian (https://bugs.debian.org/1061449) we got the following
> quotred report:
> 
> On Wed, Jan 24, 2024 at 07:38:16PM +0100, Patrice Duroux wrote:
>> Package: src:linux
>> Version: 6.7.1-1~exp1
>> Severity: normal
>>
>> Giving a try to 6.7, here is a message extracted from dmesg:
>>
>> [    4.177226] ------------[ cut here ]------------
>> [    4.177227] WARNING: CPU: 6 PID: 248 at
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:387
>> construct_phy+0xb26/0xd60 [amdgpu]
> 
> Analysis showed that this appears to be a regression from b17ef04bf3a4
> ("drm/amd/display: Pass pwrseq inst for backlight and ABM"). Does that
> ring some bells?
> 
> See: https://bugs.debian.org/1061449#27
> 
> #regzbot introduced: b17ef04bf3a4
> #regzbot link: https://bugs.debian.org/1061449
> #regzbot title: Regression by b17ef04bf3a4 ("drm/amd/display: Pass pwrseq inst for backlight and ABM")

#regzbot monitor:
https://lore.kernel.org/amd-gfx/20240214184006.1356137-8-Rodrigo.Siqueira@amd.com/
#regzbot fix: drm/amd/display: Only allow dig mapping to pwrseq in new asic
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

