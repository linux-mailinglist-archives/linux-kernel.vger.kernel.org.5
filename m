Return-Path: <linux-kernel+bounces-133824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEE89A953
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFC21F2236F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68CA21101;
	Sat,  6 Apr 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWtEG12c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA011803D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712384662; cv=none; b=Sl1pcP5q9nPmexeMdb4SWh9uy/wrkHF3iybhYx1JC21Pwci9HyRPd8WKAWft6YXRSPK1aXrviL1KgUmgNzgV+W67FO5y81rTYQkEcRPRjWXw4AJ29CeUkn3N64nCqEKT9tY4kRNoV1TYdTMyEUelztTbFn3vakJfBNxuMod38XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712384662; c=relaxed/simple;
	bh=4gG9/E8OTh0D5eA0xxln+0lOjn2aKaQQgTIkfPw0ntE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upeUTqgsAEWvQRRvHuYIaLV4gYuNa1Dcg5kub6G47n5eAEDejD48pBhD2EEWzrHTcsDPYKETWoZ60mWVWXLrJ4EjziV+BPdibjT3joFDL0yhSWnrhj8Pt805wQn1Uj4DRPTO0cvO9VN6SGk8aIx6es4o9kKTWIB7gI2/GrJYyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWtEG12c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2788CC433F1;
	Sat,  6 Apr 2024 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712384661;
	bh=4gG9/E8OTh0D5eA0xxln+0lOjn2aKaQQgTIkfPw0ntE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWtEG12cziCLwoo/U/KQ3sSMtBH47f/wMAdMIHsgdykOcBX90psCnxacjQjJnUiS3
	 tntFWNjcaWPnd505CHVJMBicxl5HY5PFBgccemY6Xn+XBV6B8EpckcLLIgxQ8XnN5z
	 DyCoOakUY0hxP2mYph3SGfflG8K/L6O1fIgEDyKJ31QOJU2LvE9kKIO9+pE28QEhcZ
	 V5rIQ6HC/fiT0GdUxzRfwIkyEw57+GBXbFTLG3DC++ZkD374CNYl99QFbYQ98hnDMT
	 3rNGraCRG55d858mQyJivNVd4z78rVA6wAQ2rR+XZbqQe1kWci2i3/GBa2FNz+QRXg
	 wYfRmp74yJpbw==
Date: Sat, 6 Apr 2024 11:54:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: phy: core: make phy_class constant
Message-ID: <ZhDqkZ-Hf9KwayC5@matsya>
References: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>
 <ZhAtQngu2uChbCCt@matsya>
 <4yxiyk555fts7ibsjubatreugv7pdmvcbnnamcuqoxpwx4g3wr@f6t33jkfwcve>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4yxiyk555fts7ibsjubatreugv7pdmvcbnnamcuqoxpwx4g3wr@f6t33jkfwcve>

On 05-04-24, 14:08, Ricardo B. Marliere wrote:
> On  5 Apr 22:26, Vinod Koul wrote:
> > On 05-03-24, 15:18, Ricardo B. Marliere wrote:
> > > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > > a const *"), the driver core allows for struct class to be in read-only
> > > memory, so move the phy_class structure to be declared at build time
> > > placing it into read-only memory, instead of having to be dynamically
> > > allocated at boot time.
> > 
> > why is this tagged net: ...??
> > This has nothing to do with networking!
> 
> Hi Vinod.
> 
> My mistake, it was due to poor local tree management. Please let me know
> if you can review and take it as is, changing the subject line, or if
> you want me to resend.

No I have applied this after dropping the net tag

-- 
~Vinod

