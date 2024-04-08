Return-Path: <linux-kernel+bounces-135564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2DC89C7A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518821C21463
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2A13F42D;
	Mon,  8 Apr 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="AWwPDu5/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMKeOxcs"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246D1CD21;
	Mon,  8 Apr 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588216; cv=none; b=L9vW7tkvmws6uxteFtFloRfe8wyoCcJWvH2xE/nfcryHf0aNdBe9mUkQNFAKYkl67RstvAODjEyX+Acq3raazpjzBc00pimulGZroC5N8cs9MrGPm1JTra7kyH9YzolB7L28Uy3ewr8+IcwBhIp5fW3FHh/mlWT8I8Zw7Yw7yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588216; c=relaxed/simple;
	bh=BsLAMIMjStbva84N75DgzSgJ1PObFKJZ68YVDpu0jGI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=X+QKC+dtYBqcvZ5oeXFeVI7T1Ttq3ci33bmSPAMTAFEPoy/Blot7GQ1oBRDa1UTeVxbfN0jnBVkxzxPcLzcQjToTPCsKKC8OGvJmyKu7ikyQxPNNU3SDYWK1PZFudxu92il8WV9u9Yagwo0q8lSE1nh15j5Ld6SlEVlYQnt5n+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=AWwPDu5/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMKeOxcs; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6C7A418000BE;
	Mon,  8 Apr 2024 10:56:52 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 08 Apr 2024 10:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712588211; x=1712674611; bh=MeGqRsPK4F
	4ifIoW4vFpk0vD/NLFxc1zuaV/atwBur0=; b=AWwPDu5/kyr24uHVM4uQ1TcF4c
	dlRaoPT9j3sewvdWF4MOtn7QtFHUaGcB40Ij45ZcqBh+1HeFyT4rn4Gy4LUak+Q1
	l+1Te/Al3Nwx4eiJcpLk46gXax29QyfftLh8mSkdtbOJNxYkPPkyfquC5k6V8wfv
	pCzFFkQWDHZTB5QGduj+FLhZZ7875QdsLV4DwYB2obspOyCgZVmEsT+D9qWptkkN
	XBRJS0rQMCHqUNjUaYA22+3MacZxYKK9+vhAnVbSiJzCag0RrP7NpQFC2xvvoGNC
	vKKKijGjx+GMbPlmVCR8ClruhwgkOlE3DGdsysbX6p10lzF2woZtalwO6xmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712588211; x=1712674611; bh=MeGqRsPK4F4ifIoW4vFpk0vD/NLF
	xc1zuaV/atwBur0=; b=fMKeOxcsQ7NLCpxPRD6Zq0n88uV8G4ecCumCkylg9M/4
	YKnzsThGqT8LMLz7gOKDMgjf61kheWkXv4HHaZs53iO6Qw7gzC/bgCXJimxuk+Rj
	qEm4VTE+vqoM3FalnbZy5IJ/vI05XZBArOUz7xjz8KLFju+k4orK5hL77baQ7lJO
	Xhn8/xd5TW8hEd7YawFBeLeTxv/W50L/ZcdpmbCVc1Bx6u+dcSFYMQ4ILIgaJdgf
	RdorEQrl1OUHcwK3wBsc+JOKsJC3t+aLesjk37xO5kj39iIPDfvaZrOCQYiuLhf9
	8/eniR1cHV3QwQK0amjz91R4pylTixxmRZNhulieLQ==
X-ME-Sender: <xms:swUUZofagPIBlHj2SMQeFMY-V3WH0k0F2RD8LasE798wuC8CYWPcOw>
    <xme:swUUZqNxnNMlD0IF0yidcHOksCYpb09JuE3Mr813FytFNQpzKFBU3wuX4nT4AT7W4
    Hjgf6v0Ml8_8TFzwxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:swUUZpgsWbsiDz8F8gl9PX3LJ1xtXrv3re3wv-sDUW3_O4m7Cc2ZFw>
    <xmx:swUUZt_4CxQrwv7RobF8FXWzu5AjwNvIsWOq-Z0VJT1OiHEjWkViGQ>
    <xmx:swUUZksViVYcZGfnB6Rvk0gCuJG9Txp9ZhS_gs_4wt_1paWAJVcsJA>
    <xmx:swUUZkEPii1grCxAZw6HWnCnqmLFEzySfXspD-Ce65N0UyvPITMhtQ>
    <xmx:swUUZlmQW2GMXE45buRb4_I4Hdw6wN4Pn-k-PkYLmOZrRdgkhew2AzxR>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 90F70C60097; Mon,  8 Apr 2024 10:56:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97f369ee-18b2-4e34-9e08-69329ca2193b@app.fastmail.com>
In-Reply-To: <a2237f76-dae6-4198-b393-7d0c18224205@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-4-mpearson-lenovo@squebb.ca>
 <a2237f76-dae6-4198-b393-7d0c18224205@redhat.com>
Date: Mon, 08 Apr 2024 10:56:54 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>, dmitry.torokhov@gmail.com,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Nitin Joshi1" <njoshi1@lenovo.com>, "Vishnu Sankar" <vsankar@lenovo.com>,
 "Peter Hutterer" <peter.hutterer@redhat.com>
Subject: Re: [PATCH 3/4] platform/x86: thinkpad_acpi: Support for system debug info
 hotkey
Content-Type: text/plain

Thanks Hans

On Mon, Apr 8, 2024, at 9:11 AM, Hans de Goede wrote:
> Hi,
>
> On 3/24/24 10:08 PM, Mark Pearson wrote:
>> New Lenovo platforms are adding the FN+N key to generate system debug
>> details that support can use for collecting important details on any
>> customer cases for Windows.
>> Add the infrastructure so we can do the same on Linux by generating a
>> SYS_DEBUG_INFO keycode to userspace.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Nitin Joshi <njoshi1@lenovo.com>
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 2bbb32c898e9..854ce971bde2 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -1787,6 +1787,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
>> +	TP_ACPI_HOTKEYSCAN_SYS_DEBUG_INFO = 81,
>>  
>>  	/* Hotkey keymap size */
>>  	TPACPI_HOTKEY_MAP_LEN
>> @@ -3337,6 +3338,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>>  		KEY_NOTIFICATION_CENTER,	/* Notification Center */
>>  		KEY_PICKUP_PHONE,		/* Answer incoming call */
>>  		KEY_HANGUP_PHONE,		/* Decline incoming call */
>> +		KEY_UNKNOWN,			/* AMT Toggle (event), 0x31A */
>> +		KEY_UNKNOWN, KEY_UNKNOWN,
>> +		KEY_SYS_DEBUG_INFO,             /* System debug info, 0x31D */
>>  		},
>>  	};
>>  
>
> Looking at the next patch 0x131c is TP_HKEY_EV_DOUBLETAP_TOGGLE and 0x131a is
> TP_HKEY_EV_AMT_TOGGLE based on this please change this to:
>
>   		KEY_NOTIFICATION_CENTER,	/* Notification Center */
>   		KEY_PICKUP_PHONE,		/* Answer incoming call */
>   		KEY_HANGUP_PHONE,		/* Decline incoming call */
> 		KEY_UNKNOWN,			/* TP_HKEY_EV_AMT_TOGGLE handled in driver, 0x31a */
> 		KEY_UNKNOWN,			/* ?, 0X31b */
> 		KEY_UNKNOWN,			/* TP_HKEY_EV_DOUBLETAP_TOGGLE handled in driver, 0x31c */
> 		KEY_SYS_DEBUG_INFO,             /* System debug info, 0x31d */
> 		},
>
Will do

Mark

