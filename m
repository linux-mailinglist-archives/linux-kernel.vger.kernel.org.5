Return-Path: <linux-kernel+bounces-43203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A888410CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8647D1F231CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249276C78;
	Mon, 29 Jan 2024 17:33:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6149F3F9C0;
	Mon, 29 Jan 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549629; cv=none; b=kK+dDfIq4xJHMnrUNRWEesttFbQHFIXoXcryDnrTuwsGjxavQSAX9ZansL+TEfjoI2Kb2ZSAFsceNDv+x5tvbwww3cX6DwOf9dBH0xeFLRcQDIK6B9FLzMdVIA4uAvd2Nj8IjCMV91KS+jjocfBgzT9E6CphzMspcoUmqSfoWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549629; c=relaxed/simple;
	bh=0G0a9SH3HRE/wXfgh9FewlGtrR4nnDKGGG/gwPSjrQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1UQ9N4hxyHYRjHEaso5f03lev7BgupFxCxWF3z+SerKetLIFZB0FCYVaUQaTs4fTRVY9q+2SsAtKjh8CDQsJtLkKQEK8mq2VWyDxJRKVNEFeFRXGiaK+z36ExnbgEtEupHPxwqYmlNe4JFK+qUrqYOW/mlLFwNkTzkH25n+2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81171DA7;
	Mon, 29 Jan 2024 09:34:30 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C813F738;
	Mon, 29 Jan 2024 09:33:44 -0800 (PST)
Date: Mon, 29 Jan 2024 17:33:42 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support
 interface
Message-ID: <ZbfhdqBBpjyf3IRI@pluto>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-2-quic_sibis@quicinc.com>
 <ZbfJN1c9viiLhO1L@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfJN1c9viiLhO1L@pluto>

On Mon, Jan 29, 2024 at 03:50:20PM +0000, Cristian Marussi wrote:
> On Wed, Jan 17, 2024 at 04:11:13PM +0530, Sibi Sankar wrote:
> > Add a new perf_notify_support interface to the existing perf_ops to export
> > info regarding limit/level change notification support.
> > 
> 
> Hi Sibi,
> 
> as I mentioned previously, in order not to add a needless stream of SCMI
> Perf accessors I posted this:
> 
> https://lore.kernel.org/linux-arm-kernel/20240129151002.1215333-1-cristian.marussi@arm.com/T/#u
> 
> to expose all the Perf domains infos via the usual info_get(), similarly
> to how other SCMI protocols do already.
> 
> I think that reworking this series on that, you can certainly drop this patch and just
> check the _notify booleans on the retrieved domain info.

Sorry, but hold on with this change, I will probably post an updated version
my patch above.

Thanks,
Cristian

