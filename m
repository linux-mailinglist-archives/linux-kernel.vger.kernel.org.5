Return-Path: <linux-kernel+bounces-129597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C43DA896CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626D01F2FE82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45D1419AA;
	Wed,  3 Apr 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqv1XO6/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51062433AD;
	Wed,  3 Apr 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141045; cv=none; b=QwQkDKjuEpZIjMHB4hFsekh9sDjEm2qDVGS3PGldb+tpyFiLK6me9IQ5nqZYGmN10Tgxi1sYs0U+KUahsZeB2KAstV/H1ET42yiZKdMndfFidGNZ0LodpsqtX6ht8W5ADM1FUEwAJviKfPVnjxbGZY/qtiAqo4OPkyIOsyXIPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141045; c=relaxed/simple;
	bh=gFVgV8VnIJkjPewJOuua6XWcrrzgQB0ahlVwO9D7s08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLZTZEAIiPlG7IFzkF/Thh6LBMffTh4O4w/6/GbaCwgjtJDROVwVSmu2ujYn2/bJ7DW/QqsaHNKn/wxj0VjXkgxYuCPSHxteEAl+KQZCvF6ghWH1iDzleU4dVxsjjsl96KaFqp1kaToNx0j2b0y3/EoaYHu3O8z2UgeNppBHLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqv1XO6/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141044; x=1743677044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gFVgV8VnIJkjPewJOuua6XWcrrzgQB0ahlVwO9D7s08=;
  b=kqv1XO6/jE3QAq96Y1dUPF/V+hncVfDZ0b5boI8aDShPnewRZWYD+NSQ
   0R6P+OfMHGq0+PpmhY7B6FJa/VAzGDQrqP97oGyR4KtS76cHg61ipEKMi
   yq9rj1VkxLJsmE+eycT01nqQ00urIb8h7d5NQ+1trS02hkiYPLALn7p5b
   msn6htThA84T0RAieeMlX8MERozl6aLrUlunsHjeViIVc8BUD42oyDNCq
   SPXdR8/3LkH3Zu6II49saTCV2fvwR5d7v86A983dMIiOQOVa+OcQjJz7K
   u7iPr3rD+EeUx1TApUHYdu/yxlWjUH4lDOzy0LDT24qGkdz4ZGoah4LYs
   A==;
X-CSE-ConnectionGUID: m/gP52CeSF6dal/sMK+SqA==
X-CSE-MsgGUID: SLHEopTtS9yYtBrRqcrIog==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10331690"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10331690"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084845"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084845"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2024 03:40:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Apr 2024 13:40:45 +0300
Date: Wed, 3 Apr 2024 13:40:45 +0300
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
Subject: Re: [PATCH 3/3] usb: typec: ucsi_acpi: Remove Dell quirk
Message-ID: <Zg0yLXfVa0wmA2GZ@kuha.fi.intel.com>
References: <20240327224554.1772525-1-lk@c--e.de>
 <20240327224554.1772525-4-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327224554.1772525-4-lk@c--e.de>

On Wed, Mar 27, 2024 at 11:45:54PM +0100, Christian A. Ehrhardt wrote:
> The Dell quirk from ucsi_acpi.c. The quirk is no longer
> necessary as we no longer send lone connector change acks.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 53 +-----------------------------
>  1 file changed, 1 insertion(+), 52 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index cc03a49c589c..8d112c3edae5 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -23,7 +23,6 @@ struct ucsi_acpi {
>  	void *base;
>  	struct completion complete;
>  	unsigned long flags;
> -#define UCSI_ACPI_SUPPRESS_EVENT	0
>  #define UCSI_ACPI_COMMAND_PENDING	1
>  #define UCSI_ACPI_ACK_PENDING		2
>  	guid_t guid;
> @@ -129,49 +128,6 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
>  	.async_write = ucsi_acpi_async_write
>  };
>  
> -/*
> - * Some Dell laptops don't like ACK commands with the
> - * UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
> - * bit set. To work around this send a dummy command and bundle the
> - * UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
> - * for the dummy command.
> - */
> -static int
> -ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
> -		     const void *val, size_t val_len)
> -{
> -	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> -	u64 cmd = *(u64 *)val;
> -	u64 dummycmd = UCSI_GET_CAPABILITY;
> -	int ret;
> -
> -	if (cmd == (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE)) {
> -		cmd |= UCSI_ACK_COMMAND_COMPLETE;
> -
> -		/*
> -		 * The UCSI core thinks it is sending a connector change ack
> -		 * and will accept new connector change events. We don't want
> -		 * this to happen for the dummy command as its response will
> -		 * still report the very event that the core is trying to clear.
> -		 */
> -		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
> -		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
> -					   sizeof(dummycmd));
> -		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
> -
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
> -}
> -
> -static const struct ucsi_operations ucsi_dell_ops = {
> -	.read = ucsi_acpi_read,
> -	.sync_write = ucsi_dell_sync_write,
> -	.async_write = ucsi_acpi_async_write
> -};
> -
>  static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  	{
>  		.matches = {
> @@ -180,12 +136,6 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)&ucsi_zenbook_ops,
>  	},
> -	{
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -		},
> -		.driver_data = (void *)&ucsi_dell_ops,
> -	},
>  	{ }
>  };
>  
> @@ -199,8 +149,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>  	if (ret)
>  		return;
>  
> -	if (UCSI_CCI_CONNECTOR(cci) &&
> -	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
> +	if (UCSI_CCI_CONNECTOR(cci))
>  		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
>  
>  	if (cci & UCSI_CCI_ACK_COMPLETE &&
> -- 
> 2.40.1

-- 
heikki

