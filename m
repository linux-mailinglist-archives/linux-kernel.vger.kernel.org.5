Return-Path: <linux-kernel+bounces-39396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321083D038
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86B0B2124D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85912B78;
	Thu, 25 Jan 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlL9DU6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF2125BA;
	Thu, 25 Jan 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223794; cv=none; b=O7ZAHKRpau90URQ4bZj5YAtufmi8NqEQ0ZxaEAHy43zc3kBJ18mteyx2Dwqf30prwumG4YP4r8cYPHpeNBTXw6KVQlEZVPsYKOTd64crZe/qI9DK60YI2Z1Q6n+TWIeGWp1SExXMAAFmyrQgBIUn1bXT+aRp+1vJawlndy53fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223794; c=relaxed/simple;
	bh=tRJ6fqwNReN0ReH1CE7vwU2UsOuWhXmcBlJ3BdSDafo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkVXLaRHFfA0NKMAustfpXB3WjnkPf4pRMMwP53VTyBoOi7bL6xwT6g4ervFYBGghw+TcfXDWEMaOjbaf59sgErPKDwNtHuA3O/JUugw9y+FDSQH3H7uLbzLiBk9mesaiatIDRr1vBMmurrZKsMwIxqaJg8v/rAKt8yrQP6iN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlL9DU6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6D9C433C7;
	Thu, 25 Jan 2024 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706223794;
	bh=tRJ6fqwNReN0ReH1CE7vwU2UsOuWhXmcBlJ3BdSDafo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlL9DU6d/j0k4cQxgjYkckuc4LxAsHoyy7EgQh3sy2J58T2QlzbuXPKtnCq1tDNEc
	 2KdG2F5ILLImhBPddK1Y4R2CNt7TPWPZ8SbjkUI9nDbxA0priIoyks9bZjjEn3dHHN
	 67QUTBuXj6Ioz0PHpIbT3y44F6BmQdjEjrrDb6gU=
Date: Thu, 25 Jan 2024 15:03:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, jthies@google.com, pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
Message-ID: <2024012512-haphazard-mobster-f566@gregkh>
References: <20240125004456.575891-1-abhishekpandit@google.com>
 <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>

On Wed, Jan 24, 2024 at 04:44:53PM -0800, Abhishek Pandit-Subedi wrote:
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index bec920fa6b8a..94b373378f63 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -3,6 +3,7 @@
>  #ifndef __DRIVER_USB_TYPEC_UCSI_H
>  #define __DRIVER_USB_TYPEC_UCSI_H
>  
> +#include <asm-generic/unaligned.h>

Do you really need to include a asm/ include file?  This feels very
wrong.

It's also in the wrong place, AND why "asm-generic"?  That also feels
wrong.

thanks,

greg k-h

