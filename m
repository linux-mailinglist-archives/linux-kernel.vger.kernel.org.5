Return-Path: <linux-kernel+bounces-49045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167D84653E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B346F1C23F10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A86DF5D;
	Fri,  2 Feb 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NgO5f9Oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+Tf598b"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4008D308;
	Fri,  2 Feb 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835878; cv=none; b=OFdj/xmGS2yLYsSmx6kFVZVZ66o64j1H6bbW2og8bQySGNSwJgFjyojMNgakTRzGqVCmGkRotaQjRezk8nhRhSyRPUbDP/1F9LILkqh6kRxHg1iplPMfnAJRb6x2tt6yC0dcJh+cZ/AqJs92i8hFAS0LtB4oGT0VLnNrEE8P78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835878; c=relaxed/simple;
	bh=VsGcaBj2+DVUKNNWLzh2v7rvDdhx1Vhnha3Ztw0+ZGs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mBaroJ2MWLCnmb4QtWxqXYRe5pOENtIw6ORpP7sM/rdANK3e4xDJdfNBohPboeBv4zZik+zge9kjX3V3WGNPj6xkKsi+SRVY1hdwnWljGo7zrcO+S/SW3ddrhPGPUKI1e7vvKqAWjf62IVwVuPEhixD15wKl3XQ4LPcJ37HMgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NgO5f9Oe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q+Tf598b; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 91ED45C015E;
	Thu,  1 Feb 2024 20:04:34 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 20:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706835874; x=
	1706922274; bh=GIGLcKpOqgSFtDtF20FwBeWhNJabIQLZaNxjZseleos=; b=N
	gO5f9Oe/8mxQCf8Zaban9cEk62KEDE7Aske1nUe/zUJDN/kg5YY/akgCaQwb4O0j
	m9eWvSBpJEh9zedXV9+sI2OLs2BFFYyXX0tVS29dJk0MbEM45Aybhl30oZ3MwlaC
	2Kb0bcn81LxR6SgsiFMHeRbJQm2IsK08WrU1mbxyVKL566Ibswbnlde5qMqw8Vjo
	IjQJoRTYFtmWcIV88fy5yor0660awbAwC77BDfcx8xrizgK0IiFsJzvZiQo5MxuX
	1WV+uVopvCazyzzIynRV5jsP21QHxIzCp84Otx/YTnSk/ZbTVJoigVzHToATQrMd
	nmCNGs9mR8lC7GEQjppuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706835874; x=1706922274; bh=GIGLcKpOqgSFtDtF20FwBeWhNJab
	IQLZaNxjZseleos=; b=q+Tf598bVqDN5xHd7UVg+Z1/t+B0VNNJVf+9Yo3uA3Es
	vqox50GNDEwYsGowvQTwvgaR/67lOBEDUuYXlIEcH4UHeKie/scQo2HuN5y4HLh2
	4zXRa1xv6jMmlB9bttvcvx7QruaTfIbJGdewdREUWzuy8XOEdGEaK1Nxk/RoS8zy
	5LAMEnuaAzrUbyLEfYYewCYNxEwTu5M/xVlb4p9lo3GZdufv0iq+rf9CY9V4bKXo
	p5DbadGWrwJ4rYoBMbH2t8KmgQC8/hFrQO4DUap2dCH3IViBMvKOYSrz+DtMkE7n
	5RvZI0zv0ozEaQcvDe57jTSifHNXGRDkoDHPYx65EA==
X-ME-Sender: <xms:oj-8Zbm73Bl162_5SNlPYUNFveGZch85U5sKvabU8v-vL5T-w4ENIg>
    <xme:oj-8Ze0_Jhh9dGdfbhQ_b2-l9Kv6l4PPdgHsQAx_hHbWilWkvFSYyelUKuR48WL-Q
    WwW53Y48avL23scQqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvfgr
    khgrshhhihcuufgrkhgrmhhothhofdcuoehoqdhtrghkrghshhhisehsrghkrghmohgttg
    hhihdrjhhpqeenucggtffrrghtthgvrhhnpeelfedvveevveetjeeikedtgefghfeigfek
    leefkeekieehiedviefghfeltdehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:oj-8ZRp-lBFUwq61DvI8xrIPOiJjE7Ek5mZ76tYzsqLCUglYt4dsDg>
    <xmx:oj-8ZTl5YPY8SbzEu4O-eyxb3JtoWDdgWNz6KSrD4MXeS_9K1mcsbg>
    <xmx:oj-8ZZ2XzP4Wb0SdKrBQyxH1gHee9rtSoSTc314TTsGX8bCmDkQgXQ>
    <xmx:oj-8Za8STrUwsPTQwtL19_3v2RU978ns-6Ykk0PD3kj7MOyObstZSQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 363CB36A0076; Thu,  1 Feb 2024 20:04:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96ef2869-ad72-478f-aa09-691752ce5b81@app.fastmail.com>
In-Reply-To: <20240202111602.6f6e2c1a@canb.auug.org.au>
References: <20240202111602.6f6e2c1a@canb.auug.org.au>
Date: Fri, 02 Feb 2024 10:04:12 +0900
From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: "Li Zhijian" <lizhijian@fujitsu.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ieee1394 tree
Content-Type: text/plain

Hi Stephen,

I'm sorry for the build failure. Indeed, It is my fault to merge
some fixes for v3.8-rc3 ahead. (I just checked merge conflict
between the issued commits...)

However, I'm out until next Tuesday. Let you cancel merging
ieee1394 tree in the next few days. I'm sorry to trouble you...

On Fri, Feb 2, 2024, at 09:16, Stephen Rothwell wrote:
> Hi all,
>
> After merging the ieee1394 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/firewire/core-device.c: In function 'show_text_leaf':
> drivers/firewire/core-device.c:369:48: error: 'bufsize' undeclared 
> (first use in this function); did you mean 'ksize'?
>   369 |                                                bufsize);
>       |                                                ^~~~~~~
>       |                                                ksize
>
> Caused by commit
>
>   67a5a58c0443 ("firewire: Kill unnecessary buf check in device_attribute.show")
>
> interacting with commit
>
>   47dc55181dcb ("firewire: core: search descriptor leaf just after 
> vendor directory entry in root directory")
>
> from Linus' tree (v6.8-rc2 - that the ieee1394 tree has just been rebased on
> top of).  I have dropped the ieee1394 tree for today.
>
> -- 
> Cheers,
> Stephen Rothwell

