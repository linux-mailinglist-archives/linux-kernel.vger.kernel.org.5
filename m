Return-Path: <linux-kernel+bounces-108864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA4881111
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422691F21D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472873FE4E;
	Wed, 20 Mar 2024 11:33:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE713FB9E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934435; cv=none; b=Pc2kzKXx+Pk3Jq6aW4oRpL3Gn9kapbC9MSFp41QFSKK/oeIKN7kxu00nBzkg9jHyU9fVDSYvBSjM/S/RLJrHnd3DGAS568JJl7xA67ie9ZqGoknvw5QSZquJSionf5vyLRA07fmRZmV6Gbx2SDWInsiE+uOKmQM6SP/K1LdnJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934435; c=relaxed/simple;
	bh=YWpzXNbiPg0NRIhcV5APAOtSSYxuVM3h5oBkgFC7q7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEWBh2pEpxXgBXoIA76VawZ4IZZmvmS7HdaccuDv+qUYhaPHetLwVbpNeVWjT4LHH5oS3w/cXnI9Vg/aoD0+0OG5hU0TV9pMHfwzV2uTqNJnyBr2ITQpSquJ15ukm08eQPJrYTz+W//1RbsnNmb+KCkYK7qGas7MnCGFU7YmtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D951007;
	Wed, 20 Mar 2024 04:34:26 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E002A3F762;
	Wed, 20 Mar 2024 04:33:50 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:33:48 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: perf: print domain name in error path
Message-ID: <ZfrJnEpzfQ-AsU9q@bogus>
References: <20240320074213.1615888-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320074213.1615888-1-peng.fan@oss.nxp.com>

On Wed, Mar 20, 2024 at 03:42:13PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It would be easier to locate the problem if domain name is printed out.
> And including a coding style update.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 345fff167b52..e98ca6d15b0c 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -79,7 +79,7 @@ struct scmi_msg_resp_perf_domain_attributes {
>  	__le32 rate_limit_us;
>  	__le32 sustained_freq_khz;
>  	__le32 sustained_perf_level;
> -	    u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];

Spurious change ?

>  };
>  
>  struct scmi_msg_perf_describe_levels {
> @@ -387,8 +387,8 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
>  
>  	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
>  	if (ret)
> -		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
> -			 opp->perf, ret);
> +		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s- ret:%d\n",
> +			 opp->perf, dom->info.name, ret);
>  }
>  
>  static inline void
> @@ -405,8 +405,8 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
>  
>  	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
>  	if (ret)
> -		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
> -			 opp->perf, ret);
> +		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> +			 opp->perf, dom->info.name, ret);
> 

Are you really hitting these issues ? Or is it just code
observation/improvements ?

It looks good otherwise. You can also add the below change when you respin.

-- 
Regards,
Sudeep

diff --git i/drivers/firmware/arm_scmi/perf.c w/drivers/firmware/arm_scmi/perf.c
index 211e8e0aef2c..ef1c27a65552 100644
--- i/drivers/firmware/arm_scmi/perf.c
+++ w/drivers/firmware/arm_scmi/perf.c
@@ -830,7 +830,8 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,

                ret = dev_pm_opp_add_dynamic(dev, &data);
                if (ret) {
-                       dev_warn(dev, "failed to add opp %luHz\n", freq);
+                       dev_warn(dev, "[%d][%s]: Failed to add OPP[%d] %lu\n",
+                                domain, dom->info.name, idx, freq);
                        dev_pm_opp_remove_all_dynamic(dev);
                        return ret;
                }

