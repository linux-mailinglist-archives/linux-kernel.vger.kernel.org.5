Return-Path: <linux-kernel+bounces-92312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A2871E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D3D1F24495
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069958123;
	Tue,  5 Mar 2024 11:47:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11929CE9;
	Tue,  5 Mar 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639253; cv=none; b=DVs9+G5agyV8xaHME1xrifpEUv0bxliJRQALRxGYqJy1GzQquzzByTldWuka4l9hNqoWhqkBv7BxSooFY7aOY34BDfaKd+fK3QZguVe2xQTDQ0M2i34UTDcRzbovYgtaz0msu2zkmImc5lLXyNlrk3BPgqOCj1BHXBs5rciI944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639253; c=relaxed/simple;
	bh=RzzONS9JF/9i7RLpwuLhp0vGWEUJd7jicbO418cKucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLqWczE3i6lIvcoMcRs9db3Lqz9U9OTAcvgitos8IQ7cYrOhAyGiNFFGqL//BeXRKg8+1Pe9nGfEYl1iu4dr731NNwsLIc1Jxk5hi6fDSJoUSOYziRe5b8xFRPWOTrc04CM+iu9wqyanraAZVgKy17j/NyuOjoVxqwV9aMi+GgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B621FB;
	Tue,  5 Mar 2024 03:48:07 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E94A3F762;
	Tue,  5 Mar 2024 03:47:29 -0800 (PST)
Date: Tue, 5 Mar 2024 11:47:26 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Populate perf commands rate_limit
Message-ID: <ZecGTjbCcDD6UaqB@bogus>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240222135702.2005635-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-2-pierre.gondois@arm.com>

On Thu, Feb 22, 2024 at 02:56:59PM +0100, Pierre Gondois wrote:
> Arm SCMI spec. v3.2, s4.5.3.4 PERFORMANCE_DOMAIN_ATTRIBUTES
> defines a per-domain rate_limit for performance requests:
> """
> Rate Limit in microseconds, indicating the minimum time
> required between successive requests. A value of 0
> indicates that this field is not supported by the
> platform. This field does not apply to FastChannels.
> """"
> The field is first defined in SCMI v1.0.
> 
> Add support to fetch this value and advertise it through
> a rate_limit_get() callback.

Similarly,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>


-- 
Regards,
Sudeep

