Return-Path: <linux-kernel+bounces-3327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27096816B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D915528250A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000011640C;
	Mon, 18 Dec 2023 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BN1v0zZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x4BbuZAk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C217980;
	Mon, 18 Dec 2023 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B99215C009B;
	Mon, 18 Dec 2023 05:26:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 05:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702895195; x=1702981595; bh=guuxQIBWUu
	Derf/nXMn9zxvVn+C3lLlu+PLnFxhy1Vk=; b=BN1v0zZMpMDWGls4nznpfTjXRu
	5ZvMAuFduKVkALZ7erJHsu0hkW00plny0Pewt7zSHTDiBSwU/a2lpAmBxAow75AA
	1ZCkyTp8Us8R3c2mCwHxL1t3SRPTiMaFKXJaZ6+yRlC2FcP+Wfta8qLHw2U9it4U
	5dV4kHUfopi1y1LXB4rkBgY6O9Ixu6qh/zgMsBuNwiAJA9tssK8+JT7zJchJ9knR
	XUc8YRYLuDiWZ3ucFp7fC6+znsQc2RZ1R4x0Z0sC2oR/NFLrto7R/vRruMPLmo/6
	bQ6fcluJkXa3C1B24jAKAWcxKGSn6MWag+alM2TklojO4gReO4ceFeAO8qQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702895195; x=1702981595; bh=guuxQIBWUuDerf/nXMn9zxvVn+C3
	lLlu+PLnFxhy1Vk=; b=x4BbuZAk35uF2bF3pdVFBmcx6jX8OVZtMSVwjMKbjLxO
	Kq2O6zlB8OjEXzXaAqwu1gQ9kXRaz1uLUWgByMkRgj+JvRAn1sVTKc+EnvsYNyYK
	+pPyZT/QF6L8YvwmhR9wSAFLtdppXAumL/eJctUCfcjH8U+YSRHqBEgphpCRRXN+
	PU8WU4pWSO7HqlCqGtbge0T/m5HuRNxF5EGeC5yZmzbB/1R9eCZCxTmRTxnTIV1n
	5my09jGa4ahPeVp8HpkdnDmz3XjZFvxLvindp9xS56NUlabQMuIOcyDsmLMsEypH
	HCUR0xmxx7RlrmXhkv+BDVtKbS8Zt8EAGV8dDUWNtQ==
X-ME-Sender: <xms:Wh6AZWLi9LMHn9Eb1gk6sB7_j8ZkZKPvLV9wjv5yFGA6X611wbquRA>
    <xme:Wh6AZeKL9ph5vv6joJOt9Ne_8TYCS_AQll0ELyVf0AUg-erpHiulEHVOJBeLo9TLs
    QJOs1rhrKF7VQ>
X-ME-Received: <xmr:Wh6AZWvzXor9ECLsiTXhD34--Ht63LbfXxcWtEfT1Rd9FdXMomzQyI3I2umkiDagS56XH6WaBac4PJhPsCoHIEwY0wWIxhYyAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Wh6AZbYyp65ioi5_bWsB-XTnQHXJPOyWL3B7ZxYBku6ynXG7HHzhYQ>
    <xmx:Wh6AZdbfy2QcWCEqV82HDC1Fb2xEMqcAC_UcS8wg9aQ5HmZrPqKjaQ>
    <xmx:Wh6AZXAuF4TGaPCCeik3kjMmJaKjfg0IOK17pyHpNo-cjHmwYTq2gQ>
    <xmx:Wx6AZaQT4mzy_Nx_q39NRUltcMMZCz6PrArcBcfGc9DSlFecZsGWTA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 05:26:34 -0500 (EST)
Date: Mon, 18 Dec 2023 11:26:33 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rob Herring <robh@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kyle Tso <kyletso@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the devicetree tree with the usb tree
Message-ID: <2023121820-deduce-treadmill-d44b@gregkh>
References: <20231218164812.327db2af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218164812.327db2af@canb.auug.org.au>

On Mon, Dec 18, 2023 at 04:48:12PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the devicetree tree got a conflict in:
> 
>   Documentation/devicetree/bindings/connector/usb-connector.yaml
> 
> between commits:
> 
>   76cd718a9ffd ("dt-bindings: connector: usb: add accessory mode description")
>   d1756ac67e7f ("dt-bindings: connector: usb: add altmodes description")
> 
> from the usb tree and commit:
> 
>   0d3a771610d0 ("dt-bindings: connector: Add child nodes for multiple PD capabilities")
> 
> from the devicetree tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me, thanks!

greg k-h

