Return-Path: <linux-kernel+bounces-55735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B9084C0F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F42361C214DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39C1C6A8;
	Tue,  6 Feb 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="c77fCKQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1y/xNYf"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300D1CD1E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262732; cv=none; b=S/B1Ll9G+3t8VfSl2Z6R4hMblPepjjHTYTVl1iRECibZUq+NiDuZ+l9f+3P/1qveoNTXg02PBBiqNeTb3mZJNHCWo6ERGVu3WMYiLNihdwKMUIrYEkOOduprGnO7yr7GWwf6tEtDj2DSAn+1Gc/MxbbZhbSGclUsukqy6emnJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262732; c=relaxed/simple;
	bh=IArY5DTzdDPSUUvQK2In8+RZfOdkVtvngCCKmJ9Q4Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbsHTIZMsKR1wh8rsLiq5X1hbBMfrzI7H7VToIPRlMr/OXr9SUbfgUysEPb5UcjLfd0jzonPyb/p9ZPk1JmnJpH0icKYumVpJthr6yLwU0XLJOJu5kqv2D9tWZdTnWOX/FyBRavTkhH/C1vLF2tJA41+z5MPZFNgvzDdDFhOm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=c77fCKQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1y/xNYf; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 34F7D32003D3;
	Tue,  6 Feb 2024 18:38:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 18:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1707262727; x=
	1707349127; bh=9lnv92XPZMe9+5e06+LHKt+jj5D0C7RYADZtxhimSCw=; b=c
	77fCKQoDO0iyjhxwOwyJq0VZOoWwbg8IqQJ9D8vfcIDVtlMf/h5OTAeautVvRNvq
	swlOg1E2zJeNTtDhxsOnJ2JtDn4ngS1B/DqWmwFAJQOL7Hk5NWObjGvFLpAyb97b
	ZFjwpLvzPJd2bH4PvepaYU9AU9vFsuEursWeoZeYt2TwdU8lJLWVAHr7Oz8psHGP
	QodM8O+HDZwmFrSK/GNAwdpmsPP4ZLJjblLa8ctHn1i1NUiAyl8ddZBtyQagNmYD
	G52vOZcPgVa7H8BM63xBfaLKADT7n7UwLGiKE/mW+uTj0aRuA93J1frKQ6fR+odN
	XrpLW9ndZpQENCwox00Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707262727; x=1707349127; bh=9lnv92XPZMe9+5e06+LHKt+jj5D0
	C7RYADZtxhimSCw=; b=M1y/xNYfryX50WqA4OmrgnB5g5HY9GlW7pUAYBsCCGXu
	hPif8c9EtT0FMbAGBNmnqsf12qKhGPJLb/SvdeRFNpa4WLCE3YfcBxNW77OzTJD4
	IWrH8fslGe4x39EYeXs/+6cM1qbjUMinfEJPn47/IdkFbf7DZn6Z157aoA03K79K
	dpVr3HNyNSMx+n+c7Urn4dt/8MUZAqbpT9TCWMv+CtGc+S6WFMNU+UPM3kiTDCLq
	1kDL5vfp1D47DfqZgw5TUaDqYr5EQhYGVuq2eVU+ImAQOq05TTC4IXLcBFjA8lke
	L+jWuLDxffedu0K1rix9tCYG3MmCs/8i9RLUU39amw==
X-ME-Sender: <xms:B8PCZdJpr2yMKKcqsntMgiZnjcn92Kt1CLL2o6RbTYw3sUUGzILzlA>
    <xme:B8PCZZLWUNEhiLoz7UzyQMnsZxCZOX5bmP1hrC8mMvJN1IJ2vOhY1G1kURtMHc0gy
    zwNWQqrSsNHOpudsbY>
X-ME-Received: <xmr:B8PCZVvgKiL3GvMXwteLB4vtAq7TnEDUhHC2x656S0E-2cK6aPNJdb-5j1JlWYtSqMDZPxocLUv4FRU07fEPrklcyN1R_6o1FY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeej
    hffhgeeutefhfeeugfeggeduhfekffduhffhheekhfdtveefhfejjefftdfgjeenucffoh
    hmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttg
    hhihdrjhhp
X-ME-Proxy: <xmx:B8PCZea0mhQFALGGu4uA1fQfGUV5SwliAjpywnC6USlnjm1oAOHsOQ>
    <xmx:B8PCZUZusTh6ZgVOzn74lH1mHhlELeuP-l-9X-hNywPghVvx9xUdpA>
    <xmx:B8PCZSB0DWrDVft2cRIgPnsytTk_hx6AMOxqmFbBMWZSb_k5jyyC1Q>
    <xmx:B8PCZfw24dhyiWCGA5McGUGNdux47HfQg5pVBTUIFh9MHSA1qekRuQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 18:38:46 -0500 (EST)
Date: Wed, 7 Feb 2024 08:38:44 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firewire: core: send bus reset promptly on gap count
 error
Message-ID: <20240206233844.GA143470@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZcBwSuyYtPEqwk8Y@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcBwSuyYtPEqwk8Y@iguana.24-8.net>

Hi,

Thanks for the patch. I applied it to for-linus branch and will send it
for v6.8-rc4 in this week. Thanks for your long patience in the review
process.

On Sun, Feb 04, 2024 at 09:21:14PM -0800, Adam Goldman wrote:
> If we are bus manager and the bus has inconsistent gap counts, send a 
> bus reset immediately instead of trying to read the root node's config 
> ROM first. Otherwise, we could spend a lot of time trying to read the 
> config ROM but never succeeding.
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
> A node may have zero or more of the following roles: root node, bus manager 
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
> Signed-off-by: Adam Goldman <adamg@pobox.com>
> Link: https://sourceforge.net/p/linux1394/mailman/message/58727806/
> ---


Takashi Sakamoto

