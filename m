Return-Path: <linux-kernel+bounces-85234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94186B298
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CF11C24241
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8DC15B998;
	Wed, 28 Feb 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Gs1v+yG/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wnlbkg93"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9315B96D;
	Wed, 28 Feb 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132660; cv=none; b=NDYI+iX4/LFAXwcwBZkbuQDa8Q0GW6gEX9yqIh+oHcjbCDirV6QmEofcDolxVP1pN1NBGiu/7l7zV2E5Mu+lKlw/rpNdBtisErIYo8lyMqE8CS/DEOvBop0S3c1w2Vo4fY8ECZ/yVRxsCGG33Ab+Rj0vk2EjGFaLwE9MxQCnk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132660; c=relaxed/simple;
	bh=9tGXBwKFGJZGSPR//Bsv4YEYrGJHk4BY+p5e8O6rcok=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UR/bYnPnvjIXqy7P7yC47ZfA/yS04+4gW9OosJaoSojdN6uy86JoxB11mZ5Gjb2q9h54/bP+k4HcTGOJGUcMPtQmXHCbL01DbgSIB3NYvh1sDQBlfYrbXceDCDkWxfQrKR0OZm3a6hTgAiiZDNxhGtR40gk77nc6u/qCaCaSelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Gs1v+yG/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wnlbkg93; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2D21E13800C7;
	Wed, 28 Feb 2024 10:04:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 28 Feb 2024 10:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709132658; x=1709219058; bh=P2H2+x5x0F
	o5gwusq3oIdtZV3HYY8iYFn/h5UuumAQI=; b=Gs1v+yG/57GNqgyWOk02TVwS9X
	v7HxGuSp15n0B1bjvZNlSmQ9avtro5BxFQYW1edFDDu8AMBPTV0DyBND1J7tsg/F
	d4eP3wLPfYm1HWPGpfYi/1KKFLODAfVMTPFCMS3C+LaG0il3+pb9syBaJinB/qxF
	w+HaocebKVXAjoWllypjyyith5zcuz6p2W1CRgDi3+M682S48TO36D4iISbCYKlj
	IuaUj0biKbttHIdc0+AHnrS+RVQOHAHf8sLozRJRM7uH5ODuKmqS1/klPlAJE1ES
	dv3UHQFTVFUHvodQcS55/4UsTYmLh2zUQ0Oh5VMY3zFXn0BLGzrsM6MXXS7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709132658; x=1709219058; bh=P2H2+x5x0Fo5gwusq3oIdtZV3HYY
	8iYFn/h5UuumAQI=; b=Wnlbkg93pqFgknqadoHyLV2YZn4aEm1Eh6y9yu13w9IJ
	YeqSH9F0BgZU1oVk0sk1IewiAK18VbM1338LrX1NMlUWG9WkoWCM18YUP9GB1z8U
	DavlmF4qousqRhILb1/H9Bc0AS2agWzdkcrptuF6NAtHMzZUU+vAq3fahealu2HH
	mA1nYoJ1GLfbR+rCeESMeT5AsvdcXs+3LkqevDnZfKFh/ZR/dywx62Fa9L5bz5gU
	BFXX2jS3EeDGQOyPD63wMmD//9wXQ/WPx0rRtJwg3zLhiBdT6k20KGdu7Ea48nZr
	2+TXI2aFDNfSimKG4yC/tGqB6IXohZbieyO0pk2hvw==
X-ME-Sender: <xms:cUvfZRj_DnPDEPQpUcno0JKfEvp4Ln15wVTYk8SSXZ97OwES75JjxA>
    <xme:cUvfZWBJqLghLk5YvWAq5hsr_q1q9UcV4mTtQmx42TbspnmTLMYvLm2tJVxR5ThHp
    -ZBQyOaA3IK9IsaZPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cUvfZRHWc61MGTeSXfJztwB3ixUjPkFVhTTIAMAOQscudotNquWSXw>
    <xmx:cUvfZWTXNEcXeFHRn8zyEgNnb9VGAbS--bkteVhro2mgtHg_GlD1Bw>
    <xmx:cUvfZexRd09R6bU05A0oPCxbXBIDMKBq-LwfRZHYScqNxFptXBE0kQ>
    <xmx:ckvfZQ6oeYyYrfipWdqbz0F0WX_L8lFHsWji5GvL6hlXlzJxmbOGpA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4B00AB6008F; Wed, 28 Feb 2024 10:04:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com>
In-Reply-To: <87msrkhcz6.wl-tiwai@suse.de>
References: <20240228140152.1824901-1-arnd@kernel.org>
 <87msrkhcz6.wl-tiwai@suse.de>
Date: Wed, 28 Feb 2024 16:03:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Kees Cook" <keescook@chromium.org>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: asihpi: work around clang-17+ false positive fortify-string
 warning
Content-Type: text/plain

On Wed, Feb 28, 2024, at 15:37, Takashi Iwai wrote:
> On Wed, 28 Feb 2024 15:01:45 +0100,
> Arnd Bergmann wrote:
>> 
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> One of the memory copies in this driver triggers a warning about a
>> possible out of range access:
>> 
>> In file included from /home/arnd/arm-soc/sound/pci/asihpi/hpimsgx.c:13:
>> /home/arnd/arm-soc/include/linux/fortify-string.h:553:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>>   553 |                         __write_overflow_field(p_size_field, size);
>>       |                         ^
>
> Hmm, I can't see the relevance of those messages with the code you
> touched.  Do you have more info?

Not much. The warning is caused by this line:

        memcpy(&rESP_HPI_ADAPTER_OPEN[adapter], &hr,
                sizeof(rESP_HPI_ADAPTER_OPEN[0]));

rESP_HPI_ADAPTER_OPEN[] is a global array with a fixed
length of 20 elements, and 'adapter' is a 16-bit index
into that array. The warning is intended to trigger when
there is a code path that will overflow, but it normally
warns only if there is a known value range that the
variable can take, not for an unrestricted index.

My first thought was that clang warns about it here because
the 'u16 adapter' declaration limits the index to something
smaller than an 'int' or 'long', but changing the type
did not get rid of the warning.

>> Adding a range check avoids the problem, though I don't quite see
>> why it warns in the first place if clang has no knowledge of the
>> actual range of the type, or why I never saw the warning in previous
>> randconfig tests.
>
> It's indeed puzzling.  If it's really about adapter_prepare() call,
> the caller is only HPIMSGX__init(), and there is already an assignment
> with that index value beforehand:
>   hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;
>
> and this array is also the size of HPI_MAX_ADAPTERS.  That is, the
> same check should have caught here...

The fortified-string warning only triggers for string.h operations
(memset, memcpy, memcmp, strn*...), not for a direct assignment.

      Arnd

