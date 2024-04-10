Return-Path: <linux-kernel+bounces-137830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E76C89E817
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116A028545D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1A8BE7;
	Wed, 10 Apr 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="mQ4PTrIi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfkG8UUI"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD91FB4;
	Wed, 10 Apr 2024 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715430; cv=none; b=IxWyTa25BCH1YBwSKwwPibTgv9Vaq0stpjU9ZP35rA5DFef4dBl98I14ilcL8Xi8RxS06mcddZE//jWPo5HOtycWdZFFfxyyoN5LwBBQ5VVVlUZ2fkr4T75lh3FQltZQbGdaz0342DwsUXekD+1CabgOCfTYfWFdGICvmPmhgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715430; c=relaxed/simple;
	bh=onrkEQO2aQUtdBzkZs6XetQ4U270C3bQZEOS7N31PO4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Jz5oAaA21mGhe9ofWGSscTlT4yE+ul9MDWOav9qMncee0/TNKZHaKnXDBW7Qtc7sZwHfAxvUPi/RNZmhQDMm08dKF1voIU1XW5YDwhUQq+ynIZqE7g6dl7Oebr4v0DHjXkXZoHnzkb0B35CdyuAH+fObVt7HWvYSdnJFs3OMEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=mQ4PTrIi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfkG8UUI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 872BD13802C3;
	Tue,  9 Apr 2024 22:17:06 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Tue, 09 Apr 2024 22:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712715426; x=1712801826; bh=QmIb7eehjl
	j51OheY2NUMsMEGmdD2KNY8qYRik3xPX0=; b=mQ4PTrIiRS7rytFH1Qd2cJH/K0
	Rst1K9kB4t+DrgXmo5pz61HLbiClt2aavSSWAIN562599LdW1wNnBS8YvigrSZ+F
	BAZapcLCWWES7H2LoA3D/+WnZfcdt3k4V7gOOWwnFUoEbyvoo7I1XczN3J0hbkU4
	T5LDIe2r1LAxaRINH6t3hfBxqbuTj3H9FiKu2uIs4rnwOnT2S7vjmGZftN8uD+RQ
	2T3sOXth2yL1lgKmZPbXNIMluKokUcHLwJuCmvMUhlJSDpisI/SMjGfjgbvoKfwh
	DY9AC33kHBNuh8xYfg7qTgtIeZabm4t1GMhrp3s6fBdf5O6H9Zs+FVvtiHkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712715426; x=1712801826; bh=QmIb7eehjlj51OheY2NUMsMEGmdD
	2KNY8qYRik3xPX0=; b=DfkG8UUI+XVQPXJzMLRwXseYHSDiNTUAMRVFc97kHhdT
	YDIHXf6y2pItsHSlGWWTJ/JhHYtbxCFAGhbABYyhZmzOLqhZhcMyPOgNdfFl1w74
	xc3H6Ut6YaWOrJXaFl93L31FIEaPKca4F8Wtk3xLENzZ3lOfG8/MmYafRndAG+Sl
	Z4MGy3r6XhP+I0LRrar+ddPfeMU6vUBZhZe4JzPfo/8ZQTzAkWIfZUkj0csIRhVB
	Zfo0S/I/pIExZ99Bi+QRLCdgLDifbAWilBKDGoYFcvO/zFk6QmzsauGOhS3Gt1Al
	/5Jw5/9YSRSTmsWAhDO7S0EVeDQoVFttJDVWSDStTw==
X-ME-Sender: <xms:ofYVZiqp5iyPfNaVOONHbobDeeEa56rHNH4EbAPo-CgGtCiPmGDGNw>
    <xme:ofYVZgrf3wDOD36oL_Csox0JerKjEjuEGI0MpFb8m10t-H-vUT6y4fUe5K4Ce0FJ2
    PNZvoFFs8z1NSZYuBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:ofYVZnNLTcKsV6MW_9sh3P7gJqC4x7MyGE7aCWndLFe5eVKDHuLJig>
    <xmx:ofYVZh7embmJTUwTDEyEVMirG_2jv7FHuTSPUkANqJGsA7wgulvO-g>
    <xmx:ofYVZh5L_kfBTJayoA6ML-LrdLBORZFrRLlBDg6BaoBwz7CIaWhJkQ>
    <xmx:ofYVZhiMUeMEI1GJtVvmvDdhjym3pXtSR6etB6WXSEQCxc2O_zZqkA>
    <xmx:ovYVZuzgJR4Tu6KGzU0GAyhXDfnuJiGu_yKdF7z0WFeGCu5n_RWSXpgr>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C52AFC60098; Tue,  9 Apr 2024 22:17:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
In-Reply-To: <ZhXpZe1Gm5e4xP6r@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
Date: Tue, 09 Apr 2024 22:17:05 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Peter Hutterer" <peter.hutterer@redhat.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Content-Type: text/plain

Hi Dmitry

On Tue, Apr 9, 2024, at 9:20 PM, Dmitry Torokhov wrote:
> On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
>> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
>> > On 09/04/2024 09:31, Dmitry Torokhov wrote:
>> > > Hi Mark,
>> > > 
>> > > On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>> > > > Add support for new input events on Lenovo laptops that need exporting to
>> > > > user space.
>> > > > 
>> > > > Lenovo trackpoints are adding the ability to generate a doubletap event.
>> > > > Add a new keycode to allow this to be used by userspace.
>> > > 
>> > > What is the intended meaning of this keycode? How does it differ from
>> > > the driver sending BTN_LEFT press/release twice?
>> > > > 
>> > > > Lenovo support is using FN+N with Windows to collect needed details for
>> > > > support cases. Add a keycode so that we'll be able to provide similar
>> > > > support on Linux.
>> > > 
>> > > Is there a userspace consumer for this?
>> > 
>> > Funnily enough XKB has had a keysym for this for decades but it's not
>> > hooked up anywhere due to the way it's pointer keys accessibility
>> > feature was implemented. Theory is that most of userspace just needs
>> > to patch the various pieces together for the new evdev code + keysym,
>> > it's not really any different to handling a volume key (except this
>> > one needs to be assignable).
>> 
>> What is the keysym? If we can make them relatable to each other that
>> would be good. Or maybe we could find a matching usage from HID usage
>> tables...
>
> I was looking through the existing codes and I see:
>
> #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
>
> We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
> thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
> specific debug info collection application (which I honestly doubt will
> materialize).
>

That's a somewhat disappointing note on your doubts, is that based on anything? Just wondering what we've done to deserve that criticism.

That aside, I guess KEY_INFO or KEY_VENDOR could be a good fit (I personally don't think KEY_CONFIG matches well), but I would be worried about clashing with existing functionality.

Peter - do you have any opinion from the user space side of things, or are these likely unused? KEY_VENDOR seems the safer bet to me (but I don't love it).

Dmitry - What are the downsides or concerns of introducing a new code? I'd like to evaluate that against the potential to cause conflicts by re-using existing codes. If you feel strongly about it then I'll defer to your judgement, but I'd like to understand better the context.

Thanks
Mark

