Return-Path: <linux-kernel+bounces-119962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90288CF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396DA1F3913D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DBC12BF04;
	Tue, 26 Mar 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WlOtjyaZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTYV8adQ"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A612C7FF;
	Tue, 26 Mar 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486581; cv=none; b=n0H4jbt+v3h9VHuac52zXXKvPD4riyIZCrdL97sW7XuEi2Q1h0FCOvwnjJNBfm8qLFvR4GmRlyjy500Yg5XPjGoXpZwSeTneO6Gq9eY3DDAi4/fcFm9VKIkFko1bhu034cgtZpEkaRBXjg0+46ME8BP9bsmTliM7rdwHhT2tXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486581; c=relaxed/simple;
	bh=Olz4AkNkzYVK19w+Jh6klcHV6fbs+XGQtH12Ue6EbtA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Gejj+PHDoJ261zFF/+liw9o/R62sP6a4rd175No5dgw8qi7NrqYVi+wbxNFA2BNXr7THYuelVsCIx0T66TcS0fYu9mancmrvgukgBOyCyn0ev/ch45Az3yFqKLKW9AvtZRqOjyiC5LTlqkyN4M7QWxkTbZg2Z6T/MMINC3J9S4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WlOtjyaZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTYV8adQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C0777138014E;
	Tue, 26 Mar 2024 16:56:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 16:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711486577; x=1711572977; bh=bTK7qxB/Dz
	ZvcacQ3ARgA6AoDzT5XFaivWWd8YVHcDs=; b=WlOtjyaZiklsRi4cCh1jYIRpIM
	pLVHILPIPgQ/oogUIpqoqYnwK1W+6v8z0OA+zU38ovpQrKeC5G+uoNavTn26eOcw
	Rx9zFSqTneqsXKVF54y5rwO2vHU/viQNr11OsBlahezKkGRdxR1vhDu/HNpjHWZH
	Hw8/5n6K5X+u1wgp5XcZivytgK6eq1An+lKKX426vYBoEHRjKtJ2g5tzqxxS1pN5
	GnkBq5GRV0kmxf1/iX6DMkND5yOLsrsoGUtnkkew0BYhBhDf12kqBMhkcdMKdzRv
	1ZZvx0c+58bG33DpLg54XvIvoERfC3DtCU/rHLAyGy1/fVXzvUpuuDc60MwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711486577; x=1711572977; bh=bTK7qxB/DzZvcacQ3ARgA6AoDzT5
	XFaivWWd8YVHcDs=; b=oTYV8adQxdjRh9Snl2cz1eHQHqctI5puzvhK2J/F+mJ8
	7tl0gvwKM0afyXZkz8C6MXAAifZckQygqw5ORc7w0qpS1TPlbO+w9G7jd3heTiCC
	r8I6RrrlNvFIk91tWPjbL747c8kuc3cUPm9wPnAItnHcvIkE5C+9ExKz8Ajn6gg4
	XtFClsZhAv7KlA2mcHHBjgSBHAdbPX7syjzicTpPVslBt7hIXn/nym+aa8280ApW
	IeFHW75gBBPdbNdhp32G4czj+aGTUaSrQiNUAlmapyxtBNnRSxScoAW/oimlmTKi
	uS/mrXXVeAnS/EwrWwW0shCoI/5h1CnBk3kKJ1UCxw==
X-ME-Sender: <xms:cDYDZnJ8rnTBWm06xK346QIC-QafLXL2gNmwIgqfmVnvDbkBSqHQWQ>
    <xme:cDYDZrKEJ0-53M2cA3w9Y_dAEKcjYEVn8bzx34Tifka9Xow_kVoe0xGHM4NN3qkKF
    gRRP3ldGGLjW5vpIVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cDYDZvvDg9wFUZ4OAUyKEggLe0cNB4rFNN936cbq-sR_6OTqjVXIrw>
    <xmx:cDYDZgZgdeDjBNgszo_zOpuYNlLc03uqLjysmZTeLwTAqDSTOmltzw>
    <xmx:cDYDZuYKC_wI7ro2wW0eBCrJnbpxAudYAU5P82Iecn1qctEWiMRPFw>
    <xmx:cDYDZkDkbD19cuKpTJQbi0S_atQZTcbT2a9iBKqGsY57IhQu9VXbdA>
    <xmx:cTYDZgYxthdidcJydzecKKASkiaYUTKEbJFDurjUEzrMsGAkjExe_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 658BDB6008D; Tue, 26 Mar 2024 16:56:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb853762-06d4-401c-a1c8-07a0c031b499@app.fastmail.com>
In-Reply-To: <87jzlohhbc.fsf@intel.com>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326144741.3094687-2-arnd@kernel.org> <87jzlohhbc.fsf@intel.com>
Date: Tue, 26 Mar 2024 21:55:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Harry Wentland" <harry.wentland@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Oded Gabbay" <ogabbay@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Joel Stanley" <joel@jms.id.au>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nicolas Schier" <nicolas@fjasle.eu>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/12] kbuild: make -Woverride-init warnings more consistent
Content-Type: text/plain

On Tue, Mar 26, 2024, at 21:24, Jani Nikula wrote:
> On Tue, 26 Mar 2024, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> index 475e1e8c1d35..0786eb0da391 100644
>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>> @@ -50,7 +50,7 @@
>>   * the macros available to do this only define GCC 8.
>>   */
>>  __diag_push();
>> -__diag_ignore(GCC, 8, "-Woverride-init",
>> +__diag_ignore_all("-Woverride-init",
>>  	      "logic to initialize all and then override some is OK");
>
> This is nice because it's more localized than the per-file
> disable. However, we tried to do this in i915, but this doesn't work for
> GCC versions < 8, and some defconfigs enabling -Werror forced us to
> revert. See commit 290d16104575 ("Revert "drm/i915: use localized
> __diag_ignore_all() instead of per file"").

It works now.

The original __diag_ignore_all() only did it for gcc-8 and above
because that was initially needed to suppress warnings that
got added in that version, but this was always a mistake.

689b097a06ba ("compiler-gcc: Suppress -Wmissing-prototypes
warning for all supported GCC") made it work correctly.

     Arnd

