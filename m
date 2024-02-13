Return-Path: <linux-kernel+bounces-63167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB7852BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5BC286292
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF724A1D;
	Tue, 13 Feb 2024 08:57:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFD24A05
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814678; cv=none; b=Zh0k8U2CH4s15p6HnkTNRawgnk/yBYj5J7GwgDwDGvvYrtjUG3NcApg1xkwSqCI68SYdZ8/ny/tWeICsfa3iidHFzs7yyl+vXX2U87uO0UegVFZBDbrB3gQpbKH8Bd7hDeJ12PqsXLiub2ahG7OBiuQ4lUNqnTBAvVc8CMRMSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814678; c=relaxed/simple;
	bh=iNVTWSqqtJ40f8xe/FSZ5vrQlRsZU23LeuGKqtME110=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp5k6dJpddKP+U5jlt1IgOFfTNvJVe7FjU1k2TYUvLXuYOOyHuY2T2OTQG4hqhOmQfBiXppNaiAAB5Oq7JB8QqUHqTKPI5HNkm+664nTYUaY4k1svoi7gOs13o6vPdojHr32Qn0ZpbwrTrdX/IbdRHndWWPRMU5JyuCmGbaTPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD445DA7;
	Tue, 13 Feb 2024 00:58:36 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF7503F5A1;
	Tue, 13 Feb 2024 00:57:54 -0800 (PST)
Date: Tue, 13 Feb 2024 08:57:52 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: make scmi_bus_type const
Message-ID: <ZcsvEOAmhUNC2lT2@pluto>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
 <20240211-bus_cleanup-firmware2-v1-2-1851c92c7be7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-2-1851c92c7be7@marliere.net>

On Sun, Feb 11, 2024 at 12:51:30PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the scmi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

>  drivers/firmware/arm_scmi/bus.c    | 2 +-
>  drivers/firmware/arm_scmi/common.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index c15928b8c5cc..609a6496c1d4 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -263,7 +263,7 @@ static void scmi_dev_remove(struct device *dev)
>  		scmi_drv->remove(scmi_dev);
>  }
>  
> -struct bus_type scmi_bus_type = {
> +const struct bus_type scmi_bus_type = {
>  	.name =	"scmi_protocol",
>  	.match = scmi_dev_match,
>  	.probe = scmi_dev_probe,
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 00b165d1f502..6affbfdd1dec 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -141,7 +141,7 @@ scmi_revision_area_get(const struct scmi_protocol_handle *ph);
>  void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
>  				     u8 *prot_imp);
>  
> -extern struct bus_type scmi_bus_type;
> +extern const struct bus_type scmi_bus_type;
>  
>  #define SCMI_BUS_NOTIFY_DEVICE_REQUEST		0
>  #define SCMI_BUS_NOTIFY_DEVICE_UNREQUEST	1
> 
> -- 
> 2.43.0
> 

