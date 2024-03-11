Return-Path: <linux-kernel+bounces-98575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39544877C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4C21C208A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F314010;
	Mon, 11 Mar 2024 09:05:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFB134B9;
	Mon, 11 Mar 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147902; cv=none; b=N0k7+JzETjFgg9uEPc86vDVWM9UKX/C3u3r/r/leJ+6YgTi7xFp02lxzbbqE5LLZv6vlA7Ibl+cDJlozn7ZPOU8+ogzNVIIE6AqiUsHqgBkj1NTnqHlSpU+pbCdOW8AE94vVyMXBdcV39ilXT5zAE62GQ0Uym390IaOuTgQsDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147902; c=relaxed/simple;
	bh=Hq9KMZlJYWHrarCVLuBeXH2ELq8mujCoLoueQLuYpv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBX+7E0iQx3Rf5CCvODga8IOBX2fXJJSvNtdhYOWGBp2Jvhzqvjm2VWFzPH2z5tdz9VEBZQOKr4Z3q/zRRxQsAslC5McphnIxHgBDXMds4Gh7UA/scHCplF7ZWI6XmivMzryJIJD47N2JAiT0nO5FnWdBYp0TaQbRb3allyzT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DFA7FEC;
	Mon, 11 Mar 2024 02:05:35 -0700 (PDT)
Received: from bogus (unknown [10.57.94.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1545C3F762;
	Mon, 11 Mar 2024 02:04:55 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:04:54 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
	rafael@kernel.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V3 2/2] cpufreq: scmi: Enable boost support
Message-ID: <20240311090454.rcyefesrfw6rp2ad@bogus>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
 <20240308104410.385631-3-quic_sibis@quicinc.com>
 <ZesbVW0dDd1i2F_F@bogus>
 <20240311045513.om2dbej62kz3hex5@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311045513.om2dbej62kz3hex5@vireshk-i7>

On Mon, Mar 11, 2024 at 10:25:13AM +0530, Viresh Kumar wrote:
> On 08-03-24, 14:06, Sudeep Holla wrote:
> > Anyways apart for those nits on the commit message, this looks good.
> > 
> > Reviewed-by: <viresh.kumar@linaro.org>
> 
> :)
>

😉

So stupid of me, I wanted to make sure you were in to and seem to have
copied the same address for my reviewed by. Sorry for that, obviously
I meant:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

