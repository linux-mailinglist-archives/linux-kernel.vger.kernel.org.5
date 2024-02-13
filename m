Return-Path: <linux-kernel+bounces-63534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E58530D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F011F26ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE1405D8;
	Tue, 13 Feb 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MVKdScji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBER6n7G"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189D4DA01;
	Tue, 13 Feb 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828345; cv=none; b=fZvxk1WWpoqzuNExbNRDwuIrS6c5TUbG51iFNFsI+19amPDGpLIp9NGqY5MzUS8Dl6xLI35JthFdoOa7/TARoe8dELSCBZEiWzjwAa0q68ma5fJ0KwI/hWtKkqD8p+TSEUfZQqg+yJNPVLWrBzVZAh66B3SsOVr3inq5TdpyYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828345; c=relaxed/simple;
	bh=Wlfk7dY0wWDXuDYy0panziIsiJR/AG6s30SqLg65+G0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tpu2KVngm5wmnUgT5a89lYpIU6d7nmGA/S85FN3bcGfWc43t5bi3nerQdswISg2+zt67xOXbG+HvpaWSXig8byZMX5jU3nAK4smhuqnq6nntiG+0c2Gl4iZnzlpI5ycGqR/zFzoC57Kyb8YJe4/kG+q5+xPCX34ydIpNQPHEhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MVKdScji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBER6n7G; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5A0A818000B3;
	Tue, 13 Feb 2024 07:45:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 07:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707828340; x=1707914740; bh=USQ9m9LRrK
	EPc6jBigxNFqy6LATxlEiA3y2icE1wmKU=; b=MVKdScjiFTQgmJvjhZ/2M90i23
	l/fpMktEDMfJppqKTT+/khsgDio7EHjaZpT3+9qAwiIYyrPwVot9zpcK61giOCak
	sIqQPDL6MwOZ6UxG6xt+gOngE22lnvjTE+cWfkiUp7+CkBaS5PTqPtRevSihjC6N
	jF0VG3bXfrlI0qoJWP96QJj4OMcsLGphzGOjK+mwZ7keX6moZ6CeTN2y6SGv4IS6
	/BeeBELwCArYgSZ9aULHv5tu1QPUHusDXOUBQ4g2ShQKjZvqPfwVjN/C1Ydg1vf1
	UFu7ZAzc1PCrIOeNKl2RtjXW69ZzJKCKIlJ4kMGU9r4KrDldt6RBwtYqWGvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707828340; x=1707914740; bh=USQ9m9LRrKEPc6jBigxNFqy6LATx
	lEiA3y2icE1wmKU=; b=TBER6n7G5KS+2jvixiyf2/8+env6bDAeIKdQkwLvkZ9l
	iUVf4w89ofi1RB6FWoUfCYdKZiz5bWGUzvEDR48HK3qdMp7M14hcOV008HKa0515
	tqsN1Ufogx5x+o5dO4kXPewWYmEdLZLXzJZWZ5Q8VvZL4MfHCAT7Jhd+qJgPpzS+
	yh36/WcKtzvE8Ip/rLHsrsTxjQRPmQDYjOmpbLOA/BfSnD7fvMICgzixFkHsZssE
	SP8E3pOsFhc4YE0j+D0x9gbNQei92jFDfdqICSWsno6APWJv8kZG217EJAY4y/5y
	EkFSwgwgQmrjStWhlA+6K0Ysk0CooMERyftl1YjZYw==
X-ME-Sender: <xms:dGTLZeOFthVxaGlMlICy2zGBpA0Z9TCq6WI-dId3lOjYJ7lkzg5UuA>
    <xme:dGTLZc8PO8q9wAStqrNZzGENQ0Xgjydxie-zGhbHrV87qBUbjrsjyr0kyMGwdcFLX
    3liXcS8Kvt18b56rQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dGTLZVQNjjdd2aSfuCueS9pgZNw49IrY36p83cr-ASUb7aFulkrusA>
    <xmx:dGTLZeuQyK3SCb7oueqV76z-aoKjGHEm4s-SqW7YEoJYfnCDg1HMFg>
    <xmx:dGTLZWeagM_-E5iIblPxOi26bQkryjltXKLm3wz-gheyUySQle4jYA>
    <xmx:dGTLZTCmdRiDL29BNyTl9Wf2np2S9JNbm_VBLoSQq3WyfxCaVWOMriXxAjc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6D8F2B6008D; Tue, 13 Feb 2024 07:45:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bcd477f9-8619-4121-83ce-fa8ba05a36aa@app.fastmail.com>
In-Reply-To: <1j7cj8k2se.fsf@starbuckisacylon.baylibre.com>
References: <20240213101220.459641-1-arnd@kernel.org>
 <1jbk8kk5pk.fsf@starbuckisacylon.baylibre.com>
 <c61d7daf-1b13-4ff8-aeae-7dcd8dd02131@app.fastmail.com>
 <1j7cj8k2se.fsf@starbuckisacylon.baylibre.com>
Date: Tue, 13 Feb 2024 13:45:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: meson: add helpers for clk_disable_unprepare
Content-Type: text/plain

On Tue, Feb 13, 2024, at 12:09, Jerome Brunet wrote:
> On Tue 13 Feb 2024 at 11:52, "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>> On Tue, Feb 13, 2024, at 11:36, Jerome Brunet wrote:
>>> On Tue 13 Feb 2024 at 11:11, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>>> This probably pre-dates the introduction of devm_clk_get_enabled()
>>> It would probably be better to use that instead of duplicating helper
>>> functions which do the same thing.
>>
>> Ah, I had not thought of that interface either, so you are probably
>> right that this is the best way to do it.
>> Can you send a replacement patch then and add my Reported-by?
>
> Sure.
>
> How may I reproduce the problem ?
> Just tried with 'Debian clang version 16.0.6 (19)', no warning.
>
> I suppose I need to add something ?

The warning is currently only enabled at W=1 level until
we have fixed all the existing diagnostic output. I have
sent the other ones today, but for now, please test with
'make W=1'.

     Arnd

