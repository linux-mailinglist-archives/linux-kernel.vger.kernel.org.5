Return-Path: <linux-kernel+bounces-146817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F88A6B69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C821F21BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238212BEB7;
	Tue, 16 Apr 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Q3XWA1+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q63jmz7S"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BF6BFDD;
	Tue, 16 Apr 2024 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271660; cv=none; b=XHdbUR0geq1fqdPgkGDvQRjxc+8fjPd7HE2XiH/FQsq3KYoZ/1Wv7CblVG7RoaN9vbfopp8U+lkrakQkoK0n8qUptaJ0LZTBlx3rqZVXXd/7n2R3biKaM0x7M+SdNuwaqmCCsVBAlnBx2IMJxFlUDiVDFzqSqFlCCl4o6qqFUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271660; c=relaxed/simple;
	bh=y+/Ebc9cDomP+Us9Son9nxZv+MjrLNi2Me6BEVjA3Xg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=brfZu1+5j76ZgTOIruLAtU74PyalROgyyNj4e4TOPgygH+5fpE5e459/nIbeN3Rp35zAhZUxYP+LX2JI0NXHaouEvMONnSdr5hEBmeC4gtK3FuN7F8RwwzjReI8ZpZ4foTdGCYi5rOz3KBcp/nL0PC1D5ZgEtk/01G3982C7kS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Q3XWA1+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q63jmz7S; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id C7FAA13806EC;
	Tue, 16 Apr 2024 08:47:36 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Tue, 16 Apr 2024 08:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713271656; x=1713358056; bh=o+A6VQF+YA
	bnPd55BY98j5+Z/sNjOCmfHE3OGnEzh2o=; b=Q3XWA1+OY/HWHYR1BQtn2qUTwQ
	xtT9OgbDT3BR8cSHAJUORD8mBmJAWIpxV/eOneMCCwOXn5kotlZygOEQz0LibU/Y
	R+Yl0wL4GYNr0nW1Hn3GMMeRABQ49Cv8nOVBo9A+lr+PhRbih2Cj+39PyIXTqnaT
	Q/U/432UW6u3q6DiRQewWPZZZumLUZebYwr62fSp7z88gh+jSFcrU0wG6ZFLbvn2
	YLfbfHD51luXvnYmuzT6JV5dO5VtaEglxLqBQ3dEbPFXRxISFx65ep0+44HD6OqB
	ScY+BGxq+xOP08kbMQlWF9ea7B71cnJKgPJbdNTZEr1vb22CFMskwkOn/m2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713271656; x=1713358056; bh=o+A6VQF+YAbnPd55BY98j5+Z/sNj
	OCmfHE3OGnEzh2o=; b=Q63jmz7SYl461WydOQDvdyrROqIe9K0Yg+Nrt/NTUuja
	hdBx7uD200mJLSYpZG4cTXV42RGVBkp8pARiI7wL3xlXmJopSQHuXbMVB90Z5PZC
	kVrbiQhIN+quX9Dimdt1c+28yiQrAH/dJ4wi0vxBXq2XZsD8ugA+IwdgWvpLSk28
	gn0djxsUqbheeyQDXm1Co1ARyjRFbSM4dY9438KowKRaOtSAa0W+LoA7LoFlpPrh
	n5duoMnRwZTOOTCuolasLzuyw7y4SddeIYUC4wOT3hebWp8CDSwNWB49aPZx3+ny
	XHuKhRejLFDaLQAVDb3EX/mOwSBf+/CObCj91KElbQ==
X-ME-Sender: <xms:aHMeZqF1sOEwKPqWJpeUjM-x1U2rKEJ_yV1BMqVAvg8nGaSnUTcb7w>
    <xme:aHMeZrXXMvjVF65I5hiVzMM7lenB0PqiIqZ6BaIY4Fw-8CgtajkmAtKBPH4jIlr6f
    s3epPX5osjTgP5YiBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:aHMeZkLOriO-2CYFs6tTuUljhQdacfE5M2i0vqXaU1_M1hNAZtlHWA>
    <xmx:aHMeZkGKeORbizedMF6EXhgi36cqroD3bEG3KB2iQiYRk7Jk2dT_vQ>
    <xmx:aHMeZgUIuaFOhSyhzXoT_BkfKp_g6dDwqIfy4AQ6FtrLDTD2bJrONg>
    <xmx:aHMeZnOEf1RfUo9sY48d2oVYz7NSvGTD6bmOGhsmrJe7aGfLuyuZdg>
    <xmx:aHMeZpOltZRUoc4rsA22y8D5RBk3BRsQnJbTor5wW83YXo1HAh5jtJjv>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 190A4C60097; Tue, 16 Apr 2024 08:47:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ce28b0e5-a867-458e-bcb4-cc327be5f19e@app.fastmail.com>
In-Reply-To: <27b1b6cf-759c-4778-a53c-5d01442120b7@redhat.com>
References: <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
 <Zh2CtKy1NfKfojzS@google.com>
 <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>
 <Zh2G85df29tPP6OK@google.com>
 <539776c5-6243-464b-99ae-5b1b1fb40e4b@app.fastmail.com>
 <Zh2wO0Bnyr8vFSpc@google.com>
 <7de52ec3-86f3-4a1d-ac87-a106ae1acb5d@app.fastmail.com>
 <27b1b6cf-759c-4778-a53c-5d01442120b7@redhat.com>
Date: Tue, 16 Apr 2024 08:48:31 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <hdegoede@redhat.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Peter Hutterer" <peter.hutterer@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Content-Type: text/plain

Hi Hans

On Tue, Apr 16, 2024, at 4:33 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 4/16/24 1:57 AM, Mark Pearson wrote:
>> Hi Dmitry,
>> 
>> On Mon, Apr 15, 2024, at 6:54 PM, Dmitry Torokhov wrote:
>>> On Mon, Apr 15, 2024 at 04:28:19PM -0400, Mark Pearson wrote:
>>>> Hi
>>>>
>>>> On Mon, Apr 15, 2024, at 3:58 PM, Dmitry Torokhov wrote:
>>>>> On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
>>>>>>> On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
>>>>>>>>
>>>>>>>> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
>>>>>>>
>>>>>>> Please see my response to Peter's letter. I think it very much depends
>>>>>>> on how it will be used (associated with the pointer or standalone as it
>>>>>>> is now).
>>>>>>>
>>>>>>> For standalone application, recalling your statement that on Win you
>>>>>>> have this gesture invoke configuration utility I would argue for
>>>>>>> KEY_CONFIG for it.
>>>>>>
>>>>>> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
>>>>>> the GNOME/KDE control center/panel and I believe that at least GNOME
>>>>>> comes with a default binding to map KEY_CONFIG to the control-center.
>>>>>
>>>>> Not KEY_CONTROLPANEL?
>>>>>
>>>>> Are there devices that use both Fn+# and the doubleclick? Would it be an
>>>>> acceptable behavior for the users to have them behave the same?
>>>>>
>>>> Catching up with the thread, thanks for all the comments.
>>>>
>>>> For FN+N (originally KEY_DEBUG_SYS_INFO) the proposal was to now use
>>>> KEY_VENDOR there. My conclusion was that this is targeting vendor
>>>> specific functionality, and that was the closest fit, if a new keycode
>>>> was not preferred.
>>>
>>> Fn+N -> KEY_VENDOR mapping sounds good to me.
>>>
>>>>
>>>> For the doubletap (which is a unique input event - not related to the
>>>> pointer) I would like to keep it as a new unique event. 
>>>>
>>>> I think it's most likely use would be for control panel, but I don't
>>>> think it should be limited to that. I can see it being useful if users
>>>> are able to reconfigure it to launch something different (browser or
>>>> music player maybe?), hence it would be best if it did not conflict
>>>> with an existing keycode function. I also can't confirm it doesn't
>>>> clash on existing or future systems - it's possible.
>>>
>>> So here is the problem. Keycodes in linux input are not mere
>>> placeholders for something that will be decided later how it is to be
>>> used, they are supposed to communicate intent and userspace ideally does
>>> not need to have any additional knowledge about where the event is
>>> coming from. A keyboard either internal or external sends KEY_SCREENLOCK
>>> and the system should lock the screen. It should not be aware that one
>>> device was a generic USB external keyboard while another had an internal
>>> sensor that recognized hovering palm making swiping motion to the right
>>> because a vendor decided to make it. Otherwise you have millions of
>>> input devices all generating unique codes and you need userspace to
>>> decide how to interpret data coming from each device individually.
>>>
>>> If you truly do not have a defined use case for it you have a couple
>>> options:
>>>
>>> - assign it KEY_RESERVED, ensure your driver allows remapping to an
>>>   arbitrary keycode, let user or distro assign desired keycode to it
>>>
>>> - assign KEY_PROG1 .. KEY_PROG4 - pretty much the same - leave it in the
>>>   hand of the user to define a shortcut in their DE to make it useful
>>>
>>>>
>>>> FWIW - I wouldn't be surprised with some of the new gaming systems
>>>> we're seeing (Steamdeck, Legion-Go, etc), that a doubletap event on a
>>>> joystick might be useful to have, if the HW supports it?
>>>
>>> What would it do exactly? Once we have this answer we can define key or
>>> button code (although I do agree that game controller buttons are
>>> different from "normal" keys because they map to the geometry of the
>>> controller which in turn defines their commonly understood function).
>>>
>>> But in any case you would not reuse the same keycode for something that
>>> is supposed to invoke a configuration utility and also to let's say
>>> drop a flash grenade in a game.
>>>
>> 
>> Understood.
>> 
>> I don't see a path forward within your stated parameters. I did not realise that there were such limitations, so my apologies for wasting everybody's time, and thank you for your patience and guidance.
>> 
>> I will drop this patch from the series and proceed using existing defined codes only.
>> 
>> Hans, I'll need to rejig things a bits but I have some ideas and I think I can make it work and stay within the pdx86 tree, which will make it simpler.
>
> Ok this sounds good to me. For Fn + N using KEY_VENDOR sounds good for
> me and for the doubletap any one of 
> KEY_CONFIG/KEY_CONTROLPANEL/KEY_INFO/KEY_PROG1
> or some other suitable KEY_foo define works for me.
>
I think this should be a configurable input, by design. So my preference (if not allowed a new keycode, which I personally think is the better option) is for PROG1.

I discussed with Peter last night and it looks likely OK on their side. I do plan on doing some testing first, so it might take a few days to get the next set of patches out.

Mark

