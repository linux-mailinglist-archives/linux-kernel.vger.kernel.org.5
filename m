Return-Path: <linux-kernel+bounces-19158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6D8268F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BD8B21499
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9B8F7D;
	Mon,  8 Jan 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mV84gpTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDGO2JzB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B48F47;
	Mon,  8 Jan 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EB9053200B07;
	Mon,  8 Jan 2024 02:53:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 02:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704700408; x=1704786808; bh=vLjDuf34Jj
	F2TkMLyKqblhCcjJFnXhKnF81wBuSsCKA=; b=mV84gpTMVeJYoxyaa1JSRshvo2
	QprpBYJwxBM3dtuMRu+tQrOUxPV6N+BUWgLbygE2n/irvMZ/6ulkLCsCIsHYu4O1
	/YAlu0nfhSUQ1beHOipT7m4HTgbmw7cRBuMP5iF2Teo/hBVddWYF+BLE824C1KX9
	zclZKYkdci5C9dhL+ud1XDRDkdVxRL51Sbxxgk57uVJmcNlOyYdQP9J1ZurIbY96
	625b03nd70Q+74lqpQ2WM+cHCZjaozdaBZpE9E8OWL6WoyUXo+NjIrni/kG3Yy1H
	N/0f7x35T1FgLfZ9MWoBgUJiiSHGAGO/lGV4aHG0UdqpHIaerCpHVUWr4U+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704700408; x=1704786808; bh=vLjDuf34JjF2TkMLyKqblhCcjJFn
	XhKnF81wBuSsCKA=; b=cDGO2JzBe7VNzVYx2c2ChB4Y52Z+JO9RjuPIJIUG4Mxg
	aT5bm+XN2QLoQXgFrGaExaRxoK3Zy05kQVc3KuVI1axCou3g2N8mtro72xKGPF2q
	xIaJKSy0Yt/vM/ea+wXn9aHBkPh/nVI16tWV2iqUSxCpbJf9zK+9enmSMR4pgyZe
	nuNTriBSxMHlYlPKyGbQ2zjZjhLEJRtSVMC6wQjGU9s4yE1zzvTWAi4X2ZUaI7KN
	PwW5PG5RJNbAMzBOO7ECb0ujzBeHppouJFtdPoyPJOx5S5FJk88CPircCm7S7R59
	dpRNCwy3M5X7nkaHIrKRkrXHrKdCHO7fi4OmzmIX+Q==
X-ME-Sender: <xms:-KmbZdwqfJZXwdzUj-lREVgir3oxFMKsZujzpNHo9ANidkpkZEEJCw>
    <xme:-KmbZdQDJjTLLKqRbsTFAJL8WgWqYAnI57LBzdvFkoFmua7419QpFuNgTe9F4JvWk
    ZwcW7yqP1vZlg>
X-ME-Received: <xmr:-KmbZXVxcLJSMntrbUwx9pt9SxBFGHXPG2MqE0J5xscHXad8ZVOWPMzX6NASovZU8OSu2fDvEn5mxQpj-gBrc1QRy0wXwpxpdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:-KmbZfjYjlIwXKBXKSED_A21FnJrOmFbksrX1MJYRS3TctnO9h28yw>
    <xmx:-KmbZfD1pM6_9P4ugYZb44HVIYEMLyGtXwLTxTUjKURhR3naXaK27A>
    <xmx:-KmbZYLzWIukn13NBL9_XYgghCujaeHAZTF4PxnmbdWskKmLZj51qA>
    <xmx:-KmbZT2hIrB23m6nlc-0p1EQ2q3sJDFSuY79ns8jrUdBsU-qYBUK3g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 02:53:27 -0500 (EST)
Date: Mon, 8 Jan 2024 08:53:26 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rob Herring <robh@kernel.org>, Kyle Tso <kyletso@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the devicetree tree with the usb tree
Message-ID: <2024010819-isolation-android-5d2d@gregkh>
References: <20240108150026.2c5930a4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108150026.2c5930a4@canb.auug.org.au>

On Mon, Jan 08, 2024 at 03:00:26PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the devicetree tree got a conflict in:
> 
>   Documentation/devicetree/bindings/connector/usb-connector.yaml
> 
> between commit:
> 
>   501b15207138 ("dt-bindings: connector: Add child nodes for multiple PD capabilities")
> 
> from the usb tree and commit:
> 
>   0d3a771610d0 ("dt-bindings: connector: Add child nodes for multiple PD capabilities")
> 
> from the devicetree tree.
> 
> I fixed it up (I used the former version as there were other changes
> in this file in that version) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix looks correct, thanks!

greg k-h

