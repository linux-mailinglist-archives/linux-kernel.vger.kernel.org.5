Return-Path: <linux-kernel+bounces-112428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797858879AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347E7281BDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AB535A8;
	Sat, 23 Mar 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="C0ADh3f0"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA718E20;
	Sat, 23 Mar 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214266; cv=none; b=KwFsjYPYf3tUDu2V8k9NROnL2mwee25tAJ5qpfOIAjn6easJxYd82UoiCeUIFZpk0qsIQ6fiVdHfK9ZmzL6kxmX0XtltIX5DOB6V6EYliaI3vVqbxPFvohRa9aJCm4yrsDVF0A7h6AKNSDENX1cHPF9QQYy6zTwL20iy2wp0e5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214266; c=relaxed/simple;
	bh=mGAh5fu0/Fw6zUZIRDr+OZ5+xOoq6Q7dS6tDtFcWVQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7aNmwkmZ3D35SuysI+EJjdlL05WiA56ftp52KoM6ldOi5PqTo1oDhFeGCLHSsQFFb4MNVIfICAeL2+E5DGb+9PMxAhceV5oK1L2JTAnWSQG4WOoRyCi60Ug276UBSoekOoHHzLh+nZE/JYIdPslHbgPHtTdrKA/wf+xlgjD6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=C0ADh3f0; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=bJ/40L52EMuGnORgpe1TjrWvCrigiJKMPJYJJOTHF8g=;
	t=1711214264; x=1711646264; b=C0ADh3f0sYm+vEreHCkWmp35KiziMRuws5WQN6fQwOHgxw/
	b17bHfk3M9R/VwhYmkthlv6pu6lKsQe333ALNuUCDPK5tSs8WiPvWoPVUWExfK9llrzK7bs0KjLco
	ETJPvGGKFoDqotlvoumWTp67srZIYKSK8IoHfCON/OvX4bW1qIIBzDxtMAnW3pHU2jYd4UZ1zmpS9
	pLSvkK9EJRvNFhwmpZq1zWaX2StqfWqjnrINuN4kKIWyJAt4DSaYBPq/mTutdCJP5NOpcHbucnuRl
	k5GqkeZ9hUn7z1Le3vTi6axwQFYoVru3UJRoI19lfm172Cqjd53zP8t0OxMeM6nw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ro4zz-0008P9-Ok; Sat, 23 Mar 2024 18:17:39 +0100
Message-ID: <092a7c4c-0a75-4b27-acec-385fdcfb9f7a@leemhuis.info>
Date: Sat, 23 Mar 2024 18:17:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Content-Language: en-US, de-DE
To: Pratham Patel <prathampatel@thefossguy.com>,
 "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
 "saravanak@google.com" <saravanak@google.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711214264;fa5dfef6;
X-HE-SMSGID: 1ro4zz-0008P9-Ok

On 23.03.24 18:02, Pratham Patel wrote:
> Since the introduction of the `of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing` patch,

There is an earlier bug report asking for a revert of that patch:

https://lore.kernel.org/all/ZfvN5jDrftG-YRG4@titan/

> an issue 

Is your problem maybe similar to the one above?

Ciao, Thorsten

> with the device-tree of the Rock 5 Model B has been detected. All the stable kernels (6.7.y and 6.8.y) work on the Orange Pi 5, which has the Rockchip RK3588S SoC (same as the RK3588, but less I/O basically). So, being an owner of only two SBCs which use the RK3588* SoC, it appears that the Rock 5 Model B's DT is incorrect.
> 
> I looked at the patch and tried several things, neither resulted in anything that would point me to the core issue. Then I tried this:
> 
> ```
> $ grep -C 3 remote-endpoint arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> 
>                 port {
>                         es8316_p0_0: endpoint {
>                                 remote-endpoint = <&i2s0_8ch_p0_0>;
>                         };
>                 };
>         };
> --
>                 i2s0_8ch_p0_0: endpoint {
>                         dai-format = "i2s";
>                         mclk-fs = <256>;
>                         remote-endpoint = <&es8316_p0_0>;
>                 };
>         };
> };
> ```
> 
> So, from a cursory look, the issue seems to be related to either the DT node for the audio codec or related to the es8316's binding itself. Though I doubt that the later is the issue because if that were the issue, _someone_ with a Pine64 Pinebook Pro would've raised alarms. So far, this seems to be related to the `rk3588-rock-5b.dts` and possibly with the `rk3588s-rock-5a.dts` too.
> 
> I would **love** to help but I'm afraid I device-trees are not something that I am at-all familiar with. That said, I am open to methods of debugging this issue to provide a fix myself.
> 
> I would have replied to the patch's link but unfortunately, I haven't yet setup neomutt and my email provider's web UI doesn't have a [straightforward] way to reply using the 'In-Reply-To' header, hence a new thread. Apologies for the inconvenience caused.
> 
>   -- Pratham Patel

