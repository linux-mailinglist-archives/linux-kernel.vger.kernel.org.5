Return-Path: <linux-kernel+bounces-59208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1284F33D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C941F23C83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810096996D;
	Fri,  9 Feb 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LWxD6VlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yd6vhEgV"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8169949
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474046; cv=none; b=Efr7guqWOPNGYq8WwP+xT5zzcFqmLUqTPO3J+XKeEzX4HzC/ax6MRAE83BiEnmjQUnxWc4hjzWGqu/yqYRFxF98L0M7wnAeAXAvzTJQFRwnDlNtToBm5sHg4TCpllR8mYewfuvKsbH7u0IpiN/PkzBj+6VkxyujyVbMGaYYwEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474046; c=relaxed/simple;
	bh=BdP/gbWV69W+twjGklu0gw6zUZWOu0HNNni9y/moC5M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=N4HWXyj+EUxfDn7txnBRsbOet3ybVNTJCiQrRXlpI5cNfRHUEk//ranRcU6WXAq6XejvVVfaUeqDGUMSMWWzGfwrRQw0tKpHNcaFFG5NxsL//HYJDwDndQm7sZd+BTymgq954rN2VUZSsXyYwWA9ZL2Z18XAF7SFy2ApoFtAESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LWxD6VlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yd6vhEgV; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 163973200AE6;
	Fri,  9 Feb 2024 05:20:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 09 Feb 2024 05:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707474042; x=1707560442; bh=YlVp2fVc8I
	bNSfuq3P/i0hjvzDSLwhQ0RUOswf2KtYw=; b=LWxD6VlSDU4ez/liiq0KuV5G6q
	u99IgdZTexpekpxRF6qjWTriZNxCiU2V6951LW2waftVqpbU8nN7Lb/F605PkAMH
	59AXRHBdqlLGf0MJuF4vyHdIowy2h4c7yJ9y1txuDvqYa56els0EQ6qYGG6zVuH8
	SGzzoyDgJqumksvBa4Jpwq6nOtRLFf74ErFPlK9VnxuFhGYhGcZ01JgxycdOxyrz
	+taz9FdSN+y4t7I00uolcfOHHkqg+fOBSD1bRWRmC2GPnczh+EWJ2QViWGBXeSDa
	BfiJqC7cFRLRRLMmOZHVWfdhpbmXJJDjrKS31OApw3Xiw1hY69usx3NPg16A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707474042; x=1707560442; bh=YlVp2fVc8IbNSfuq3P/i0hjvzDSL
	whQ0RUOswf2KtYw=; b=yd6vhEgVQfwVOMQdcqVsi2WSKFS5mukIyZjef0VdmnJE
	rrS+uO9xw8mAiTQEwM0lA7SDm1/HsYFuRaQFXHe3cIy6yBYGTkaugU2Ef/nbT6mD
	jejlTP3OwZz5cv69FARst5Wm/TZMBC6eYldxbZxc9jUDhcKe0+GhlAoRGMmBKEf/
	7CuFX9AU2X5JRVFn/dR2xQ/pdK40d+VxMTCRE3pFNDc1RMWVhsDpBKqWEtviBKCH
	1sE+ciN/qpCxyfguchgKxJTLspjef8z+lo7uPPZh1r+oIRLQy9JAGWU+RzZGdqO+
	Fpsb+PdGu0n3rVX6hVPaIyHFI8E2/RmkyGje7htAYA==
X-ME-Sender: <xms:evzFZcoxSmPDTPofGmNFrxPdWjiGqgQP7TNCcmxcCnL7gBUYocCrKg>
    <xme:evzFZSrLgEnNM8ThB01shdU975d7ArPefSSD291C5iIxHMPVtAPGPYCX7w_lVTcMg
    6yn5PwbtHwPZPnWCbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:evzFZROVdrCX_jOJPGB2AURUMTrVpnnTRwbXiMA8FTnVkxB5VbxTRg>
    <xmx:evzFZT7309h_1q9LB1Ze1RHQbvGavVNZEEWJ3nS6Z2IKdIOppSI_ig>
    <xmx:evzFZb69za8yGoOpm_CKxP8YrokQ9ke3MZlo1Sb1tl4ykvlHGYEAcQ>
    <xmx:evzFZYFj7RpK0Ydk-bqtweUlWTYmk1VgwRGcCqPGP-0PyDJFD_tz2w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0D6C0B6008F; Fri,  9 Feb 2024 05:20:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <87302cfa-c3ec-4d60-b870-a86acf0f6f8b@app.fastmail.com>
In-Reply-To: <e9a72160-2d39-4090-8822-ca68477f429f@leemhuis.info>
References: <20240122153442.7250-1-arnd@kernel.org>
 <170594251756.17335.7078970144473561827.b4-ty@linaro.org>
 <e9a72160-2d39-4090-8822-ca68477f429f@leemhuis.info>
Date: Fri, 09 Feb 2024 11:20:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linux regressions mailing list" <regressions@lists.linux.dev>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 "Chen-Yu Tsai" <wenst@chromium.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, asahi@lists.linux.dev,
 "Sven Peter" <sven@svenpeter.dev>, "Michael Walle" <michael@walle.cc>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Content-Type: text/plain

On Fri, Feb 9, 2024, at 10:09, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 22.01.24 17:55, Srinivas Kandagatla wrote:
>> On Mon, 22 Jan 2024 16:34:10 +0100, Arnd Bergmann wrote:
>>> Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc1 on
>>> Apple M1, which (in downstream dts files) has multiple nvmem cells that use the
>>> same byte address. This causes the device probe to fail with
>>>
>>> [    0.605336] sysfs: cannot create duplicate filename '/devices/platform/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
>>> [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                 6.8.0-rc1-arnd-5+ #133
>>> [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
>>> [    0.605362] Call trace:
>>> [...]
>> 
>> Applied, thanks!
>> 
>> [1/1] nvmem: include bit index in cell sysfs file name
>>       commit: b40fed13870045731e374e6bb48800cde0feb4e2
>
> The problem description from Arnd to an outsider like me sounded like
> this is something that should be fixed rather sooner than later in
> mainline. Am I wrong with that? If not: will this be heading to Linus
> soon? Just wondering, as the fix seems to be a in "for-next" branch[1]
> of the nvmem repo and not in a "fixes" branch.

Yes, this that this needs to be fixed before v6.8 is
out. I assumed it had gone upstream already.

If anyone is still unsure about the ABI, we could also revert
the original commit 0088cbc19276 ("nvmem: core: Expose cells
through sysfs") for v6.8 and try again for v6.9 with the
fixed ABI, but I think we already had an agreement on the
changes that I sent.

     Arnd

