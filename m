Return-Path: <linux-kernel+bounces-151849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD18AB4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4A6B21F19
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FC13B294;
	Fri, 19 Apr 2024 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdShaWgv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F213AD1B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549812; cv=none; b=WT0RCY8Srnav0xBW4T7wPNjjzwXDU1a2Q27bIt6GRQAJ74WCB0+T0W+s5/nb37cxd9YuncVt9Qu1BEUSyF8nWq4z8Hk+eK/tzZepOhmXk8Td4zpHC2BNsxotR3QEjoRH3B9XS1Qv1adjjT/cwSsNW65eqv9LnMiWEyMpNBR1CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549812; c=relaxed/simple;
	bh=Q4ajzruvUt8rfQ9MwqpW4YS50/I6Pb1301/GZ4ke7DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcSKj0GXj+grgTZpJrHieclf9YWp2NVFQ1E0ouG7VuOAfeTLUxmyu/zQH9uF6pZ4PVQFr49EqeqLVr1s78Z5nYnPu5jXUHVhb7GOSKpsu0YruYLQ51rZle1Smm5P8t8WAepDRIJy3Avvp8HUkhooVRspdyrcAT68mUCJ8OGkg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdShaWgv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713549811; x=1745085811;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q4ajzruvUt8rfQ9MwqpW4YS50/I6Pb1301/GZ4ke7DE=;
  b=JdShaWgvVmxDizFxPhdExZpRzyZeWmG4YaTmCbF75T2eEr4YuipUce1f
   Lel6SegevHV8fMX0FnW1dVbgz/Qr6uFZU3KN/MweFXy660W5ijo2FJ4KF
   El+Qq4L3XKajvvNz5EntNhm4vgW02nd3augk0UX1XkvuUmcU0n1Mf2Fxo
   rSA0pG47XQsWpvswDr/to99k/OGxhFUpY44X239E9lenYHB03u5OavvbM
   3gkCfAEotS260mxb/lNOtZrsCg8uCxGxpxTP0ErNjeBFrsmY0fSsW21qR
   uY4dEEVtri/TtVJpG1ZFLM+puNbsGFknRLkoW4TFti9IhShqtwbLvMl+6
   g==;
X-CSE-ConnectionGUID: E0rE47ybTeGNzWDu6tIwiw==
X-CSE-MsgGUID: Zshjs7pXRvOdLtT3oTmabA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20585707"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="20585707"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 11:03:30 -0700
X-CSE-ConnectionGUID: 4rHuCVevRMOM+chT7cy02Q==
X-CSE-MsgGUID: gomr+llSSCyVpLsQOriwBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="24015210"
Received: from mmihaitx-mobl.ger.corp.intel.com (HELO [10.125.66.30]) ([10.125.66.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 11:03:30 -0700
Message-ID: <24713e0d-779f-4084-ba5c-7375d4b05955@linux.intel.com>
Date: Fri, 19 Apr 2024 11:03:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker feature
 is present
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
 charishma1.gairuboyina@intel.com, chang.seok.bae@intel.com,
 Josh Poimboeuf <jpoimboe@kernel.org>, antonio.gomez.iglesias@linux.intel.com
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 10:47, Pawan Gupta wrote:
> +	u64 gds_lock = 0;
>  
>  	switch (gds_mitigation) {
>  	case GDS_MITIGATION_OFF:
> @@ -769,6 +769,8 @@ void update_gds_msr(void)
>  		 * the same state. Make sure the mitigation is enabled on all
>  		 * CPUs.
>  		 */
> +		gds_lock = GDS_MITG_LOCKED;
Can't we just drop the new gds_lock var and set mcu_ctrl |= GDS_MITG_LOCKED here?
> +		fallthrough;
>  	case GDS_MITIGATION_FULL:
>  		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
>  		mcu_ctrl &= ~GDS_MITG_DIS;
> @@ -779,6 +781,7 @@ void update_gds_msr(void)
>  		return;
>  	}
>  
> +	mcu_ctrl |= gds_lock;
>  	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);



