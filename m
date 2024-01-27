Return-Path: <linux-kernel+bounces-41401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EB83F032
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE1C1F222F7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46E1B27D;
	Sat, 27 Jan 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="AU/CnMFS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixsic8fM"
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC81A723;
	Sat, 27 Jan 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390422; cv=none; b=Pz3jM7kJ4WWT+f+VvdrjXZ3PWUBBy9ZFF4RKYiI/sXq9FPru8+Ymu82gUCCyy/U4kHJNUnj8PGY5Co5H+I08aeoTUyl2XJmk3PpoqQnKUNEIw2x4Uj2zQ0XX1FPM7jz18E4wkBCXNSgAnJUIQNzx6O2x5Aj54YCpDvv3EV5AvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390422; c=relaxed/simple;
	bh=ZwsAmgZApPQl6UcX4NZ85FITCeQi1lWhLsxv2X98pc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmCSIo3Sn7dquWQTGodkWRn05kfD3uVj1AH8JbVWkOTS8fX91zJy+UQpSzR6aMChCu0gzMlG/IVEHoMkj95HYuFnBACWxPCnLr8v5fhfYzIBNG1wOhQg6VZnYJH6Y53rj9V+2GReQASIeHdCn5Adhxy2NaGfgIfwAivjVxjoMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=AU/CnMFS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixsic8fM; arc=none smtp.client-ip=66.111.4.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id 525C15808BF;
	Sat, 27 Jan 2024 16:20:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 27 Jan 2024 16:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706390419; x=1706397619; bh=vl7A5tB7tb
	/TqrGN7zKDKDidJXhLI9itkoXMD7OD1W8=; b=AU/CnMFSB3VE2OditYKkN9RDmL
	a09lnP+jf2t0+QlPmNGaKX2Bo46pu2wwmXltSB1TC+O8JRxoUeowKVhe/G3+PJxD
	N5QkVK7WmXicWGBQ9Kxbc0V9F5GDiWEFTw5HgqZ3kUDPduuWH7WBBGWI4Bra0b7u
	28PIAvnI2h13n7b0PdIjFl1VGCI4sRgnZE4ttaG7yhiCeaB/+PEfsX4CmHC8KLct
	GoZEBMI6boF386ZpQYXuM4lOXn0qJ+ZovU994CWhdcb6gVok7tzpZ1/X302qfWIm
	K0VGMzvRXM1Of4Tr8XdetUCnXkT075FQDhVbY0APrBoe0O1s5uAseDT7Z4TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706390419; x=1706397619; bh=vl7A5tB7tb/TqrGN7zKDKDidJXhL
	I9itkoXMD7OD1W8=; b=ixsic8fM907SI64oZJ1hXuRpDwLdNXJQGJ7ngk7ig2KD
	nHfufxLq2FqokSBdpKQ5PyZ41S1VHcKLphDasiKKwtYgXsKtOVkqXqFtnbD9SqAa
	911zpe81neI1J58vF5IUP5YH+IqhJB5iJTHRkI8lzrAYOFEJlo/fmQ3P4PaoTIkG
	lLQZjD4iEeEkNNrunVdujhXfz2Ae6lfsM9OcHdRWeItImG57ZEiJhMGelm0rLMVd
	PEo2d8J2U6sZiu5hDRi5f/VGUJy1nE2V8XWLE6hQvnuNj6mGkaQn2SH50FDQiwJd
	SIccKQaTRMr6uWVxxAlH9vtGY+aHGhK/s9FnGGKKzw==
X-ME-Sender: <xms:knO1ZXS1eEDL5fsf2yvykeaFl-i759gkOgMq90hKm8bDl1Bl5VkWyw>
    <xme:knO1ZYyWUQ196Li0y2qx7GVxrh9Eaqo-lgLMC7dl4SrjqaWKacwFApqI_2NmS5No1
    U_rhx0Aa_cuTA>
X-ME-Received: <xmr:knO1Zc05byHj2SHn5D9W0G-Y1yZZ61F7Ap779-2H7kGvs8vJE0nZiOgGcxgW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:knO1ZXA2KX4kRKj_eSzAT1yLnZ7VpeYDT1mdVGbTKN26DgCLdU5J0A>
    <xmx:knO1ZQiS-Em0pL-1f4xRU4d2FcAsBdBNYTB8FCSuIPLAYrdt30zD8A>
    <xmx:knO1Zbr5T-IlXYO8UwelejQ07wUHEuPtkT-nmGo1aj8Bk00KlDXFrQ>
    <xmx:k3O1ZZCnrFwC3_SnFMBTlBtg2ZxVxebxlmAhMFnrU6DGtq_ZUV1t0A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 16:20:18 -0500 (EST)
Date: Sat, 27 Jan 2024 13:20:17 -0800
From: Greg KH <greg@kroah.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: kovalev@altlinux.org, stable@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, keescook@chromium.org,
	sfrench@samba.org, corbet@lwn.net, natechancellor@gmail.com,
	ndesaulniers@google.com, "pc@manguebit.com" <pc@manguebit.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>, linkinjeon@kernel.org
Subject: Re: [PATCH 0/2] smb: client: fix "df: Resource temporarily
 unavailable" on 5.10 stable kernel
Message-ID: <2024012708-satchel-canteen-d949@gregkh>
References: <20240126193143.245122-1-kovalev@altlinux.org>
 <2024012613-woozy-exhume-7b9d@gregkh>
 <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
 <57fda449-0d18-485a-0858-39f48722fe27@basealt.ru>
 <8ad7fac4-dcd5-4ef7-8e40-0c9fd1c6fd0a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad7fac4-dcd5-4ef7-8e40-0c9fd1c6fd0a@oracle.com>

On Sat, Jan 27, 2024 at 06:59:15PM +0530, Harshit Mogalapalli wrote:
> Hi Kovalev,
> 
> On 27/01/24 1:32 pm, kovalev@altlinux.org wrote:
> > Hi,
> > 
> > 27.01.2024 09:42, Harshit Mogalapalli wrote:
> > > We can reproduce this on 5.15.148(latest 5.15.y) and Mohamed
> > > reported this on 6.1.y, so we need backports there as well.
> > 
> > in the 6.1.72 kernel, this problem was fixed by the commit [1] "smb3:
> > Replace smb2pdu 1-element arrays with flex-arrays", which was proposed
> > in this series of patches.
> > 
> Thanks for sharing this, I didnot notice that the above commit was
> backported to 6.1.72.
> 
> I think we still need fixing in 5.15.y as the commit eb3e28c1e89b ("smb3:
> Replace smb2pdu 1-element arrays with flex-arrays") is not in 5.15.148

Patches gladly accepted :)

