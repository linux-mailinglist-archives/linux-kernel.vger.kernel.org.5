Return-Path: <linux-kernel+bounces-97139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A48765FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C971F26755
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E83FBBF;
	Fri,  8 Mar 2024 14:06:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84864381C1;
	Fri,  8 Mar 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906780; cv=none; b=F3VY6jqPI6qg+UEJKX7F475XJXE/1PZ60Oy7SOVzdSunNXJXcRnBPBiLU1W0NzM3Lo4nIXPLXbw+qswgiJiuZ0j912VAhMq4NLVuVu4nA6P7mR6SgYoTFq2RCWCLiUm6Dpm/dw/8Fdjy+n6swe8g8JPufn5ysZBEsUikT4JGY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906780; c=relaxed/simple;
	bh=YNKQO8eq+spXiFjQGqJrc8i08W6wiv6p1QJ71kvlbHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROZp2WtlkDd4888ck/186ZAZIgq7YEABV24NNRI616WMjpusowtt09Cch/VNmVuLsh7ACiio2Tux/EHIl03I9XZtgdb4FnJky7RVkrDtECJfu03cO/xEEGVAiu4wwqRawGUgNz+kZ/HFLFDLkzqlqpL54xuYh49uabBGs8rPZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E4F9C15;
	Fri,  8 Mar 2024 06:06:54 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B510E3F762;
	Fri,  8 Mar 2024 06:06:15 -0800 (PST)
Date: Fri, 8 Mar 2024 14:06:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
	<dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
	<sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
	<nm@ti.com>
Subject: Re: [PATCH V3 2/2] cpufreq: scmi: Enable boost support
Message-ID: <ZesbVW0dDd1i2F_F@bogus>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
 <20240308104410.385631-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308104410.385631-3-quic_sibis@quicinc.com>

On Fri, Mar 08, 2024 at 04:14:10PM +0530, Sibi Sankar wrote:
> The X1E80100 SoC hosts a number of cpu boost frequencies, so let's enable
> boost support if the freq_table has any opps marked as turbo in it.
>

I had asked if you could put the information about how and when the boost
frequencies are used, it would be useful for reference purposes when someone
attempts to use this feature. But it is not a blocker, just good to have
info.

Also I would not sure specific platform name, just refer as certain platforms
as it such information becomes stale soon.

Anyways apart for those nits on the commit message, this looks good.

Reviewed-by: <viresh.kumar@linaro.org>

I am assuming Viresh might take both these changes for via his tree. If not,
I can take it for v6.10 after v6.9-rc1

-- 
Regards,
Sudeep

