Return-Path: <linux-kernel+bounces-48277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF684597B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B951C28E19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7605D479;
	Thu,  1 Feb 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F6gZrOgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ox+jViU1"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ACA5D461;
	Thu,  1 Feb 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796030; cv=none; b=HkZleadKEMzvRrJ4F2z2O7HPfnAuGa/E98MsCi3HW11gYcV9JQn3Or0VkP8zzeFOIWaB8SwuCDNPONWF2c/Dc1z97Qd7OIiSbdIN9qTnPhwHn9dLrY4tRbk5fK3dv4nrA4Yj1+pCozdHhijWjL+ks1gGm9GfKwk7CXANaf+Oq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796030; c=relaxed/simple;
	bh=xMwJiP7MmYCabqx5cyil4Dn67arKtEGuoUBogTvOSRs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HTfBHpuoFKivzstAup7qY3UGA/fWwgHCyeX44Y2vphj3Ciiw/AU18GGx1HYVu574MXchoqbRPRgSgDl+U4b72u0GC8GiRASuY9UyIz78r2mK5HugGYeJeKo0nBgAg+/TMNN1+1HqoyheGjGuipQrPNKI0JNgBFpKqSNNtI6uupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F6gZrOgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ox+jViU1; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E50DC5C0195;
	Thu,  1 Feb 2024 09:00:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 09:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706796026; x=1706882426; bh=N58mymRXnR
	4Pivcrh/fWTAT8wYPAf8WjYxse+92s2hg=; b=F6gZrOgCErZol5JlEh8BtMNAAb
	XFReSGz51PnubydifA5UziGQWaOjUrlVeJd6wiyUI30AwznPkjRggrV+/JvEUpmZ
	G6VXhMGYuhsrj+b3Bum2FDSREvLwm8TL9V0hWKXZYgIExd94qv9mJBRPI+aKUVKB
	Y5AtvJMiux1PV2I/rfluHWYMY0GfWGK2OVUSP0bnwNa6S2VSA97h3zrQ0ul7xvAR
	SWNED1m+gGD7C4tWxPUrE83bR2sBPURGZI7Pr+XmSJVD97dLAzGZMhCUuFv+V+7/
	RhcmPrTvAjRWpDVqY4AcYshN+I/OSQIY9eLoRJEhUD/bhkyJc7bM5yzEwZvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706796026; x=1706882426; bh=N58mymRXnR4Pivcrh/fWTAT8wYPA
	f8WjYxse+92s2hg=; b=Ox+jViU1ThqKcmFL67a2ZjB2HYMpauiDnSxeuTlvBTyK
	8nBc62vVLeqniUs8Bk0nQti6pITiM/ZQ4ynVSCwnpjSWXWgJtAP2g7eK/YRUuEYJ
	/fg7XorJbEVc4bpRnsJzjNmZdoVVzdSIjWyuacscpUSxDqlSDTj/GOFdKdcuAvNY
	5G3p7le5cbfmhwc3hc35udXXc+7VN8w81Uvx07fufE5O7ZWX9mYYjp3UlWDu0xpk
	aiVFkQJ2wdh+tUOg7EqZ7VQ5e6wofeM7jSJ2PBar0qNgfm5mUJxTr7y3SDCbM1Eg
	+HOYtwxJnGioeZtDxqeNE/BfLonCG1uF2NCaicW/zA==
X-ME-Sender: <xms:-qO7ZVk2qdClUQ7_aDgANRo7zUUhm5i1rYkJA-HDXJUc9jbfVVzeLA>
    <xme:-qO7ZQ024m7euwGqPZudfKU4sA3LMDLAgVOAVZ1QpD12geP7UtrulClU7l-8wBfyh
    5mqfnGMrFx8xJ5UDxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-qO7ZboJPYSuxzznt-4RVVRpxtal5gjQ9nsVIGTYC_9wq5KnGEVYtw>
    <xmx:-qO7ZVmsFa0YBhMsN3EuoqnfrgDQZTp3A56uewgHz65X-oI0YBv0Hg>
    <xmx:-qO7ZT0cYnf5dAIM08AQgvaBHvr7AgmcBolw1WsQxdlFtMGa52AiIQ>
    <xmx:-qO7Zcs3LFB3apPfbt1S1mCmk3keICfucKt8dp73qRGMvuPZcx5krQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 15664B6008D; Thu,  1 Feb 2024 09:00:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <789b7ca0-80c5-449a-99eb-8c05b5380245@app.fastmail.com>
In-Reply-To: <ZbuZ_55a-qqDqkeN@smile.fi.intel.com>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
 <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
 <ZbuZ_55a-qqDqkeN@smile.fi.intel.com>
Date: Thu, 01 Feb 2024 15:00:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Linus Walleij" <linus.walleij@linaro.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 "Kalle Valo" <kvalo@kernel.org>, "Arend van Spriel" <aspriel@gmail.com>,
 "Franky Lin" <franky.lin@broadcom.com>,
 "Hante Meuleman" <hante.meuleman@broadcom.com>, "Lee Jones" <lee@kernel.org>,
 "Brian Norris" <briannorris@chromium.org>,
 "Srinivasan Raju" <srini.raju@purelifi.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
Content-Type: text/plain

On Thu, Feb 1, 2024, at 14:17, Andy Shevchenko wrote:
> On Thu, Feb 01, 2024 at 01:20:16PM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 31, 2024, at 23:37, Linus Walleij wrote:
>
>> +	} else if (ah->led_pin < 0) {
>
> ...
>
>> +	if (sc->sc_ah->led_gpio)
>
> Dup check

I don't know what you mean here. To explain what I'm
trying to do: The idea is that the LED is always backed
by either gpiolib or the internal gpio controller on
the PCI device. This means every access to an LED must
be guarded with 

   if (gpiodesc)
         gpio_*(gpiodesc);
   else
         internal(ah);

We could probably go a little further in the cleanup and
throw out the gpiolib path entirely, instead relying
on the existing leds-gpio driver. Since there are currently
no upstream users of the gpiolib path, that would likely
lead to cleaner code but require more changes to any
out-of-tree users that rely on the platform_data to
pass the GPIOs today.

     Arnd

