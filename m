Return-Path: <linux-kernel+bounces-3322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9A816AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D97C1C226A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D371549B;
	Mon, 18 Dec 2023 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZerVlu5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmiVBL13"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AC14F77;
	Mon, 18 Dec 2023 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E3F445C00A3;
	Mon, 18 Dec 2023 05:26:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 05:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702895170; x=1702981570; bh=9uksYQ3xlp
	5Ys6n47ab5G9eyxt8+vJzx9s8YHlsl6CE=; b=ZerVlu5GdVUJ32eoZAxhSLi9iP
	jmWqoNCIUStPB8usIURsHsC7o+C9PmXGle1H72gd2FVOb+m6Of7ZEAr6AhHAjYDs
	S3Wo4df/LdK/oiDQBxVRVi+M2I+Usj9awwV+gohcKRPy23sVnAC0FTi/+GWxPW96
	8VwnHLFAEeXB/1k3NsliEqd37wHx4pXbDJlUnTcQXhzeOj7CDUlLfA4kglLE52P2
	y63apleI4HhGwDpyrg3/iC/Bj16lHPSuspU1Nti5fQo1QjNJkFtAHR7db5ocOGrn
	Up4kDpibPZeKV4YC5WBDbFt7366Rh2T8qX8SeQuaqCDdXOD/NSosey3bds9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702895170; x=1702981570; bh=9uksYQ3xlp5Ys6n47ab5G9eyxt8+
	vJzx9s8YHlsl6CE=; b=PmiVBL132KEraaa7AjHtqrtidVGr0PQSrLROV2dWd5ji
	p44PFKX4cHzS9k6kF5MM9ADk06ycJ8PW/ZUtpV2X6v1TETMNtXy6Y0TGDmQ7pWNq
	1+tjBEE+oNvf+rwt8eHbywbY4t0B01x02upNvRIeqVJAgt+qrfmcgVoYhXIYOlJs
	J5refyb4X+ylLVGEksKraFIi0sg6M5Juuj9r+pBY4kZD+lHSPWbi244StNqiJhxz
	oApPiHoUd7l+0fq2IM0FRgA/5Fn7WyM54XUsHv+fjSFJhxWYnG+LOIBDIAElpmZd
	MIrAJA0VMwsml4X9v0fn9HTtgKbQ3XYrzdlAjc1k6w==
X-ME-Sender: <xms:Qh6AZWObw1FiNYIBoTZjrAT6vkwONxJL-wRO2tTFhfbSQIldzQ6xAg>
    <xme:Qh6AZU83Hu_Q6g19G9wWKB8_fTABcDNs8aXyDq0LWKmmh8dzqVrRvQxmjgVhWnXcz
    DsGCibNS146cw>
X-ME-Received: <xmr:Qh6AZdTewmvAsMkZ-m5CERBNkhDiGquwSraTR7nuZEo2TC8uLUFK6gUCJqA3UUcHpzEexZplLnJRy4P6UUN05Ww6qCDm1dPftA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Qh6AZWvEfn782ml61zYOW_mq_1ssIQZ7o0Dej3D49c3tiRWl39rzDA>
    <xmx:Qh6AZeeHWdmzizu9n9aufun4Cn-gRPZop_eNtuNWa_DuYimcFoOUQg>
    <xmx:Qh6AZa0DExewc7klkOxCGsy7J76FXxfwCPDuktCjLsgypH535yeUfg>
    <xmx:Qh6AZWSfKn5RcdEk9g3IXFyWLRE1eQNeDjvFPPlJYb8U7ry-Elxacw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 05:26:10 -0500 (EST)
Date: Mon, 18 Dec 2023 11:26:08 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-ID: <2023121857-myself-contact-8ca8@gregkh>
References: <20231218154034.56bf4c68@canb.auug.org.au>
 <20231217215429.944b318dc38a3646e734a807@linux-foundation.org>
 <20231218173506.2165eef6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218173506.2165eef6@canb.auug.org.au>

On Mon, Dec 18, 2023 at 05:35:06PM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> On Sun, 17 Dec 2023 21:54:29 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 18 Dec 2023 15:40:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > > The following commit is also in the mm tree as a different commit (but
> > > the same patch):
> > > 
> > >   2678fd2fe9ee ("initramfs: Expose retained initrd as sysfs file")
> > > 
> > > This is commit
> > > 
> > >   426081603f6c ("initramfs: expose retained initrd as sysfs file")
> > > 
> > > in the mm tree.  
> > 
> > I'm suspecting that something went wrong here?
> 
> Like what?  You and Greg have applied the same patch.  It happens.

Yeah, sorry about that, git should be able to handle this fine.

greg k-h

