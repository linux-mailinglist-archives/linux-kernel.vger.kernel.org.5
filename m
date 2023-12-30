Return-Path: <linux-kernel+bounces-13407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C156A8204A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D49B21336
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040279DF;
	Sat, 30 Dec 2023 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rtItvV3f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhOK0LBZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DC79CD;
	Sat, 30 Dec 2023 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id D6BA85C0075;
	Sat, 30 Dec 2023 06:43:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 30 Dec 2023 06:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703936628; x=1704023028; bh=RDMzNXeoRc
	XtTozgalvQ1v7S9gcCF0W/23GWD67Yelg=; b=rtItvV3fct9Ah3tKmTbcAT+uro
	/8gumEOF30bzbKOqwjqcRllVZmBQPkn99DlIR0/NHH1R8jkAjhlFp3/ncXdGdj3l
	A/6p1FANm2O5UE+zY60kaaUmMARtGeDgayCODji3pDdCso1b5qslEOQaZP88+24z
	Z0BkybZk7MfkpKuSCwzrc2ZhPG0CsAhZKdkqWK4XmnpqBYeLZRo2cOfVvBxTnfOK
	lfBo8HKZ4vteixcWMTmzZBlOzot3xWnBetFYT6pX4hBvT2N/i90/N7WlIlUtkdZb
	oj+GjB7lShuyQQtRCm4Uu9c4eebrxMSNrP8/SW32slFyozjYdGxSA9uJddfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703936628; x=1704023028; bh=RDMzNXeoRcXtTozgalvQ1v7S9gcC
	F0W/23GWD67Yelg=; b=ZhOK0LBZRGNZxTF7TQ9YpCn1UYZkqTyTW0WKhBC2Av8V
	zqhUAaCDhEMWP0uaRG2+RmIE+Ra/FAFT8esGtklM92Xdn5DMK4TP7KyGJb9AyHUd
	BfeFUwSigl/+srUQB0/VKpOWj92YJZpQRf5Ih2allHdvToJBONXrBy5OoNcajo8l
	siWvQw1tjOVNRPXoV1vJkoS2w1zWja8su73SkjyI90/iqFAdLaG3b5h3Tg8zAxsf
	0XDDpx2/urcS5xv8hTtKiB+8ONfejWGyvgEeDdfuYUadt0BzY5r5zXwazhxCEYyD
	3W3+xodNudClje4KKFMmowDaMNVMxaGWPLQpA+HP3Q==
X-ME-Sender: <xms:cwKQZcsdQj0szJ-3NOwXM7UiDdTvPF2gregvMHjs2hMEKPEyrqeIyA>
    <xme:cwKQZZctBUV3M1gAfno5rYvqiz_D-RViQTWIyvEE63r0PT5bMQw6hmwPre68fDYIh
    QFyprTxr6Pv0w>
X-ME-Received: <xmr:cwKQZXxrvvrF9JRfCGVb9X-JGtal9csvgPeu__01K1YXBU-rIM3FJq34_hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:cwKQZfOX2LorBkssFUmtubV2xCjis9sUvR0IXWwWpcv66R9zLIO64Q>
    <xmx:cwKQZc_IBDGj518M2AxafhPVHdJ_NzYgzBMU1QQTh2-jESsctBEZgg>
    <xmx:cwKQZXUWLk3w6C6UM3DUgb4fj5FzIfz_mDsTjQKFmiLlSG-mykkFgA>
    <xmx:dAKQZcNx5nXiPU5lClqzSvPhrzj8iZTxuVnDIR88Bi4WHFpabCvUIQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Dec 2023 06:43:47 -0500 (EST)
Date: Sat, 30 Dec 2023 11:43:46 +0000
From: Greg KH <greg@kroah.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, akpm@linux-foundation.org,
	willy@infradead.org, liam.howlett@oracle.com,
	zhangpeng.00@bytedance.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] maple_tree: do not preallocate nodes for slot
 stores
Message-ID: <2023123027-baffling-arise-63bf@gregkh>
References: <20231212195255.219624-1-sidhartha.kumar@oracle.com>
 <2023121847-cope-surviving-26bf@gregkh>
 <19b88718-a1e6-d699-f056-cf00b1b75346@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b88718-a1e6-d699-f056-cf00b1b75346@oracle.com>

On Mon, Dec 18, 2023 at 09:53:53AM -0800, Sidhartha Kumar wrote:
> On 12/18/23 2:59 AM, Greg KH wrote:
> > On Tue, Dec 12, 2023 at 11:52:55AM -0800, Sidhartha Kumar wrote:
> > > mas_preallocate() defaults to requesting 1 node for preallocation and then
> > > ,depending on the type of store, will update the request variable. There
> > > isn't a check for a slot store type, so slot stores are preallocating the
> > > default 1 node. Slot stores do not require any additional nodes, so add a
> > > check for the slot store case that will bypass node_count_gfp(). Update
> > > the tests to reflect that slot stores do not require allocations.
> > > 
> > > User visible effects of this bug include increased memory usage from the
> > > unneeded node that was allocated.
> > > 
> > > Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
> > > Cc: <stable@vger.kernel.org> # 6.6+
> > > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > ---
> > > This is a modified backport as the patch to fix this in upstream does not
> > > apply to 6.6 because the node_end field was moved from the ma_wr_state to
> > > the ma_state after 6.6.
> > 
> > What is the git commit id of this change in Linus's tree?
> 
> The patch is in akpm's mm-hotfixes-unstable tree and has not made it to
> Linus's tree yet.

Ok, please resend when it hits Linus's tree.

