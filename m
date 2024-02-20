Return-Path: <linux-kernel+bounces-72537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F185B4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83F3B22B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095C5C8E2;
	Tue, 20 Feb 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="b58RCw8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qd8bReim"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48985C611;
	Tue, 20 Feb 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417341; cv=none; b=VJY2Taij94OYACo2rA0KmpuL4twQxaywhN1DJDkeJTPrUai2uwmon6Sla0v1rVti6jr2rdJHuCe4XAc+3YI/LAeuNibwpbfKPZVXe+lrWFHCX0mHWUqNA/ZIL4gyxjRXx6Hvwt1qEO40aBP9EoMKe6vcoWYoz0I27AUu37yAPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417341; c=relaxed/simple;
	bh=Fncpxzm+VzecNokxaoTX7r7GO1dZRZqBEjfdUav0bgo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZrQquonVBD84kpGb0aKLGMRkDkeXxlAhCWQS1ZDLIiV4/NV3LA6WGqgiHjHWCTSh9uoA6dogRHvvOnyKEjDgac9180c29OEZ05GVQC8DZmcoJMoxMIDZXXrKMxJx65pOpuHfAk48KPmJbSTQjdXWgdIKFUfWwv2KCt9eNnfoP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=b58RCw8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qd8bReim; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 94A4F1C00092;
	Tue, 20 Feb 2024 03:22:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 03:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708417337; x=1708503737; bh=Eq5cezQ+jg
	+AbAPb9sMQKZiH1luIyKLeUNPtI60VkVo=; b=b58RCw8XLy0vKL6JAyMECxjIrw
	/0NMS9Bn6Iz5RODSL9D19rX4E3Wza+dZ+YH/oBjxS6fM1AlNCsOq37JZp83fif4+
	7wLpBFZmwcH2lEmltZ6eDLpD4MgseanUVM1Al1PwolUHJ4wTwmoXr+kDiQHCAIB/
	6C8qxUNIylpp/M2KWLX5NpuatkLbt+3SgvzRvsLnDF/2bSCgEE7HcRUvF8vZzO+t
	lRIo7zuAViGL1hRhFUIvtMWVmm2WrCjBw3gT3HUH5nEB7/GJhyCiuFjQUM+E6Evc
	ewHBPFqOWsPaMTNJnOHwdJsuoUBuXgRKoJ6UeQDZG/daRk4xP43Er/gF2JMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708417337; x=1708503737; bh=Eq5cezQ+jg+AbAPb9sMQKZiH1luI
	yKLeUNPtI60VkVo=; b=qd8bReimkLUEQwkfnGmZ8G582qt7LoAjQHAORfC8Q8HD
	O5wxOR5N6hbojtgrijjmMUeMxzFBTttHfyY/8XRydGcN35GG+4DKqeQ53wujGanl
	Lo3vCgQyrHhz1sr8SxfWNTUm0zyy3JOe53ldR/UWUGrnhmx/0MJDnvMv6DXmpxZp
	tdEh9dd3W17UYgHD6SA/6zXGId4cMvf6jTa0gwCo9oU+sDvgCE7BSIaOK9vbvQZq
	FlrRSlhHnucupkvO+Cka9N+WArump56aWnneCyoidO95Ftsg67wDVHrg2M08A9zh
	pS9eDtGFjydi7kPGuODTvYzjR3+5ol65xsQ/LP2vZA==
X-ME-Sender: <xms:OGHUZYGnyF3rqDm2Hxxn0myoHjhjVyyJeky5qCx5GBBkjsyQAh40QQ>
    <xme:OGHUZRVUz8UovIexKpS91U3d8W2mgMNFnpidP2qPcH-WX5tbol29OI3CYVkFiyTBt
    U43_3uA9KjJ7TmrPdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OGHUZSIDji9hQcXPDl771ySZvn82yVUIVwsC9vHJvXmKUYKcL70jqg>
    <xmx:OGHUZaFNg3qpmcS-I8Iq48ITnzhhAu1PZFbvTsO9zAN4CdaFSj9SAA>
    <xmx:OGHUZeV3Vozsca6pplVgYGui2BgI-gKkt9kXb6Lv9aSEwsTELM2guA>
    <xmx:OWHUZal9hXzKc86kcvYqD55j_jazuxxmZKckFH9cMWyWMAk0G_deI1pWwpQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 48994B6008F; Tue, 20 Feb 2024 03:22:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96f6e105-0e89-429f-a8c5-2e64087d7771@app.fastmail.com>
In-Reply-To: <779d72f1-832a-4fef-a529-ebe8100b04f9@amd.com>
References: <20240219093900.644574-1-arnd@kernel.org>
 <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
 <412c0a42-4c19-48dd-aa4e-de39b6ec3099@app.fastmail.com>
 <343f7b1d-1b4e-402e-bd54-4473b91b6f79@amd.com>
 <65f13ad3-989a-4699-9695-d7b1a95297eb@app.fastmail.com>
 <779d72f1-832a-4fef-a529-ebe8100b04f9@amd.com>
Date: Tue, 20 Feb 2024 09:21:54 +0100
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
 "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Content-Type: text/plain

On Tue, Feb 20, 2024, at 08:54, Mukunda,Vijendar wrote:
> On 20/02/24 12:40, Arnd Bergmann wrote:
>> On Tue, Feb 20, 2024, at 07:23, Mukunda,Vijendar wrote:
>>> On 20/02/24 11:43, Arnd Bergmann wrote:
>>>> On Tue, Feb 20, 2024, at 06:57, Mukunda,Vijendar wrote:
>>>>> On 19/02/24 15:08, Arnd Bergmann wrote:
>>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>>> In normal configs, they should all either be built-in or all loadable
>>>>>> modules anyway, so this simplification does not limit any real usecases.
>>>>> Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
>>>>> AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.
>>>> Yes, that is what I described. But as SOUNWIRE_AMD is a user visible
>>>> symbol, there is no problem in expecting users to enable it when they
>>>> have this hardware, and distros just enable all the drivers anyway.
>>> Want to set SOUNDWIRE_AMD flag by default, similar to Intel & Qcom
>>> platforms instead of explicitly enabling the Kconfig option.
>> Maybe use 'default SND_SOC_SOF_AMD_TOPLEVEL' then?
> Didn't get your point.
>
> Even with the current patch, if we select 'SOUNDWIRE_AMD' flag explicitly
> AMD ACP63 SOF driver Kconfig option is not visible for user configuration.
> This results in ACP63 SOF driver won't be built at all.

I don't understand what you mean here. What I see
in linux-next both with and without my patch is

config SND_SOC_SOF_AMD_ACP63
        tristate "SOF support for ACP6.3 platform"
        depends on SND_SOC_SOF_PCI

so it clearly should be visible as long as SND_SOC_SOF_PCI
is enabled.

There is still a problem that SND_SOC_SOF_AMD_TOPLEVEL
can't use my "depends on SOUNDWIRE_AMD || !SOUNDWIRE_AMD"
trick if SOUNDWIRE_AMD in turn uses
"default SND_SOC_SOF_AMD_TOPLEVEL", but I don't think you
meant that, right?

>> I don't think copying the mistake from the intel driver
>> is helpful, though I agree it would be nice to be consistent
>> between them.
>>
>> As a general rule, you should not have a Kconfig symbol that
>> is both user visible and also selected by the drivers that
>> depend on it.
>>
>> To avoid the dependency problems from coming back and keep
>> the complexity to a minimum, I think there are two logical
>> ways to handle soundwire:
>>
>> a) keep the current drivers/soundwire/Kconfig contents and
>>    change all the 'select SOUNDWIRE_foo' to 'depends on'.
>
> Current patch already using 'depends on SOUNDWIRE_AMD" for
> SND_SOC_SOF_AMD_SOUNDWIRE Kconfig option.

Correct, because this is the Kconfig option that actually
controls whether sound/soc/sof/amd/acp-common.c calls into
the soundwire-amd module.

> Still we couldn't see SND_SOC_SOF_AMD_ACP63 Kconfig option
> is enabled.

I need more information here. Do you have additional
patches on top of what is in today's linux-next?
I have it enabled on my build here.

      Arnd

