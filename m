Return-Path: <linux-kernel+bounces-3521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8CE816D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9711F22A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2C1B281;
	Mon, 18 Dec 2023 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C6ud4NCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgCOrFzC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFE47F55
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 780655C00C3;
	Mon, 18 Dec 2023 07:04:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 07:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1702901052;
	 x=1702987452; bh=TJvghgd2GT0U8gbW8eh0n+GYx6gyP4lfuYSZLcygGD8=; b=
	C6ud4NCV1Lil6O1w/uNBWMckLfddsiZHNSTb67P6DFP7hJrUmUfLzIjxlWgmRAOx
	xa5joMPdupYgLFnVMXzl584t6geMAfnyea7MF3YO3GIoLm2ETJx0OdlBUEPVsIit
	lawBQ2rsb4+iutfvY78+Q/sAaum3CZNgND/qeK8t5UyaS4gnxAF9aRVHex7lIzyy
	tT+Vxxhy56PYqYCTw+TFTjnbvBPab6bv366Mv2cs9Bjri6jHfb9kl2n02VFlzuw5
	QUKEgTOGt/3oNCu0Adh/5GWm67P/DX/qwNeH/aqFwMSBJrE8IeBYxgvjgCb4U/wJ
	HcdLiSEXhYrl54J3jE7F1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702901052; x=
	1702987452; bh=TJvghgd2GT0U8gbW8eh0n+GYx6gyP4lfuYSZLcygGD8=; b=T
	gCOrFzCFp+6QnP7BPNt0/Hxs0GjmQ4zTxr05TmYA2ys2E2fhxPQJEECaVipqp3AC
	p/HQ2Ojap56r9YfeePhGn2CGlQJXxfWT4HUvZqun9A0XULSlnoVD8yBiEB4DIjQt
	z//CImX2RPBtXqNNefUtzdop05ZIBEZSau2xYhTlJo6LWSy1chNvkvzirzPub56+
	hufVKdU6XRvTKT0uU7pbI4R4NFnZlpNK6zGEdn03nTNZPX5iKBb0Fyd1zkFzpcMs
	/u801jXtZ23H70/6QUqMPLHI1KulYAy81uWIwJ0RdNnIrTTwWAs9H5o7uo6iZr9i
	hO28gJCSMDYUVRUenSILA==
X-ME-Sender: <xms:PDWAZeI6sZPhsIIRQzeD4ymoUDhVB-IaCGNC6kKImW-PISuu8j6SXg>
    <xme:PDWAZWI6q6mBMh3wIrF8Vg4nG6zukNu9ZZ9HjdFsOMl-CUE1y_EhsgSaj5kSt6gIc
    2Z45E7RWQ-ATWpDjdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:PDWAZes_FNrhuRG7fDZflhU8ZYFPOTuuHrxlPfPZu6lB7ffCC3NEbw>
    <xmx:PDWAZTbFkwc8ZP6x7jTdUDtWjnlEGEuq2zo9_NMgiDeG4ex-2UpO2Q>
    <xmx:PDWAZVZAJduZ805DDNDU-dTPj-LW4v6YCxD95voi2pgmMCbbel76ZA>
    <xmx:PDWAZZFYCsV7CVXMOvM6LWRrH9m-pJYSovig7HmdBcmHH5FutNupxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E10CBB6008D; Mon, 18 Dec 2023 07:04:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <487cfd35-fe68-416f-9bfd-6bb417f98304@app.fastmail.com>
In-Reply-To: <bfe530f9-d3d4-4cdf-b92b-2fab95f44522@t-8ch.de>
References: <202312171924.4FozI5FG-lkp@intel.com>
 <3fb66648-5581-4371-b15e-23e52e6469ba@t-8ch.de>
 <b091f9d3-14e9-4f2c-bf98-9a207cef412a@app.fastmail.com>
 <bfe530f9-d3d4-4cdf-b92b-2fab95f44522@t-8ch.de>
Date: Mon, 18 Dec 2023 12:03:53 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Jakub Kicinski" <kuba@kernel.org>,
 "Simon Horman" <horms@kernel.org>
Subject: Re: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON
 failed: skb_ext_total_length() > 255
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023, at 11:11, Thomas Wei=C3=9Fschuh wrote:
> On 2023-12-18 10:12:03+0000, Arnd Bergmann wrote:
>> On Sun, Dec 17, 2023, at 17:13, Thomas Wei=C3=9Fschuh wrote:

>>=20
>> The -fno-tree-loop-im option would likely stop the loop from getting
>> unrolled, which is how the skb_ext_total_length() return code is no
>> longer constant.
>>=20
>> Does manually unrolling this loop avoid the problem?
>
> That also works.
>
> The offending commit was a change from a manually unrolled loop to the
> current code.

Ah, I missed that.

I also see that I added -fno-tree-loop-im back in 2016 as a workaround
for gcc-4.9 and higher, but I don't know if it's still required
with modern compilers and I'm currently unable to do large scale
testing of this until maybe early January. My guess would be that it's
still needed.

If you want to fix it sooner and not revert your earlier patch,
I would suggest changing the BUILD_BUG_ON to only evaluate the
length argument if CONFIG_GCOV_PROFILE_ALL is disabled. It's not great
but if we ever exceed the limit for real it would still be caught
in normal defconfig and allmodconfig builds since they disable
the option.

    Arnd

