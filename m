Return-Path: <linux-kernel+bounces-165833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3D8B922E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B43B1C2117D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F318165FD6;
	Wed,  1 May 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nEPLbHnv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H4vhHlVX"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D6168AE4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605577; cv=none; b=NM9CG204mn24rbUywJjufC5FiNPNgXi7GSW5HW+j6vgvqIkhNAnFDoVZUTKHyuDDmZO73Jt61moZtHqTFoedlcZtdmLJ3rsEMIysqNndLZmdDjyP+KU5n119u7bZ/klKldht8sCCs9fCWShbBviqZTbEevd9I2G5fQfXYPU3AOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605577; c=relaxed/simple;
	bh=BQsvHIpsbm/ye5b6OR/dSwwmp8PukAId2ZXHkT3Kz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzXAyT+8AtBRTo0PlD6qrAHaJMt4fHlfHdj3+gkTlGMPxE9xtlZbw742fF3xjq6X8EnehSy0d4llxnyHBwsMpOTFieMUgi6f0u0vTuVtLuFBz1MW3GFKkyJLEaf1HL73m5WkL24r7mBw0DBnNKX2Y6CxTsXDvVctggmMNftESEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=nEPLbHnv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H4vhHlVX; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id C91B01C0016C;
	Wed,  1 May 2024 19:19:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 01 May 2024 19:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714605574; x=
	1714691974; bh=aJ9bQTQ0bXFx75w1V4iyVyCDpPwSIeyvhFaFFkaoznc=; b=n
	EPLbHnvn7kk3Q6HYjNnt/OXnh2RN8kQC3XElkRXx4fy6QTwG9blEl6lkid8ZwMim
	8FQi8ec1df3ls65liqVggKMSjpM+QBFJr/mddTOIjhWNETefC3/JXegbfOaBUjer
	JISoUSTAo7y804jT37zdEoPkQsZQPeL0dAl9yMsNVDHOdjFD873E9eSfrldfA/pX
	ajgFI5Y5/gDTED430KysQOfkugOQII5d40QyYK6mUXwso3a2kxYYuMCq7z5yEF/W
	ZM4KeW4ndUPYoRjnqbzG0XQARkQGUo+eW/tDQI++l+Dl5CK/nAL2j3r2GIyz2z4R
	dvCZSoYSQKWDHva1v/niw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714605574; x=1714691974; bh=aJ9bQTQ0bXFx75w1V4iyVyCDpPwS
	IeyvhFaFFkaoznc=; b=H4vhHlVXcT7kw8wLXefLQE0IW9kvUA1YOGNJ+6u3jMt5
	r9vulwR5ilNwStsg3THwnqPVsQ8u0Zac1wWi3eB6BRtNa1THS5QbRUZUzOf0OOdJ
	0qa07qFx5UdseBIzTtekvG7ovSPmFR9sCXiAed/1opVbxbHoWzIW+8mVWzc53W16
	608mf3dInts22j0emQNJYmmmj0vyuQ/ZNO1FQ1TyzWh6NuoIriE3rojrou9dQ3Gy
	5vzRy0ksA6XriYxxs6C4/YI1PMypzbGdP31xC/+GGZMRhlmdK+IvkHLcjVZsIdp2
	/T9AVVm7Q5J+i4rhTgqFeAE4ivCYYBJ/gopfF7mwyA==
X-ME-Sender: <xms:Bs4yZuRj43ouOoEpzP8FU7k6rpScrGu09QeP69ppwqQFsSLibHkkmA>
    <xme:Bs4yZjx8trRk0btoDEE8pQ_n7Ao6XmyIkqVKoP2oF0zL8UKnvFIyhQldpBP9aJ-64
    AGYops0DDXj2DO3Uz4>
X-ME-Received: <xmr:Bs4yZr0lAWzSUccET_TrZW6auV7zr4dIt8Z8_5_4q_KoQG-UT9lA90VPCdVHNAz_CDB0ECLb8kVf8G2S6eDc0MnORsuCrzjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Bs4yZqBLhPn0s0kH3DDdkD0LhW7U9VHdrcG9Y54R4AsKQLO1k8xytg>
    <xmx:Bs4yZni3Cc1erQbDWL2xgUxdnkm_4V0xAmlv22bP1KhhpJUSDqoQ6g>
    <xmx:Bs4yZmqKf7uSx2_MfxSilQVE_d4GtThPJjKXXLt00SZVYdHP-mPWjw>
    <xmx:Bs4yZqi8_mMMxL-AffjltSMYssZjEvGhCbK7cxX6NpBoWfxmvVq_wg>
    <xmx:Bs4yZksTYx_eDfEVfaQ_VLIuW8wInPg7bPWNQ18YPbp18VlzDcERlPMq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 19:19:32 -0400 (EDT)
Date: Thu, 2 May 2024 08:19:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: mask bus reset interrupts between ISR
 and bottom half
Message-ID: <20240501231931.GB106963@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZfqpJ061hLtPT8XL@iguana.24-8.net>
 <20240325005828.GB21329@workstation.local>
 <20240401121800.GA220025@workstation.local>
 <ZjIp68AqHhegFmDv@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjIp68AqHhegFmDv@iguana.24-8.net>

Hi Adam,

On Wed, May 01, 2024 at 04:39:23AM -0700, Adam Goldman wrote:
> Hi Takashi,
> 
> On Mon, Apr 01, 2024 at 09:18:00PM +0900, Takashi Sakamoto wrote:
> > I sent an additional patch[1] to handle the bus-reset event at the first
> > time. I'd like you to review and test it as well, especially under your
> > environment in which 1394:1995 and 1394a phys exist.
> > 
> > [1] https://lore.kernel.org/lkml/20240401121200.220013-1-o-takashi@sakamocchi.jp/
> 
> I'm sorry for another very late reply.
> 
> Now that we eliminated the IRQ storm, it makes sense to always enable 
> the bus-reset interrupt at startup. I tested your patch with various 
> devices, with a FW800 repeater, with a FW400 hub, without a hub, etc. 
> Everything works OK. However, I only tested with XIO2213B OHCI.
> 
> -- Adam

Thanks for your test. The content of patch is equivalent to the first
one in the candidate series[1], so I appended Tested-by tag when
applying to for-next branch.

The for-next branch includes the commits to provide the following
tracepoints events:

* firewire:async_request_outbound_initiate
* firewire:async_request_outbound_complete
* firewire:async_response_inbound
* firewire:async_request_inbound
* firewire:async_response_outbound_initiate
* firewire:async_response_outbound_complete
* firewire:async_phy_outbound_initiate
* firewire:async_phy_outbound_complete
* firewire:async_phy_inbound
* firewire:bus_reset_initiate
* firewire:bus_reset_schedule
* firewire:bus_reset_postpone
* firewire:bus_reset_handle

All of them are used to trace the action of firewire core function,
instead of 1394 OHCI driver. I think they are helpful to debug the kind
of issue which we handled for v6.8 kernel.

[1] https://lore.kernel.org/lkml/20240501073238.72769-1-o-takashi@sakamocchi.jp/


Thanks

Takashi Sakamoto

