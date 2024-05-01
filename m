Return-Path: <linux-kernel+bounces-165198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8094C8B8961
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C921C2301E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753A50A65;
	Wed,  1 May 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WHxdslQs"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FD1758D
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563575; cv=none; b=RrP3iH5xZfmv5empCrN5lVH0xsFMntwhcypHgrvmhaA7fN6gg//lRucXFLTMWvYAwxoNk2bqU0DNGRIIh3BWpdCVtRaGkxM3270VY5DYFbOkkHyOvtJ5esb/0y8KvjQ2gK+1UgCg8zL6twX9kdv3fJs7Iff6lm09cVY5zvtro9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563575; c=relaxed/simple;
	bh=zE/LWOEqu0Tmhm93sSwUBTn6WQCXkZ817g4M5ORksZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYDh5JjQYSa1V1t0Xxc0vr1B8toLK/0kshN8lIJddA23iCOkpnPZbGgsco3hCCnTsmGlZA9iI1SegnlK3R3jJu/6nu9URQD/5dOB4kwyE5I7d/AnIkSOTLmqP/GUnygD681k7JaedVmvpGLs0r5LB32Or+hSTY995dPU5reV2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WHxdslQs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA2B43F5FF;
	Wed,  1 May 2024 07:39:32 -0400 (EDT)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=zE/LWOEqu0Tmhm93sSwUBTn6WQCXkZ817g4M5OR
	ksZo=; b=WHxdslQsY8l/Lq5q56oazY5/EmLvajKZol2o2DoXricwjpSlwMyYncM
	NzQFZY/KtLqJZ+PPfvsKmsB0FoQiBCWbvFkDs4Er7KfCcKR/1xUDxrazEkE7aeMn
	Fbq4T14OK9ywNv9YLLDtaYAvs8CtAbluwA1fO79taienIEG3VDes=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1CB73F5FE;
	Wed,  1 May 2024 07:39:32 -0400 (EDT)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDB603F5FD;
	Wed,  1 May 2024 07:39:26 -0400 (EDT)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id A1D3DC00E9;
	Wed,  1 May 2024 04:39:25 -0700 (PDT)
Date: Wed, 1 May 2024 04:39:23 -0700
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: mask bus reset interrupts between ISR
 and bottom half
Message-ID: <ZjIp68AqHhegFmDv@iguana.24-8.net>
References: <ZfqpJ061hLtPT8XL@iguana.24-8.net>
 <20240325005828.GB21329@workstation.local>
 <20240401121800.GA220025@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401121800.GA220025@workstation.local>
X-Pobox-Relay-ID:
 7704730A-07AF-11EF-A046-78DCEB2EC81B-07713566!pb-smtp1.pobox.com

Hi Takashi,

On Mon, Apr 01, 2024 at 09:18:00PM +0900, Takashi Sakamoto wrote:
> I sent an additional patch[1] to handle the bus-reset event at the first
> time. I'd like you to review and test it as well, especially under your
> environment in which 1394:1995 and 1394a phys exist.
> 
> [1] https://lore.kernel.org/lkml/20240401121200.220013-1-o-takashi@sakamocchi.jp/

I'm sorry for another very late reply.

Now that we eliminated the IRQ storm, it makes sense to always enable 
the bus-reset interrupt at startup. I tested your patch with various 
devices, with a FW800 repeater, with a FW400 hub, without a hub, etc. 
Everything works OK. However, I only tested with XIO2213B OHCI.

-- Adam

