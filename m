Return-Path: <linux-kernel+bounces-51550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F1C848C66
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C08B21920
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043318C05;
	Sun,  4 Feb 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NczQepVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOqUDlRV"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7E182BF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038430; cv=none; b=nLVlVT2fxmWFxEnNkmbkZDKBVZzBrV8J2EuWKeXaUAr+rZv8E9MHvmGkU1fy6pdxVufBfxkliDUUrTXVBiMeLM+voSpYsKXm4UB7AVb24Q4kv2anwUy6HGqAx7m4Rzw0uRxa+wt1Ojddc1ZlW8Wo9I+F1Oazeo7Fx7n8xs5AULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038430; c=relaxed/simple;
	bh=v4mFBKqAFYVXSaZoDvGIgK5zYWkAZmcjBpOYxz5HTOA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=crxTcdAq0J2a36iaK9EjeUOsz8kY9stc/tcNgXcsmYGwltmymA5crQu3hUBGLjZ7pEIA0ofJyanbT3ghYdY9J0dEicKyF8H/F5fdoS5Oa/FNBhQWrQ0uhNOKelGK9K4RZoRVt0jNgg3V0z8w2LNVk0i7uOvk7BuYDlvWdTRL65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NczQepVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOqUDlRV; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 725CF3200A78;
	Sun,  4 Feb 2024 04:20:26 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Sun, 04 Feb 2024 04:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1707038425; x=
	1707124825; bh=D0QpOGjFbZTko0PkSRlDsBxnVILcVK+fHTpP9Q5l7C8=; b=N
	czQepVe8zMpXJKP1j1nhEVKp72uhRCTTTf1CyQaCl/teneXT+Vj8tT1k+4G7uUaA
	skRz1MOxh1OY46AQ7aOSL5hcyxAV1sQ2C6zd757q5W12kO+ShY7bkcA9LIcxRKtv
	t0ap38uPRP485OoFKXyFfYeVoGVr3LSXkxgV1GR9cS16EtxO0Lf0TxijvdxHEUUx
	JYB29bYBNEj92MOL97Uf0GzdVY+O2L5w871B0fClQxZE5XfQwYdb4v29lKee4gkl
	tZkBwjLzWojTM6Hfbze1Go20AESv+Y7DUPh5KHJTPu+OWMZ4lq+BsKCbp2d+TzwU
	8HLS3OrvRDMdxPnd18z2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707038425; x=1707124825; bh=D0QpOGjFbZTko0PkSRlDsBxnVILc
	VK+fHTpP9Q5l7C8=; b=oOqUDlRVKobB5wR8cZMHzzrIWbrCZU849rpx5xwjZoqm
	NPZjRJxNOwXlWXxnKl+QlG5brXyXzDmviCCUwsRFMPHfmTfF2c+tkcbbHWXtQZba
	v/5C+NM1zFRDfMEBxePzdEbNitp+QC5UhvGY1x6L7V1w/4mbOvcRw/tO/ZWz48Q4
	B/Xj8zH0Y7j41W9KHlpf0jHFzPiKVgZaJHo7jY5v/LQaeGgty60nkhO5BQVFToul
	2LIdlevMl5Q45L1heWbar9Uw7f64xKM2sIV5Yyfz3lQT6c84dw6IC+f/eNT/MBGu
	PwFlF/bzD/ZnzuQVwGLXFcjbHgyRfTYfIMNQfsbSTw==
X-ME-Sender: <xms:2Va_ZeaahbU1U04JOYqs5WOHtA0wTuh609bUyNKU1K9glIfS_Mdgcw>
    <xme:2Va_ZRa0C9vqHDoM4QL9R8qcogA69bCPD0bx_7edBBTSedviuMBtDZ_AVCVsOJs0c
    mtViBD-psLo0DDiuhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvfgr
    khgrshhhihcuufgrkhgrmhhothhofdcuoehoqdhtrghkrghshhhisehsrghkrghmohgttg
    hhihdrjhhpqeenucggtffrrghtthgvrhhnpeelfedvveevveetjeeikedtgefghfeigfek
    leefkeekieehiedviefghfeltdehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2Va_ZY_Jb9cadsyvu1a4Y8ACOnzIbaBrg5oRdwXbteB-sHgfNkVFFw>
    <xmx:2Va_ZQq4ZkCat1MSSrx6tBNCFAgtxCN-c3SOTkFsruskWETJqNCRfQ>
    <xmx:2Va_ZZockUZD6Oryf6gJhsfey6JHV5H-9lnfgejpZIafKodEGd9Uhg>
    <xmx:2Va_ZYTpkE4zwgJpKDQzFAr4tZgRocHhImxxStp-RcMRk6z95meTgg>
Feedback-ID: ie8e14432:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ABF9A36A0076; Sun,  4 Feb 2024 04:20:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a89e9035-66ec-484f-9f0f-99d7a07c228f@app.fastmail.com>
In-Reply-To: <Zb8tId0k1iNqFstx@iguana.24-8.net>
References: <Za90vAQlDhbLpY67@iguana.24-8.net>
 <20240127083730.GA159729@workstation.local>
 <ZbTlaCCbpxQoqo0i@iguana.24-8.net> <20240131142714.GA60028@workstation.local>
 <Zb8tId0k1iNqFstx@iguana.24-8.net>
Date: Sun, 04 Feb 2024 18:19:51 +0900
From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
To: "Adam Goldman" <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: send bus reset promptly on gap count error
Content-Type: text/plain

Hi,

On Sun, Feb 4, 2024, at 15:22, Adam Goldman wrote:
> Is the following description acceptable?
>
> If we are bus manager and the bus has inconsistent gap counts, send a bus 
> reset immediately instead of trying to read the root node's config ROM 
> first. Otherwise, we could spend a lot of time trying to read the config 
> ROM but never succeeding.
>
> This eliminates a 50+ second delay before the FireWire bus is usable after 
> a newly connected device is powered on in certain circumstances.
>
> The delay occurs if a gap count inconsistency occurs, we are not the root 
> node, and we become bus manager. One scenario that causes this is with a TI 
> XIO2213B OHCI, the first time a Sony DSR-25 is powered on after being 
> connected to the FireWire cable. In this configuration, the Linux box will 
> not receive the initial PHY configuration packet sent by the DSR-25 as IRM, 
> resulting in the DSR-25 having a gap count of 44 while the Linux box has a 
> gap count of 63.
>
> FireWire devices have a gap count parameter, which is set to 63 on power-up 
> and can be changed with a PHY configuration packet. This determines the 
> duration of the subaction and arbitration gaps. For reliable communication, 
> all nodes on a FireWire bus must have the same gap count.
>
> A node may have one or more of the following roles: root node, bus manager 
> (BM), isochronous resource manager (IRM), and cycle master. Unless a root 
> node was forced with a PHY configuration packet, any node might become root 
> node after a bus reset. Only the root node can become cycle master. If the 
> root node is not cycle master capable, the BM or IRM should force a change 
> of root node.
>
> After a bus reset, each node sends a self-ID packet, which contains its 
> current gap count. A single bus reset does not change the gap count, but 
> two bus resets in a row will set the gap count to 63. Because a consistent 
> gap count is required for reliable communication, IEEE 1394a-2000 requires 
> that the bus manager generate a bus reset if it detects that the gap count 
> is inconsistent.
>
> When the gap count is inconsistent, build_tree() will notice this after the 
> self identification process. It will set card->gap_count to the invalid 
> value 0. If we become bus master, this will force bm_work() to send a bus 
> reset when it performs gap count optimization.
>
> After a bus reset, there is no bus manager. We will almost always try to 
> become bus manager. Once we become bus manager, we will first determine 
> whether the root node is cycle master capable. Then, we will determine if 
> the gap count should be changed. If either the root node or the gap count 
> should be changed, we will generate a bus reset.
>
> To determine if the root node is cycle master capable, we read its 
> configuration ROM. bm_work() will wait until we have finished trying to 
> read the configuration ROM.
>
> However, an inconsistent gap count can make this take a long time. 
> read_config_rom() will read the first few quadlets from the config ROM. Due 
> to the gap count inconsistency, eventually one of the reads will time out. 
> When read_config_rom() fails, fw_device_init() calls it again until 
> MAX_RETRIES is reached. This takes 50+ seconds.
>
> Once we give up trying to read the configuration ROM, bm_work() will wake 
> up, assume that the root node is not cycle master capable, and do a bus 
> reset. Hopefully, this will resolve the gap count inconsistency.
>
> This change makes bm_work() check for an inconsistent gap count before 
> waiting for the root node's configuration ROM. If the gap count is 
> inconsistent, bm_work() will immediately do a bus reset. This eliminates 
> the 50+ second delay and rapidly brings the bus to a working state.
>
> I considered that if the gap count is inconsistent, a PHY configuration 
> packet might not be successful, so it could be desirable to skip the PHY 
> configuration packet before the bus reset in this case. However, IEEE 
> 1394a-2000 and IEEE 1394-2008 say that the bus manager may transmit a PHY 
> configuration packet before a bus reset when correcting a gap count error. 
> Since the standard endorses this, I decided it's safe to retain the PHY 
> configuration packet transmission.
>
> Normally, after a topology change, we will reset the bus a maximum of 5 
> times to change the root node and perform gap count optimization. However, 
> if there is a gap count inconsistency, we must always generate a bus reset. 
> Otherwise the gap count inconsistency will persist and communication will 
> be unreliable. For that reason, if there is a gap count inconstency, we 
> generate a bus reset even if we already reached the 5 reset limit.
>
> -- Adam

It looks preferable in this case, I think. We are going to change the part
of fundamentals in this software stack, thus the longer description is
inevitable.

I think it preferable as well to add code comment about your judge to
retain sending PHY configuration packet in the case. Additionally, it
is helpful to add code comment about "bm_retries=0".


Thanks.


Takashi Sakamoto

