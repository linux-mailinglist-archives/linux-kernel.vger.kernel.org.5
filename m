Return-Path: <linux-kernel+bounces-136258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4303E89D205
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF10E286377
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5277F3E;
	Tue,  9 Apr 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Tv2aY7QQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ohMa2R79"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9974438
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712641039; cv=none; b=U7b2ll42Ndh+ynFTIguxmhHIX+3qFl64dM6Q7rjm8V0FBzoDs6E/skagjOv6VgnK49kk6G9awccRkRZjmdJo/pCg2JivI7AyClztt5hsmhWl0cW6+AEHefs539psGU+iao6nJ88I4+wf/NmaCIS9PlhY+vqt4y85Itb7XsSKz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712641039; c=relaxed/simple;
	bh=lTCSNVlJ6eROconCklf0lUttHmQ5Wtcp6EAz241j66g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EVZhpvaD7rOGZS7S1UNqN/ELqjpDVEIqV/oSPXcIn8AXWGOH67U2mAOY3WXhgT4/x5+u/pVGdVup8Ieyu4vtgZtrfc0F85TTPa/XuRUABmm4zcVDzJdBSI/iqm1VMjX8p3O+/GUa9NAxRSQag/UCH9GzZ60Bz68Sebo/21vTFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Tv2aY7QQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ohMa2R79; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 13BFB1C000CF;
	Tue,  9 Apr 2024 01:37:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 01:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712641035; x=1712727435; bh=N2u6h8moDB
	/fTrACtRe+4SheoESaX066xDK/8RKTrfw=; b=Tv2aY7QQAm99/pz2q0eveh7JGm
	EfuSYzJeR2QJa0vb6P9iDs/oHdeTyb9Uuy8oyOyVuT0a9TSV4dyHIwYSImGxUmmj
	Ui8Rpk6S1W2zaVzAZAspGRz6HBlGQCGjh05+kDjVSxpa13UlZDVNWQjnkS/cXhNx
	QIq7n8JB3QZdtsDVYIFAewpZXEX5H8w6ZWK2dUbvP9cNA+6C+XS2wQwkLjOcChni
	mooq3eElINOpKJl7xCxmkRiYKPYzkIyqvi9lQzP0pnhk0k9nb0mqnuUnd2AFat+f
	vBJb8Zxbg5Euo7f4POuAZotU3tUkAbWamJ/D8BsUl3MgSGugtqbcfiegXSTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712641035; x=1712727435; bh=N2u6h8moDB/fTrACtRe+4SheoESa
	X066xDK/8RKTrfw=; b=ohMa2R79u15cVtS+Hp9UcT9qCYwDCzkdSZwD64PHuxLL
	ogfPbSzwStwmmxM//S/G2juvf5lWvwnAiWTGPUyF58LgwDxXagQ+6teWjMMgreAH
	81Wf0T5OGNV5+N6kxifl7hF7kc9pkSS5pqvpDzxqhaFWUduPi72YNzY62BGJRyd7
	vujMGnTL6XUnJi1gzKXywDTqLbHwRygNJwLx+QjaA/lrguWL1NLORZvOkB8MIM5L
	RhM6urcMsOQ3DpdJRBAgQi7yhMcteT9O7WnrQBxXyqSQj2e2dNEp8UDOOKr4xjyT
	VymgXEXID6/wtD4YUl5G6TXQiY6geTb1A1NXrkfLqQ==
X-ME-Sender: <xms:CtQUZsFfSUICkWocoB5zC5-PrQnhTJahJ5iiY4tMAfy_fZ2-uRlRlw>
    <xme:CtQUZlVHJxGjeCMy1KEcuEUnYiervNbI-1IGG4NdDtnHwfsydE1xjT-vRYM6MiBFs
    sicN3teljXe8Rq6Vms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:C9QUZmIVjAcut8WPutq21WbfrWS5g59akM0KpCDBxcR4f1j_WwHDuQ>
    <xmx:C9QUZuGSFgkVo1yMG-B7uF4Z3at6sW-0rUUrfZv7_il-cF5ktOreYw>
    <xmx:C9QUZiV0Qui6M0VVg7sG5z5eBwPqb_qGfmtGfDq0kAZpuY0DwdPGeA>
    <xmx:C9QUZhNOp0EPBYCG-SsWcla1g_pZ_qgOaCHD3toiynA_CaWONsQHCg>
    <xmx:C9QUZkdeeGcEaKfoj5sJUbzxdTjNanxBMunWJ02EKKoa2dTxParFfkPj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DDC0AB6008D; Tue,  9 Apr 2024 01:37:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5740321-455e-4939-8a94-72c01e4c09f3@app.fastmail.com>
In-Reply-To: 
 <wb5h2syqmxpoxmajwiiyqvlkyojjsjql5xpfmris6djegtqzya@6xfio4dmqjdp>
References: <20240408194821.3183462-1-arnd@kernel.org>
 <wb5h2syqmxpoxmajwiiyqvlkyojjsjql5xpfmris6djegtqzya@6xfio4dmqjdp>
Date: Tue, 09 Apr 2024 07:34:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v2] staging: rts5208: replace weird strncpy() with memcpy()
Content-Type: text/plain

On Mon, Apr 8, 2024, at 22:28, Justin Stitt wrote:
> On Mon, Apr 08, 2024 at 09:48:09PM +0200, Arnd Bergmann wrote:

>> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>>  
>>  	if (sendbytes > 8) {
>>  		memcpy(buf, inquiry_buf, 8);
>> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
>> +		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);
>
> I must say I am not the biggest fan of manual string management with raw
> pointer offsets. I wonder if scnprintf() could achieve your goal here of
> combining inquiry_buf with inquiry_string into buf (perhaps utilizing
> %.*s format specifier).

scnprintf() would be wrong here, since it's not actually a string
but a SCSI HW data structure with both binary and ASCII members
and no NUL termination. It's supposed to be padded with spaces.

> With that being said, I am just a casual reader of this code and I
> really don't know much about the expected behavior of `buf`
> (NUL-terminated, NUL-padded, etc) or even what the next line buf[4]=0x33
> does.

I believe this sets the length of the buffer to 51 bytes when
pro_formatter_flag is set, overriding the 0x1f (31 bytes) for the
normal length.

The root of the problem here is that the driver emulates a SCSI
command set on a card reader for both SD cards and memory sticks
instead of using the existing abstractions from
drivers/{mmc,memstick}.

Apparently drivers/misc/cardreader/rtsx_pcr.c does this the
right way for all later devices (rts5209 and up) but is
not compatible with this variant of the hardware.

    Arnd

