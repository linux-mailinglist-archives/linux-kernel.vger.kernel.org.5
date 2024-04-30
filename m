Return-Path: <linux-kernel+bounces-163963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819A28B769F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DD01C227FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BAB17166F;
	Tue, 30 Apr 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LYg6KpbA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwktPQ2o"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9617164B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482669; cv=none; b=T+UW8fJ/8kLK72W+uBDRR89CYwwbAMmJW/ZKq4dcWf7wcYPJE5b+wKsXBVqn4XMOiPVgpkLUqq51sWKHUmXYFbvbLITLikDKOPchNAlaX/gRL5pbpbeSRpWfOSJ5YuqfKB6Apu4umxNwOYpM3G4VbkxcPe+2pYGovrBOmutUhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482669; c=relaxed/simple;
	bh=LH9AX72f5F1IwKelNUFpMKjWIxxueo6ysl0dj3hRCjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Rm5T7O+gw75yQPFYVJmom+1Qowe0mQR5v0Pa+Pto4iRS5hi+n4rJ+X7uujr+eSRJjIOpj/Fc1o/yumqXvCppqS6w1DAXuhTSaEp8A3L0165CpJg6d+FXBuNsvP79Dlq49mX4dVPFqMDtlCLjPzsDF+Yk9f+sgnv/SDxU4ptRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LYg6KpbA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwktPQ2o; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CBF0D1800125;
	Tue, 30 Apr 2024 09:11:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 09:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714482665; x=
	1714569065; bh=bmnKQg4HJkWbFP4JL8uFAX2dV8OePxoK7bLCssuU2AM=; b=L
	Yg6KpbA+V1II8lfo6lP55lmlhmiEuA6l8bX7Dp7maQnHeH0M5GwH8qBVk8thF3ch
	2WD3S2xINi4Xd/j6a4DjlyVNsRz7RdQSlMlfIgeWM6aib9B8C5d54HDHLQKc5PpX
	h7aIpjHA/loWoYLSeoIs5pRL4INvMr0AQlkRYBB8VFDaZjC6mxljYuunqYYGcqTw
	9n2xLi2PHJEfP01utISe6mD22tSGBMNJbjaEfgzKSL9Hmfy+8HaX4xeb6FoghYZ/
	3c3bCtGceKIv8I/hHAzYNKGN9eH49kRgv3DXcI2sXsipVn7KqY+C63inWB3B3OGg
	LtRtW5ObuC7zAJGitU0ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714482665; x=1714569065; bh=bmnKQg4HJkWbFP4JL8uFAX2dV8Oe
	PxoK7bLCssuU2AM=; b=HwktPQ2okoRBy4AHIGDduYT6OvhyROLH4YRWdPWm4NG8
	DHkNpR4kICMaVH/HIFjmSsG00Ro/rw3I8SSLcp/ZqW4Z4D0OZmM5FZxhKfDtw3pr
	CPu7c7G9s0m/CCAG6PmtrNMjqTN0PAxB2yruOneWIqN6klClNCi97WnnU49WbZtd
	RexK50EohYPO3JzY6rzHWeL83cK5jAPjTo/iiiOpZRuvDRttIgIoaIdu75zZvUVR
	30uOz96aZ2P5hlelTdlOmeRVs4C+AgrkEJHOCAYbr0dN7Nf1b5LIILwSC2GqOu0v
	oh5brEsXDE8bF3t336pXZrdbpOyDdUjUp5EL0JtrNQ==
X-ME-Sender: <xms:6O0wZiRYlb0qMSGVf1T-YeVK0nPqyVpQ7jMn8EEufqdCnbeFGywnig>
    <xme:6O0wZnz77KYaJAq0AuWNGuMy0iXAuLqi-lJEvYn2N27-hZftzNCBtQl5x8MSiySra
    yDRjGMKztQZ_3SfDT8>
X-ME-Received: <xmr:6O0wZv3TiFKuiTXhC1gnfllexyVXN-H7qm-NaOUAqjJYmG26aP2Ym3bfe6gtEPwbqXY_C5h46-cMtKSWS1n6laXeMK-RE-96mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:6O0wZuD81ipGu2q4Crkx_nvTfUcQFoAxFPVUHmT5vD8o1Y1RFugW8g>
    <xmx:6O0wZrivfv9-3g6GbDlXSXblFjM8Ow8BCwSLHNev9JetuORs_1L8Lw>
    <xmx:6O0wZqq9Vqk2myGp7clUvOwyfdpCifYm2YZylSrHHWJr74yrKBM-4g>
    <xmx:6O0wZugOq79va1niiKWHFE8FUwvXLA4aFh9kvzMx0CPgMqQ7Umfc-Q>
    <xmx:6e0wZuv72gg2jrw5w-nNp7cBHnOedeAVkXqsWucxJAe0YXgNHnn9REwm>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 09:11:03 -0400 (EDT)
Date: Tue, 30 Apr 2024 22:11:00 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core/cdev: add tracepoints events for
 asynchronous phy packet
Message-ID: <20240430131100.GA7699@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240430001404.734657-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430001404.734657-1-o-takashi@sakamocchi.jp>

On Tue, Apr 30, 2024 at 09:14:02AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In IEEE 1394 bus, the type of asynchronous packet without any offset to
> node address space is called as phy packet. The destination of packet is
> IEEE 1394 phy itself. This type of packet is used for several purposes,
> mainly for selfID at the state of bus reset, to force selection of root
> node, and to adjust gap count.
> 
> This series of changes is to add tracepoints events for this kind of
> asynchronous packets.
> 
> Takashi Sakamoto (2):
>   firewire: core/cdev: add tracepoints events for asynchronous phy
>     packet
>   firewire: core: add tracepoints event for asynchronous inbound phy
>     packet
> 
>  drivers/firewire/core-cdev.c        |  7 +++
>  drivers/firewire/core-transaction.c |  8 +++
>  include/trace/events/firewire.h     | 78 +++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)

Applied to for-next branch.


Regards

Takashi Sakamoto

