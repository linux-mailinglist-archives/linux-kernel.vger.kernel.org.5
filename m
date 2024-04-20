Return-Path: <linux-kernel+bounces-152291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25168ABBF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D78A281823
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68426AF1;
	Sat, 20 Apr 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RF19qbky"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF461219E2;
	Sat, 20 Apr 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713622683; cv=none; b=QNHT2r/21QujN9sAQKuPMkVe8COPuo5xa60FKieih8CKoF+XrSu6HVSj6DR5RJnwXk4idgC/prv7PVHj4x/vgXKb/Ltu55sok7Kl9ipGLU07hiflxEYDvBODcvVvK2R3jpu7SHAu/Et0P74b4hpL1Zm588CaT+IFNS9jHPvETAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713622683; c=relaxed/simple;
	bh=IhmcAAcxPMLNcXwD3ROydVIshE7mJpHYxjctvvOo53E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN4pvFQmMmAN7ObvnRU/lWFtWUzQDLgOaTlmvJeBlbG/U3QYBx3vq6UIVzF+g3murf6fE8jC5POGWobIjXiiEJBcMVbWUnHv1CFd2cyB/JbNYGimKQUBGyLcpUGvIeQ73zeotv9Wf+vFpmDbqm25g9VG9pTRqlwmp3rSllFAT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RF19qbky; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wYKh7leSQOOv10U3kntigwhuQ5oEPTab1stw2kTMjeo=; b=RF19qbkyFprUxuCUrwZDTrTHF1
	mFKmgTVVMeiJ+SmCj8BteLRCUCPLEBhVdq7T1odGFJnnYlnWx2o08cdMBHQnFfs4wzub6QAy6q/HO
	iFPnWrkXCbwdP/BtxskV+q30Xhd8/1cm1dIcq4E6iYCLygu3kYQy1uploTN5Ht4YRQVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryBXK-00DVq5-Jz; Sat, 20 Apr 2024 16:17:50 +0200
Date: Sat, 20 Apr 2024 16:17:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: renjun wang <renjunw0@foxmail.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: update fields of mii_ioctl_data for
 transferring C45 data.
Message-ID: <01d9fc07-ffaf-4353-b4b2-d7fcaa146024@lunn.ch>
References: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>

On Sat, Apr 20, 2024 at 08:41:10AM +0800, renjun wang wrote:
> The phy_id is used as u32 type in function mdio_phy_id_is_c45()
> with the 30th bit for distinguishing C22 and C45. The reg_num is
> also used as u32 type in function mdiobus_c45_read() or someplace
> else. For more C45 information needed and data structure alignment
> consideration, change these two fields to __u32 type which can make
> user space program transferring clause 45 type information to kernel
> directly.
> 
> Signed-off-by: renjun wang <renjunw0@foxmail.com>
> ---
>  include/uapi/linux/mii.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h

Just adding a general point to others comments. You have to be very
careful with changes to files inside include/uapi. These define the
API between user space and the kernel. You cannot make changes which
break existing binaries of user space tools.

Sometimes you can add new members to the end of a structure. Sometimes
you can add new enum values after all other enums, but you cannot make
changes in the middle.


    Andrew

---
pw-bot: cr

