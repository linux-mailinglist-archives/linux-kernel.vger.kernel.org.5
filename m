Return-Path: <linux-kernel+bounces-165827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49F8B9217
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DCF1C20E14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331A168AE4;
	Wed,  1 May 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Lxhr1KIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQmShT7U"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB70168AE2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605258; cv=none; b=LHqO6KgHMGzHIwwF0ITPWGaRurTxYtQAUx4eMSJHpirCJlzUBUKMlr2RD1bpHmD2cgzM0WyzxRoMV7UKNObRhepvyRDXXzUh46uLylMAnHHRAWX/3RYcltaYCCCr9TcMJW6+Mok2/swd5wQLPkiK9r5dk6e0WR/E1lZamh2EVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605258; c=relaxed/simple;
	bh=AiqxsKjFKvp/SSZ7vb4FWRu3hvbAWkDogSSTrauTYPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiVy+G+aGyKRHa5OZ32YIduTBiCkFuu9FV2MQmUaHMHkiDT3x/wXsYWa6DyVn4ZGYyBY4LLnRfPUCIDzW9ZpZKDRQxy/x01MfwuCXo8NSrm4HCUrwxrL9rN6BJdmy+RpBqYa6gUaSWwEgM+S8tS0Dog90LjsndoWhlsIqqsvqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Lxhr1KIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQmShT7U; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C63D718001AE;
	Wed,  1 May 2024 19:14:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 May 2024 19:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714605254; x=
	1714691654; bh=LGBpfsfi1Wa2XZqumOpfSa70+soAJ7ROMnIXyxLaxJM=; b=L
	xhr1KIBXSIGKhTDSwFtwCxJrtrg8yLtZkfRbApMQk04ZvCjFemUooob0vRLimEV0
	aUrcUvqU5P8oAdxfkFPMwJpGZhdOEmMx/NRNRjKygZijwp1IuCAI6eQlIPHVQGiy
	/9HhjnrX7zOP/mHbbeQW4gSku6QeU0SuUi2+kbPuGykOsVts6YQeQ1q43cy3f8Mi
	zZIkthpQ1plC31UFghzp4DtpddeNIKgCg0EdwfpQccemf3OwIZsX8vPHlSjGWrtt
	JqU9ZV/Vw1BGiEFY51KudZAxECn7dAJW01TZPf5xkGOapuNag6AmdG4NIRNPucj/
	Lh84X4uj6mWdsASfH0J7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714605254; x=1714691654; bh=LGBpfsfi1Wa2XZqumOpfSa70+soA
	J7ROMnIXyxLaxJM=; b=SQmShT7USHei3dws+1rm3m1358/r2FIN/MpbL8TlQM1K
	0yEAnspPLQGPaBVuGiV9yETrJ21SvQBPCZrG8gAYQDtAArC10LmaDIhPgGs4VWSV
	d3SZxX8KVX+xMWcv+XasS59eJdwKAJ2SkIRzF+8JneWJskHjE0iBE5shEn5Ws36N
	kWqqrVgVSuysnBScPDFa/dMokZXx0DiqQ4edqBp8/kWvZsmlSnZg1TZDVSHKq4Gx
	Q4QdVIGkVxufsrag34rDjbZX1POWQyzPcw8De6It5hg1hTimXuDgb09hDJSKewn7
	cNK7pu0c6Z692I7uEbG1fYV4aBmBAuQpb57Ho6fbig==
X-ME-Sender: <xms:xswyZqtsg806iXZeFUmHer5HpTnVbqnDLtuFKFPCrkkhD_WB5WXItg>
    <xme:xswyZvcCMVTlEETK4SbEXyp8AaFlFT5610dFLx7fc7Cnscbk12eq8z3_MqPo7iYsZ
    ejkKbnSaRIh8qg2uoc>
X-ME-Received: <xmr:xswyZlyFnMZdPRaLTd0LJ1JVOxeU3gmJN5tz-lISapdkkDk4bv2ci0rGJnwkwtC7267PWy3mW6FyKqtvlZbvmLorvefp9lj5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xswyZlPcKC7QkqKMf-KT4Y0O9y1C5Z_aVIisCvtuLX60K8G611pHZw>
    <xmx:xswyZq8lILCgqTDBmRVpJ4cg3OQFM3t-wkx_tYvq15czWMkgSnGTIA>
    <xmx:xswyZtXhxd_NvAsUPWZGV-Zd9PEmzdJtsGvWM5T9iFTtGnPRhVeQCQ>
    <xmx:xswyZjcXIGk6yNSkgscSanAhaxb2BZkBd_UFpsEX3plTl1rMREDIfg>
    <xmx:xswyZsKZoov1_uTTV5OYBRRJUXI2Xwif-29k72jphASDbw7u8tIcmH6D>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 19:14:13 -0400 (EDT)
Date: Thu, 2 May 2024 08:14:10 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firewire: core/ohci: add tracepoints events for
 bus-reset
Message-ID: <20240501231410.GA106963@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240501073238.72769-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501073238.72769-1-o-takashi@sakamocchi.jp>

Hi,

On Wed, May 01, 2024 at 04:32:33PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> IEEE 1394 bus is under bus-reset state when the physical state of bus is
> changed; e.g. bus topology change by adding new nodes in the bus. It is
> important to handle the state appropriately for the maintenance of bus.
> 
> This series of change adds some tracepoints events to trace the events
> related to bus-reset. Some kernel log messages are obsoleted and
> deleted. It also includes for 1394 OHCI driver so that bus-reset IRQ
> event is recorded as much as possible, and obsoletes bus-resets bit
> from debug parameter successfully.
> 
> Takashi Sakamoto (5):
>   firewire: ohci: add bus-reset event for initial set of handled irq
>   firewire: ohci: obsolete OHCI_PARAM_DEBUG_BUSRESETS from debug module
>     parameter
>   firewire: core: add tracepoints events for initiating bus reset
>   Revert "firewire: core: option to log bus reset initiation"
>   firewire: core: add tracepoint event for handling bus reset
> 
>  drivers/firewire/core-card.c        | 13 +++---
>  drivers/firewire/core-topology.c    |  3 ++
>  drivers/firewire/core-transaction.c |  7 ----
>  drivers/firewire/core.h             |  4 --
>  drivers/firewire/ohci.c             | 18 +++------
>  include/trace/events/firewire.h     | 61 ++++++++++++++++++++++++++++-
>  6 files changed, 73 insertions(+), 33 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

