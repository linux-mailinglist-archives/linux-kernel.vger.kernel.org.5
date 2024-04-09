Return-Path: <linux-kernel+bounces-136304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CB989D275
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0227C1C21A9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340043AA0;
	Tue,  9 Apr 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzVT0OsL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1A1DFC4;
	Tue,  9 Apr 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644210; cv=none; b=UTWsQYTyuxneIJ8o7pY9LQqqE60fAaue44k72NkIUkYyGBw3Z68K2Fe79Pgq3I3jnhYz7mSVYMUY+KAKq96HokmsBMZLf1mB6wFfo8sHSFuZ3RQSWkiZB+ghrFXjD/4FHBCpOIQ2ytVHVWTIAkf1+vjyCGudDyv1KMYQACrZvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644210; c=relaxed/simple;
	bh=y4XqJdFt7y1AyYebuwpEgYd69/uTnJh6qyQOlVWNtTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTdoaqESPKRgBviIfti2nl/SJvK6FSUYAT/YS1fMB8OaDDKOGHHkQg20f1tPDY1GD2+wsQRcgmEbSdJE8qWpN/sq2ZkBPh2J7N6ZbJV3njxPgwAwkfqfrqw60GCHrVnKHwWlZUjjV9ZE+iMCJQPvBv3pIa3nzhppPTf6zW8ZXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzVT0OsL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712644209; x=1744180209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y4XqJdFt7y1AyYebuwpEgYd69/uTnJh6qyQOlVWNtTY=;
  b=EzVT0OsLyZFoSIWBchJIEGLiOyL4EXuL48HngcRTRmKBkH0O89+zTt7n
   R7YGScrX9XICUsZMBQ+eRZUK5vL1d5RET19WUpIJBOdulMnjpQm6+u62Z
   oNuez6IkFi4NYtue/o12bvb0IHpukWeMhkN+OPXG+rHGCDA4jHvK4IG87
   Ya+oJflQwkx+RIvDpDz4XAGrdw8wG3uqyC9XrB0Z2koQVWHXcyAiE1r1s
   t95GwQwqAWwTWGwfKYHRKMlrsn9MlF7FgVEPeInONAKPSM4fFmwbvo2D1
   vi5XiETrj132w3y4H8MN8gWkODTRfYMe74ccVNM7u21bdqtn2+BJxPCi9
   A==;
X-CSE-ConnectionGUID: OK8KBrloRNGZVn8wKb/FhA==
X-CSE-MsgGUID: qUR03+ISSWujYc3IP6hkYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8069501"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="8069501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093067"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="937093067"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2024 23:30:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2024 09:30:04 +0300
Date: Tue, 9 Apr 2024 09:30:04 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: typec: ucsi_glink: drop special handling for
 CCI_BUSY
Message-ID: <ZhTgbOYigUBucwNY@kuha.fi.intel.com>
References: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
 <20240408-qcom-ucsi-fixes-bis-v1-3-716c145ca4b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-qcom-ucsi-fixes-bis-v1-3-716c145ca4b1@linaro.org>

On Mon, Apr 08, 2024 at 04:04:17AM +0300, Dmitry Baryshkov wrote:
> Newer Qualcomm platforms (sm8450+) successfully handle busy state and
> send the Command Completion after sending the Busy state. Older devices
> have firmware bug and can not continue after sending the CCI_BUSY state,
> but the command that leads to CCI_BUSY is already forbidden by the
> NO_PARTNER_PDOS quirk.
> 
> Follow other UCSI glue drivers and drop special handling for CCI_BUSY
> event. Let the UCSI core properly handle this state.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

One minor nitpick below, but feel free to ignore that one.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 9ffea20020e7..b91d2d15d7d9 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -176,7 +176,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
>  	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
>  	if (!left) {
>  		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
> -		ret = -ETIMEDOUT;
> +		/* return 0 here and let core UCSI code handle the CCI_BUSY */
> +		ret = 0;
>  	} else if (ucsi->sync_val) {
>  		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
>  	}
> @@ -243,10 +244,7 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  		ucsi_connector_change(ucsi->ucsi, con_num);
>  	}
>  
> -	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
> -		ucsi->sync_val = -EBUSY;
> -		complete(&ucsi->sync_ack);
> -	} else if (ucsi->sync_pending &&
> +	if (ucsi->sync_pending &&
>  		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {

Looks like you forgot to fix the alignment.

>  		complete(&ucsi->sync_ack);
>  	}
> 
> -- 
> 2.39.2

-- 
heikki

