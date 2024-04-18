Return-Path: <linux-kernel+bounces-149910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE28A97C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C691C21033
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F515DBA2;
	Thu, 18 Apr 2024 10:50:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215156464
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437415; cv=none; b=jvwvMQtc1tzEMzDB2sYz/81K//GFKOWEiycXURGdv/F4dwl/Zqg3wQDmkG6ZBYXNCENMj2e8aQlZ/4DXG1m7kMGHW7HDu/uoDN9vLtyHMO/aXyTxfHJvwM5FKidZz+Bv+7QSCH10lw1ODgaHlnMwMAyIjBDKUmZYz5r9UfrzQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437415; c=relaxed/simple;
	bh=Gb01zz7qAuzJeG4CS2gKsjN09lALUK7BnQ027MT77so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK7N+XvKK9lnUxgH3TuJPt++ycwxd7AorXkq3PxOZdXq1bcqUzEEvYrcVA6Glv5Pr/ls+frX+LB4EZ79SvNwiU4Z0N8nUxEeKv912ASik96N/J9Sj/hd0QuxbLSUEGuXkKSJfvjcAzMytDlwmmJZmDBrigg9rnomDawliN38KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFAF339;
	Thu, 18 Apr 2024 03:50:41 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94EAC3F792;
	Thu, 18 Apr 2024 03:50:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:50:08 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: Re: [PATCH v5 1/5] arch_topology: init capacity_freq_ref to 0
Message-ID: <20240418105008.auhtzjv47zrrud77@bogus>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417093848.1555462-2-beata.michalska@arm.com>

On Wed, Apr 17, 2024 at 10:38:44AM +0100, Beata Michalska wrote:
> From: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> It's useful to have capacity_freq_ref initialized to 0 for users of
> arch_scale_freq_ref() to detect when capacity_freq_ref was not
> yet set.
> 
> The only scenario affected by this change in the init value is when a
> cpufreq driver is never loaded. As a result, the only setter of a
> cpu scale factor remains the call of topology_normalize_cpu_scale()
> from parse_dt_topology(). There we cannot use the value 0 of
> capacity_freq_ref so we have to compensate for its uninitialized state.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

