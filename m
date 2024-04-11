Return-Path: <linux-kernel+bounces-139665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785298A0623
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7F284878
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CF13B2AC;
	Thu, 11 Apr 2024 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="cDFgNMkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qLVMCqzi"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2E282FA;
	Thu, 11 Apr 2024 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803719; cv=none; b=kK1WQZ9c71R0PWMAxMMwwlG1pGTukS1caBi/IEltsNXdnY9ILkUOy46c761FRcyAaefSk2sCKopTRssJacQR+Q1RgfvDKT2vWUIikHZ+m4o8JciHedgtz6QR/OM4t6wRISBE5+/X7RfH1upJY+H4YxATUIezg9kS8EamLm//q5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803719; c=relaxed/simple;
	bh=aG9jifOeSRS55H2245LVoteuYcyfAxJTCH4WvXM9sqs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MGrb++8As1d2SLwuogL/4x0f5/Nu35w4JfzclSK/gBO0ss01+LerIjWWVn9dUah0Os0zSHqoUbXYsmyQcl9oAJ22BAb/Qwnt89mspCQteR2k/rzQFmXGNoG/seJHIfevBpxNkdD2HJO4cmH+HLoHRlw2oFTMcen+SCKt6ZbMh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=cDFgNMkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qLVMCqzi; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 325B411400AC;
	Wed, 10 Apr 2024 22:48:35 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 10 Apr 2024 22:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712803715; x=1712890115; bh=Yw4/+Kal2y
	eV6OQ9nNVgwAfjyawJa5osSvgbqIuMBbk=; b=cDFgNMkCDQagIwh89ozW3+dNxX
	JIx76JtiRg1yil3hIFOm3sYBzkyAO62Pf/zeesWS48iWAiLLIO9B3Ogc60GitJZt
	RRPZJQ/pGeZMENiZI1FXnzL5j95XtbdgwLU44OxF72lzUtsJYFsokAlQC7moIT/G
	BbliYLv02Sjm/0XvRuA1e08lNDdYK0Wmn0RYhsNhhhW2hu8Wxj5rhcaislklOhVn
	gSw3ptOTbMbmjb/qEGb7eSzGNS5bQ1ySy43v7WVTkliWl9Yl/bvGVQNstp+rMHdS
	NPrk9K0QRuKgbujZirPJNC644dL2IGZ8ynHVUBVpBROO/GaiDNV7cz2AytPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712803715; x=1712890115; bh=Yw4/+Kal2yeV6OQ9nNVgwAfjyawJ
	a5osSvgbqIuMBbk=; b=qLVMCqzihWgQYAgIx99+5pUe+B+Sk3ij2mOyTCrkJ+4E
	Py4HtW6V/2mS0T7+pFIqIz4v5youvS4mbq84mmakWoElz8P2YakwSU/RgqcaAXn+
	0DffBKYD3vAGb/5SfDQ0TTBYuMOvzoQD2Yf9eydpIuCLyc7g0RKofQCj4gCYlXBN
	YxsEunwiG3XqgMv+fYNjpifOXCi+AufMnbAIthuKwDvi6Bv3j3urr65rU6o7HHHJ
	drBUdpLOlktBZYEc6It4+6NxwqD+6ba+42oOzOD6vnGzY30qRJtqCcKB4glOQXlC
	EAWbJ4LAkRpfE1alBpKZzoSJwHc18WYxJEQXT9K0pQ==
X-ME-Sender: <xms:gU8XZiOIkaJtmADG6hCgvnfqAd9OE5g4h6IlGL3-6IJOItbj9unHVA>
    <xme:gU8XZg-FgBqWspQi8ASo6QGUfmg39Wb7-LB-c6XoNd3pzk3wOJ_EN7MjzW4uypIWg
    e4Qt_uXmtC--XzRIOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:gU8XZpR5eGPwJrlhs8YcAJtY8N4Iodzk98txlzhlwE5hdsmPBHu-lw>
    <xmx:gU8XZiso2kjSAJKB0vuqUN-Rw_45NQH7jgxNuhVDQTIEsdaADx6fEg>
    <xmx:gU8XZqeA4ZINDp6f73pmLVXCXgZZUuPSpzIoyPoErJhQffcJzzWmRg>
    <xmx:gU8XZm1tdBCDkbkmLlOBRqIv2va1xa_ljdXDr8UZQeSWaWjXp8DUUQ>
    <xmx:g08XZrWKVYpc9L-o5PBObPNAQBvlBIfRzb3pBV7bxKtKCbBmHkSmkbbD>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C6ECBC60097; Wed, 10 Apr 2024 22:48:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
In-Reply-To: <ZhcogDESvZmUPEEf@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
Date: Wed, 10 Apr 2024 22:48:10 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Peter Hutterer" <peter.hutterer@redhat.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Content-Type: text/plain

Hi Dmitry,

On Wed, Apr 10, 2024, at 8:02 PM, Dmitry Torokhov wrote:
> On Tue, Apr 09, 2024 at 10:17:05PM -0400, Mark Pearson wrote:
>> Hi Dmitry
>> 
>> On Tue, Apr 9, 2024, at 9:20 PM, Dmitry Torokhov wrote:
>> > On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
>> >> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
>> >> > On 09/04/2024 09:31, Dmitry Torokhov wrote:
>> >> > > Hi Mark,
>> >> > > 
>> >> > > On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>> >> > > > Add support for new input events on Lenovo laptops that need exporting to
>> >> > > > user space.
>> >> > > > 
>> >> > > > Lenovo trackpoints are adding the ability to generate a doubletap event.
>> >> > > > Add a new keycode to allow this to be used by userspace.
>> >> > > 
>> >> > > What is the intended meaning of this keycode? How does it differ from
>> >> > > the driver sending BTN_LEFT press/release twice?
>> >> > > > 
>> >> > > > Lenovo support is using FN+N with Windows to collect needed details for
>> >> > > > support cases. Add a keycode so that we'll be able to provide similar
>> >> > > > support on Linux.
>> >> > > 
>> >> > > Is there a userspace consumer for this?
>> >> > 
>> >> > Funnily enough XKB has had a keysym for this for decades but it's not
>> >> > hooked up anywhere due to the way it's pointer keys accessibility
>> >> > feature was implemented. Theory is that most of userspace just needs
>> >> > to patch the various pieces together for the new evdev code + keysym,
>> >> > it's not really any different to handling a volume key (except this
>> >> > one needs to be assignable).
>> >> 
>> >> What is the keysym? If we can make them relatable to each other that
>> >> would be good. Or maybe we could find a matching usage from HID usage
>> >> tables...
>> >
>> > I was looking through the existing codes and I see:
>> >
>> > #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
>> >
>> > We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
>> > thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
>> > specific debug info collection application (which I honestly doubt will
>> > materialize).
>> >
>> 
>> That's a somewhat disappointing note on your doubts, is that based on
>> anything? Just wondering what we've done to deserve that criticism.
>
> Sorry, this was not meant as a criticism really, but you mentioned
> yourself that there isn't anything in the works yet, you just have some
> plans.

All good - I was just worried we'd promised something previously and not delivered. We're often slow at delivering - but I try not to fail completely. I try especially hard not to annoy hard working kernel maintainers :)

We do have something developed internally, but it's pretty basic and we'll need to have discussion with 'userspace' fol as to if we release that as a standalone application, or if we tie into gnome (which we don't have a lot of experience with)...or something else.
Kernel world is much easier :)

>
> For such a project to succeed Lenovo needs to invest into selling
> devices with Linux as a primary operating system, and it has to be
> consumer segment (or small business, because for corporate they
> typically roll their own support channels). The case of retrofitting
> Linux onto a that device originally came with Windows OS rarely gets
> much if any response from the normal support channels.
>
> Is this something that is actually happening?

This is way off topic for the patch set, but as you asked :)

I'm afraid I'm going to disagree. What you're suggesting is probably the more common and easier route vendors take, but it has some issues and I think some longer term limitations.
For me one of the things I like the most about our program using the same exact HW as Windows is it means:
 - I have a business lever to get Linux support from HW vendors. This makes a difference when you're dealing with 'minor' components - panels, fingerprint readers, touchpads etc - the smaller devices (though it helps for the CPU vendors too). We have requirements that state the upstream Linux support is needed or the chip vendor will not be considered for the platform...and that's a big deal.
 - It gets FW teams thinking about Linux support. Yeah, there are still a ton of issues there and it's far from perfect, but it means they have to think about Linux support and at least helps us shine a bit of light on what is going on in that horrible closed box.
 - It means I get Linux running at a good level on a wider range of HW then would be otherwise possible. It means that when there is new technology I get to go and ask "how about Linux" and have that discussion (including schedules). It might come later than I'd like - but at least we get to put Linux on the roadmap rather than being excluded for being so niche. Shrug.

I think our Linux program still has a long way to go before it's even close to good - but it's in better shape than it (at least I think so, I don't love the way the industry is going with more being stuffed in FW...but that's above my paygrade)

>
>> 
>> That aside, I guess KEY_INFO or KEY_VENDOR could be a good fit (I
>> personally don't think KEY_CONFIG matches well), but I would be
>> worried about clashing with existing functionality.
>> 
>> Peter - do you have any opinion from the user space side of things, or
>> are these likely unused? KEY_VENDOR seems the safer bet to me (but I
>> don't love it).
>> 
>> Dmitry - What are the downsides or concerns of introducing a new code?
>> I'd like to evaluate that against the potential to cause conflicts by
>> re-using existing codes. If you feel strongly about it then I'll defer
>> to your judgement, but I'd like to understand better the context.
>
> The keycode space is finite and extending bitmaps leads to more memory
> consumption and weird breakages (like uevent generation exceeding 4K
> memory page resulting in failures). I am trying to balance need for new
> keycodes with how likely they are to be used.
>
Ack.
So I've been refactoring my patches to implement the feedback from Hans for the latter patches and just need to figure out what works here.

For the SYS_DEBUG_INFO, if you'd rather we use KEY_VENDOR (I think that's my preference - as its intended for a Lenovo support role it seems the best fit), and Peter has no objections, I will make that change.

I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.

Is that OK?

Mark

