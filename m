Return-Path: <linux-kernel+bounces-43033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E6840A88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8FD287CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967C15530A;
	Mon, 29 Jan 2024 15:50:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91419153BE2;
	Mon, 29 Jan 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543422; cv=none; b=Et6uOZhZPpx93P4PJHr1po0V/Fnjr3x0no8jA9ScOgCNVODURzzefuTiYTASPZSKqHhRoyuFFpPlEJ29tmTi6N2Smvj3t3ydyJJBw3rSt78X/PEmjNWepoDvzPFut/mAN9IRfbr7kw0Nh/rTgkMDbYEoAR6bvpfiQyroN+IPnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543422; c=relaxed/simple;
	bh=VmvZDhKYfgrRdCXKs7qjeIO7NOgbgsUQBfZdk3ARslU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbahPpA4SmP8zAGrfqUy6EdSMrUmhhl4Y9+MF9qkYkV3Opa7js5kZ9t3IL0KXIvZdCC9WllFn8OEXE+qSZi9FHFWX1hWshSCDYZYZyjsBErydduvYlfUnbsH42EZKoQQZvuWQ4BdIzsgbjGk7k+mAAn9D4KxOs0chSi/y4ypuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC82BDA7;
	Mon, 29 Jan 2024 07:51:03 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7343F738;
	Mon, 29 Jan 2024 07:50:17 -0800 (PST)
Date: Mon, 29 Jan 2024 15:50:15 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support
 interface
Message-ID: <ZbfJN1c9viiLhO1L@pluto>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117104116.2055349-2-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 04:11:13PM +0530, Sibi Sankar wrote:
> Add a new perf_notify_support interface to the existing perf_ops to export
> info regarding limit/level change notification support.
> 

Hi Sibi,

as I mentioned previously, in order not to add a needless stream of SCMI
Perf accessors I posted this:

https://lore.kernel.org/linux-arm-kernel/20240129151002.1215333-1-cristian.marussi@arm.com/T/#u

to expose all the Perf domains infos via the usual info_get(), similarly
to how other SCMI protocols do already.

I think that reworking this series on that, you can certainly drop this patch and just
check the _notify booleans on the retrieved domain info.

Thanks,
Cristian

