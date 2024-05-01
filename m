Return-Path: <linux-kernel+bounces-165031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605958B86D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9162A1C22C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADFE4F883;
	Wed,  1 May 2024 08:26:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF2EED6;
	Wed,  1 May 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551979; cv=none; b=KRRujS6jqRSE9P/U1SPoPQburuzqpZrIIGraPo7uopWdy9botcYbc8x0pkP345CtJ3HwQWomP3DF23ncNG5pHiBF5PtgsoxIjWTRomfqPTDnlPUw58C6PfvYHj5I+x9QY1qV5EW1vetwbhYLsMecdRyAPoybtgIiRj17Z4v0pkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551979; c=relaxed/simple;
	bh=iYFnDq0CeKxPGYYHmDL6Q0GWpMVC+8yb5WrFiUIvPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAkTt8oA+Cxam/WyVJy4E+6DmMPfKb7CwHjP1pY0ZWOaPU2YhS2ykGpgkQusPwQHufFBQAFt1okMrUJhEOWkJcZA1o4ruLCfLsRNRAyfFFHvJTrX+CKaV/5IXHV07oVjh7jiKHSXCjgR9IsjImhl6ADpzb5Z8u+QQz1/nPVSNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EE952F4;
	Wed,  1 May 2024 01:26:43 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8773C3F793;
	Wed,  1 May 2024 01:26:15 -0700 (PDT)
Date: Wed, 1 May 2024 09:26:13 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, pierre.gondois@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 2/2] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <ZjH8pWppKhayvFxx@pluto>
References: <20240328074131.2839871-1-quic_sibis@quicinc.com>
 <20240328074131.2839871-3-quic_sibis@quicinc.com>
 <ZjH7hWnKFcpQ-TXH@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjH7hWnKFcpQ-TXH@pluto>

On Wed, May 01, 2024 at 09:21:30AM +0100, Cristian Marussi wrote:
> On Thu, Mar 28, 2024 at 01:11:31PM +0530, Sibi Sankar wrote:
> > Register for limit change notifications if supported and use the throttled
> > frequency from the notification to apply HW pressure.
> > 
> 
> Hi Sibi,
> 
> a bit late on this, sorry.
> 

..forgot the tag :P

> Just a couple of nitpicks down below.

[snip]

> In general,
> 
> LGTM.
> 

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

