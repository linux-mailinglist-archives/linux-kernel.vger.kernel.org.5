Return-Path: <linux-kernel+bounces-129589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA2896CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F49028A3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430BE143887;
	Wed,  3 Apr 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vb31bbcJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5C433AD;
	Wed,  3 Apr 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140960; cv=none; b=c9SeKcU18GOaLayelyt1pexsoXRBpNY4LS2zBA5KXzO3vpBl6MERqe2jKvx4lDKGNM/5h2K9IAynCWEjcBDWAdLjDIoaMsrzXkEAg6eRp43DBbsA0BvCUd4iq2kvLAv9m2N9i26KZPBdxf/Buz4vKH8+jveFvse8Bb0rVbR17f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140960; c=relaxed/simple;
	bh=kvLrjtLhhqRjyJ49Iqe9d/QUUJr5eILfFsPRFkbQOxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCE4AEqneFQPY9qLFv+i90dTxy1DDYCawS3RLB6ToLOj/iuaE5f6aXIZD/oxJBCKfi2MxLHYuSz19yUVoa5GW3dMZ51C6MBe8KI6l2vq1LR0snTU4f7E3uArZntI+/hHbDSNIjG6+78LM2WZki8hsbZzinu1Ip7Jw4vJIeb4KBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vb31bbcJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712140958; x=1743676958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kvLrjtLhhqRjyJ49Iqe9d/QUUJr5eILfFsPRFkbQOxs=;
  b=Vb31bbcJm+1NGj1Ocv9JIfgjYTmEb549fZJc1aXIneoRxRzZ4HKKC2h+
   fAHBO/U3FMcz7paMqhB3jUmC1B72scZfwcQq8eD/pt3B4wLDIoI6MSjp4
   qGEBHmyAdhuwhvl1mClUlx6Mrh8xnT4TXQGjNuyxS5kZu82e85kqtL8ju
   qNmKBU0l0+8WYZZMKvF9h0SsMziSvKI5nBXfY3Pe22BwExh4kzqdt1Smc
   i1S6xHq7Gf16MnjggelP/nIYfLuLKo/kXsejGGNiHZsV3wCKO21EWh8QW
   zeKPKmIXVLSuVoVRqRf9QtDSPhzJuOX7V1Tas3hYbbujlYu6R+7PlPkIA
   A==;
X-CSE-ConnectionGUID: 7t1qyyPlQr28lnRI2q6QKQ==
X-CSE-MsgGUID: M6AQ987kRYiFHzg+lzlo2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10331114"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10331114"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084844"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084844"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2024 03:40:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Apr 2024 13:40:01 +0300
Date: Wed, 3 Apr 2024 13:40:01 +0300
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
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Never send a lone connector change
 ack
Message-ID: <Zg0yAfuhoOT0XrX+@kuha.fi.intel.com>
References: <20240327224554.1772525-1-lk@c--e.de>
 <20240327224554.1772525-3-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327224554.1772525-3-lk@c--e.de>

On Wed, Mar 27, 2024 at 11:45:53PM +0100, Christian A. Ehrhardt wrote:
> Some PPM implementation do not like UCSI_ACK_CONNECTOR_CHANGE
> without UCSI_ACK_COMMAND_COMPLETE. Moreover, doing this is racy
> as it requires sending two UCSI_ACK_CC_CI commands in a row and
> the second one will be started with UCSI_CCI_ACK_COMPLETE already
> set in CCI.
> 
> Bundle the UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
> for the UCSI_GET_CONNECTOR_STATUS command that is sent while
> handling a connector change event.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 48 +++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 31d8a46ae5e7..48f093a1dc09 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -49,22 +49,16 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
>  	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
>  }
>  
> -static int ucsi_acknowledge_command(struct ucsi *ucsi)
> +static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
>  {
>  	u64 ctrl;
>  
>  	ctrl = UCSI_ACK_CC_CI;
>  	ctrl |= UCSI_ACK_COMMAND_COMPLETE;
> -
> -	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
> -}
> -
> -static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
> -{
> -	u64 ctrl;
> -
> -	ctrl = UCSI_ACK_CC_CI;
> -	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
> +	if (conn_ack) {
> +		clear_bit(EVENT_PENDING, &ucsi->flags);
> +		ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
> +	}
>  
>  	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
>  }
> @@ -77,7 +71,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
>  	int ret;
>  
>  	/* Acknowledge the command that failed */
> -	ret = ucsi_acknowledge_command(ucsi);
> +	ret = ucsi_acknowledge(ucsi, false);
>  	if (ret)
>  		return ret;
>  
> @@ -89,7 +83,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
>  	if (ret)
>  		return ret;
>  
> -	ret = ucsi_acknowledge_command(ucsi);
> +	ret = ucsi_acknowledge(ucsi, false);
>  	if (ret)
>  		return ret;
>  
> @@ -152,7 +146,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
>  		return -EIO;
>  
>  	if (cci & UCSI_CCI_NOT_SUPPORTED) {
> -		if (ucsi_acknowledge_command(ucsi) < 0)
> +		if (ucsi_acknowledge(ucsi, false) < 0)
>  			dev_err(ucsi->dev,
>  				"ACK of unsupported command failed\n");
>  		return -EOPNOTSUPP;
> @@ -165,15 +159,15 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
>  	}
>  
>  	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
> -		ret = ucsi_acknowledge_command(ucsi);
> +		ret = ucsi_acknowledge(ucsi, false);
>  		return ret ? ret : -EBUSY;
>  	}
>  
>  	return UCSI_CCI_LENGTH(cci);
>  }
>  
> -int ucsi_send_command(struct ucsi *ucsi, u64 command,
> -		      void *data, size_t size)
> +static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
> +				    void *data, size_t size, bool conn_ack)
>  {
>  	u8 length;
>  	int ret;
> @@ -192,7 +186,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
>  			goto out;
>  	}
>  
> -	ret = ucsi_acknowledge_command(ucsi);
> +	ret = ucsi_acknowledge(ucsi, conn_ack);
>  	if (ret)
>  		goto out;
>  
> @@ -201,6 +195,12 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
>  	mutex_unlock(&ucsi->ppm_lock);
>  	return ret;
>  }
> +
> +int ucsi_send_command(struct ucsi *ucsi, u64 command,
> +		      void *data, size_t size)
> +{
> +	return ucsi_send_command_common(ucsi, command, data, size, false);
> +}
>  EXPORT_SYMBOL_GPL(ucsi_send_command);
>  
>  /* -------------------------------------------------------------------------- */
> @@ -1168,7 +1168,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	mutex_lock(&con->lock);
>  
>  	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
> -	ret = ucsi_send_command(ucsi, command, &con->status, sizeof(con->status));
> +
> +	ret = ucsi_send_command_common(ucsi, command, &con->status,
> +				       sizeof(con->status), true);
>  	if (ret < 0) {
>  		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
>  			__func__, ret);
> @@ -1225,14 +1227,6 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
>  		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
>  
> -	mutex_lock(&ucsi->ppm_lock);
> -	clear_bit(EVENT_PENDING, &con->ucsi->flags);
> -	ret = ucsi_acknowledge_connector_change(ucsi);
> -	mutex_unlock(&ucsi->ppm_lock);
> -
> -	if (ret)
> -		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
> -
>  out_unlock:
>  	mutex_unlock(&con->lock);
>  }
> -- 
> 2.40.1

-- 
heikki

