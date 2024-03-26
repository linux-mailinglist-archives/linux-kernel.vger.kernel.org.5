Return-Path: <linux-kernel+bounces-118990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FF88C258
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43C8B2242C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3FE6AF85;
	Tue, 26 Mar 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="E1hUty5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RkZ3pIBz"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFF5C8FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456740; cv=none; b=R6yTtkOdqL41UzlJ7NSGPVLtht2KQ1gX5Cy6VBHET7ihvNIWAOlgBd00LLXl/QZ4NvFu/v2bqf0UjUs/C3ebyOW+97DPRT2OuqydD4Z8mS4FWn20Lbt0UsPyfk7Of4Ydw9PpOrWqHGi8LfcSyPlMJkd/4sQXiihHekWNR948asI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456740; c=relaxed/simple;
	bh=5vpBVi8l5SdPJOEq8VnBU5XwcDzOC3AOa50PlgKFA/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T54SlwRWHC4cfuwCTMAhywc4XJYFjCBTqDdy63G6+uINrnOobNcesKXXWhULEDYUy7i0q9VbPMDVuj3SpHdUxXRspc68zTpJ739VvwCT9HlGXyvFyzsSxQ+mZouf2UNj9czwF/ZbtrSCJyLmYx8hZnvuWackZle8sxE/47Juv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=E1hUty5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkZ3pIBz; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id B8A3E1C000B8;
	Tue, 26 Mar 2024 08:38:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 08:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711456736; x=
	1711543136; bh=SpN1i+9IU2YyhmBo6ufdJzLACq9EamCprJ4iEIQKtrI=; b=E
	1hUty5az9b1XwLJYZVo+vl6MYqo/f3dzKyBovCvm1QOa0ZvTJ40tvcyfvT2QYzMW
	2pGxLrX6vxNlg2zNPf5ZRy6WTVE0XChQgYKdbRj6MklSKvA1HRZiceVAGAaiTnCJ
	GIYeiw1rnuOx8XIDjsQcEQ0yoFy0gCeQuCER+dY6Kr6ImPIsMIu+OYSeVUcpt2so
	KIyDwjoufIy10Yu+Uev70OMi4A/hRjMNnk7svOmB2zje60YlrjSLQxpkGsEyMLCG
	04L/X9m8HT3RhyNgTKASbI5rDY+nv9s9P3Dy3hJ9ol2gnAs6n9MgEkssA3cIrYhV
	tTNfJgB1NKKw34bOYEKNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711456736; x=1711543136; bh=SpN1i+9IU2YyhmBo6ufdJzLACq9E
	amCprJ4iEIQKtrI=; b=RkZ3pIBzdXiu38ljJxqXCxCpmCscnBZO5XWEXaN8XIuo
	ODBnOmql2DchhALur7xClxP/UnJcbMwimrKblUMyrdutVlPO4AgRfPvpDiW0yqC9
	gPwXNuQAFn0hIW7JFymDp2b7DJO9q5Rg8KwuwZMxN9EffLsXjdk5TrsAxI+NexcB
	vxsBVbyGCmYb4O3JtEqYG3wIkTjc9W8w8y7N/NkanxHloqpnkn6lNfJWHW8lWr2A
	5qv43O7il8Srbslub7CVmQ1bKUvlGAaievO0Zojt0jLfX2XfwwEf9quyyKzEfv/L
	zkhHq/0WGKA3GdftQYkyXRJC2ARfvovxULZzFT9HLg==
X-ME-Sender: <xms:4MECZpDpw8cJwRBmV-ZdBNqrix5JQdTrBWx52QEttnTifhLF6m3qdw>
    <xme:4MECZnju94q9RTr_IRKCBGFKz1xTrP7u8pxDbQtk9_qDPTqfVc1VzZqQ9SKjL65WT
    XwumpV2FCrqKDl14rk>
X-ME-Received: <xmr:4MECZkmx0MlMTpkeUiKsYCsvasUfIz7Z-8kJVuX3Qiac3p1woVhrtHZIFz-SPe-mmkraiXQkDC9CPWiMWqOprp2jgKaeA7NQj9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepudehgeeuveetuedvkeekvdfgffelieeivdelhfet
    tedtveettefgffegjeefleeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:4MECZjx-Um8aHTaZk_W-1HGPLcXlrUZwBq46T7_a9aIogXhKzB49hg>
    <xmx:4MECZuRrHSfmpLukLH5bnlDx6nK4L0gA8jyg6w3R3wwbOC-vBOWeJQ>
    <xmx:4MECZmZkjMXgYSBf6Grm3TfU8dBUn844mgHJvGosvXt1alqu8RGdDg>
    <xmx:4MECZvT0n7PFJDAjTkKV0xwI-JdzAvMn0DOZZo0Ju9WxIL9czxqs0w>
    <xmx:4MECZkOu98iuUFVAY3E6R9hvIdbakumiq7G7UVHHyd0OrQctcX1slWwByUM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 08:38:54 -0400 (EDT)
Date: Tue, 26 Mar 2024 21:38:52 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: option to log bus reset initiation
Message-ID: <20240326123852.GA140364@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Zfqo43xhFluOgO01@iguana.24-8.net>
 <20240325004134.GA21329@workstation.local>
 <ZgK9GNLURNg63zRU@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgK9GNLURNg63zRU@iguana.24-8.net>

Hi,

On Tue, Mar 26, 2024 at 05:18:32AM -0700, Adam Goldman wrote:
> Hi Takashi,
> 
> On Mon, Mar 25, 2024 at 09:41:34AM +0900, Takashi Sakamoto wrote:
> > Now we have two debug parameters per module for the slightly-similar
> > purpose. In my opinion, it is a pretty cumbersome to enable them when
> > checking bus-reset behaviour. I think it is time to investigate the other
> > way.
> > 
> > Linux Kernel Tracepoints[2] is one of options. Roughly describing, the
> > tracepoints mechanism allows users to deliver structured data from kernel
> > space to user space via ring-buffer when enabling it by either sysfs or
> > kernel command-line parameters. Linux kernel also has a command-line
> > parameter to redirect the human-readable formatted data to kernel log[3].
> > I think it is suitable in the case.
> > 
> > It requires many work to replace the existent debug parameter of
> > firewire-ohci, while it is a good start to work just for bus-reset debug.
> > The data structure layout should be pre-defined in each subsystem, thus we
> > need to decide it. In my opinion, it would be like:
> > 
> > ```
> > struct bus_reset_event {
> >     enum reason {
> >         Initiate,
> > 	Schedule,
> > 	Postpone,
> > 	Detect,
> >     },
> >     // We can put any other data if prefering.
> > }
> > ```
> 
> Maybe these should be four separate trace events?
> 
> > Would I ask your opinion about my idea?
> 
> It seems that tracepoints are the modern way to make debugging logs, so 
> if we want to modernize the FireWire driver, we should replace the 
> existent logging with tracepoints.

Thanks for your positive comment.

I pushed my work-in-progress patches to the following specific topic
branch::
https://github.com/takaswie/linux-firewire-dkms/tree/topic/backport-to-v6.8/tracepoints

You can see some patches onto your commits:

* 145da78e firewire: ohci: obsolete OHCI_PARAM_DEBUG_BUSRESETS from debug parameter with tracepoints event
* 3bdad35d firewire: core: obsolete debug parameter with tracepoints event
* 30f489af firewire: ohci: support bus_reset tracepoints event
* 4937d9c8 firewire: core: support bus_reset tracepoints event
* 0da26087 firewire: core: add support for Linux kernel tracepoints
* 961cba18 firewire: core: option to log bus reset initiation
* b3124560 firewire: ohci: mask bus reset interrupts between ISR and bottom half

In the above, I added 'bus_reset' events in 'firewire' tracepoints
subsystem. The structure is something like:

```
struct bus_reset {
    enum fw_trace_bus_reset_issue issue;
    bool short_reset;
};
```

The issue enumerations are in 'drivers/firewire/core.h':

```
enum fw_trace_bus_reset_issue {
	FW_TRACE_BUS_RESET_ISSUE_INITIATE = 0,
	FW_TRACE_BUS_RESET_ISSUE_SCHEDULE,
	FW_TRACE_BUS_RESET_ISSUE_POSTPONE,
	FW_TRACE_BUS_RESET_ISSUE_DETECT,
};
```

You can see the above event is trigerred by two kernel modules:

* firewire-core
* firewire-ohci

When merging the above changes and build/load the kernel modules, we can
see 'firewire:bus_reset' event in Linux Kernel tracepoints system, like:

```
$ ls /sys/kernel/debug/tracing/events/firewire/bus_reset
```

I currently consider about a pair of events for OHCI interrupts and PHY
operation, instead of the above event. I'm happy if receiving your
opinion about it or the other ideas.


Regards

Takashi Sakamoto

