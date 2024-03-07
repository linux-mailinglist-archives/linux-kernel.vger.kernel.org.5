Return-Path: <linux-kernel+bounces-95866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0513D875449
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD380289909
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105912FF65;
	Thu,  7 Mar 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jQWoFk7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1hpWE7+"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06112F393;
	Thu,  7 Mar 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829461; cv=none; b=f4YBuqXlq+Ropmru8DSCe8RB7zae2ZQXBiCUIRxSyf+m7VY2MY/mJe3CZHVb4lTTtNNGxAT3xUTFiEiFClRJhhPnXJAj7srX6PxDnXNYuberKWWYcl59oo/9beVNPHximj6jjCFIdd85E4oJfwFYXkY28oT6QqmNRNca1Oce3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829461; c=relaxed/simple;
	bh=2UwQ/3+hZDOmDtUxHdUaBjK08KKgnnmo/Hpltvw0Fx8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SOQS58AqtoXLwnhUofyQG4R9MDh6KVvRHxMmPqCMhw+f1i3upOP4/VV5l2c4gf2iLJdhjw+5shCCE1RavCBrDrfYpCetBTENl2UO65ycIAWVm9v1GNGwLQUmCA0HEXdmE2qbDI314btBNvO41ao0avxpRVw2ScSEVr8H88/HKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jQWoFk7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1hpWE7+; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id CCF2D1C00095;
	Thu,  7 Mar 2024 11:37:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 11:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709829458; x=1709915858; bh=zm57BWWKRt
	lKrAeEYm5SXUcxUkXEWzE2ICyPiQaKdnw=; b=jQWoFk7uGg8OwU9n3vq+E7jA1S
	JI5YDg633AjJgk8W+NqwdcG1W3dfask6HCoPM8YTxQ7qN7ZkF6m1UgxswRcwiCnK
	z6yeXBWtjqD+NhDJXFJDFdwtmCiO+wE3g7hkj9aeqZJjJBzkj3Y0IuGBtLxY8rB2
	WU4il5MEEd8XmM7BY9D81r3qDQncL4VNlxRGsA1MpZB6Fk+0CACyXEXwtjg2HiYo
	N/l1K/QwLn1FwCl/lykAr8ikSfQa5ep38DPnYY+DI+A0neQ8/SC0LOTdQ62xpCGP
	LkYRzb3tlCZUuJdW15+eQOUw/z15tmbCMiII4Upco89OCDEaG+EoVUzEwcow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709829458; x=1709915858; bh=zm57BWWKRtlKrAeEYm5SXUcxUkXE
	WzE2ICyPiQaKdnw=; b=W1hpWE7+yAcJjD47B8hs7D70imGpBnv3WJEApru7rBbP
	+4FMxR24CmicDwZkONLm2an59hFgE/e6vJAjpGC5udQm96gAGt6h+a60BQGgWoCb
	2wrMmup62eeMN4tZ+DI+dJGDICITFEv/S6rqSjs+x5+SnmSCkBFzbENZWY5mIKan
	6E/mmjrHwveECM4S5lRJju+oNOGfQVdD00LIDVeIqgxWS91m6vGI5bzbfJZoqTt5
	aKFgkNO/aYKxO1hfxMs8b0/UHmhOCXg4fUu8eNChl+JpMNNFDQcfYAySZscxmm1M
	ECaEHMPXze2BTvfAVGogyYyKyB1+AuhC0na/FSNYvA==
X-ME-Sender: <xms:Uu3pZYOgDm_lr72DNMYpwr3iXcbxojQmbuzam4nfhAA-DIhe_vLYnA>
    <xme:Uu3pZe8lKkg8-NzUGcp2mlBXU4uyonUPzqb1sBKsp0n-2FvscuFXo-oVUta-B34XH
    Pu-8qU8zvzfcyPaJw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Uu3pZfQ4u8mIZ5xPCQmLMZtt7ZIRUwtqU6kpA13Aa6BrFnPyIfWSjw>
    <xmx:Uu3pZQvktXfGkjxQMa8zNpYIpnO_RJRypy3qXAe2UV5yDRE0_oIaAg>
    <xmx:Uu3pZQe_u2MeWHG32GX1X8HrzH6BY24bW1cN5-daZY1HoWH6iBNZyA>
    <xmx:Uu3pZXxGOjWMFikQ7P0_IOrovpF06qaXaB7t7CHKZgyCBseOu6DmSPXD2RM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 04133B60093; Thu,  7 Mar 2024 11:37:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64cde1d1-1d4f-484a-940f-536c1279287e@app.fastmail.com>
In-Reply-To: <20240307160823.3800932-3-andriy.shevchenko@linux.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-3-andriy.shevchenko@linux.intel.com>
Date: Thu, 07 Mar 2024 17:37:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>, "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: Make num_chipselect 8-bit in the struct
 pxa2xx_spi_controller
Content-Type: text/plain

On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:
> There is no use for whole 16-bit for the number of chip select pins.
> Drop it to 8 bits.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  include/linux/spi/pxa2xx_spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
> index 56aba2f737b1..e5a4a045fb67 100644
> --- a/include/linux/spi/pxa2xx_spi.h
> +++ b/include/linux/spi/pxa2xx_spi.h
> @@ -17,7 +17,7 @@ struct dma_chan;
>   * (resides in device.platform_data).
>   */
>  struct pxa2xx_spi_controller {
> -	u16 num_chipselect;
> +	u8 num_chipselect;
>  	u8 enable_dma;
>  	u8 dma_burst_size;
>  	bool is_target;

I wonder if we could just move the entire header to drivers/spi/.
The spitz board only fills the num_chipselect field anyway,
and that could be derived from the GPIO lookups instead.

      Arnd

