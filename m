Return-Path: <linux-kernel+bounces-151042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA868AA843
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05078283C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BF10A3B;
	Fri, 19 Apr 2024 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EFGa45E9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EO2W39Hy"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055D10A09;
	Fri, 19 Apr 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506970; cv=none; b=cVUg5puc/YaYn12Z9j4MNWPtw+AQjmRlXPP6K8rdYQRKx3+wQozA5N82v/BCcFUDswB3BkuZ61lQJWT8btG5Ep+zLotZbqifBOzZQhHyeSeIsbuBCy9fXRXUm2XRsBQlQXfQhzHgolUZSpzk5nQkkk5vOJGkQOd7A81K93ZazSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506970; c=relaxed/simple;
	bh=RyIwE3trWPlOq9sty8gBXujeKIe368HFR8WPMyM4z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlwOQNLWKfFMPZKKUV1l4r7/eE1I6xjfBPfZB5uMwU56HUmucGw925uhdGfeKZtEIx9Yg8UMXTNLoK5Wz7Xv12NqlQp0D5mtHDrEn8c8/l1xo1F5GeagMhS2DX7i8NyrJ4VvX/6E5oSsa9AhylcFq3DCDuo48eCcadMRYyhSJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EFGa45E9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EO2W39Hy; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C56AB13800E8;
	Fri, 19 Apr 2024 02:09:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 19 Apr 2024 02:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713506967; x=1713593367; bh=TBixqiZ31b
	LNMEUE6H16ebkmGgcqoeb9yiDBFLDTjv4=; b=EFGa45E9cUNzbNkm28/ZJjOd+R
	nkC91IJiDybbjMiDLxfCgogjmwsb27L2jSQK38AzcGudpA59MKBBZYe3aU2Kkaf9
	4fd6phaO3Lcrs/K0g5C1lywJjq964wxj7BpJpclw62o7ve4tANFYSxZdDrrV9Dch
	9zgtiIvspaLZG/LdsuYGzSWai//L2smXeP7u8gsfaRuRfzyvLEMKhGPrtFoSqjvf
	6qzY/qTrUTX3+8rAapG3jNFweN3cwAeBhiXAaikQoWS2ivIA4vs3m7aG5cJxL2oO
	PKr6SzWgNK3LaRAudl8xqvdQ3ryVpFfcYvowSAaWtcQI9tZR4Dmn7qYl91JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713506967; x=1713593367; bh=TBixqiZ31bLNMEUE6H16ebkmGgcq
	oeb9yiDBFLDTjv4=; b=EO2W39HyVEBr0yJQdp4gh2cU6flE8tH7pl5ciMmOjuac
	lWXzozfN40QvCkuN3lnuUOrjQbMslsPTgxi3/VQpTVyhZ6kqk13ByxO/sM4qOmbe
	CyE47IHIWhnJUZpR6AVDurHulCI5eVSCEoP5LPjVjL02jFWqrCKohEYCdzR9Fp4m
	6Y8VHOCszJtHDAXYnr8tROQAlfof0T32vj+VH+oRtQYIPk8qdGdDI36pghIqNvY2
	2cGlDclYZdvU/4xaDvcEwbGZEYd8Q6eNv5CNTg1lfn5ZOYFA/tWFrfsbYzLvep76
	p+nL97WCl9H8XMUQCvMxtZfKvFcmMBMPmzKPkDsCVg==
X-ME-Sender: <xms:lwoiZreyQDvn3VQesqLow5TypUnNZ6zmiHOj9Bg2tXR7n4ahmSz-0A>
    <xme:lwoiZhOexhVDiopbAI9BOZCRZS6a4N00FDCe4HEb6MWlBqCfpnTcHub2q8BB2clnU
    eZrah7RylHH9w>
X-ME-Received: <xmr:lwoiZki4euIPK13uub05R3FrdFbJpt1MYfA9hBtSNC1qWDL9BL4bvUnVVAvf68NjDBwud62GPR_twk8vSBRT_XZ90MiRFg77C_ZtqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:lwoiZs-SFEdZEGMQm4thAQQ9JM9OLl93CV2SOPeCAZPgJwCUyJ-uEA>
    <xmx:lwoiZntAwNTdJ_ypveF0KQ0k1mt04a-lLUxj4wWZqLSfhtrCRE3KUQ>
    <xmx:lwoiZrGSFOzqAoicA6sW5unR3w3EiWjtdXt1sdR3OC_byfkK5zDypg>
    <xmx:lwoiZuMMVyyRQZDhBxjaCdoJ1zF3SdO064C9poeu1We3-R8Hog0ESw>
    <xmx:lwoiZonnc21DV70iyxykuTt0oAkBkCkiyAqaDBZTIl2YjzFlvVJmK9fb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 02:09:26 -0400 (EDT)
Date: Fri, 19 Apr 2024 08:09:24 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <2024041916-grove-cymbal-291e@gregkh>
References: <20240419141947.4bc16fa4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419141947.4bc16fa4@canb.auug.org.au>

On Fri, Apr 19, 2024 at 02:19:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   drivers/tty/serial/serial_core.c
> 
> between commit:
> 
>   9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLifying it")
> 
> from the tty.current tree and commits:
> 
>   1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
>   abcd8632f26b ("serial: core: Extract uart_alloc_xmit_buf() and uart_free_xmit_buf()")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good, thanks!

greg k-h

