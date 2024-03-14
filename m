Return-Path: <linux-kernel+bounces-103619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E687C208
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22B6282F12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B0745F4;
	Thu, 14 Mar 2024 17:18:57 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEB1EA6F;
	Thu, 14 Mar 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436737; cv=none; b=rrYwZetTUsmxUS8zCrK8IxwkB18kK60E7bdnAErJFgg2Ms/OdcHgHvMiWBbJjoguwTGlkHrjjFNOziTbgieeQZRW2CG/7FTzQXXwhp564BriDESZoFzgk8wKbvwzhOISDtu1KJM0xfuTUAAGCwICXhcnvjY2VL01j4VRMarGuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436737; c=relaxed/simple;
	bh=ScgJkxs9uD7S5VVXNIUGoytyYxjXodh1C85TtwT2BVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W5/hCKlAlnXwea4UBvceFcCbyQWnGqAg157o7B3zUO67hGdhl6rMkWdi76CCU378KgLEV7JN0WIf8glEFwPaiDotJt/NgHYXjO4NjTv/nKOpMnUc1WUzriJqOkVxuL2MGFJmWpztZdp1qpnYK25aw1NzfGrqEJKA+b3m2eYUCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id F365F40AB2; Thu, 14 Mar 2024 10:18:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id F152540AAD;
	Thu, 14 Mar 2024 10:18:53 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:18:53 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-arm-kernel@lists.infradead.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    Stephan Gerhold <stephan@gerhold.net>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, 
    Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: always allocate zeroed cpumask
In-Reply-To: <20240314125457.186678-1-m.szyprowski@samsung.com>
Message-ID: <9aea1694-d54b-2f48-bd67-fb5ab12d347c@linux.com>
References: <CGME20240314125628eucas1p161af377a50fd957f445397bc1404978b@eucas1p1.samsung.com> <20240314125457.186678-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 14 Mar 2024, Marek Szyprowski wrote:

> -	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> 		return -ENOMEM;

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>


