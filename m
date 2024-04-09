Return-Path: <linux-kernel+bounces-136028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2C89CF1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A372845CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9C28376;
	Tue,  9 Apr 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="onb6kH+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hx8VlIy2"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079476FCC;
	Tue,  9 Apr 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620832; cv=none; b=pCki/npEAs3cQeDe3ys4qQud0RcU4qpk0FmdYXXQL7Uw47cp96TTRNwv5tEJTSe2cgoBPWbotRzOVFddYJu4hE5TCWzAjwBawNrvpS9pfsTtbd/eI2uKqUjSF5rcxo5JqaoS8bpLxhW2xWkGvdhZA4nRpMwkP7qiFoSq7FU08BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620832; c=relaxed/simple;
	bh=YLbAEexYffOfuWNkm4tRuuW0cy32tPBJSJ56rXHioTc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=U+3ypuC0QY1h7V7OCxbz++S3F+GbpItdV45Gc/2ppRjhMnfIbE4ssq5/gGamNJievyuqryJIk+I5gVJZVMO6AHCy8nICTK5jhfH3C/gSds2ehNltW1jfZXtzMMGoXWiF/cp02r2b/d2EQZroVwoTQGSGcedLjXb7w4ZPW1WuuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=onb6kH+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hx8VlIy2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F295C114012F;
	Mon,  8 Apr 2024 20:00:28 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 08 Apr 2024 20:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712620828; x=1712707228; bh=3jJTrn3M9P
	nPBPpdaXwd3Dwyudp0ERNih8NQ9xLiPv0=; b=onb6kH+/eoNGbV/QZHdUzkd+ZE
	7b92FM70Gc8HQOO5KN5/wQt8UVCF3TR7lGWPPBPzrlslu12hH27T0Kke/uQCNmOO
	C80pO6G6ag0ouBlWv2PFBT6b3QaiCYAk2sJrILENZn85+ndrpyXaHAb7iJESkk+W
	Mlg5hSsRwMYPBpXJNEiVCocogyFj0hJTfBremmT82x23pZMHwjZtIl8FaogA4fWI
	phgkC8P/jnH4wGCGbtEUSHQ8GIhVPVIFfYJWHjUdv7mJpr1RWUAgEfc636ueGfqu
	3H7yjp5J7+9WtrFK1Gypdi2yEN4DlzXivFjDHded2YAWubyuYqZ49/sAz/lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712620828; x=1712707228; bh=3jJTrn3M9PnPBPpdaXwd3Dwyudp0
	ERNih8NQ9xLiPv0=; b=hx8VlIy2mYvNIWumG6XMu+XCDCrmaqTjFNO3ItLMYlH4
	XhNzNJHaUGwIXQAczHTbvR6SMcBuoiWvsdqJ6X321w5jmxodYaoVlLD/SiTTgW4l
	l7EwrN/S8KtAA2D6GamAS5HZR56ZbeJgjkXipOKL+MKrn1E3o84oqiOsL86Ibah5
	nRdozI2+YMOHLObElsE+AOU8rL+r0Zww02w41mHXmDlTowUaq4+NchDbRZBXTSJ0
	1OcRUXyr5WoKSQosBm3+5uhgdNTEaazocOF++e2zNmqRIxFXFcn8dGY4X5/QWgfz
	yYkSDwXov70TIRT6AGunumJJGsrMwc2A5o5iWV2Gxg==
X-ME-Sender: <xms:HIUUZmYKrqfu5if1nxPNdDOv8wW5Cp7Qx57uv0FJ6kl3zkke0s6czQ>
    <xme:HIUUZpYtcBRddWDF_3c5pEgrTQ44w56sh2kkrcRBnWxqiNU8V6j8SeYhMvKXeCC0O
    knx9i2JCfSPS1qri_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:HIUUZg-FYI6_bB9Dkfd5Y-zkDTzr26pyv5cki8FoZWxZoaSlbSutqA>
    <xmx:HIUUZoqNW0dzoT03O4jV4AzABptbAQP8wjtzoD_YIc0ep72NybdItA>
    <xmx:HIUUZhoEoQa6gSgnE9Ade_-W6tRH7gMTP9gaxnCGGuVQQStyNLUCHA>
    <xmx:HIUUZmS3HFEwfiodwz5E_bMWdXaAzAyshL2UNJhyT0kkaUf9ZahNbw>
    <xmx:HIUUZujQGB0JJwgtnhiysPEdZVXZWRZHrlba0fAFZ-stgnDaZrZQdD4Z>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4842EC60097; Mon,  8 Apr 2024 20:00:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c6427b27-3c9d-4aa4-abfa-c3588b5d9a42@app.fastmail.com>
In-Reply-To: <ZhR-WPx7dgKxziMb@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
Date: Mon, 08 Apr 2024 20:00:30 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>,
 "Peter Hutterer" <peter.hutterer@redhat.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Content-Type: text/plain

Hi Dmitry

On Mon, Apr 8, 2024, at 7:31 PM, Dmitry Torokhov wrote:
> Hi Mark,
>
> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>> Add support for new input events on Lenovo laptops that need exporting to
>> user space.
>> 
>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>> Add a new keycode to allow this to be used by userspace.
>
> What is the intended meaning of this keycode? How does it differ from
> the driver sending BTN_LEFT press/release twice?

Double tapping on the trackpoint is a unique event - it's not the same as BTN_LEFT twice. The BIOS will send a new ACPI event for it and it's not meant to be the same as mouse button clicks.

For example, on Windows this launches a utility that let's you do various configurations on your laptop (some Lenovo specific), but that's not available on Linux (yet). We did want to make it flexible in this implementation so users could use it for whatever was useful to them.

>> 
>> Lenovo support is using FN+N with Windows to collect needed details for
>> support cases. Add a keycode so that we'll be able to provide similar
>> support on Linux.
>
> Is there a userspace consumer for this?

There isn't yet, though we would like to implement something, and do plan to. 
We still have to work through the details of the best way to do this, and if it's Lenovo specific, or (probably better) something generic.

I don't have as much knowledge on the user-space side development, and my experience is it tends to move a bit slower for getting things implemented. We thought we'd get the framework in, so it's available, and then work with user-space folk to deliver a solution in a suitable manner.
Ultimately this is something we'll need in our Linux preloads and the aim is to make it easier for Linux users to get help from our support team (not always the easiest currently).
I don't know if other vendors have something similar, but I wouldn't be surprised if this could be re-used in other cases so I hope it's not Lenovo specific. It felt like it would be useful functionality to have :)

Mark

