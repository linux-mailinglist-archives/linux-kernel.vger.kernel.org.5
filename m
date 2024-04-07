Return-Path: <linux-kernel+bounces-134228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60E89AF40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5DD1C219F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89713F9E4;
	Sun,  7 Apr 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="UkI+SYnz"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFF3D7A;
	Sun,  7 Apr 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476032; cv=none; b=i/4BgoRU0hP0SxLOfpm54EyFVxKUx2ec2aPBKRfH0m/qmBvk9WtYdIZLmg0cdLnTE6C9o4WEZvVMDDwoKTKvcOTd1ZeODHqLTMqwTre0R+Q8SzTSpZF2szDJ+tADW6tzv1uhWkog9cZdMRoUOjKqcDafK7vmtLIXjS3AN4FM/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476032; c=relaxed/simple;
	bh=gdPvuzeifbyQ8bPxAT87bBGt6duuonIoaLkOeQ9rfyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TumWaI5Ytjehl2LFzAZ/2nXqwg2pvmJaQhZqMsIl70xhHr+ZbVpOTWGWbVYyxXXNzibm5aMvF9Vwp+MlgpsVYdRn4Y0pDjYKO0vO6TmZRzh8AYhHszXm9LlKE/j0Y5ek4qqmrWtnO000A2M9b+g2JlmQE1lSytTyEol/fVKvPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=UkI+SYnz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=dRTkXOBwhAoBZc/CH5o2f1CZA6qy+HsK0VlNaQTEZXU=;
	t=1712476030; x=1712908030; b=UkI+SYnznHsCenGAJE5BASBFwS80PuzQ3oUNk/FwMoA99Hj
	UrVm5pXZ8vTXjE/iAjfsWvCiD/I5fUc09G6kBmbOUuCsyhTPA8gK58+S6s7TPd0ShNAGRzECKAtD6
	5bTzCM/bjkEsWfb/2HSKbTBm+BfQOdeFmVKvIPj3p/lgN6M1rciZUPfk7Znm9Mye/a8uqKEyOxWpY
	SEKyWIekyGchDxZa2BW3R+o3AD/MHcjS1nfzkCh76aiU+EihtqivFa0sH/XZNBAS4J5JY6KmwTSp7
	cokS2AysVnIddmbyUraapTT38zun4FMr4KxmGtzl994XcZOYJDgwyakkPVeqDM7w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rtNEz-0005nH-I2; Sun, 07 Apr 2024 09:47:01 +0200
Message-ID: <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
Date: Sun, 7 Apr 2024 09:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Emil Velikov <emil.velikov@collabora.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Daniel <dmanlfc@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Sound System <linux-sound@vger.kernel.org>
References: <ZhFJZoful6nEFskW@archie.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZhFJZoful6nEFskW@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712476030;7e7d8f34;
X-HE-SMSGID: 1rtNEz-0005nH-I2

On 06.04.24 15:08, Bagas Sanjaya wrote:
> 
> On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
> on Steam Deck OLED [1]. He wrote:

Bagas, why didn't you forward this to me in private first, as we agreed
on as general procedure for cases like this?

Anyway:

>> I'm adding this here, I hope it's the correct place.
>>
>> Currently the Steam Deck OLED fails with Kernel 6.8.2 when trying to initialise the topology for the device.
>> I'm using the `sof-vangogh-nau8821-max.tplg` file from the Steam Deck OLED and associated firmware.
> 
> See Bugzilla for the full thread.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218677

A quick search made me find these posts/threads that foreshadow the problem:

https://lore.kernel.org/lkml/20231219030728.2431640-1-cristian.ciocaltea@collabora.com/
https://lore.kernel.org/all/a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com/

From a quick look at the second discussion it seems a bit like we are
screwed, as iiutc topology files are out in the wild for one or the
other approach. So we might have to bite a bullet there and accept the
regression -- but I might easily be totally mistaken here. Would be good
in one of the experts (Venkata Prasad Potturu maybe?) could quickly
explain what's up here.

Ciao, Thorsten

