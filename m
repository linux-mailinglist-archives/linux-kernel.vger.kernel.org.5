Return-Path: <linux-kernel+bounces-19159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9BF8268F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1E5B20E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD200BE5B;
	Mon,  8 Jan 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kqZYXpgl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wd072Asg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60153BA38;
	Mon,  8 Jan 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id AB8C53200B41;
	Mon,  8 Jan 2024 02:53:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 08 Jan 2024 02:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704700423; x=1704786823; bh=PPBttl4zpj
	Pt1cTg2oNg8Jm7lf7PoSrYzxqMpSZcWn0=; b=kqZYXpgl3SjIr0Uv5EHhC+/3x0
	57AVmDask0v8OHiA2tqbeIKk+FFHmf7pZuwb+WSH+6Ow1oOf0iAkGNwh/wzFnNp8
	x8DshzmVy2dVOR4yAvOUiKn8sDUGRQ+kZFGXYKMhrYQM9zZwun8huVum3Xpazmqf
	PErfPpvTvgOhBchPb0H7LcyLzcWJVU1rzi5KVSuZHyABJrYaNeCSu4zULMvjy8TG
	mIXcOCtyhE1tKB+97le/wCm8JD6dLC6GNh2O/Z2nzvgKaxRdRIdBpTMCPC/xAOol
	3wcFudCcGBsumHK2xO7xMEd9/8QeO/8tfVqLoSqcT71BKBL5dX7BC3Q5cX9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704700423; x=1704786823; bh=PPBttl4zpjPt1cTg2oNg8Jm7lf7P
	oSrYzxqMpSZcWn0=; b=wd072Asgv+kZpttqR2M5cxVhkP5JnItUWNILwAjjmT9K
	wc3KoFFNxGuJG9DrJFtSc6za5XGeavsu0jSJLOobm+HrPz2KV+gcjoHhRPLJ1sK+
	B8MfbGaYMfxR5RjqYtDX8NBrDiRfB8x1I1EUXX4U6C7jnmMxTGJzHm5G5yukhJsC
	6kKcwUH425S3kB8t6ylOvqOJUq38/s0C5nr6sC5PRqs8VtjGmYkaqepryozjr2Dq
	RFy8NcMrVoRn+TpBynfQyBi5jwhJ7JTT0lfCr/8ViqG9VLPn5/PPT73qvC+VE9fP
	kGsHal4dQfhBP69GqCJkXn8h4PC/fRm4aRrMHDBtpQ==
X-ME-Sender: <xms:BqqbZXYwzT39BHFXI8Y6zJ3NLPGgaCjeullhxlYtURCIA5_-CuMbjg>
    <xme:BqqbZWbCpfKE2WPDOw8uA5L_8Wn8wqk38g3IdB0TQmpU2oBsdUHWMwEb25NguFqMw
    sASR7sqLPJkhA>
X-ME-Received: <xmr:BqqbZZ_Bo96spPBKJGbfNzUS5V6TuShlWHVn7ha_cjXuCOBCdkA7YwUQOQmKqqUsc3pZwF7ws3uai8NfjO59HAu4j14HiUd28w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:B6qbZdq2JZFy_7eXjJJuJ4A5mCH5g3rEV6zgtORl-jKhaVToF6IrBw>
    <xmx:B6qbZSp7kohVdERaNQVYYe1KD7SkrcC-sfbgvPNaxa5Dca7Jy7P4TA>
    <xmx:B6qbZTTJpDhSkKLwW6YNVsXQxmvDd5KvHH1u7FRP7Qijetwu2Fvs2Q>
    <xmx:B6qbZedP0mJcgPTPghmU66fjHvdgl0yX_g_o5BH4NuGPm2wB3IX0EA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 02:53:42 -0500 (EST)
Date: Mon, 8 Jan 2024 08:53:40 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yury Norov <yury.norov@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bitmap tree with the tty tree
Message-ID: <2024010830-swimsuit-ferment-8b88@gregkh>
References: <20240108143627.29ac91fe@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108143627.29ac91fe@canb.auug.org.au>

On Mon, Jan 08, 2024 at 02:36:27PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the bitmap tree got a conflict in:
> 
>   drivers/tty/serial/sc16is7xx.c
> 
> between commits:
> 
>   8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error")
>   3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> 
> from the tty tree and commit:
> 
>   e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")
> 
> from the bitmap tree.
> 
> I fixed it up (the former removed the function updated by the latter) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Fix looks coks correct, thanks.

greg k-h

