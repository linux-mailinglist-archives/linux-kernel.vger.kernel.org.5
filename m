Return-Path: <linux-kernel+bounces-7243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04881A3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CDC1F21893
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D4A41854;
	Wed, 20 Dec 2023 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FpRRQpsh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vGXqsaqY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D941763;
	Wed, 20 Dec 2023 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A4D7C5C0877;
	Wed, 20 Dec 2023 11:04:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 11:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703088277; x=1703174677; bh=0AwGjGLkW3
	PKzAf3cgQXCYA7IFWt07iCjSMh4jSjGT0=; b=FpRRQpshGFDnLGu4zEoPMpYpjj
	YTG7pN9XanBnSW/zhR3iPADfjHEwgbmUQ6hGhrV6jiTulka/V6S1WBACIF2KyakR
	gm7WM+MAaOckm+qfPqbh5FejgG2fgBXpANwAj7B952jx2+aEp4v7NYcLtYDER0cw
	iDlHB7A/pMce9mR5aihvN+ydMttKUInBwySVHV+Gs65DwHImCZbw3qbuNoE7iez6
	VqMgcKmEByB9gU44lqGsCVySp510+Ao+OTPRnIvME0iL4WvNuIFNkvzM/qrS3m2r
	7VrRdb/qb0hLi5lqeFtnmCYUP0rIZi3d4B/l8pvgDBTs7S3lEW75r5e1ZTag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703088277; x=1703174677; bh=0AwGjGLkW3PKzAf3cgQXCYA7IFWt
	07iCjSMh4jSjGT0=; b=vGXqsaqY/S76V8hHi8UEm/Nh3xnZxDrEyn9ueHADHJpZ
	3Orz0MUFPZ+SqaZhIGIo9eUsD8Ca5WkgjfhXvqktyITPoacGZ0Qsn83ZB+ObA3Gf
	ZB3R+bpYPAGqKtAjRCpEabp38GpurprlcoLWPRIWUxY5IcVmF31JdUz52Xvy9Uvs
	KBb6gTJZE64Y7h5gckmUZCl3J5AfQaEZY2g/i4uz/7k/pw0/amR9eqTI3uXUbGOe
	XvDeSR5hGAEdheXyKYLjENJVaLTg1w/LB0mn6utHr96FpCCpSfQG1w/HtGVx6PLP
	KvEPEPq5I9+yxYNhmffNMaotqe84DhLcAE9AJm1yRg==
X-ME-Sender: <xms:lRCDZbuszN8cswIyzC0Av44c_Mjcans4Ta6AgJ4Hb0m1xZIG5pH_6w>
    <xme:lRCDZcepr9tT_ku0f1E5Wk-xWXeRzi6_ef1zG-0V2oWdH5GHnI8pBUBLtcTCDX5Gh
    ov9i0D-EnTUZQ>
X-ME-Received: <xmr:lRCDZexrKGkGtn2ECym2kTq8ilOa4gYWOG7vmUd22hLxvtychAAJFGjOQIDilWB9_48NagbXCfVsQH48yYIGTdZ1Jn6l4Ui5DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:lRCDZaNnn4HJ_cKYtDJFwXU6Utofmy9w8CjNCIn3zg2j2GwQHzelOA>
    <xmx:lRCDZb9Wg4jqw6md9ma_mFaeT7EtWsFbZ9QNumxaJ6KLlWmD_8yLdA>
    <xmx:lRCDZaUl1jpAnFI7nwPyMrpF57dXDu4SZr9IP77RGZUfmZloyoiN1w>
    <xmx:lRCDZeUWtaoLj5iUZhwQMxexX8L065UCwlWmEURKBEL211O8TZyE4g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 11:04:36 -0500 (EST)
Date: Wed, 20 Dec 2023 17:04:35 +0100
From: Greg KH <greg@kroah.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
Message-ID: <2023122012-spruce-unsteady-e187@gregkh>
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
 <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>

On Wed, Dec 20, 2023 at 04:23:15PM +0100, Werner Sembach wrote:
> Am 20.12.23 um 16:09 schrieb Werner Sembach:
> > This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
> > systems with Intel Maple Ridge".
> > 
> > It seems like the timeout can be reduced to 250ms. This reduces the overall
> > delay caused by the retires to ~1s. This is about the time other things
> > being initialized in parallel need anyway*, so like this the effective boot
> > time is no longer compromised.
> > 
> > *I only had a single device available for my measurements: A Clevo X170KM-G
> > desktop replacement notebook.
> > 
> > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> I wonder if this could also land in stable? Or would it be to risky?

If it's really a bugfix now, why would it _not_ be relevant for stable?

thanks,

greg k-h

