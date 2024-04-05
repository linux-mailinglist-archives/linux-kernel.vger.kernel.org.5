Return-Path: <linux-kernel+bounces-132910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59894899BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C9D286A59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033016C68F;
	Fri,  5 Apr 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDR2tSlT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25F1649D9;
	Fri,  5 Apr 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316790; cv=none; b=DOne+qXVxuqS5FiZmsjmUPFubw79+EkIBv9wRkRO9hP1r604SKDnJucxhD+IESGRq5YcfmoM3YlDML1VXdVOHw3+IA8KGpbutBkRpEHmsJpPGv1ETVMbF2LIDo0QiQxbNDlFTAEWU1VHryHsxkUjvblVdu+DaahLLkOQKsSZdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316790; c=relaxed/simple;
	bh=1IJxKXB+iIW8cKud3ZyPKD1YQbL8JP+Q6dQ7MVjZPnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT3Kij5YSQJlvThrl6rFcqBG9ef1Zs/8fCVODBVDnoWIQ9zrm0XZArubZuEXmZfxEqWTGlELiaFV5icu7IrAdOjhE42MBbMdACM9WzMCnvJD5U4a0MdjzAelXOHibgo/7FklHrsGDczKqHEJWJaTme1CZBeZPltWMHGUvMty/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDR2tSlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B07C433C7;
	Fri,  5 Apr 2024 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712316790;
	bh=1IJxKXB+iIW8cKud3ZyPKD1YQbL8JP+Q6dQ7MVjZPnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDR2tSlTuRGcnmG+PbyU4+itCc5G8tEb8kvsp+vyHqHH4ey71I4Xlb5K5+Z1R+SV/
	 WnodWDdMIv8JKRZw4ysq0ZA2RTcurvGoluKHZqgDkYomP7TgnT/HfVtAFFqEBQgqU0
	 qIsenfVnNmMUqYO/KCzUnxrhDSwDwYeYcqsZQuQvJ9yZlfD2LbPW94MdCDQ1kPiEZJ
	 LuyrZn+7KrObiaMYspKcR0O/wRlE0PPzjH9SB7LFE7nmnwTchm639cX9xwf0dMk8fp
	 is+/INaqMbr4NIQ+UyaLTYKMImK4spsYpFm5GLwy9M8F3p4KfHdk0d3YcTFt75xdXp
	 Xg04fQ9o3RCdg==
Date: Fri, 5 Apr 2024 17:03:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 4/7] soundwire: reconcile dp0_prop and dpn_prop
Message-ID: <Zg_hcQ2RUBpkA_DG@matsya>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-5-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326090122.1051806-5-yung-chuan.liao@linux.intel.com>

On 26-03-24, 09:01, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The definitions for DP0 are missing a set of fields that are required
> to reuse the same configuration code as DPn.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index e5d0aa58e7f6..e3a4bccc2a7e 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -235,7 +235,8 @@ enum sdw_clk_stop_mode {
>   * @BRA_flow_controlled: Slave implementation results in an OK_NotReady
>   * response
>   * @simple_ch_prep_sm: If channel prepare sequence is required
> - * @imp_def_interrupts: If set, each bit corresponds to support for
> +  * @ch_prep_timeout: Port-specific timeout value, in milliseconds
> +  * @imp_def_interrupts: If set, each bit corresponds to support for

why is this line modified? seems to be same as previous and leading
space added which might not be correct


>   * implementation-defined interrupts
>   *
>   * The wordlengths are specified by Spec as max, min AND number of
> @@ -249,6 +250,7 @@ struct sdw_dp0_prop {
>  	u32 *words;
>  	bool BRA_flow_controlled;
>  	bool simple_ch_prep_sm;
> +	u32 ch_prep_timeout;
>  	bool imp_def_interrupts;
>  };
>  
> -- 
> 2.34.1

-- 
~Vinod

