Return-Path: <linux-kernel+bounces-41116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2883EC0F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887F22860A9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24321DFC5;
	Sat, 27 Jan 2024 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="hMyWf+g/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xZashbmN"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AA1D52B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344659; cv=none; b=OQNkAoPIyrAKsWrZ5TD58Qz8AUfQI9DHhP4w0xTh7jDfYHnxrraMy0xGkqUewAncmng2OOTNS9z5yWD3juJKqvdV7LHNHln3twN686OVNvFkMU0iNqsYGoPdzlCCIlNQTbXY+RQXppmRKtLQklVr4mZJRk54Pcas3Ivv21N9DHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344659; c=relaxed/simple;
	bh=ViIHgp/KdfRtbTI3DQt3LG//KAcvh08EM2nQtFTD2pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrwOomHLCAuewFTW6Q7m+cBxjVET1Wd3WCtZXJ7cqdXBThI3hBaNMb84neChYkzYnvGz5zhKfIvgPbKUBZ68DeYvSN+JHFtPg4oYpcUrJTZyWW169nd/WoteWuBLx5IfC4B13TMZWx+l/gZMi5CzZ/6H8YD34sHHtARn1AjSLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=hMyWf+g/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xZashbmN; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 39FDA5C0194;
	Sat, 27 Jan 2024 03:37:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 27 Jan 2024 03:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706344655; x=
	1706431055; bh=HBAy1ON+KFlap7KUmYNJGUyFHczf6v5pNQNbPjUNgjk=; b=h
	MyWf+g/kYDvjIerXQDV9US18+04iZiUbBXdLEvqlPMehKVTbFmJgNnorffrj5SLK
	N2a2FzYyV9w0Zrsd/We2Mv9jc0xePW+vN5cp6SN3EIoL480KOxTV+AuOkcRxyAP9
	S5xRJ95veMV/7ytWPZ8EiOk7ruHZIsSNr3uAq+PsYsVj6a5dCFJxzn3V1hg+0A2z
	KNPfpnkuIk1NSK+MQTvzo5liyKSxAocC0aNC6TvYgfH5W5LXT3vJVPbLXA5BmFvd
	2Jsgv2/8boXKAWpHTR92L2L1ieDlDYA23FvRC3ZZhqzoKOi2xhrj4GSF1+fFMOkx
	8DAyCFZ/GnOe9ZsOTsY6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706344655; x=1706431055; bh=HBAy1ON+KFlap7KUmYNJGUyFHczf
	6v5pNQNbPjUNgjk=; b=xZashbmN/chZ+5ZAenlnOZjZ/VU4LTNcYK6IcjuSHXrG
	YMtN7NU2YRp7mfaMqgh+bN+veSm3PHtTa3x5S3StsRr05FLfLAFHnRT8yy/TUdkB
	lJlrCO94cjekZjIW+ClkyUArGNCAbiClMSdcNgXAA8zPGxEIm4CXZJInnaoD4rV5
	VLXcuTNaNyg4j8LQ+d+Agy7MNk5+KfggBRDH79/K/J+HncYI0iK6K8+nLGp/hJWQ
	2LyJzs8fu7cuEeoIBTNC05OOoKUlN4p/TYnfjab4KrDlxmF+ZaVJpQztjRrCmZ8U
	VFRSs0HsPMt1aM2JZRmu02vVd5CjXYR+WRM6U8wSgg==
X-ME-Sender: <xms:z8C0ZYeKm5sjPkvs_KO5mzGnUN5i58iVLb1nAAIakYjt9u2uKXcwUw>
    <xme:z8C0ZaNhGQ449_6ucmp8JKywBCuNEJl3ghXqPSVnoLsJuU2kgsVoknLN0rrIII6gu
    Baet95d2rPhUFXLR1I>
X-ME-Received: <xmr:z8C0ZZhcKyLdDE0Q8WN1DRLUpY1HsE_ZUkVq2Q_Ly4NabU4ARFG-6mowPoHH2fQHoBWC2eoixQ7SLX0uHUBSGHHpPF8kqQB-dbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhn
    peejhffhgeeutefhfeeugfeggeduhfekffduhffhheekhfdtveefhfejjefftdfgjeenuc
    ffohhmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmoh
    gttghhihdrjhhp
X-ME-Proxy: <xmx:z8C0Zd9oqvIR2eXy32OXys8xw64gxyMN6OSxH3Z_URL7DAE_AQ682g>
    <xmx:z8C0ZUvFnrjtaflZPDQ-PGojTSi7zVFi5k-5qOxRMDGv50PqAgfaGA>
    <xmx:z8C0ZUH_5azjfRmhJQQU-pjj3zvPnxaRGCx0FnpGPh3Xo-53NibtcA>
    <xmx:z8C0ZRURrOPybB79uzo8CgIykCEL9Z62P-gTvBsSCUr8TWB6Z11f9Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 03:37:33 -0500 (EST)
Date: Sat, 27 Jan 2024 17:37:30 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: send bus reset promptly on gap count
 error
Message-ID: <20240127083730.GA159729@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Za90vAQlDhbLpY67@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za90vAQlDhbLpY67@iguana.24-8.net>

Hi,

Thanks for the patch. I would like to check some points about the
change.

On Tue, Jan 23, 2024 at 12:11:40AM -0800, Adam Goldman wrote:
> If we are bus manager and the bus has inconsistent gap counts, send a 
> bus reset immediately instead of trying to read the root node's config 
> ROM first. Otherwise, we could spend a lot of time trying to read the 
> config ROM but never succeeding.
> 
> This eliminates a 50+ second delay before the FireWire bus is usable 
> after a newly connected device is powered on in certain circumstances.

At first, would I request you to explain about the certain
circumstances in the patch comment? It is really helpful to understand
the change itself.

> Signed-off-by: Adam Goldman <adamg@pobox.com>
> Link: https://sourceforge.net/p/linux1394/mailman/message/58727806/
> ---
> 
> --- linux-source-6.1.orig/drivers/firewire/core-card.c	2023-09-23 02:11:13.000000000 -0700
> +++ linux-source-6.1/drivers/firewire/core-card.c	2024-01-22 04:23:06.000000000 -0800
> @@ -435,6 +435,16 @@
>  		 * config rom.  In either case, pick another root.
>  		 */
>  		new_root_id = local_id;
> +	} else if (card->gap_count == 0) {
> +		/* 
> +		 * If self IDs have inconsistent gap counts, do a
> +		 * bus reset ASAP. The config rom read might never
> +		 * complete, so don't wait for it. However, still
> +		 * send a PHY configuration packet prior to the bus
> +		 * reset, as permitted by IEEE 1394-2008 8.4.5.2.
> +		 */
> +		new_root_id = local_id;
> +		card->bm_retries = 0;
>  	} else if (!root_device_is_running) {
>  		/*
> 		 * If we haven't probed this device yet, bail out now

Next, after the condition branches, we can see below lines:

```
	/*
	 * Finally, figure out if we should do a reset or not.  If we have
	 * done less than 5 resets with the same physical topology and we
	 * have either a new root or a new gap count setting, let's do it.
	 */

	if (card->bm_retries++ < 5 &&
	    (card->gap_count != gap_count || new_root_id != root_id))
		do_reset = true;
```

When the value of "card->gap_count" is zero, it would hit the condition of
"card->gap_count != gap_count". I think the transmission of phy config
packet and scheduling of short bus reset would be done, regardless of the
change. Would I ask the main intention to the additional branch?


Thanks

Takashi Sakamoto

