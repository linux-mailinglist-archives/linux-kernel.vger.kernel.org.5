Return-Path: <linux-kernel+bounces-153175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B58B8ACA98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD581C20F93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565913FD61;
	Mon, 22 Apr 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+OAdNX1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26B13E885;
	Mon, 22 Apr 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781767; cv=none; b=TTphVgnEUZAQKYzeSS0vgwswLnXb+IbADmqAwx8QbbEdBFhBk8qlIR03mCVgCB6iUsjNVQduFg4G2R60rNS379IwqLIe4BB4KEM3ZYuWDd9QBiaEwAQpU3L/8198Pz6AJZmAY+W4qbS78C5AjFBEI0iVxafRppHF5wmebHQZqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781767; c=relaxed/simple;
	bh=Dsjtwdz42mlbmRF3eRysE4BJ8B9Lqudf+iM1+vpzlYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVnxq8AJCAKmtUBXBWNIMKt73KHMxUiuF0Ol5b73crjusrrYW6Vs25Hlx4zCLxct8lwmCoEkIwyBrRpY3d2iJDd2ZSqbVURDf+ZR8Oa1NB8Bo2R/M9KOUAvIK/OVb5SEQjOgySG6JatdAGfhZBaMmI/0R3q08eqpnszcTtBnhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+OAdNX1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713781766; x=1745317766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dsjtwdz42mlbmRF3eRysE4BJ8B9Lqudf+iM1+vpzlYM=;
  b=P+OAdNX1PopvO7JeKXfAWFWMC/NsKdwxiyg/l8FeU8cCB260mspKNTCy
   +vTaRgCviAA01LYbm9UGmrM5Doq804FEnUYbgYkdkvf2l2Lb9LE+VWIwR
   Mz+i0K98ZAbse/l5fQI2gDzIH3c2WH9IFZZc8biTuQ9jdKojGdGK/kVH0
   1D0Nyskbn9aiOfjR9QSCeXb86JNpXjJIgscUSYNijxZ/nNDJCjlYzzp5Y
   WH5XambXQVmzewGGb13Ywp7fXZESD+JFAfP8nPbHqVf1F4NEsI9ynU6b+
   dpHuYsq20wlBdlXn/a2090ULxqFRrxduLRRwI7b8DAUzZ3y90Iosh2tvM
   A==;
X-CSE-ConnectionGUID: 8gevncY7RBeDLE8KLnxBQQ==
X-CSE-MsgGUID: diKzmvJcQ++nrmbdwkP0mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="20714679"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20714679"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 03:29:25 -0700
X-CSE-ConnectionGUID: SOyw/RQuRHa4hy0zb1qhDg==
X-CSE-MsgGUID: xVR5rgHDQOuV5zhV0fTmpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24024565"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa006.fm.intel.com with SMTP; 22 Apr 2024 03:29:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 13:29:21 +0300
Date: Mon, 22 Apr 2024 13:29:21 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/8] usb: typec: ucsi: glink: use le32 for message data
Message-ID: <ZiY8AR54sV9RSK9G@kuha.fi.intel.com>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-4-890db00877ac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-ucsi-glink-altmode-v1-4-890db00877ac@linaro.org>

On Tue, Apr 16, 2024 at 05:20:53AM +0300, Dmitry Baryshkov wrote:
> The message structures as transferred by the PMIC_GLINK use le32 for
> data encoding. Correct struct accessors to follow the lead of the main
> pmic_glink.c driver.
> 
> Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 6be9d89d4a28..d029cc9d82e3 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -33,7 +33,7 @@ struct ucsi_read_buf_req_msg {
>  struct ucsi_read_buf_resp_msg {
>  	struct pmic_glink_hdr   hdr;
>  	u8                      buf[UCSI_BUF_SIZE];
> -	u32                     ret_code;
> +	__le32                  ret_code;
>  };
>  
>  struct ucsi_write_buf_req_msg {
> @@ -44,13 +44,13 @@ struct ucsi_write_buf_req_msg {
>  
>  struct ucsi_write_buf_resp_msg {
>  	struct pmic_glink_hdr   hdr;
> -	u32                     ret_code;
> +	__le32                  ret_code;
>  };
>  
>  struct ucsi_notify_ind_msg {
>  	struct pmic_glink_hdr   hdr;
> -	u32                     notification;
> -	u32                     receiver;
> +	__le32                  notification;
> +	__le32                  receiver;
>  	u32                     reserved;
>  };
>  
> @@ -255,7 +255,7 @@ static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *
>  	if (resp->ret_code)
>  		return;
>  
> -	ucsi->sync_val = resp->ret_code;
> +	ucsi->sync_val = le32_to_cpu(resp->ret_code);
>  	complete(&ucsi->write_ack);
>  }
>  
> 
> -- 
> 2.39.2

-- 
heikki

