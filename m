Return-Path: <linux-kernel+bounces-85431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587E86B5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DC61C229FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9B12F38F;
	Wed, 28 Feb 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="en9o0nri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgYaz9Ds"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A823FBB2;
	Wed, 28 Feb 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141017; cv=none; b=KGiElUVrBKuX+BPn9cvAeD/quA737i2e+rsgKNbzPoEaelHpIAgehIPkxQUGjUS1ekKStTNHiqkl9S0WfHWrXVTCZth9aFmg4oMUaalxmQmm/RZFW2EQqr0lnlY4T539UBWxdhdBG9OyTQpUEIzAsezLludeQEXZ2gCsNaOhh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141017; c=relaxed/simple;
	bh=gyHaX4rUH7VfXk5+GSMnekvjp1WHHHsYtG16XBQttRM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HI05kRleNIZuMp0CYaqr3Whx1J0B9+TjEpmXfgKWQKLP2reML10UM8sUxueent/Ozbv/R+U0F4e78wf8zBvU2THPQvNV9dll/EwMwMiyYZAX1zbw9C7c9rLV4OyLYpd7WQbyPzcpbnxl8Cs+VvPNdfZSmA3ErtCAVNqr7fB/2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=en9o0nri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgYaz9Ds; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 69C3813800B5;
	Wed, 28 Feb 2024 12:23:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 28 Feb 2024 12:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709141014; x=1709227414; bh=Uczs6P+Vjh
	lsb/gj6HcF1VFbl7LhQCHMFJrfB/feXkU=; b=en9o0nri8jxQPWja5PFaAxCjBA
	CVBxhnwxdOqfhXeiKEr+G1DCaaMIRNquKEtCdBroqhtKlzd06Mtko3jduGHe7cOQ
	S7fWvwXKsXn4Y6vt3CUC13wD9dNVgQ3KMwqHbGEMubfD0iuJcwsamSD++5v0lJ+p
	k0oZMd94hq5jwqKTKLrja9LEeikZ+sAh9TDqJYKVETniCS/7+hc5iD+4x4p3vcbG
	xg4NdTCmvxHZ7Q6La679xTekm9TNojZPFpXRbEQH/lmBt7lPmGY+ZmS0qgu4YXPB
	9982UuShK/IY5SXNoMXRL2qPd9pwvUjdi8JA4jccX7RH0Xg3zhSnvTbT4sUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709141014; x=1709227414; bh=Uczs6P+Vjhlsb/gj6HcF1VFbl7Lh
	QCHMFJrfB/feXkU=; b=JgYaz9DsiLHdxiHNDvW8LwzgBn/BCNjf2fob6BKz5jQc
	DS5kEAeXURNsQZrPIKN9UIcI9+D5d/Ql5rzfYE8oI03V8+6Xcmi8sT7qf1IfcBf3
	wT/yMM3dUJ3cL7L7YLYNa6FebV0892paATs0dslLr2ZOtmEN+pZEFK3PpVTozZlG
	ETjDNtSSx5UlIDV/m1U34HExkRAWCshbKoolnF6hJ41jEChZa3Zy3pYPkEpzkySL
	pBGd7RW2/z3j98TaKrTsUrDPCxnDvlRmokwfGRjmYE6oTNmCQFj3sJ2wsMv3Ge7x
	t+jbx/Ui/4HcJAe2u8/s3VtdtDojqklL0Yp3mI9hZQ==
X-ME-Sender: <xms:FWzfZQdJnERtgPUGhWvTMoPTc8vTvStLKqwqM8uoJ15MrQfp6OhDcQ>
    <xme:FWzfZSN-kUxVIyhgDuW6xybAFJFdxqNHE3h5a2x6cWi7UfIH5uCBT_XKjXyQ93z3P
    s_vWkt34NI2tth0DYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FmzfZRh_6upNX0-B6oaWDTR4DjOE33shLapoovFm1eckDY-jte_nSg>
    <xmx:FmzfZV8ZC_NDmBpXfcAS2AaJgfc1olAVkxquD-MYUuJf4LCRaxgfbA>
    <xmx:FmzfZcvrXHYnI6fWUzBRb9cRi3I9G6YcUl-TBXpB6I2KbGHi_qdTVQ>
    <xmx:FmzfZcHoHWEBeJFgNhGJoP0YSpwrg8qfQqIm-0Tt9-sykLuOUbLmwg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ABF8BB6008D; Wed, 28 Feb 2024 12:23:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62f20e36-536d-47ee-b486-28ed87201b60@app.fastmail.com>
In-Reply-To: <87il28h7zs.wl-tiwai@suse.de>
References: <20240228140152.1824901-1-arnd@kernel.org>
 <87msrkhcz6.wl-tiwai@suse.de>
 <1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com>
 <87il28h7zs.wl-tiwai@suse.de>
Date: Wed, 28 Feb 2024 18:23:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Kees Cook" <keescook@chromium.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: asihpi: work around clang-17+ false positive fortify-string
 warning
Content-Type: text/plain

On Wed, Feb 28, 2024, at 17:24, Takashi Iwai wrote:
> On Wed, 28 Feb 2024 16:03:56 +0100,
>> On Wed, Feb 28, 2024, at 15:37, Takashi Iwai wrote:
>> > On Wed, 28 Feb 2024 15:01:45 +0100,
>> 
>> The fortified-string warning only triggers for string.h operations
>> (memset, memcpy, memcmp, strn*...), not for a direct assignment.
>
> Ah, I see.  Then from the logical POV, it's better to have a check
> before that assignment; otherwise it'd overflow silently there.
>
> Does putting the check beforehand (like the one below) fix similarly?

Indeed, it does address the issue. I'll send a v2 with that
version, since it clearly makes more sense.

       Arnd

