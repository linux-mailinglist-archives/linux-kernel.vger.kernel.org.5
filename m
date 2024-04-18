Return-Path: <linux-kernel+bounces-150053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753FA8A99B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B271281AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0C15F411;
	Thu, 18 Apr 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ldN9XJZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vh4wuoky"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45E15E7E7;
	Thu, 18 Apr 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443031; cv=none; b=R7GMlbRfkAj//0EFFHOZH8m98/OLKvfsbC6OFyZqVII4xD1N88ZTfZ/Du4jkFJpRpqFXd0hJRlMpZwC7z22okwSOu8fL2c7NcXaQct9IfzinVDCM4iaj722k2mYOhzRJldNo+1QVI1UZWLeo0YT8UYyCPFQLC/l3ZKHz35vInm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443031; c=relaxed/simple;
	bh=CW+ZkdqeMy+Gcnrm9/xb2jWnC0SqwGr/GAHMdTk3Kmc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LNLgk1nUGs9BDJ0qjniTMLQy/CT6sQ3p0alNFvSU4VYtcarzJmX+blHH1u1cUtgsvGlXNK38HkGmC3yOQOYLVx0XqWyBwzjAIhzjdb5w1i21IiGnPIPICtJAyXbtI7czN2rqdGTiBZACmlAjDcWPFVMq38g4uu2wqpXPS/Vy5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ldN9XJZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vh4wuoky; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id BB1E318001A3;
	Thu, 18 Apr 2024 08:23:47 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Thu, 18 Apr 2024 08:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1713443027; x=1713529427; bh=Ku9n4CtW+a
	96ju08gyViB+v8W7/g00oO3k3aplYVJ0E=; b=ldN9XJZi8g5C7BvQTJ2ERKhwqt
	ZkZUAHQgaWyxHDMCfD20MYO7I3md2CZyEW4t4x0BkBiyvngHia5qKIMhbCzK2qql
	O1k5MjzaDJImQCITAtUGd534740UcPiI7jVN36X/irtGijjUlLaysTRJuPvTRCjc
	nHlf0hhQECIuLkNAfCpzUlTDbxS0MBeJSsQym6hEhopVNpn1WvEF0Xdu4VsnFX+k
	Vfmjwn0yJlUT0Vp1JKxrW+nzx2vQFZpa+6u6tJjkPsKRrjpwFkrT6axZOuIfV8F/
	MKRgkVkoXeUcR9obRQ1U1kPRoUcOuiRbCciIkcrHpF3lQEw/Px7rHPFjd6QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713443027; x=1713529427; bh=Ku9n4CtW+a96ju08gyViB+v8W7/g
	00oO3k3aplYVJ0E=; b=Vh4wuokyMg9jrF/4RxLHf/QfW94Pz10TAsrHwP6cnTBn
	wic9F2Mic+GtLTNkpXY34xQfKOev8x5HXjQcYKzdhj27urzqzemlR+CivQSIioDh
	1m9AbjcRfvdIkNi1E6s9Nmis+Hoth+a5IO0y8I68d+1iw042DysGCFVrUo9oeYjn
	6/LjIohpIEcq04YKrMkrza3Dwue8iF8nMtwgPELAbbJb3+/EE4qdMhyQXw6O2VGo
	ejlOtBSlrzW3jSh879pirw+ze3fPsjq+l6dsYo+TercxC6VLnLJsDV14/JkTu6NE
	LnSZ0JgDvL9MDdE4MIanLETZJW0PK6WEH2p/kO17xg==
X-ME-Sender: <xms:0hAhZr15_2WWwS4UaEjGdYycNHw4hyLevagG1RII9cBz0xTG7bm7JQ>
    <xme:0hAhZqG_WF1K63Sbk9dF9R5kaA30o84dWidAeIq5Erw_iaNXNVxG6eo6BZX_gUs6t
    AtvHl38VzLrqTzIyBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:0hAhZr6VwLi-cJHYY508U-ABMdYz8x2XdotuhxjokEYbGp-9u2nzbA>
    <xmx:0hAhZg3ik8QeEoUAZHlwc0CYpahtJK6v9E9XHQiT43IjTj8nhUWZ4A>
    <xmx:0hAhZuGxTnY1Rw-NVP9SMMAULkxDlkN-Qf78vy1-001oxveALjTtZQ>
    <xmx:0hAhZh9_pK2fai9sW6wthgXItVxHRU45KyyLfE6CegQpQg1a2cyAFQ>
    <xmx:0xAhZhCgSXx1qVWsezvEvDn0hwp3sZmcyTwj0TAmAAv-_uRwXHl3DBOF>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 85BA8C60098; Thu, 18 Apr 2024 08:23:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0917e5bc-a198-4aa8-812e-31434408e78d@app.fastmail.com>
In-Reply-To: <76d92fdc-ad0a-40a2-9e1b-d550f8e07267@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
 <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
 <98082080-0fcf-470f-afa5-76ec2bbffee7@redhat.com>
 <55ded7c3-fbc5-4fa5-8b63-da4d7aa4966c@redhat.com>
 <a7f7d94a-f1c8-4d6a-9c65-b5de59b9f7c0@app.fastmail.com>
 <76d92fdc-ad0a-40a2-9e1b-d550f8e07267@redhat.com>
Date: Thu, 18 Apr 2024 08:24:40 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Nitin Joshi1" <njoshi1@lenovo.com>,
 "Vishnu Sankar" <vsankar@lenovo.com>,
 "Peter Hutterer" <peter.hutterer@redhat.com>,
 "Vishnu Sankar" <vishnuocv@gmail.com>
Subject: Re: [PATCH v2 2/4] platform/x86: thinkpad_acpi: Support for trackpoint
 doubletap
Content-Type: text/plain

Hi Hans,

On Thu, Apr 18, 2024, at 7:34 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 4/18/24 1:57 AM, Mark Pearson wrote:
>> Hi Hans,
>> 
>> On Wed, Apr 17, 2024, at 4:06 PM, Hans de Goede wrote:
>>> Hi Mark,
>>>
>>> On 4/17/24 9:39 PM, Hans de Goede wrote:
>>>> Hi Mark,
>>>>
>>>> Thank you for the new version of this series, overall this looks good,
>>>> one small remark below.
>>>>
>>>> On 4/17/24 7:31 PM, Mark Pearson wrote:
>>>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>>>>> This handles the doubletap event and sends the KEY_PROG1 event to
>>>>> userspace.
>>>>>
>>>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>  - Use KEY_PROG1 instead of KEY_DOUBLETAP as input maintainer doesn't
>>>>>    want new un-specific key codes added.
>>>>>  - Add doubletap to hotkey scan code table and use existing hotkey
>>>>>    functionality.
>>>>>  - Tested using evtest, and then gnome settings to configure a custom shortcut
>>>>>    to launch an application.
>>>>>
>>>>>  drivers/platform/x86/thinkpad_acpi.c | 18 ++++++++++++++++++
>>>>>  1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>>>> index 3b48d893280f..6d04d45e8d45 100644
>>>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>>>> @@ -232,6 +232,9 @@ enum tpacpi_hkey_event_t {
>>>>>  
>>>>>  	/* Misc */
>>>>>  	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
>>>>> +
>>>>> +	/* Misc2 */
>>>>> +	TP_HKEY_EV_TRACK_DOUBLETAP      = 0x8036, /* trackpoint doubletap */
>>>>>  };
>>>>>  
>>>>>  /****************************************************************************
>>>>> @@ -1786,6 +1789,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>>>>>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>>>>>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>>>>>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
>>>>
>>>> I understand why you've done this but I think this needs a comment,
>>>> something like:
>>>>
>>>>         /*
>>>>          * For TP_HKEY_EV_TRACK_DOUBLETAP, unlike the codes above which map to:
>>>>          * (hkey_event - 0x1300) + TP_ACPI_HOTKEYSCAN_EXTENDED_START, this is
>>>>          * hardcoded for TP_HKEY_EV_TRACK_DOUBLETAP handling. Therefor this must
>>>>          * always be the last entry (after any 0x1300-0x13ff entries).
>>>>          */
>>>> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
>>>
>>> Ugh, actually this will not work becuuse we want hotkeyscancodes to be stable
>>> because these are userspace API since they can be remapped using hwdb so we
>>> cannot have the hotkeyscancode changing when new 0x1300-0x13ff range entries
>>> get added.
>>>
>>> So we need to either grow the table a lot and reserve a whole bunch of space
>>> for future 0x13xx - 0x13ff codes or maybe something like this:
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
>>> b/drivers/platform/x86/thinkpad_acpi.c
>>> index 771aaa7ae4cf..af3279889ecc 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -1742,7 +1742,12 @@ enum {	/* hot key scan codes (derived from ACPI 
>>> DSDT) */
>>>  	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
>>>  	TP_ACPI_HOTKEYSCAN_MUTE,
>>>  	TP_ACPI_HOTKEYSCAN_THINKPAD,
>>> -	TP_ACPI_HOTKEYSCAN_UNK1,
>>> +	/*
>>> +	 * Note this gets send both on 0x1019 and on 
>>> TP_HKEY_EV_TRACK_DOUBLETAP
>>> +	 * hotkey-events. 0x1019 events have never been seen on any actual hw
>>> +	 * and a scancode is needed for the special 0x8036 doubletap 
>>> hotkey-event.
>>> +	 */
>>> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
>>>  	TP_ACPI_HOTKEYSCAN_UNK2,
>>>  	TP_ACPI_HOTKEYSCAN_UNK3,
>>>  	TP_ACPI_HOTKEYSCAN_UNK4,
>>>
>>> or just hardcode KEY_PROG1 like your previous patch does, but I'm not
>>> a fan of that because of loosing hwdb remapping functionality for this
>>> "key" then.
>>>
>>> Note I'm open to other suggestions.
>>>
>> Oh...I hadn't thought of that impact. That's not great :(
>> 
>> I have an idea, but want to prototype it to see if it works out or not. Will update once I've had a chance to play with it.
>
> Thinking more about this I just realized that the input subsystem
> already has a mechanism for dealing with scancode ranges with
> (big) holes in them in the form of linux/input/sparse-keymap.h .
>
> I think that what needs to be done is convert the existing code
> to use sparse-keymap, keeping the mapping of the "MHKP"
> returned hkey codes to internal TP_ACPI_HOTKEYSCAN_* values
> for currently supported "MHKP" hkey codes for compatibility
> and then for new codes just directly map them in the sparse map
> aka the struct key_entry table. After converting the existing code
> to use sparse-keymap, then for the new events we would simply add:
>
>
> 	{ KE_KEY, 0x131d, { KEY_VENDOR} }, /* Fn + N, system debug info */
> 	{ KE_KEY, 0x8036, { KEY_PROG1 } }, /* Trackpoint doubletap */
>
> entries to the table without needing to define intermediate
> TP_ACPI_HOTKEYSCAN_* values for these.
>

Ah! I didn't know about sparse-keymap but it looks similar to what I was thinking and played with a bit last night. Agreed using existing infrastructure is better.

Only things I'd flag is that:
 - It did look like it would be useful to identify keys that the driver handles (there aren't many but a few). Maybe one of the other key types can help handle that?
 - There are also some keys that use the tpacpi_input_send_key_masked that might need some special consideration.

> I already have somewhat of a design for this in my head and I really
> believe this is the way forward as it uses existing kernel infra
> and it will avoid hitting this problem again when some other new
> "MHKP" hkey codes show up.
>
> I plan to start working on implementing conversion of the existing
> code to use sparse-keymap, which should result in a nice cleanup
> after lunch and I hope to have something for you to test no later
> then next Tuesday.
>

That would be amazing - do let me know if there is anything I can help with. Agreed this will help clean up a bunch of the keycode handling :)

Mark


