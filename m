Return-Path: <linux-kernel+bounces-146026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F918A5F05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC3E1F21A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D88159900;
	Mon, 15 Apr 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="jXLiSokM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAYfhFjp"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BD158DDC;
	Mon, 15 Apr 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225496; cv=none; b=cYvajE1j0dEHg5hZQ18cXXEPwfwmcIatY0ZBPdv5wWnRMjaUqFCPu+ZfRwcVO2et566tWUxoxTA1GlHx6Ko+1ub9mbo7w5EfHRrAuzHLA6yl4ZEHVvoGW98lhTEZVDsNsf0Vatocl2fOwuIZ49Fj0dEDCVlqRQrjTtZjs5ppf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225496; c=relaxed/simple;
	bh=W8KlIbMQ30Wu+c2HGGq37gh4IgUwexzLYbdcYepKVWI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aqziRgC74lRUbHdrZJdYwKQmFJZTpi/4fhqVK71E3Qk/daDPPMpNu2WWOTmoT6c7fOuQMKbSYnGiXBovQIh2yNVXlj+cKOYvSxowG1Tjbwk46qB1gAhL/I2jw13gjEQ0eC+dGAYjphuTCW6C9B9M2bE82rb/0PRCRFGTOdW1AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=jXLiSokM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAYfhFjp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B07001140131;
	Mon, 15 Apr 2024 19:58:12 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 15 Apr 2024 19:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713225492; x=1713311892; bh=k2/J7hdwFo
	PqwQc+fqXNZaykRVaVRk4wpoekmeB11RA=; b=jXLiSokMmYEvLK0wPmD8NP5aci
	5NGY9WnhpJlNE2lpCcz2T65mEDPuGq7mnD6ProHAMXLktTkSAsbx4ryy/M0dhv+2
	OZbro9pMJCnqn4tDnkybQb5mKUdgcaTdW+htPSh3iM8wQmYV+epuhBBUCCzg5ih1
	VNPtcLkwr9kqInqkq7iBMUP8EFgV8YKTNzv792ZI95/9opVb5gTLnOA21RWgvuvg
	J7ySwNR2/5h9G3Jh2uRWfJELm5a0EQUI12caDTGABNW4oWbBAxujrQrNkAeac5rV
	ytGFq2yLtiSPhZa/I9QDWM0l2O3Hr13qVeQQiqzdTRpIhZ+tCn6Yi4pGdJ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713225492; x=1713311892; bh=k2/J7hdwFoPqwQc+fqXNZaykRVaV
	Rk4wpoekmeB11RA=; b=YAYfhFjpuwM1Q0NK4TrgVF1D3O91OWYPx5ffMV5lTR3l
	ZwYvB0JG7a79BsFmWqixFqoIP89J5EzpJF6IBVfOLnxIUbAlSnpof8Uf4TEuhbZR
	HEY6zKJdzX5Fb9adysjvCQrALDF2hXOf7v78Qc9RSiCnaihvhve723uqPmnWSXsk
	RAuSQBhhRK2AK/cvaSa0HPoPd63On/NfmWlfYAvpQMkMWQxIRaW1UKdwj1k/xNBS
	nD9M0a3NMTEQrOXTNpouhpPEPwYPf82JkjJ046Zk2q2OgpH9cLnzA+kCoYQP31Ks
	61vLMtUyv4+lbQ4vVYML+/w421sfAg7huiCZrE8olQ==
X-ME-Sender: <xms:E78dZrbvy-PSl9vtA4YsolTrfUdZoq32BIYFDPFX8goC2Ds3lpMpUw>
    <xme:E78dZqaw8E4MBpxAbwEcq141cvfgfRqjdCnrFO3ORnMzY0lqnMyg6u2IvkuQxlHte
    UG7wT9aqtsmKK0lehU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:FL8dZt-ymJ8D9UAqInlku2J0OOKUn_zb-h4VCtm48fg8pBmXJ4eWPQ>
    <xmx:FL8dZhrvL7HbWXI8a7Fwv8CW5HDExX-NTMf4bJskwBP__2SmHKOi2w>
    <xmx:FL8dZmrudba23rRbTc1r0THvtSm1N4Nfe8qjozUi-SAV6-vBN4PbUg>
    <xmx:FL8dZnRbCNu93muL86xu6_oFtdYWntoKuyqnIq5ZzgZM_K-flvb1zw>
    <xmx:FL8dZjjvPJgYIbLSQjSnt5fZJSV7AfYE4fFn6KE_dWPE60gup105peA_>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DE8CDC60097; Mon, 15 Apr 2024 19:58:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7de52ec3-86f3-4a1d-ac87-a106ae1acb5d@app.fastmail.com>
In-Reply-To: <Zh2wO0Bnyr8vFSpc@google.com>
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
Date: Mon, 15 Apr 2024 19:57:51 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "Peter Hutterer" <peter.hutterer@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Content-Type: text/plain

Hi Dmitry,

On Mon, Apr 15, 2024, at 6:54 PM, Dmitry Torokhov wrote:
> On Mon, Apr 15, 2024 at 04:28:19PM -0400, Mark Pearson wrote:
>> Hi
>> 
>> On Mon, Apr 15, 2024, at 3:58 PM, Dmitry Torokhov wrote:
>> > On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
>> >> Hi,
>> >> 
>> >> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
>> >> > On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
>> >> >>
>> >> >> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
>> >> > 
>> >> > Please see my response to Peter's letter. I think it very much depends
>> >> > on how it will be used (associated with the pointer or standalone as it
>> >> > is now).
>> >> > 
>> >> > For standalone application, recalling your statement that on Win you
>> >> > have this gesture invoke configuration utility I would argue for
>> >> > KEY_CONFIG for it.
>> >> 
>> >> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
>> >> the GNOME/KDE control center/panel and I believe that at least GNOME
>> >> comes with a default binding to map KEY_CONFIG to the control-center.
>> >
>> > Not KEY_CONTROLPANEL?
>> >
>> > Are there devices that use both Fn+# and the doubleclick? Would it be an
>> > acceptable behavior for the users to have them behave the same?
>> >
>> Catching up with the thread, thanks for all the comments.
>> 
>> For FN+N (originally KEY_DEBUG_SYS_INFO) the proposal was to now use
>> KEY_VENDOR there. My conclusion was that this is targeting vendor
>> specific functionality, and that was the closest fit, if a new keycode
>> was not preferred.
>
> Fn+N -> KEY_VENDOR mapping sounds good to me.
>
>> 
>> For the doubletap (which is a unique input event - not related to the
>> pointer) I would like to keep it as a new unique event. 
>> 
>> I think it's most likely use would be for control panel, but I don't
>> think it should be limited to that. I can see it being useful if users
>> are able to reconfigure it to launch something different (browser or
>> music player maybe?), hence it would be best if it did not conflict
>> with an existing keycode function. I also can't confirm it doesn't
>> clash on existing or future systems - it's possible.
>
> So here is the problem. Keycodes in linux input are not mere
> placeholders for something that will be decided later how it is to be
> used, they are supposed to communicate intent and userspace ideally does
> not need to have any additional knowledge about where the event is
> coming from. A keyboard either internal or external sends KEY_SCREENLOCK
> and the system should lock the screen. It should not be aware that one
> device was a generic USB external keyboard while another had an internal
> sensor that recognized hovering palm making swiping motion to the right
> because a vendor decided to make it. Otherwise you have millions of
> input devices all generating unique codes and you need userspace to
> decide how to interpret data coming from each device individually.
>
> If you truly do not have a defined use case for it you have a couple
> options:
>
> - assign it KEY_RESERVED, ensure your driver allows remapping to an
>   arbitrary keycode, let user or distro assign desired keycode to it
>
> - assign KEY_PROG1 .. KEY_PROG4 - pretty much the same - leave it in the
>   hand of the user to define a shortcut in their DE to make it useful
>
>> 
>> FWIW - I wouldn't be surprised with some of the new gaming systems
>> we're seeing (Steamdeck, Legion-Go, etc), that a doubletap event on a
>> joystick might be useful to have, if the HW supports it?
>
> What would it do exactly? Once we have this answer we can define key or
> button code (although I do agree that game controller buttons are
> different from "normal" keys because they map to the geometry of the
> controller which in turn defines their commonly understood function).
>
> But in any case you would not reuse the same keycode for something that
> is supposed to invoke a configuration utility and also to let's say
> drop a flash grenade in a game.
>

Understood.

I don't see a path forward within your stated parameters. I did not realise that there were such limitations, so my apologies for wasting everybody's time, and thank you for your patience and guidance.

I will drop this patch from the series and proceed using existing defined codes only.

Hans, I'll need to rejig things a bits but I have some ideas and I think I can make it work and stay within the pdx86 tree, which will make it simpler.

Mark

