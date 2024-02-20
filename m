Return-Path: <linux-kernel+bounces-72454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4285B3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182B71C228CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A65A119;
	Tue, 20 Feb 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qikNwBZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzysZa41"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEC5A0EC;
	Tue, 20 Feb 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413032; cv=none; b=nGDzJTnQ0hRc/yOhNOvgkvM7GQo4QKHqwyRlkSnajEjUSHe/103p5lhG+UqV4ixlBhVkhkGaqH748Sry26E8p6VrckJLfzWh3tnUFIQX1iL+oyAO9rgh46N7A/IKQhr+Rn5gCBzOj0jJhsNjBqpylnXkmgo87+qVAWmSOZkLZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413032; c=relaxed/simple;
	bh=Qqak2MRc/Z9vHuXY79TXbXvAUjQz4eVKCYjYm0cKJIY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KRhQQ6xEy1eQEVrGfZDCyIqFBqgGCOEJ1AU3zL1mSJCD/GzvgM5t6hwdOvBuxvG/TGlpc0N/HNrIjHhBpGPZXRRqZnV/4J0Dchq/CNdU+wdyvWdikjErN1z4P5SXdkc1Pxnv33bFfErPirTG0cQJaL4bqBfZm9GArlWFUBRdtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qikNwBZc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzysZa41; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2B55A3200A09;
	Tue, 20 Feb 2024 02:10:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 02:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708413027; x=1708499427; bh=JQPzjw3O9b
	8Yrd4Had1HuwUNdgwDwywheYTR/XJOfbo=; b=qikNwBZc0mELFyj+V7edWgNx1N
	LaNtxXw5PUtKRos/7uouf78WngCiiIEnPlGQveJr48e1uvUpQpRkYXKuWibXOcd1
	Jhb/ePUkeR8pPa6kZXZfPTC1bXHVIw1l0qVMCatZACoQZn4p7xki77N0m1B1MwTB
	o5TGKbPtpvA16LUbHgCAJNasX67wYXFtXDYU+/ifStOSwtVf8RRQIZgrW5znn2FK
	sF6nyM/fdYiZ4s1TvO2xtzOEUvzxRNx21N+wvR7mseCVg+EyX2R9liLLFjjGxiu0
	VDZWHvy7SAX/8UNxH6JYTeWvkFrWNXZiwbakv+qJVUMUdi+yBgX6fwl3soyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708413027; x=1708499427; bh=JQPzjw3O9b8Yrd4Had1HuwUNdgwD
	wywheYTR/XJOfbo=; b=VzysZa41QPPsLwhVZAhCaUJK+20QNB9kz2vhMc2XFkZi
	W2l2qqCujFkokGndm/3R54bSUjl11kWHPa8APb+NYRbBjYPnXLNPdnA2qJHcRIpJ
	KX0EBPKxEeYQ2OtaWIS6BYctaWL1zD7ySvAXvRj6/47dihfBuFKS3VMja6ibzSP/
	CBzKlP8L56m1rFLErsy+2FiDTFQ4saV9OVRdMdqZ9QbwJk1G67Fzbvnw589N3fpN
	vCX9ADxwkwlOTahDrKkjMgeM1GtACMlCMFfpYChzFQT0/nbBj3Hfe1nLajjnLdoQ
	3KYpz1QQc1bEzC2b4obH0KqU8Ei43kuoXjAdBnnjcw==
X-ME-Sender: <xms:YlDUZQ08HroSDwpCublOI7Clu0UeswoXIFMJB1Y_L17emWVkNcC0Aw>
    <xme:YlDUZbFbxVIU95CtahlrvvfTBTdyNDomZajJ0hr7YxGzAwK8Xt5jPhqEYZvPrq4vh
    9uShvyTN_ZJRj3PXb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YlDUZY5o9YoMXO7AlcblnFr7RZM4TtImcRoFIPxJjU_LwZPe1Tv4zg>
    <xmx:YlDUZZ2EOHL5dIJRdk6Req_YgBMHKoTfy57RT3F4lZmdTc4wBGJ9aA>
    <xmx:YlDUZTFJNQybfsXLq8mmrHdgq14eJ8UUzocQSAhMKTbqKffdcFqkQg>
    <xmx:Y1DUZdG4XvDRaso7EbQmeCAVAuuqmZ_pc31eGIU42N-6KiFmmpMMqg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9EB1FB6008D; Tue, 20 Feb 2024 02:10:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65f13ad3-989a-4699-9695-d7b1a95297eb@app.fastmail.com>
In-Reply-To: <343f7b1d-1b4e-402e-bd54-4473b91b6f79@amd.com>
References: <20240219093900.644574-1-arnd@kernel.org>
 <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
 <412c0a42-4c19-48dd-aa4e-de39b6ec3099@app.fastmail.com>
 <343f7b1d-1b4e-402e-bd54-4473b91b6f79@amd.com>
Date: Tue, 20 Feb 2024 08:10:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vijendar Mukunda" <vijendar.mukunda@amd.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
 "Bard Liao" <yung-chuan.liao@linux.intel.com>,
 "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
 "Daniel Baluta" <daniel.baluta@nxp.com>, "Mark Brown" <broonie@kernel.org>
Cc: "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
 "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Content-Type: text/plain

On Tue, Feb 20, 2024, at 07:23, Mukunda,Vijendar wrote:
> On 20/02/24 11:43, Arnd Bergmann wrote:
>> On Tue, Feb 20, 2024, at 06:57, Mukunda,Vijendar wrote:
>>> On 19/02/24 15:08, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>> In normal configs, they should all either be built-in or all loadable
>>>> modules anyway, so this simplification does not limit any real usecases.
>>> Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
>>> AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.
>> Yes, that is what I described. But as SOUNWIRE_AMD is a user visible
>> symbol, there is no problem in expecting users to enable it when they
>> have this hardware, and distros just enable all the drivers anyway.
>
> Want to set SOUNDWIRE_AMD flag by default, similar to Intel & Qcom
> platforms instead of explicitly enabling the Kconfig option.

Maybe use 'default SND_SOC_SOF_AMD_TOPLEVEL' then?

I don't think copying the mistake from the intel driver
is helpful, though I agree it would be nice to be consistent
between them.

As a general rule, you should not have a Kconfig symbol that
is both user visible and also selected by the drivers that
depend on it.

To avoid the dependency problems from coming back and keep
the complexity to a minimum, I think there are two logical
ways to handle soundwire:

a) keep the current drivers/soundwire/Kconfig contents and
   change all the 'select SOUNDWIRE_foo' to 'depends on'.

b) keep all the 'select SOUNDWIRE_foo' but drop the prompts,
   requiring that all drivers that use soundwire have the
   correct select statements, with the main CONFIG_SOUNDWIRE
   getting selected by the individual drivers.

    Arnd

