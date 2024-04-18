Return-Path: <linux-kernel+bounces-149650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D558A93FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75311F21B22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401D53381;
	Thu, 18 Apr 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY/N9fun"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154D38F96;
	Thu, 18 Apr 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425428; cv=none; b=Ixd5fDEKHIwfM+SKVp3poT59Hfc93DrJU/7E84YxbgxdExnODpEAFJEg3RHiwFSV5F4Pot8DPKrBRg6Kqz0i+9br109pRJV5BZjJgIuEXAvPcU8vpp8i8wMr0eCNnGQgvejO2dDVPKt9N7C/eOqTLsy7+Ds0efITFvJC6HopoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425428; c=relaxed/simple;
	bh=5g7iu/VVAy/L+SP4+CheknDrk8WwulKiELdeRGtgDF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/MVCJyhMyZRF9YAsMSzda+yQs0rnNHxnOixg5tIqF5AS1hYkJKBMoyfRVsfImJhMt7u1K4AQqrYXbfQzGFbE2Te4N4uHpkuUzi2BjGEr6dPXKvZkpL5xGvj2Rk4RdFmdO+ApPB5P+mXsv1FSHhvmW2qD6zBRZnfpfPKkbcxBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QY/N9fun; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713425427; x=1744961427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5g7iu/VVAy/L+SP4+CheknDrk8WwulKiELdeRGtgDF8=;
  b=QY/N9fundHkAsTf2cChu4e4/6lr9980bnzNQ21h/OQP7ztb0yckr1Da1
   i34raXWOw5n6RxnrdiN8af7KZs+2bkdOOdDWu+rktqUIdESRRczVvAfbb
   byMtCuht0zcmgaRUfSCcYNSZw0a0lQH41/mYZVroRvnok8HJ0D7gLl1RA
   kBJPpyyc28KBXpHU0lXAAgeKStSL4k8e2Q62SsYoDDSGiQXhjCtFL0cK7
   IEmlY6ktAiUY/udcclDF9l2QlEE7/Ok2sNkfLfCVCiHSll9FpA6lYUf5L
   KQ9bCwOxgkL4AyRlo5ClX4WXKd1f5tqkRGSFpopUBOQ6kA74s5ls7/kJk
   w==;
X-CSE-ConnectionGUID: PqrORcytQjq02UOIjScVZw==
X-CSE-MsgGUID: HKcH8GKpRCKGXTbzgpFAEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9502750"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9502750"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:30:26 -0700
X-CSE-ConnectionGUID: iks+W5Y9Q5K1RKF6sS7HkQ==
X-CSE-MsgGUID: KqH5QFqvRm68XI9aFxiv3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="23316867"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:30:24 -0700
Date: Thu, 18 Apr 2024 09:30:01 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate control
 flags
Message-ID: <ZiDL+TTeJWhYam6Q@mev-dev>
References: <20240416144331.15336-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416144331.15336-1-ast@fiberby.net>

On Tue, Apr 16, 2024 at 02:43:30PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 2f2fce285ecd..361abd7d7561 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -1673,6 +1673,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
>  		flow_rule_match_control(rule, &match);
>  
>  		addr_type = match.key->addr_type;
> +
> +		if (flow_rule_has_control_flags(match.mask->flags,
> +						fltr->extack))
> +			return -EOPNOTSUPP;
>  	}
>  

Thanks,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
> -- 
> 2.43.0
> 

