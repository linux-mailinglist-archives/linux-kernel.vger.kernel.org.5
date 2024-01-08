Return-Path: <linux-kernel+bounces-19160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E835D8268F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB62822FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA211CAE;
	Mon,  8 Jan 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="N6HEUpWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQQXt0kQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA01170A;
	Mon,  8 Jan 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id E12C43201051;
	Mon,  8 Jan 2024 02:54:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Jan 2024 02:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704700445; x=1704786845; bh=do6wSM65wu
	NBlwFTezykdmfQZBkLknUPyfcdoRSKY1E=; b=N6HEUpWhc3sUfXld/VtDftiFWt
	hlqjXXY2FUZ955p30roobWY5UL71oEi+0XEDdpDuIPNz31Rzb1rfAqoRnWzA8Kw5
	gMPoQOJmF3TqRgCGs3zlDFJDLzrwYJX5tlTq1SjYSVYRCSy95Ev1XE+l8A+7mHap
	/gB0pw0OhZVYgnGNAwjQ79V6g+4L1nxFG8SSyV3pbqIcclJfadvnABUk7AdKukZg
	bK/TbblGJT5l3x/bIvIGSQBmNEzgYNL5RtAdWcmjTT0EyCHDz3O8RWS/LhKtYUo6
	p5aKltwmLYjImvQQL4GzoNgh9SM50wBpgxfyw+O0c+fYqLNUscS6CvX13ccg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704700445; x=1704786845; bh=do6wSM65wuNBlwFTezykdmfQZBkL
	knUPyfcdoRSKY1E=; b=KQQXt0kQiB1rfyC7ZFU1bb2J9WYY4c/tXueaVH2CfkbI
	0EdQx6E8324EC8b6TDh07ZwTFEWaqkdTbvfKUbBZY0kbnLC2LfLJ+z4wMtL+sB6T
	cSQXtxScPW1YeI/rTjQ7ZuCaTvaZlHwvOyFgSXMg5cTEUO1GVkkQFDwKrFXTLNH8
	vD+6AxnONtzSQepd8ORAO9bO2sKBVZtOoFlCNXnyG9gcqOc2hcsM9qTs8dVm4P6s
	tfibIF1BMg5nVTSLnU3esSC/Tojvhrk9HX/QOGyQ4pjBWjuoFWGxQXGA+2L5xW+D
	2pcA4pgbwu72UpEcoPLt1LxBqUzFs/renyEOekUoyg==
X-ME-Sender: <xms:HaqbZZcwm4uy_fdrxyAfcGeCO798IUnyGxT2vCFdgbOkYUMQZigd9g>
    <xme:HaqbZXN25eNg9VyNJt4LLWQj__3pXFgW3rXnGqdBCiOIjiw5MBePInrPhSLJcf54y
    IaSsbDMhOSxUg>
X-ME-Received: <xmr:HaqbZSgZgxQb8N0dlQF-bcRJ-trlDxiGuQHRlek5MSMAckRhULEis2S_czUToVjazssuO34PMyR3OTSid9kl_Bno0iQHgbysuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:HaqbZS8SL6p8_z2zNYYVwNuV7RD0jPH0beOAx6mDjwsz22sTBKTAUg>
    <xmx:HaqbZVu8-IEwlxfn5qiL0JGsuq09PmX5Mc1ZNtTHLNIAUhUSCcJH6g>
    <xmx:HaqbZRGR7N5J7mg61bb3WfaJobbsIsgHbmaNmezqGEX79iL5lISSaA>
    <xmx:HaqbZbCbStlFQdn0CzkGMFCNus6mflAxw9hRI7do0cqFDEJXKBPixg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 02:54:04 -0500 (EST)
Date: Mon, 8 Jan 2024 08:54:03 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the char-misc tree
Message-ID: <2024010856-bottle-tipoff-21d5@gregkh>
References: <20240108140254.6def2dc7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108140254.6def2dc7@canb.auug.org.au>

On Mon, Jan 08, 2024 at 02:02:54PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the scmi tree as different commits
> (but the same patches):
> 
>   259566503782 ("firmware: arm_scpi: Convert to platform remove callback returning void")
>   927e11300d8e ("firmware: arm_scmi: Convert to platform remove callback returning void")
> 
> These are commits
> 
>   8b12056b2cbf ("firmware: arm_scpi: Convert to platform remove callback returning void")
>   66926739f592 ("firmware: arm_scmi: Convert to platform remove callback returning void")
> 
> in the scmi tree.

Should be fine, thanks.

greg k-h

