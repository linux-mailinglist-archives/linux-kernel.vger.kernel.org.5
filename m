Return-Path: <linux-kernel+bounces-19152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF08268DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9BB210AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35CBE6F;
	Mon,  8 Jan 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FdsUbwJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjXCbyxz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B6BE58;
	Mon,  8 Jan 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 8CB2D320128F;
	Mon,  8 Jan 2024 02:46:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Jan 2024 02:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704699964; x=1704786364; bh=H9r8WTz9DN
	D0Cp3bEl392WyrJu7uzpB3aWtuQ49mSEU=; b=FdsUbwJhPPDFTiw1qrsQaX8/FE
	es90Gg2sJUBGdwKoi79ptpprHdo2uRO95KqFKFbpB41CzQQKkuKrM+gigIaxq8YN
	hcItO2IBD3SU78VcMMuXy4N1dlTTixf2LOeS9XLz650sSE4WrDqVh31sMdwoc72Y
	dqfrAkKeBu5/kmbVM6d1OSj1M7kSiY2mHAtikgs2rla2QFYlsNHUrk8eKu/PyAru
	u5b5h7gAIyBJQWvIjEhM1RqYNSNnrrFfYj6J/WK9sJhg6qT23IupDAxxWB7E1MXk
	WmDXqndu7u0XVuleUhkY5Da3v1rF6se01PrcLYXU90XdzHCYU4ydf/oZ799g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704699964; x=1704786364; bh=H9r8WTz9DND0Cp3bEl392WyrJu7u
	zpB3aWtuQ49mSEU=; b=CjXCbyxz5nSuNaDurZZn8V9gdG87fQy9v677uQc7s+3b
	Dlyh0TEuCrYvjGgk47MU74daE4RklOauj/M2HJ2n2dGFpLOpBBukBPtlw2J531zr
	NN18LZfB/ouMuA3cowqbd/uDbaSwJZ68/20Ckn5/iYNJavm+cnbyAh0Cad7dfwn1
	vYCXBtXZwnvkMXf+zY1v6oKj0NdU2Iof4m5LZtCTmFaH2fXzCNfP6mvN3q5Ywfnx
	IObViQNunj3mNZTsmFFRm7rvLwTQY02WQF/XNALa6+pvd4nYIzNOXo81gRHo+mO7
	fY7yN/Ghr5OFC5TdPFKUw2lm2vrZPblRG9gznnQkLA==
X-ME-Sender: <xms:O6ibZWO5axERj17YFXE_qkJxJwWUMTxOW81XvwuYEL8K8jFpYinfJQ>
    <xme:O6ibZU_9pjyDVVKxvppduB_WOiSFBArkWJcy2Rz9kM-_56Jjz7AvPi6gVNLYANRl3
    oV4KQysW7JgSw>
X-ME-Received: <xmr:O6ibZdQs49gYsVuXQ2iNvCVH2rDx3WdfdoityGi_O4N-yHdvHvNWDX3JqGNBLXeMvcphU5LhWgDBh5SasRMKBI2eZd5xmjL9cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:O6ibZWv6U-MIH8TXTTANV1V1ZiONphS41cgFObRwWN5Oz57lZDvsgg>
    <xmx:O6ibZeeFpR6Gn5ki_z_VKfeoK9QLqtnHfFchG9-weyq_Sbiy1Y8BMw>
    <xmx:O6ibZa0pogaYPvEiDln-3k4j4w5dsNhKnyupPck9YLVzgozOReo-nA>
    <xmx:PKibZVzyxt_T5w7BDQuhRG7o9NhdPUzN1tiPlIctE4RU7qvFYAHYnw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 02:46:02 -0500 (EST)
Date: Mon, 8 Jan 2024 08:46:01 +0100
From: Greg KH <greg@kroah.com>
To: Helge Deller <deller@gmx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the char-misc tree
Message-ID: <2024010857-scandal-unlit-51f7@gregkh>
References: <20240108135842.34543bb6@canb.auug.org.au>
 <b47068a7-473e-4b0e-9511-0d3f2afc4724@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47068a7-473e-4b0e-9511-0d3f2afc4724@gmx.de>

On Mon, Jan 08, 2024 at 08:37:32AM +0100, Helge Deller wrote:
> On 1/8/24 03:58, Stephen Rothwell wrote:
> > The following commit is also in the fbdev tree as a different commit
> > (but the same patch):
> >    110684d58bdb ("vgacon: drop IA64 reference in VGA_CONSOLE dependency list")
> 
> I've dropped that patch from fbdev git tree.

Thanks!

