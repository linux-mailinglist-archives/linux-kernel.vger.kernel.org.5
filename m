Return-Path: <linux-kernel+bounces-19164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A15E8268FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8B11C21AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967A14AAF;
	Mon,  8 Jan 2024 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="avn53GMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iG1NLshB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B014AA0;
	Mon,  8 Jan 2024 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 6B9383201284;
	Mon,  8 Jan 2024 02:54:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Jan 2024 02:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704700480; x=1704786880; bh=sJ3fesZ9Hb
	nBImMQwIHBlbn6iJ5Wv1fhltbNw/Fo1ZI=; b=avn53GMD9CG542966rOAkkAXaY
	2E62flLxoB7A1PiPAE0FWiaqSGpTEK2Hl+SUbtBE9eHJGIIZOhdsHwnAfXwiMOsH
	uskBuAElZi3NZNc4xfxjjHwrxLY7pbE0MEGuPSwHbQK94WjXIvcFvxrCE+sYno0o
	osbUa8KjcbLhuob9wYmZo/lpUGpxuBbVT4sO4QCRDis6Sp8kqUevFiBHAKheXD7A
	FTd8kn3sYPXQYLa9QLI5UHLnrVjrYhXZYLksJIJnXylaKH4rdxuzxL6kzenxGzeL
	UsDKY4xNSXaJhE8GMm9oDFuT9SIgIwk37GG5HX+86fYSq1mTR7s8N0/Zsu5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704700480; x=1704786880; bh=sJ3fesZ9HbnBImMQwIHBlbn6iJ5W
	v1fhltbNw/Fo1ZI=; b=iG1NLshB7GwjnAxHkoDg/zYLdN+cNYX6k9AfW7AyqijD
	HqeP22ZXUbdb7CRHzcvNJhJb2MynBgZaMfIb74mIwfsSsP6egwn1IgJs8Oy8w2rG
	UloZjiyKV8qtwk6IydchG6WpnQ4DQmiAIihQ9f4sA8lIJfpEkhR0AaoxSyNJrl4E
	4pMsnGT34Pfg47E+UDjXIviwSRkTKd+BOh8Tdeab/K0mYo/bMeOLtRrQx5YQEr21
	4WjFjPpF8y36Rigj53KNG9oQnQEHEGJP6E6FDef0cQ4SXBYdKzLOqHBzNDaC+mdc
	sSeQbHEm9qxavYlvLVgM2Ikb2Af/pLzZJgv5w+LLNw==
X-ME-Sender: <xms:QKqbZaDpEUZA9HZzaDKCandAY--O69U86UqMEQvalq_2N9LQ0ppaIA>
    <xme:QKqbZUhV_FTzOKofBl7aEG4yJASRjd1x8KEtmhuBJ_Qn6Vpm9FIkzsatVWnc3r9gt
    opCf3vgTkiVxA>
X-ME-Received: <xmr:QKqbZdlXz-lcqjPxhADJEob9RlCKrlWVH2yGsZ3T36Adm5CdQlr3OlFLQ6oJsHJQ-wuuuXFB10834OH3Pvsz288ZGu3Myd3yyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:QKqbZYzJJEXsBDHVt9aMZnWInv2V2aTEZpOwIRBr27SgYuaQfEEDAg>
    <xmx:QKqbZfRcEe9D1kDtKwLcrlRaxSjG1EQd9xrmySbwdDqxiAkvEjXrww>
    <xmx:QKqbZTZovi3VpXGUBe5zmWO3TqCJXCo96Hekuty0RwrltO1qtc48Ew>
    <xmx:QKqbZeH2THYoT5GzWU1gHdUtyo4Rlcwfhx1pHQbdnBCUNvVv8PztKg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 02:54:40 -0500 (EST)
Date: Mon, 8 Jan 2024 08:54:39 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <2024010816-fabric-cassette-1548@gregkh>
References: <20240108160221.743649b5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108160221.743649b5@canb.auug.org.au>

On Mon, Jan 08, 2024 at 04:02:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
> Text in column margin in table line 9.
> 
> ===============   ==================================================
> ifname            network device interface name associated with this
>                   function instance
> qmult             queue length multiplier for high and super speed
> host_addr         MAC address of host's end of this
>                   Ethernet over USB link
> dev_addr          MAC address of device's end of this
>                   Ethernet over USB link
> max_segment_size  Segment size required for P2P connections. This
>                   will set MTU to (max_segment_size - 14 bytes)
> ===============   ==================================================
> 
> Introduced by commit
> 
>   1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")

Krishna, can you send a fixup patch for this?

thanks,

greg k-h

