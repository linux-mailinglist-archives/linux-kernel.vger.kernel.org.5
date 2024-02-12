Return-Path: <linux-kernel+bounces-61277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0D85103C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234D31C20A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A017BD9;
	Mon, 12 Feb 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RTnKUsQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A828EF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732128; cv=none; b=NYQP/UtJR1akljaroNA7bY48DSrbQQjq1wtqSoIbMAVW4p7lGeG0ZGso+7o3+8zQAVgokoujBrDpgUdlVFq4MgvGwwRtS5IBswFOszpHP5ut5OcrXUiclnUY+f7vRDarmOYAVRvxZlOUHe94ONieIDL90t14/umAYMuc2Na5PFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732128; c=relaxed/simple;
	bh=zpCv4CyeZaFDF/ZPPOLtiz2KwiCRx5PBxGtNXZYfqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoHsCxWQy3rpWMwzJNFpKVgV6uTedImutDj1yhPV+pAJrptSFluXUZnXLWG/MgBZ1EbvSle3sgOG/YS5flroJ9fAjmEo+13BtP6mbsUmwjVVwvzN9usm08zBOdgDsUf7tm8dZ8D0EzK0io3AZlKDQFBYzAYMS7Pacf32PD3oQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RTnKUsQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0B6C433C7;
	Mon, 12 Feb 2024 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707732128;
	bh=zpCv4CyeZaFDF/ZPPOLtiz2KwiCRx5PBxGtNXZYfqSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTnKUsQf+LdZGoaXW8tIy/LD/E1/C2qbraNOSlCF+t6H1Xqb6T+T6W4cJmE/g8hOd
	 6oSUEUUCgtkcAUqKu6FD8I8cxB3N7xRNnpPG1py2WMCNU5N6Hy29rDqXmMxf5iYJcY
	 wgZntKitw4fsvASCymxTAxCHbpkMTNlUaYvLnfZk=
Date: Mon, 12 Feb 2024 11:02:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] mei: vsc: Assign pinfo fields in variable declaration
Message-ID: <2024021210-freeway-unblessed-d966@gregkh>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
 <20240212094618.344921-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212094618.344921-4-sakari.ailus@linux.intel.com>

On Mon, Feb 12, 2024 at 11:46:18AM +0200, Sakari Ailus wrote:
> Assign all possible fields of pinfo in variable declaration, instead of
> just zeroing it there.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> index 200af14490d7..1eda2860f63b 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -447,11 +447,16 @@ static int vsc_tp_match_any(struct acpi_device *adev, void *data)
>  
>  static int vsc_tp_probe(struct spi_device *spi)
>  {
> -	struct platform_device_info pinfo = { 0 };
> +	struct vsc_tp *tp;
> +	struct platform_device_info pinfo = {
> +		.name = "intel_vsc",
> +		.data = &tp,
> +		.size_data = sizeof(tp),
> +		.id = PLATFORM_DEVID_NONE,
> +	};

But now you have potential stack data in the structure for the fields
that you aren't assigning here, right?  Is that acceptable, or will it
leak somewhere?

This is why we generally do not do this type of style.  So unless you
are fixing an issue here, please don't do it.

thanks,

greg k-h

