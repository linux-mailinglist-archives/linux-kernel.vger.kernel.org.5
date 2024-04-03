Return-Path: <linux-kernel+bounces-129587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B068896CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F01C275AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E31411DB;
	Wed,  3 Apr 2024 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cin1z96n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394C13B2A2;
	Wed,  3 Apr 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140926; cv=none; b=HKD6i1DxS0GAD+N0doGKtUL3XPi/w1zYqJIU2PqbfYJEbTMnrBPYmRSuY+cgnzVBapdD5aykUtmk6Qw4ysozrBwfOz5Iax3Pu7UUl9Tc2r/acRG8OfgDntw0DyyyDc/Dd0Gcl3lIoU4iAeTRwkILG4fpZwMZjrVUk7ItbvR+HXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140926; c=relaxed/simple;
	bh=VyamW3pmzqfesnrQLCpxRniRljIdmqoDlBtM7x6Qkgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHO4u9+n1xYLJHyps2c7faxS2G4/vqm29SV7zTUN9FRl8CE3aAbA2ssy+vDVHkBZsYW7hv/Jm6hNTQHc3Anq8CU99p+8MXtNIAv5yaWX84mCQknGgBXgIMZdafjrE8D+T0W9gflEJsEvkjdrkHZBM3Lh6/BcnOo7sRus8hZ4oh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cin1z96n; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712140924; x=1743676924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VyamW3pmzqfesnrQLCpxRniRljIdmqoDlBtM7x6Qkgc=;
  b=cin1z96nD3GMtwoqf6MMneJ5Fs/+NEmfUj8hGidTXgGkIpwQWYiNDSHN
   ixl7XZzO+hU8TOQagNrgVd4gDSGGUl54JRBOMynByRnbzuORlwTebPrNV
   TLYrUUy5qjvh24/srKL/wHPh1iSH+WDpe5DKSuPfGkgjlmocDoP+j4dS/
   wT1sqFIol59Ac880qINh0iTfqzisgK+Udr6sVuMDapWgSXXNGo90eMiWf
   /NZ2j1Pa/gkC56NkZ710OibBP8Ee+Wu4UUT3djyXzgxwMz86VJqqYJWZp
   JoZO9FjJ20VDGmhfdOY+cGiroW9kIKI3yqPNGbRgoLTOp3OBEPq/8GhzP
   g==;
X-CSE-ConnectionGUID: jSsXvr9KQHC6c6U7ZSj1Ig==
X-CSE-MsgGUID: tuWs3oMFScG3r9axp8HFvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10330861"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10330861"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084843"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084843"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2024 03:39:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Apr 2024 13:39:44 +0300
Date: Wed, 3 Apr 2024 13:39:44 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: ucsi: Stop abuse of bit definitions from
 ucsi.h
Message-ID: <Zg0x8HKsoJb+phWw@kuha.fi.intel.com>
References: <20240327224554.1772525-1-lk@c--e.de>
 <20240327224554.1772525-2-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327224554.1772525-2-lk@c--e.de>

On Wed, Mar 27, 2024 at 11:45:52PM +0100, Christian A. Ehrhardt wrote:
> In ucsi.h there are flag definitions for the ->flags field
> in struct ucsi. Some implementations abuse these bits for
> their private ->flags fields e.g. in struct ucsi_acpi.
> 
> Move the definitions into the backend implementations that
> still need them. While there fix one instance where the flag
> name was not converted in a previous change.
> 
> No semantic change intended.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.h         | 2 --
>  drivers/usb/typec/ucsi/ucsi_acpi.c    | 3 ++-
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 1 +
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 0e7c92eb1b22..591f734d457b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -403,8 +403,6 @@ struct ucsi {
>  	/* PPM communication flags */
>  	unsigned long flags;
>  #define EVENT_PENDING	0
> -#define COMMAND_PENDING	1
> -#define ACK_PENDING	2
>  
>  	unsigned long quirks;
>  #define UCSI_NO_PARTNER_PDOS	BIT(0)	/* Don't read partner's PDOs */
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 7b3ac133ef86..cc03a49c589c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -203,7 +203,8 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>  	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
>  		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
>  
> -	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
> +	if (cci & UCSI_CCI_ACK_COMPLETE &&
> +	    test_bit(UCSI_ACPI_ACK_PENDING, &ua->flags))
>  		complete(&ua->complete);
>  	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
>  	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 93d7806681cf..ac48b7763114 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -64,6 +64,7 @@ struct ucsi_stm32g0 {
>  	struct completion complete;
>  	struct device *dev;
>  	unsigned long flags;
> +#define COMMAND_PENDING	1
>  	const char *fw_name;
>  	struct ucsi *ucsi;
>  	bool suspended;
> -- 
> 2.40.1

-- 
heikki

