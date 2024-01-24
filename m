Return-Path: <linux-kernel+bounces-37615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B831E83B297
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7132B2816DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEE133412;
	Wed, 24 Jan 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AShXU97H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vlkaqg/k"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD9132C1B;
	Wed, 24 Jan 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126038; cv=none; b=F3/GERKwtJGZTo7xTXKAEIRicK4pDifaHGjgRkOa3uCHMDpvmzoezJOzpu3iZDkxhxl0xHxqjjgWXNJ5tb7N6iYJ31bIn17cGjrx/1jOkn4jTxFABlj6AN8Z7cQSf8cPIg0pU0kmFZckuAzUjGwqpW/KNMfR9DGJ5hzoY+FYbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126038; c=relaxed/simple;
	bh=27ijHhB7eO2uJXB5t5eCwVkcej/vwZZXEh3ekCd2zZw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ju9w4MjP4GXuep25eLR+n5Kk2+kSTqMnRkjF8muKMYHWqLRXLsUFYIN0Q4pGqH1uzxdIC37zlfdjbKuh5DjF1b1M9ZZF0ngoR0teQvpSIbops44gAiBVj72W/MNxOu9rMhgnkrLu43qKFLDP5vaD2DWZMyyJEyeZTb3Jb5btNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AShXU97H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vlkaqg/k; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 6C75B3200B2A;
	Wed, 24 Jan 2024 14:53:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 14:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706126034; x=1706212434; bh=trFXHQLks5
	NlQQ3Kew2ZdD97EyasR/piMwxe/G5vlME=; b=AShXU97HQHaNCL19qIfHlLIX42
	OSsEeMBQgClsIOMcrSVVUZHrQ7hJvswsGtUVocbmi7734K/9SPjpkNRtlsbYrtNM
	chJRgVcqEGvP+x3ZeK3zWUYBcc6gXjGdjEBh62YQyWR2Ds2P33G7J2igJTJlcHuJ
	7BudLl1h0iO5Sqc+/vxyDVFv0Svmhbminkgp9FmozTPuOuiZXZ76wDyqzBMtcLDc
	3hw+wpFLVA4MT3oJVRtT5DrueJGjFSyDcjnOM9n6lHV8k7WKwnMAkAPub/qpdRKy
	bZ8BEX6+u6P8Njls1y6n4KzzfNCoslucbR20S8+ybzbUbOPqtEIM4BMp6CXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706126034; x=1706212434; bh=trFXHQLks5NlQQ3Kew2ZdD97Eyas
	R/piMwxe/G5vlME=; b=Vlkaqg/kZBhLJSqC9Dx6FYX7W9MSjnIYZ0agX0rvMYXZ
	n9uk73lciVGqlM9Lq1/szLhNiSswc4gCXqstT6EvWpOvi0r0Zxif8lUDxbc8Mtrk
	5+VZiExPhKBn9Erv1Vmc0MpPIJGHWMDFfNHqJYj4lMdpBnZ0NqvpJSP6gO8qEQdf
	EtkN5kD0hnCe1TzO07NkOaHsm8c210JVazrobm64Cay93NQ2guZ0lVnvFDF5923Z
	YOjeZmQrICR+cBOrEnSRMkUKsp7tWv9+/zy3sSZa/ft3rm716oEdezwFPTEF8BOI
	RwMpeJF8Fc7VBz/VeOXYqRv6Jd1oSPw8W1kRyULFMw==
X-ME-Sender: <xms:0mqxZfMzEx_0r8Y8Vpi5oJeCR-wY6D91_VWRrZBQsRgYpByA86Mt8A>
    <xme:0mqxZZ-M02HKmPvHxf0X2jQstttZzpYQhblfOLAwjQ3jYvH1aByBaCUMP3zA-I_Sn
    ELX2iSOPm11vEpwLh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0mqxZeQRXjOKeD7UGavfe9l-dLkHtB2vp2N02MYgrXXNqIMArHVNFg>
    <xmx:0mqxZTviM97d7ZFWQM1bqLl-XrlmIm4WRY5nj2OTHmNXBFoGdL7U8A>
    <xmx:0mqxZXcZAC5-n4s8rCqBdRM-l8N0BDVyRcZfoEhS4j646h2Y4PHZ2g>
    <xmx:0mqxZfR70V_ETnyt5PmvOC7r8xRasPVLFEuTmYRR2DkuTYHolH2V9A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 958CDB6008D; Wed, 24 Jan 2024 14:53:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33255519-f9ea-48ce-8528-a8013c3e7b01@app.fastmail.com>
In-Reply-To: <2171522.irdbgypaU6@camazotz>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-9-zfigura@codeweavers.com>
 <4027ec4c-1e11-40fc-a9af-07732d7c3c1a@app.fastmail.com>
 <2171522.irdbgypaU6@camazotz>
Date: Wed, 24 Jan 2024 20:53:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [RFC PATCH 8/9] ntsync: Introduce NTSYNC_IOC_PUT_MUTEX.
Content-Type: text/plain

On Wed, Jan 24, 2024, at 19:03, Elizabeth Figura wrote:
> On Wednesday, 24 January 2024 01:42:19 CST Arnd Bergmann wrote:
>> On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
>> > @@ -738,6 +803,8 @@ static long ntsync_char_ioctl(struct file *file, 
>> > diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
>> > index 26d1b3d4847f..2e44e7e77776 100644
>> > --- a/include/uapi/linux/ntsync.h
>> > +++ b/include/uapi/linux/ntsync.h
>> > @@ -46,5 +46,7 @@ struct ntsync_wait_args {
>> >  					      struct ntsync_wait_args)
>> >  #define NTSYNC_IOC_CREATE_MUTEX		_IOWR(NTSYNC_IOC_BASE, 5, \
>> >  					      struct ntsync_mutex_args)
>> > +#define NTSYNC_IOC_PUT_MUTEX		_IOWR(NTSYNC_IOC_BASE, 6, \
>> > +					      struct ntsync_mutex_args)
>> > 
>> 
>> In your implementation, this argument is not written back to
>> user space, so I think this should be _IOW rather than than _IORW.
>> 
>> Again, no practical difference here.
>
> Hm, but there is a put_user() at the end of the function, or am I 
> missing something?

No, I was just looking at the wrong thing, your version is good.

     Arnd

