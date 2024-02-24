Return-Path: <linux-kernel+bounces-79506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646586235E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AC51F240AE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF14417543;
	Sat, 24 Feb 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pf2Sl/sI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QIdGf64Y"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E479E4;
	Sat, 24 Feb 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708761075; cv=none; b=Lm3LztM83Rg3lxh8TneaRlr9bKu7+NJIVwGd8IiIpjiHWYsIsrejn8jzQM3wdBZ27vpNw5uPUi8Hios4s+KGPcmd/Lvd4q10QI/CjdkEtrRL78y5QnBe9GHZ0FnZXeSp9RBaKtCOosviTnucjgLCayu3wqEsY2z8sSDzisUMMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708761075; c=relaxed/simple;
	bh=NZu7884jbQxKplISr4kCwPVejLQR3NxfjCa2+s5T2ao=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BdSIF0H3KBiFyLwhMLLdqBb5SG5GYJ4jikPgL8HzbGAV9RcVug71dN4sWqxpUs+clQ4bycmpp4JKQDrJEUc0F1E4QermHH3Okgkvie4udEBXj4zVZltEqR7TPWF7WEO9eL+lyFfFqMV0w/8zVIDVBNipWf+kuc+AtB2Reuz9F4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pf2Sl/sI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QIdGf64Y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57BF213800DE;
	Sat, 24 Feb 2024 02:51:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 24 Feb 2024 02:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708761072; x=1708847472; bh=fehBFjztNU
	sChvE2N/ZKvwmwJZ1JLOdBn2mZWlKng5M=; b=pf2Sl/sIdgyNEtDcoo7s95d9t3
	m4SbadgaJdotfy2GXDIvxYX3ERANddTW1m7TR4xNGMAMynvZcrRnyFarpsz47gEx
	HHy01NP8tDjLP8x3aVhMxA1cQKOxr7ROzvqQrkN4+I9c5Bz1ciWJ8sVrzH24icHQ
	JH8lTdlnn3xWtChnlh88qmhJrOxzYBa6tGxv/NNuPsMfSiw04eYa6kOGmuat9d7C
	yKR1Dbxfh4m3HpB+3K9k6z5sKJBBhrSrDBtsbTTTDy8p2k0e7XqMmvXAiCEZgQn4
	7ldpfTAvJcEfvbgQnSqUeRIAHDNxNPAcyB00/owIQy/yBlI2UCC5s8hGW44g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708761072; x=1708847472; bh=fehBFjztNUsChvE2N/ZKvwmwJZ1J
	LOdBn2mZWlKng5M=; b=QIdGf64YY9dA3KtYtQLOrenYvtC4NZKb0B1JnSnnnX+m
	3Xs/RhQAzyKtSGSHpUFSrSvdv/AjMNIwc6JbukNoFbbUN26uivtj9J1DyzLIzrZ8
	iajt3weYOuFXFWwBkLS/NumBJBBwvaJPGub6tbCyD1XJryIn5qdo7iJUfGcu7NTn
	ZD83UXdj7sXepZL/v40pvI5IxotDdR7CTYcDk3Rj9I5XXs/ydu8D0Onc2D5oXiHb
	xOeARbKhRAuQu1hm7gzN1absYZStB8SpM4GQ8UJSkV0sQvVBVPZ4RErgGZu6QQNk
	WusRpeaa36GpAlbesiAuqXz3cXRLIi5ye7HQbCuvkw==
X-ME-Sender: <xms:75_ZZbn6m3uq7icLq8Kub9shZYXw4F0y9WDCEHcmu610YdGpfWu9mA>
    <xme:75_ZZe0SLp1A3g3heVl7pOco74n3P4qAjjfTSMImEh_wkEHaN2W2szfnXFBCB4flj
    eneX9cnxg7INTlH0y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeejgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:75_ZZRpVe0HBboGshmpTmRSo-B3BS5y7d6KK9ZTcxr32wGJuqmpIzg>
    <xmx:75_ZZTkE1PRv0z3WGozAD806ZJgtDIs0HO744T-4tQJslceQTuQSYQ>
    <xmx:75_ZZZ3G4EiPyriI2LfNjEJH2PFFnS0BiuHRQ70sRLk5uScVMxzIXg>
    <xmx:8J_ZZSs6KrIrv2W7FzUcjn_LgN2qqJjl0x6Vuc515K0toMDYU-2dQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D3CD4B6008D; Sat, 24 Feb 2024 02:51:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e1a3753-4707-44e7-b746-48437cac8e70@app.fastmail.com>
In-Reply-To: <95e8cc82-2e7e-bca9-16ab-3148c3183f32@intel.com>
References: <20240222100324.453272-1-arnd@kernel.org>
 <95e8cc82-2e7e-bca9-16ab-3148c3183f32@intel.com>
Date: Sat, 24 Feb 2024 08:50:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Jesse Brandeburg" <jesse.brandeburg@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igc: fix LEDS_CLASS dependency
Content-Type: text/plain

On Sat, Feb 24, 2024, at 00:15, Tony Nguyen wrote:
> On 2/22/2024 2:02 AM, Arnd Bergmann wrote:
>> 
>> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
>> index af7fa6856707..6e7901e12699 100644
>> --- a/drivers/net/ethernet/intel/Kconfig
>> +++ b/drivers/net/ethernet/intel/Kconfig
>> @@ -372,6 +372,7 @@ config IGC
>>   config IGC_LEDS
>>   	def_bool LEDS_TRIGGER_NETDEV
>>   	depends on IGC && LEDS_CLASS
>> +	depends on LEDS_CLASS=y || IGC=m
>
> I don't know kbuild that well, but would this cover LEDS_CLASS=n with IGC=m?

The 'depends on LEDS_CLASS' take care of that.

> There are Similar checks in the file [1][2] that would transpose to
>   depends on IGC && LEDS_CLASS && !(IGC=y && LEDS_CLASS=m)
>
> which should cover that and keep the checks in the file consistent. IMO 
> a little more readable as well.

Right, that works as well. I find the negative dependencies
slightly more confusing, they should do the same thing here.
Please apply whichever version makes most sense to you then.

     Arnd

