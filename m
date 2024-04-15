Return-Path: <linux-kernel+bounces-144641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 145408A48B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C25B24628
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E4225DA;
	Mon, 15 Apr 2024 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiZjjIvz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAC2206E;
	Mon, 15 Apr 2024 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164902; cv=none; b=jCFd3isSJktev2coGhRBHuPwZeak07dzprvTBOX6WX6dNqG8089rrck+Xto/i8UFF9ye1lOJ8q0C7ku6CMyiPXGFdgQEENXhHOi82ngngcEVfQNLPQRae1PDleP8Lj4gHuGek7LBaYaCqnueJSpFZJhGHxlGczzcIjmUFTA6wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164902; c=relaxed/simple;
	bh=Q/P5yjZRfoVZ5TbI1Low1FH019cQT1sVEhcJzOofFNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adQRPnbeT3dXG/YYsvdvIZBvcahGlZC5CWEVlC0oK8XLQGi8OBf1g2ClPuf/REMU2Mh+aJXsJM4QtlEf5lZ6Q9Q28Kj4+on3z4v880MEd5DzNO6MhazCtCVywMoqx7wfxF/KJyJgsxFpSA2lj4CS+rGUvjEYO2R/DcfUkwOrzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiZjjIvz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164900; x=1744700900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/P5yjZRfoVZ5TbI1Low1FH019cQT1sVEhcJzOofFNk=;
  b=AiZjjIvzJsSBuotRNaOiJ9zDtSkbDFGz69i9kE4wfLQtrCxa7Euzw3yx
   6KeCbf9vYOEoCdoFZxQLe3t6FJRWWMcm5smi8MGafdK/nB/mZXinn+oIK
   8Q0Fp87fSFNtpEv3VNFlOOsHQDIT32RajmAEgLAl1rlkVzKyQY2pIAIID
   KM+FaVRKS5X38+dFPZRHeNfPc3yt/faZ/BtfD1HIrYAhwLrgBmvCsupN3
   Y/yi0B6JPKqx0PJ06salFeZJttWEYxzrCvU1qa8BurFAeXIUZKevmqICt
   OepNx2XtThclRpqg9cI7iVfQNiLOtkAJDI+cTunHATu9UH7xDiLOtOY54
   g==;
X-CSE-ConnectionGUID: HUtQlt1lSnKvrmZUikn10g==
X-CSE-MsgGUID: wO/V/RRRS26fha7rgK7GGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8757306"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8757306"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:08:19 -0700
X-CSE-ConnectionGUID: 5TndEbYoR/qSGU2hMzMHvA==
X-CSE-MsgGUID: nMUEnbp9TFOlkwtOfc81Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22242361"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 15 Apr 2024 00:08:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 10:08:15 +0300
Date: Mon, 15 Apr 2024 10:08:15 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] usb: typec: ucsi: glink: set orientation aware if
 supported
Message-ID: <ZhzSX0z7Ofl0I93+@kuha.fi.intel.com>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
 <20240411-ucsi-orient-aware-v2-5-d4b1cb22a33f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-ucsi-orient-aware-v2-5-d4b1cb22a33f@linaro.org>

On Thu, Apr 11, 2024 at 07:49:57AM +0300, Dmitry Baryshkov wrote:
> If the PMIC-GLINK device has orientation GPIOs declared, then it will
> report connection orientation. In this case set the flag to mark
> registered ports as orientation-aware.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index d279e2cf9bba..f7546bb488c3 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -186,6 +186,17 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
>  	return ret;
>  }
>  
> +static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
> +{
> +	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> +	int i;
> +
> +	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
> +		if (ucsi->port_orientation[i])
> +			con->typec_cap.orientation_aware = true;
> +	}
> +}
> +
>  static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>  {
>  	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> @@ -208,6 +219,7 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
>  	.read = pmic_glink_ucsi_read,
>  	.sync_write = pmic_glink_ucsi_sync_write,
>  	.async_write = pmic_glink_ucsi_async_write,
> +	.update_connector = pmic_glink_ucsi_update_connector,
>  	.connector_status = pmic_glink_ucsi_connector_status,
>  };
>  
> 
> -- 
> 2.39.2

-- 
heikki

