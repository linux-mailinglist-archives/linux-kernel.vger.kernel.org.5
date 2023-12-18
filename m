Return-Path: <linux-kernel+bounces-3395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F6816BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3914DB220E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F718C30;
	Mon, 18 Dec 2023 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WilBptd2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wriK9Y1+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88381946B;
	Mon, 18 Dec 2023 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id AAB6D5C0109;
	Mon, 18 Dec 2023 06:00:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Dec 2023 06:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702897200; x=1702983600; bh=DhJuFyKeI5
	xdQm8Pua0VofKhhE351ohYbJVIzzUIEi4=; b=WilBptd2KY3wYkNR+dcC6HKzBF
	M/iKlNojY1Zo3MIWsFUsnce6zS9ZGLHV0SgfmaDAMoOk8CnRuvgw+rO2Kgg5GZ5k
	D454PbdqLMmv+zwXodoO+q9xWo2QFpKpLyjjK1SbWAa3SfY8POAJdjEthSQ0Afs3
	a2UtpzIuoHNk+9TTMUaH4D+kXAKZYQgCcM0DTf6Olu6ynvaKd7/xxELRGf82nlur
	ny0ITnHI+9UDAdtR5Shhj8iIxVZ4B9bNB9ck3p9lEkqf9x8IW5rYNfR4aPP2cWsD
	EEc3qgu7r1DNra1s0fKMXnNUMupZmsv7C2BahG+WgeRbNyyfsNzaLJRwIqig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702897200; x=1702983600; bh=DhJuFyKeI5xdQm8Pua0VofKhhE35
	1ohYbJVIzzUIEi4=; b=wriK9Y1+6TAMgj5hg6iJd4T4zEJfpkCsRvlp+3Zwnd7c
	ds9bJ2Qpy2QOn8AGgkWK7E5B7ZHkuUgoyoIR1Gym1baSNbuRa41VmVYF4jPNn+up
	EbG8WBPHR6e9NlNOIKSzgB4aH90iYz8fHvnCOLEhinq/VNfMFykUZtlLHyNOWaOI
	DhmqnJr8+Q/JetrYRD/0Nuvr4Uo2thl52CVrkYUpcfHCHTQPawon0uZYLRLjF1/g
	akUM5d3iqKhVa6laulVol+P0GOsfSA8ze0p+29+BL4iYoPefzQGZElEEGVitJXtD
	vQ07ezINcpdTHNqPkaCOYs/MvK4pOqy0Wq5I5IrinA==
X-ME-Sender: <xms:MCaAZZT7-gqyXdgugK_ZaigHGHcoai6ipZCU3K-UobNPpXBYMxp7Yg>
    <xme:MCaAZSwySrcHO3o2KlSJuAHgDoRphw-V5L64LqoAtkPWzUZ6Kt1nwPOENH9PHjqZI
    66IhrnDcV1ZxA>
X-ME-Received: <xmr:MCaAZe08mxPHTsUJra-N8LESQRH7ro4DbAIizfn-nHhK6SJARyLP_aGpMEHVkX2rRgszXlWU0jRtm_4HwYdaIXVH6LRQBKjzwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:MCaAZRBLNcflfUJmgfGwBeaGUHKMdt4_HWP5dXRsQx6VvpcsVbqMSg>
    <xmx:MCaAZSgaJQKXNUrwkREHKuZbhqc5RBTRxVABF9WYjNxV9MZJBbi42g>
    <xmx:MCaAZVqvEo2MMhA16LbDB7z0VDWlJeVOr0I0--leUYyMokClAdeK9w>
    <xmx:MCaAZZRmJDmDENl6rIP-qW8HfpZy6KQjmg8E_eS786P59zi9mF3utA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 05:59:59 -0500 (EST)
Date: Mon, 18 Dec 2023 11:59:58 +0100
From: Greg KH <greg@kroah.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, akpm@linux-foundation.org,
	willy@infradead.org, liam.howlett@oracle.com,
	zhangpeng.00@bytedance.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] maple_tree: do not preallocate nodes for slot
 stores
Message-ID: <2023121847-cope-surviving-26bf@gregkh>
References: <20231212195255.219624-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212195255.219624-1-sidhartha.kumar@oracle.com>

On Tue, Dec 12, 2023 at 11:52:55AM -0800, Sidhartha Kumar wrote:
> mas_preallocate() defaults to requesting 1 node for preallocation and then
> ,depending on the type of store, will update the request variable. There
> isn't a check for a slot store type, so slot stores are preallocating the
> default 1 node. Slot stores do not require any additional nodes, so add a
> check for the slot store case that will bypass node_count_gfp(). Update
> the tests to reflect that slot stores do not require allocations.
> 
> User visible effects of this bug include increased memory usage from the
> unneeded node that was allocated.
> 
> Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> This is a modified backport as the patch to fix this in upstream does not
> apply to 6.6 because the node_end field was moved from the ma_wr_state to
> the ma_state after 6.6.

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h

