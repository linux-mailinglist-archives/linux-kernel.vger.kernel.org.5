Return-Path: <linux-kernel+bounces-45173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5810842C71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049951C2460A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6A6995A;
	Tue, 30 Jan 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NmYN9gGL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHWphIxE"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002BA7AE58
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641849; cv=none; b=XTIz5VGdyJNwwRGsM47aQ3iKT6MFUSABRBsAbKJIev6N49U3qnDn9Bo4U9wPC7bnCM3vuX21HbRHZVGPk33pL/IlnoKX6zbqKeJD4YKzlJ2dCbYDj+FiwUHaVF/ISQJcPZS/oN+SOCkKdxTKWlgicERaQC92XdJcGzT5x6dWPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641849; c=relaxed/simple;
	bh=sZv4hZ59DmUixucPnWeXqZ6a7oFZ896iY95SEZQmMEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO+bvjiDxj06H3mzOtjvE+17Cjo1QFiinHeXcM/5//umCU0OVGDj3hoa6xgP94xx9T7OOinhV8+5e1cRYsL+uO0IUWKhZxryk5K309R0LRk5fcKo+dFWyT11u1PWjPxqigIPS4qAyZjZbRPlnHuu+BZxy9DlO8JMesufGyNuEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NmYN9gGL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHWphIxE; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id BF4213200B6F;
	Tue, 30 Jan 2024 14:10:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 30 Jan 2024 14:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706641845; x=
	1706728245; bh=+gJh8ZcSY4aL5gFs6qPyGXcGkB9f/lwBzjFZBMTljRQ=; b=N
	mYN9gGLmOYjRAN+BQ3ASsuLiYWHhM7vKyuUaTJdaHrbfjfWtqDakhhCWRrbJ+0fU
	q02qgiFG3E3VzMjCIIT7aku4XU9vOe/5k6cGRlfbE2qQuZvGuwBZq37jCPKIfVPZ
	xE3cVPc21yxG1f+2rmg9JX0ssML52PnU7q7ele6T0Ja1J/o6CedvsLGPVLpNTEbl
	Ki+FpeCjFm3YYkXDWwgoUiB0f9rYR8YB+5HCJohemRDsasz5pSqI0oP6ZVSizC7M
	gvz8w9LXNq6shgE4EvTVQs5O9VnYXG//9gxswN8kFIJQmR9WvoV89KPTSFqK68ca
	2IrdDuiozmlgjuZMG0zxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706641845; x=1706728245; bh=+gJh8ZcSY4aL5gFs6qPyGXcGkB9f
	/lwBzjFZBMTljRQ=; b=CHWphIxER++1SfPEXD67bf1ELZKQ6YOftuQhf/WLlV3X
	9xdBKlvMzzfyuFSNQAVxZAwIpWtmUs0nCJca5xjS/k5j7XRgJN3Q/dyAdJ1vOTlR
	JskNMqRflQ+3WDDbVR4u3PE0hN+3glMolle2US33lN6GjGB7YGPEpegnB8Ihm6zH
	23EjpaJMyRLq7zQxMB+dh2J4T+/Gcqs6ZdJHUP9xDVDrjp6LN1xuTn+gkrXB0SAD
	eLp4qVMypTo8zZtCdwoMVJfC/5bBWX2rOLkGGJysIjj4AqsaDjYEmr+8CuIJ8ipf
	Ur2b7yDdUWoxb/8kXwneYXuHdnHQMX499C7LkToiNQ==
X-ME-Sender: <xms:tEm5ZWzj_nukIFsyQsXbUUEicKwed1DtERHGAKXSs58nFVZh6uGoTw>
    <xme:tEm5ZST5X2M9VyVb2FIOFI1vd4TtUfmLvDawIxqGWht2D-9qz4V778V7q6V0Jg7xg
    4NLCQixHOvSd2Sv3Cw>
X-ME-Received: <xmr:tEm5ZYXEQ2aXvYWUR36cE5C34jRO9mlym6xw9qqQeY_wsjZRnRThh_9fH0IbhakiHIXlvyLhqfFg5CWL1cjhGWqID50ijG8O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:tUm5ZciW6TKa6yWDiBeqIbO8gHU7D8v7sVAwy0vFsGNZZBqFutU0fg>
    <xmx:tUm5ZYCnkDe4PSZj182yzm0pjUxW5b-9ijGFilNJmk-lKNr3hxDI3Q>
    <xmx:tUm5ZdLt-omORLz4l55szDVqstZU_1Rz8lauWjviKPUWAm1b_LzFlQ>
    <xmx:tUm5ZR6zAcN2BD_BVFcHsLLkQQ2VC_RmuYu6oH_tD4M9Ty__hbI71g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 14:10:43 -0500 (EST)
Date: Wed, 31 Jan 2024 04:10:40 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: mask previous entry's type bits when
 looking for leaf
Message-ID: <20240130191040.GA35237@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZbJQ0JdbGixJouvn@iguana.24-8.net>
 <20240126011705.GA22564@workstation.local>
 <ZbNyHg3TTWpjiieI@iguana.24-8.net>
 <20240126121917.GA99160@workstation.local>
 <ZbSMVdOZB1zusXmo@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbSMVdOZB1zusXmo@iguana.24-8.net>

Hi,

On Fri, Jan 26, 2024 at 08:53:42PM -0800, Adam Goldman wrote:
> On Fri, Jan 26, 2024 at 09:19:17PM +0900, Takashi Sakamoto wrote:
> > I think we can handle the quirk of configuration ROM without changing
> > the kernel API. Would you test the following patch? (not tested in my
> > side).
> > 
> > ======== 8< --------
> > 
> > >From 83bf1e04d308ea89c76c64e3168b9701f9d9191b Mon Sep 17 00:00:00 2001
> > From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > Date: Fri, 26 Jan 2024 20:37:21 +0900
> > Subject: [PATCH] firewire: search descriptor leaf just after vendor directory
> >  entry in root directory
> 
> Hi Takashi,
> 
> I tested your patch with the DVMC-DA1. I also tested it with another 
> device with normal placement of the leaf entry. In both cases, it works.

Thanks for your test. I reposted the patch in the series of changes for
v6.8-rc3[1].

The behaviour change of kernel API is not preferable within the same
version of kernel once the release candidates is public, while we need to
handle it as the series of changes to support the legacy layout of
configuration ROM. So I'll apply my version to for-linus branch and send
it to him.

Anyway thanks for your work and suggestion.

[1] https://lore.kernel.org/lkml/20240130100409.30128-1-o-takashi@sakamocchi.jp/


Thanks

Takashi Sakamoto

