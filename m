Return-Path: <linux-kernel+bounces-97336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB68768F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC61A283C38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB81C295;
	Fri,  8 Mar 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XsOfXz8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KK1Jby4P"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753215D0;
	Fri,  8 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916973; cv=none; b=CEAC49sq0fQx8e21ZKRBnIimTgAbRAJxPWGG9xiNngLetHtVexen/iPhqJKs7jJTAFFwh7s4u8VC8HLAePckULOOrNkZtL8rqMiykFdPeHJt2eOw56fT3tDwRP1d5KnJdE/zrJYcu283EQ/km0W2aVxB6NXavp0Z8W3UGC+mwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916973; c=relaxed/simple;
	bh=r6uhChX0M6c6VxGFVC7vM450cA6B04bHqZgorw1HNmM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=M4rKr9i6RiCF2vQSEZmvNYjDUouEqu3FrHZotrfJ0J8SrFoD7rm7nlvfojAn36sGSQF83vhWC0wOANfSDJ7UVblsN7YpLd/By4hXtxozKjiga45dQteuk4FkxMIzOnPV/3DqW4SH4trb840ayd5S/YmaNKxNQkPu4vUy+LWmz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XsOfXz8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KK1Jby4P; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF35713800AB;
	Fri,  8 Mar 2024 11:56:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Mar 2024 11:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709916969; x=1710003369; bh=xnhX7BeGxm
	k4GyXvpk9AHkxVWY0R4hFv5lV38tPGFzQ=; b=XsOfXz8Hrc3z3uQcnfV4LZHI0p
	cg8hl+yYhAS7op9WmmA/y5q5dtBYZuICP5MKa/WErMm2861Aku/SD3+F21VrY5k6
	UoRlYFSBZUio7pHYjXoX6W0X8CdtD/BnMv3mDLQ75wiM4Bgjiy9ppeIuvFCSJv91
	vfqLg8G3YaUiRsRkmu/gxhSjQeUpI58/wGxXUZQ0dR6qR9amiVRJLA7JWPerf/sw
	fhCwIZcaLz8TLTPvk5PIbe83Mjj5zr4WiKz50YKekxy1qNA7zHygmS4G+66jbi6d
	WEONHu/uoc0zMync+OCisR8u74QUcbQk3GlyEr3VQ+MY58qNfLSxryWZLAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709916969; x=1710003369; bh=xnhX7BeGxmk4GyXvpk9AHkxVWY0R
	4hFv5lV38tPGFzQ=; b=KK1Jby4PfnfUScWKuMK4MSoC077hXEs8ssf+0Ietjz4Z
	cM1yLUhGzuLAA8bpZmnmdr3fycJkYHPvUe0vFmm3GVXimU1yz8KaDTGk+Nfqnifz
	3Mz/hgjH9z0lat62clYSbtszh+6RyZ8OeHwtRDwZBNXAem/r3t4XfVH2XStIZmE5
	X+wBapjIetzTU7rMeoqCOpwOugo9M7j/H2RNi4oSGAqfJgza6a1PQJmrb7T3IgrN
	zTLPWC1O7ZMl9bi7CI7Qc1uR+BgUxlgM8Wr0lI7JkQMNCX5oeEsNk8WiRnKRRmmL
	528NUjFiDAOlI3bPaL+qvvM0LNMnzRhf3g7e4xr/DA==
X-ME-Sender: <xms:KUPrZb-77X0uixuahGbxkTeUwfr41D-T2l2kZ4JXkyKGOsRiOWF6jQ>
    <xme:KUPrZXum8DLdNzxAsgOtv4Z7rKtpUWodo49nGzZEbESB79rSa0x_uhTYLlrF6jfi1
    1ciwlicWFlG6tmrvgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KUPrZZC8zQB-_8yI-wlBzI72EA9xJ4U66zYsllKF9HB7Rt4gqdYlQw>
    <xmx:KUPrZXcVpihXYHImq6WqC1vQFolXY-3w6S3ccRxZ0KwDpBIcv-nTNA>
    <xmx:KUPrZQPS973zsoDqZvM79gBaqaSzYVaegO-TPyFHl0AVwrj7yxL8uA>
    <xmx:KUPrZRjppHjw9ExvAyjG00wrX2gJA1ggoy0-fbjwF6GeWYvnm5-C2g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 10EAFB6008D; Fri,  8 Mar 2024 11:56:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d43790a0-d6a3-4178-a298-a86db68918e5@app.fastmail.com>
In-Reply-To: <ZesoygjRoCR9HO_V@smile.fi.intel.com>
References: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
 <20240307195056.4059864-4-andriy.shevchenko@linux.intel.com>
 <ZesoygjRoCR9HO_V@smile.fi.intel.com>
Date: Fri, 08 Mar 2024 17:55:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: "Mark Brown" <broonie@kernel.org>, "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c
Content-Type: text/plain

On Fri, Mar 8, 2024, at 16:03, Andy Shevchenko wrote:
> On Thu, Mar 07, 2024 at 09:47:47PM +0200, Andy Shevchenko wrote:
>> There is nothing from pxa2xx_spi.h used by soc/pxa/ssp.c.
>> Replace it with pxa2xx_ssp.h.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> P.S.
> I dared to add Arnd's tag from previous version as this patch
> hasn't been changed.
>

Thanks, I mixed up the two messages and thought I had replied to v3.

    Arnd

