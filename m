Return-Path: <linux-kernel+bounces-63593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F438531F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06F9B26439
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49E56460;
	Tue, 13 Feb 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xdNZb5FN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDTl5L+J"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E355E6C;
	Tue, 13 Feb 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831083; cv=none; b=At9hQgyN+FbTjDdNquXnlZ5UZuzMxbNeLQHQ8k4poLge1Ac1q6f0g7AMVq75O05MXx7SsHZcN2f2w3H7SGM7pWx7J8uXiikuqQnqisn2oMrAwV/3NSK5yS3qgUrrZ2+St4wPaRNcJRTSKRYJ+L0d0Otak0WYwqoEDftbcHxpwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831083; c=relaxed/simple;
	bh=t7dUzixQgGgfHCE+xYRgs18If0gl9ptwlMELTWn8130=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jNi5YrooLagUY6obgElf3TFacnZ9uLjAys5yFyTWLaRhRRQUybWHVvhVx4Lvo6lX0qaZJgzOEYnV8YjKQYjLmm8wbOBqWIupYu2f3T+l0axpu0G11TprnW0dkLNsXcwiS1KGIDQDjOMrm+3j3LmoV84HFvHv0T5KVp5uIrcdW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xdNZb5FN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mDTl5L+J; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 497C31C00085;
	Tue, 13 Feb 2024 08:31:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 08:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707831079; x=1707917479; bh=1CLqAnvekW
	i/zNDdu70Gx6QdI5camKVBGuus8xrH8zA=; b=xdNZb5FNWGxs6g0/IjlAzo6Ewg
	VqlzT6dyirVa/hAWd5PDLWgo/uSQnKJrL+OC9MPRLRS4BJhfkOnCAvlqzXwHwJhQ
	X7m6gVUgWsCfASesb9P5Kc0HEnHsS2759+Hya/00npgfFN26qXoUADiPUZISdvBq
	ynv0y8SfoIQrYiHQdBUUV7Kb34Pr9nazLu9mNgqwMNHTuymH7adYVaPxb1aFh8JK
	yzgEmViMzpU0pewmSQoX2Uhj55meTkfRBxJ9L5CjhoRwkiuHNU57blrd2NNGdJXy
	eNs3SOmwslfaK4oREf2PINmJ6j2R26ArXAaNWjmMG9hhDtyOCazz16znyzYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707831079; x=1707917479; bh=1CLqAnvekWi/zNDdu70Gx6QdI5ca
	mKVBGuus8xrH8zA=; b=mDTl5L+JmD1mJuEYjZcOXxTMvaMaa3Ef5BhezVP1PmVk
	WNikl29u/WAwRo+J9tGJ+OxSOjUJsjfTuqfJ0x2WZDtx/QNuwpgdQ6KP6hWhXrcl
	6351E9W1bzzmdBQ9Je5QUF50/vuMxkvUwxFLBSCZDnl1HrP8H7wTwOE4rmyGFeuw
	f42PY3L9N9TK9vW5a6IG2RnGUALidaQ6HzmY7koKvnShut5gmjhZ96ncNqjerTcR
	zsbeH/qgDs1hMkN2fGx+kZ7FVxb5Z+3nyiT5PFASTDDGmGuTIjcK5kb5T65aCvtP
	LX3XjkeUODDTJxP2wPdifUsaIjXx/BHeQu/SqdatiA==
X-ME-Sender: <xms:Jm_LZYjhmfgC47H8TkqMFaMx3VoS1gRSES4dZyiRuxlziUiaqemKBQ>
    <xme:Jm_LZRBTeztoQz9CmYBQulMnw9uPD0qFAHAwAJADUcDq5R_gfGQrxBU2IS9sExvzS
    wApmoiUnbGTHT7gOrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Jm_LZQEWQ4oxLhgOWX3NmKwC_7Abh6478ddmWSYl6fl6nORcbPF__w>
    <xmx:Jm_LZZSwJJDaPY7SHrW1IgiPMDm3R7dLtnXv5GpKziyOcHhLAzvkGg>
    <xmx:Jm_LZVzr97J6qp9riKpgD8w7RhqlSPl7H_iqLsGmuXU5i164X3MDKg>
    <xmx:J2_LZYqQ6mRIN5SGUYH6EgmpbNTGreBRvyZ6c-FxtbHYvYE2u0885N1dzGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 86C7AB6008D; Tue, 13 Feb 2024 08:31:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a52b971-227b-4433-bdf9-b4a69a41d061@app.fastmail.com>
In-Reply-To: <87il2sy13f.wl-tiwai@suse.de>
References: <20240213101020.459183-1-arnd@kernel.org>
 <87il2sy13f.wl-tiwai@suse.de>
Date: Tue, 13 Feb 2024 14:30:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Curtis Malainey" <cujomalainey@chromium.org>,
 "Dmitry Antipov" <dmantipov@yandex.ru>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: fix function cast warnings
Content-Type: text/plain

On Tue, Feb 13, 2024, at 13:56, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 11:09:56 +0100,

>>  
>> -int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
>> -			const unsigned char *buffer, int count);
>> +int snd_rawmidi_receive(void *ptr, const void *buffer, int count);
>
> If it were only about the type of the buffer argument being a void
> pointer, it's fine.  But the substream argument should be explicitly
> typed, otherwise it's confusing for other normal call patterns.
>
> I guess the suitable fix for now would be to provide wrapper functions
> that are used for callbacks and bridge to the actual function with
> pointer cast, something like below.  Eventually we can put more const,
> but it's basically irrelevant with the warning itself.

Right, makes sense. I gave your patch a spin and it addresses the
warnings I saw in randconfig builds, so please apply that with
"Reported-by: Arnd Bergmann <arnd@arndb.de>".

     Arnd

