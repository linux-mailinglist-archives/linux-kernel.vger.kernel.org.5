Return-Path: <linux-kernel+bounces-63164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F057852BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418FA1C230CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB302224E4;
	Tue, 13 Feb 2024 08:57:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE7224CF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814644; cv=none; b=E8eL61QTYtCMWTnoNknCR095HELp/0W2zoo+ZXT/9I77xMhdmgkLuwT2ZqHdjGG+E5MXc6P1tA/fVS2U0+LQ+UEOv8B7kSH7XdxE23XH/gcWuAMrGB3DyT13btFpBWIxYleq7MnC2G0axaez/Ai+aUoiVcBAFjQioyUvBtnayiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814644; c=relaxed/simple;
	bh=9lSW6m32627tKU44SqdR8PbYjOb+I7w9s6jJoZeehWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAQbTAHzKexdMEdQA/CPb8LeZJfvLNLwXH0/2KJfukkuWQzLFp0HdAepPuUI559sFEVp3WNnZbr2p2fkNMOEaAC0zjJEKe7TcI2EMktPkcuMtBtf9xHoA50GCGjqlYQ2ts1y23j/kZ8nbXIBxv6ImqAput5maxDBRCl7YgeGcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE01DA7;
	Tue, 13 Feb 2024 00:58:02 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE2BC3F5A1;
	Tue, 13 Feb 2024 00:57:20 -0800 (PST)
Date: Tue, 13 Feb 2024 08:57:18 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] firmware: arm_ffa: Make ffa_bus_type const
Message-ID: <Zcsu7nj1MPzrES2x@pluto>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
 <20240211-bus_cleanup-firmware2-v1-1-1851c92c7be7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-1-1851c92c7be7@marliere.net>

On Sun, Feb 11, 2024 at 12:51:29PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ffa_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> ---
>  drivers/firmware/arm_ffa/bus.c | 2 +-
>  include/linux/arm_ffa.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
> index 1c7940ba5539..2f557e90f2eb 100644
> --- a/drivers/firmware/arm_ffa/bus.c
> +++ b/drivers/firmware/arm_ffa/bus.c
> @@ -105,7 +105,7 @@ static struct attribute *ffa_device_attributes_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ffa_device_attributes);
>  
> -struct bus_type ffa_bus_type = {
> +const struct bus_type ffa_bus_type = {
>  	.name		= "arm_ffa",
>  	.match		= ffa_device_match,
>  	.probe		= ffa_device_probe,
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 3d0fde57ba90..c906f666ff5d 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -209,7 +209,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
>  #define module_ffa_driver(__ffa_driver)	\
>  	module_driver(__ffa_driver, ffa_register, ffa_unregister)
>  
> -extern struct bus_type ffa_bus_type;
> +extern const struct bus_type ffa_bus_type;
>  
>  /* FFA transport related */
>  struct ffa_partition_info {
> 
> -- 
> 2.43.0
> 

