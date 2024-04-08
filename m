Return-Path: <linux-kernel+bounces-135867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B819C89CC53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42511C21D26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED814533E;
	Mon,  8 Apr 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bABV0/JD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9nHUdfU"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D1143C59
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604054; cv=none; b=S8eGkTrkhK/9uo0EwnLtyX2xB7qjGiztXk52u9Nr4zJ7zuGXmiS/xBatDrZYgalJdYLz5mEtdJa8sOCmeD7V3hmHg/v7jLjxBDSAbADiIfaTIjOpbsuNHUYR+Hau3HgQwJSoshMcDmwXtqROjoMPEJD4FLyCueJtRpnhYmOORPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604054; c=relaxed/simple;
	bh=l/9NaRSN7Lj0BWe71GtBBKD+0KLY6lT3ekZ1kX65dMg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HQWCoUrLs0Qei/zHRgo7nQKpC9uJ0KiFsLIbu9j2oXrCox69/jerbFYVgxJHR/Nky5BvvlIQbyIyPQfz39HTvuW6C56tCseagzoCGzZSzAx+PWxb1YKwr6x9P0KoMjCD/ww3E6x4JuHx139DK+G6Df7YRK1th7prvsokxBmyYqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bABV0/JD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9nHUdfU; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7DB1518000F9;
	Mon,  8 Apr 2024 15:20:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 15:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712604050; x=1712690450; bh=CJdJSJ9hqf
	ff0ogua6mplEDET1TsT3kx5yGSs3bTW+g=; b=bABV0/JDgEHSMqz3QJ6eUm4zmY
	cO4nxZd3AX7G+X+FtEE/wdy/Ha+pX3M9AXJfz0frw9vvDIIrMnmwIT1mhojc3pjW
	AUVFJohUIVIylRDfggSTq2DnL0anFxM24aKDfMCF9GFC6Y3YNVPyUc2J6vHaZ42j
	a9lIkbqyVFWjmP9SQzpUjKvNk9W1nyVl7SHcBgtAIFpKA5n8wP8g9wQcJjc3dHcC
	D3vQ407kQ+IFJFySLotyY7lMcM85DaNhV1vvG4yv/c4x4l8fiGzDR8AxUTh22B1c
	PUqan9IkfH042oSceCnGz4iP4GUhW5H7q3dAHu286uZJ/Qqe/ko8lJ1fYotA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712604050; x=1712690450; bh=CJdJSJ9hqfff0ogua6mplEDET1Ts
	T3kx5yGSs3bTW+g=; b=s9nHUdfUV2i2cnbzc9yXOsWJlzcPsi5bbYfAE7F9zVcT
	lZAK6m83S7BgMs6udpCelvzXXsg5l7qWyiT9FaSjV5pu/hTiAWpJU/Te4p5PNURL
	tUVmjaIfhl8J8FKIvwWMEB3XFQhYpQ4T6n6GS5SMmW1feapFfRy4NF+gSc8nAbSF
	93untM5v7bo1b3+EHGhaDzaDkScG4UVX0RMyjGZLflfb6EEMcX5c4hpcUJvptqem
	nSP0DG8RuSBQ0WXi6xUHZOcvwaW1Q2GtH8PMDsXoCX4tOceKOH73+tNtP/IjeQ+S
	jbWitDWSCC2gxia1X5dSLN18LQkPk8xBwvOFDCYj+g==
X-ME-Sender: <xms:kUMUZmKeRu0TNtmb8G46MgD2CzdCl6tXvU3csePhL_OuyRO-fu7gDQ>
    <xme:kUMUZuKXq79VdFTT6twyknTtAVwhO2oKi47krCVOl6I0MxZI01-CLcfjptP2RdiaU
    U4svhNzz4cjU5rhQeM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kUMUZmsPPb50_gHeAXSqsrid4zYpZtsPk91ONqdkKZL99Jn97DxxDg>
    <xmx:kUMUZrYeYSHaUlBRFswa3lqib_bIRHrunfVFlPwphoIhb7oT4wr5Fw>
    <xmx:kUMUZtZb_dci5OgeGDYn8Fke1Jayyoc10Zffe52Ue-lGNiyPGKTijQ>
    <xmx:kUMUZnD6kFUUS1k8SapoBi8xd1-EzPT-YPekKu6LCo-M_9GpEFjYhA>
    <xmx:kUMUZiNgAPxm9Rqc-Y-rvHL4EfWM8ipZgCVKaZTDSmjY-KLSU_zARDIj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8F766B6008F; Mon,  8 Apr 2024 15:20:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <88009872-377b-4155-aceb-88d36f4a44e4@app.fastmail.com>
In-Reply-To: <948ab982-cb4d-46d4-a3c4-cc1c6369eb92@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-4-arnd@kernel.org>
 <695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain>
 <d8ee72ec-c16f-443a-b9c1-555dcbc69182@app.fastmail.com>
 <948ab982-cb4d-46d4-a3c4-cc1c6369eb92@moroto.mountain>
Date: Mon, 08 Apr 2024 21:20:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Kees Cook" <keescook@chromium.org>, "Daniel Micay" <danielmicay@gmail.com>,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH 03/11] staging: replace weird strncpy() with memcpy()
Content-Type: text/plain

On Mon, Apr 8, 2024, at 17:59, Dan Carpenter wrote:
> On Mon, Apr 08, 2024 at 04:45:55PM +0200, Arnd Bergmann wrote:
>> On Thu, Mar 28, 2024, at 17:35, Dan Carpenter wrote:
>> >>  	if (sendbytes > 8) {
>> >>  		memcpy(buf, inquiry_buf, 8);
>> >> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
>> >> +		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);
>> >
>> > I think your math is off.  The string is 29 characters + NUL.  So it
>> > should be "min(sendbytes, 38) - 8".  You're chopping off the space and
>> > the NUL terminator.
>> >
>> > This only affects pro_formatter_flag code...
>> 
>> The extra two bytes were clearly a mistake in the original version
>> at the time it got added to drivers/staging. Note how the code
>> immediately below it would overwrite the space and NUL byte again:
>> 
>>         if (pro_formatter_flag) {
>>                 if (sendbytes > 36)
>>                         memcpy(buf + 36, formatter_inquiry_str, sendbytes - 36);
>>         }
>> 
>
> Ah.  Okay.  Fair enough.
>
> I do think this code is really suspect...  What is the point of allowing
> sendbytes < 36?  But that's not related to your patch.

As far as I can tell, the driver tries to emulate the behavior
or normal scsi commands that could be issued from userspace through
SGIO with a short length. drivers/ata/libata-scsi.c has code to
handle INQUIRY as well that is somewhat similar but also different
enough that I don't trust the rts5208 version of it.

On a separate note, I just noticed that I forgot to put
the driver name into the subject line, which I've fixed
up for v2 as well now.

    Arnd

