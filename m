Return-Path: <linux-kernel+bounces-129603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCEB896D13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B84328CDDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651C13A417;
	Wed,  3 Apr 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lc4xMIj/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F43137C47;
	Wed,  3 Apr 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141166; cv=none; b=jY2/rt7GR58JOqIm7VG0e7kajBB5hVnI24f6X7U/RRgwX/6EVNg1c6lEUz0K0uz4GIm62ofDb50wsAjuDkf6wWdJKmLnUIdPAuh/PfjUZA52Ivkp+PF86LqW3FGU/+rLf72JD8t87vZKBiJm0fFgWO82KKHER905s8Dq85HQ7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141166; c=relaxed/simple;
	bh=J14sLh9bFuqxnc7SY8mcH1I46NF5bOyBXqn1GfbFCjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO1iSE1N+G1lgHWDAfDnNoy2s5RMej+eMuGuI05pg19nYEBAVmQNnM+BQolLYVXk3DR98FVf72WeWhxsYSXdk9O7CYadH52G4qzzzyQFAVO7brdRMmpBspWjFOtl/sbbbtn3yJr0YW/mIYGFcjt0TiuuiMQ9BIyUQFrnsIva5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lc4xMIj/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141163; x=1743677163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J14sLh9bFuqxnc7SY8mcH1I46NF5bOyBXqn1GfbFCjU=;
  b=lc4xMIj/ErGGynXfSfPP0BdJdiQFl/17qLNnIvfU8AbxYiTCME1nlShc
   aooSh+7uRyuiuZ1yiYT1JOuRwvEOM5LTBinKJqA58fw97b4353rlFndpQ
   mGYDxnUNzvOtorVrqBzt/0TPOwm/KunAkQehJSXDcas/2MaC069jfZosn
   ixGgMi9R00o9U0n13+Mv1p4jhNaCiTfhcQAPY0pbdb5WhfRX4nbMEXVtd
   LS88l/t26c0q8jsn1XDPatEHKPBoIW+trAwvmjp8HkoBoxtd1x/LaeiS6
   FTfTKQU1WsetOZ7CYpyt2gv2uU+YJm9Xfmj2MrwofY6ZukD4poJ4unzcv
   A==;
X-CSE-ConnectionGUID: tpbvA0bOSlaq5P6GCgT0DA==
X-CSE-MsgGUID: L786OjHCREqIcLOnuY+oaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10332529"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10332529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084846"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084846"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2024 03:42:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Apr 2024 13:42:26 +0300
Date: Wed, 3 Apr 2024 13:42:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix connector check on init
Message-ID: <Zg0yksaQaGy+ZOaI@kuha.fi.intel.com>
References: <20240401210515.1902048-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401210515.1902048-1-lk@c--e.de>

On Mon, Apr 01, 2024 at 11:05:15PM +0200, Christian A. Ehrhardt wrote:
> Fix issues when initially checking for a connector change:
> - Use the correct connector number not the entire CCI.
> - Call ->read under the PPM lock.
> - Remove a bogus READ_ONCE.
> 
> Fixes: 808a8b9e0b87 ("usb: typec: ucsi: Check for notifications after init")
> Cc: stable@kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 31d8a46ae5e7..bd6ae92aa39e 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1736,11 +1736,13 @@ static int ucsi_init(struct ucsi *ucsi)
>  	ucsi->connector = connector;
>  	ucsi->ntfy = ntfy;
>  
> +	mutex_lock(&ucsi->ppm_lock);
>  	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	mutex_unlock(&ucsi->ppm_lock);
>  	if (ret)
>  		return ret;
> -	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
> -		ucsi_connector_change(ucsi, cci);
> +	if (UCSI_CCI_CONNECTOR(cci))
> +		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  
>  	return 0;
>  
> -- 
> 2.40.1

-- 
heikki

