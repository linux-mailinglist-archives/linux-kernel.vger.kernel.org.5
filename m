Return-Path: <linux-kernel+bounces-153359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC38ACD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8445328589E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5C14F9DC;
	Mon, 22 Apr 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmbiw8g4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2A149C6C;
	Mon, 22 Apr 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789671; cv=none; b=rkYYL4lLajNU/6jSWtH7n/LHiNjGmkLJnL+gg0OrAHMxaCnLPydZu9+Otvq0GvHdvtdPdEla2Uw3ayxCdUESlxLh/oq08v1FKU14ASz8k3ADS/kNnzWGrDLyR4cI517VQMAvxwBKT54FcNIjA8yJ2EMvXU5t2zsOwMyCNdkm01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789671; c=relaxed/simple;
	bh=q1rjbjWEjU6oynrB5uWmbFr73fQnIPng6LYdBHmm2KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmgtqLY49QNDBeO4ucAXVQDJqIRUyH0JuxtpW3FaY0W7fdws7ew4fnzWmlq3vHCMsv+wpAmjxfTSlJZXdnFpgsQJkwHlB3rQ0aKO14zlbCiz5KehSCFbwdCqjsRwARvBxZfDYPn/oVwMwJBZpjmOzH8C+bJMgUm3aHH1XnHPnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmbiw8g4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713789670; x=1745325670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q1rjbjWEjU6oynrB5uWmbFr73fQnIPng6LYdBHmm2KQ=;
  b=hmbiw8g4I5Lg5V01lgGhvg8D3zChd7OyFDKT1/1EDYHGqSuXFLEEsuKt
   iOxcGYYSFbydl+OKjxrX2bALu7fpQyv8IavxMIiZfjUCqyagoRJ7XndBd
   xmHUF55MhdZ9ItYg+Zq3g5YD0h+jvhLgK0SFe0PEcTU9BdSEJv73izBsy
   sV1Kv6ya/RPGXEIu+V9td91johdNJJy2MIBu+oRK7B/fRLG+3yS0vtc6b
   eNYLOftL61Xs+2Bx8GVl/Ozw8FATHpLwFpbi+n5UcUIk1MywpHawdgEGK
   ueJRMx3/e+M68XZgV76xOc6ND15H5OgxCRnncJ6X7X1CISGX39NcOfdB+
   A==;
X-CSE-ConnectionGUID: teyZ3cwnTgygo5+CcO3/iQ==
X-CSE-MsgGUID: 6kwfZQVXQFCbLrNjz8YfZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9151097"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9151097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:41:09 -0700
X-CSE-ConnectionGUID: 81KViA8hTvS2wGu5G1sxCw==
X-CSE-MsgGUID: /Q6cBKUESam2m5pyi7hn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="61455544"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa001.jf.intel.com with SMTP; 22 Apr 2024 05:41:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 15:41:03 +0300
Date: Mon, 22 Apr 2024 15:41:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] usb: typec: ucsi: Always set number of alternate
 modes
Message-ID: <ZiZa38zuzigPKnPe@kuha.fi.intel.com>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-5-jthies@google.com>

On Fri, Apr 19, 2024 at 09:16:50PM +0000, Jameson Thies wrote:
> Providing the number of known alternate modes allows user space to
> determine when device registration has completed. Always register a
> number of known alternate modes for the partner and cable plug, even
> when the number of supported alternate modes is 0.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cd4c3b7a5d989..ea76d42fd1504 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -812,10 +812,11 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
>  	/* Ignoring the errors in this case. */
>  	if (con->partner_altmode[0]) {
>  		num_partner_am = ucsi_get_num_altmode(con->partner_altmode);
> -		if (num_partner_am > 0)
> -			typec_partner_set_num_altmodes(con->partner, num_partner_am);
> +		typec_partner_set_num_altmodes(con->partner, num_partner_am);
>  		ucsi_altmode_update_active(con);
>  		return 0;
> +	} else {
> +		typec_partner_set_num_altmodes(con->partner, 0);
>  	}
>  
>  	return ret;
> @@ -1138,7 +1139,7 @@ static int ucsi_check_connection(struct ucsi_connector *con)
>  static int ucsi_check_cable(struct ucsi_connector *con)
>  {
>  	u64 command;
> -	int ret;
> +	int ret, num_plug_am;
>  
>  	if (con->cable)
>  		return 0;
> @@ -1172,6 +1173,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
>  			return ret;
>  	}
>  
> +	if (con->plug_altmode[0]) {
> +		num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
> +		typec_plug_set_num_altmodes(con->plug, num_plug_am);
> +	} else {
> +		typec_plug_set_num_altmodes(con->plug, 0);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

