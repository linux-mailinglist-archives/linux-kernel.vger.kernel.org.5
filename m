Return-Path: <linux-kernel+bounces-9771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6A81CB29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A0B1C223CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3D1CF94;
	Fri, 22 Dec 2023 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kIVkH7yD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiPCtw9s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5481C693
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CD7395C00E0;
	Fri, 22 Dec 2023 09:14:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 22 Dec 2023 09:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703254462; x=1703340862; bh=oVt+LAFbFg
	KG82TEtbcSAhVvjHyj9SbZbARJs8bxpHc=; b=kIVkH7yDE4jU+JW9SAUuXyc9DA
	JXWW8k0mOWh2kQZfANdFqGi2dPiyn/Eikt1XMsQZ5ZO9vWOQVQagzdllFfQave9Y
	UNqdIO4vUFJ/kyrOhlbedNRZCb6k43J+Posx/VezgPMIaxCDsAPZtSe1APGaVPdg
	foEksd7fVlrju5+gnbYVZivaTCI15pooFmyRKb44qNaNk7VbFhHL8ql3Duoj+Pbp
	CxRgJ2ZbAQMCjK8DNa5/NENMlgyjW+fuIIhr/Y5J9EA8Hd/xliH4zRoU16PfZ7Sd
	EMgrtLCN3ua+BvTk2Qag1hvTXOyj8Da+4XnFX4YdzUDY6vcPmjhzV4WfZGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703254462; x=1703340862; bh=oVt+LAFbFgKG82TEtbcSAhVvjHyj
	9SbZbARJs8bxpHc=; b=AiPCtw9sMXjAp9lCuZab5e4lTZDwZ+6WRLkagoavVBnV
	xYUShCYxhv3VyhKRO0faPvlo4Y/9P9THiSs7L6blVNuWmT/u7Dg0KXP6ZCnoFrZP
	PARaDPUCFKncfmLApupwc4nszr2JTclJZuDDcTE0jZAd6QESpTPD9PKmBmNwlLpY
	Qqosf3ap9Q+IChia6CK21Z2+zF0FCyd2nuC+jNu9+nXSBe/hB6UPtiqmSAi3V7Zg
	cF4m1rJie5MgR7FQz+QFjNDB84wv2x9Qk62asm0Q1Rsfenu/t2vBSZgPRqW2RHUa
	GkEtFWz9Zdh9sUpu1WM8JdtNQz/xkzljmkf0Vef6eQ==
X-ME-Sender: <xms:vpmFZZPgoqh_7SuCO1NToy1OrnLrwl7bGLGweBq2SfdiFK7qbvdCMg>
    <xme:vpmFZb_Ml-zkBhxBXEflLCcK4QvByvYmiHHaITxHCFTDBfQYnU1JySNRBugRi__O4
    nXmYck7ykSaH-eZl60>
X-ME-Received: <xmr:vpmFZYQfCniqiymZasnstShqWzelVx3b3QXUCeerxTFdAx7rQIHYY1ep95QY07CUxBpCJiCIIgGRQ9upsInxPo64nHNFBTfxG60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpedtvefghfevieejhfejueeileekieeiteeuhffhgeej
    feettdfhjeevhfevueejfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrrhgthh
    hivhgvrdhorhhgpddufeelgehtrgdrohhrghdpshhouhhrtggvfhhorhhgvgdrnhgvthen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrg
    hkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:vpmFZVtvM_9KHGoF1fcN2LTteMJz5Eoq_DLBKRP5eNBkkIYSs0ymPA>
    <xmx:vpmFZRfwGa12bNRA_2HSzwcPFbDyfwF4LK6irfeIwVjghWcG3xfuRA>
    <xmx:vpmFZR2A2slpqMALsSASM4wn0VtU9n_Pk5QdR7qnr-lcFROM1l4k5A>
    <xmx:vpmFZRkpQnWMmKsn37NK8LMJpmnupGibR5OaTTTSTr53rn3NGRgpmw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 09:14:21 -0500 (EST)
Date: Fri, 22 Dec 2023 23:14:18 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] firewire: core: support legacy layout of
 configuration ROM for AV/C device
Message-ID: <20231222141418.GA625065@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20231221134849.603857-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221134849.603857-1-o-takashi@sakamocchi.jp>

On Thu, Dec 21, 2023 at 10:48:41PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> This series of change is take 2 of my previous post[1].
> 
> Current core function of Linux FireWire subsystem has support for legacy
> layout of configuration ROM, described in annex of 1394TA document[2].
> However, in a point of device attributes (e.g. nodes in sysfs), there
> are differences between devices with the legacy and standard layout of
> configuration ROM. The differences bring some inconveniences to users[3].
> The series includes changes to solve them.
> 
> The series includes changes relevant to driver matching procedure and
> notification to user space, thus could easily bring functional regression.
> For safe, the series includes some KUnit applications to test the change.
> 
> However, backward incompatibility is inevitable due to change of modalias
> for device corresponding to unit. As long as I investigated, any unit
> drivers in kernel are not affected by the change. Additionally, less
> applications in user space are not as well. I think we can be optimistic
> to the regression.
> 
> Changes from v1 series:
> * fix evaluation of uninitialized variable in 7th patch
> 
> [1] [PATCH 0/8] firewire: core: support legacy layout of configuration ROM
>     for AV/C device
> https://lore.kernel.org/lkml/20231220041806.39816-1-o-takashi@sakamocchi.jp/
> [2] Configuration ROM for AV/C Devices 1.0 (December 12, 2000, 1394
>     Trading Association, TA Document 1999027)
> https://web.archive.org/web/20210216003030/http://1394ta.org/wp-content/uploads/2015/07/1999027.pdf
> [3] [PATCH] Fix missing sysfs vendor/model entries for some devices
> https://sourceforge.net/p/linux1394/mailman/message/55802731/
> 
> 
> Takashi Sakamoto (8):
>   firewire: core: adds constant qualifier for local helper functions
>   firewire: core: replace magic number with macro
>   firewire: test: add KUnit test for device attributes
>   firewire: test: add test of device attributes for simple AV/C device
>   firewire: test: add test of device attributes for legacy AV/C device
>   firewire: core: detect numeric model identifier for legacy layout of
>     configuration ROM
>   firewire: core: detect model name for legacy layout of configuration
>     ROM
>   firewire: core: change modalias of unit device with backward
>     incompatibility
> 
>  drivers/firewire/.kunitconfig            |   1 +
>  drivers/firewire/Kconfig                 |  16 ++
>  drivers/firewire/core-device.c           | 127 +++++++++---
>  drivers/firewire/device-attribute-test.c | 251 +++++++++++++++++++++++
>  4 files changed, 368 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/firewire/device-attribute-test.c

Applied the above patches to for-next branch[1]. Thanks for your reviewing.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-next

Takashi Sakamoto

