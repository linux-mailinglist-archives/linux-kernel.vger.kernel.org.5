Return-Path: <linux-kernel+bounces-34942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0741838986
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E725A1C25DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86659B57;
	Tue, 23 Jan 2024 08:49:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E440858233;
	Tue, 23 Jan 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999770; cv=none; b=qUTxXUBwuCv9ZLvoZ0sU7qpfeOSuXvgkX1a4G97MVCvh7yXVJyi1R/tci9mkJbgoHVM70OjxogW0KarwvhLsYGcY8JGPvy4dnuONanKxE5WjC1paXnIF7gFjjNHVXu2B6AefpNubvrWBS/LDIbL/GHFB0jiO5elzqn7OSirklJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999770; c=relaxed/simple;
	bh=OhEQnIXrlhdFp7CeyB8l+srQyd3hlcNi3YFfbgAq5I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMGToFvpOTaGH96GBj24BXjVU+rh+DFF7XuGnQ4IfTuLW0TwLBSbst41DS0ml84SY+H4uB3DmuK68whEpM4iFx0bEbrcZhWGK53VmrWUgZn/DuIACBH64LdqrNom3cl5ynStEJp8RADNbptE+zau6rASFsPoLqew7wq2QCQ7Too=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649FF1FB;
	Tue, 23 Jan 2024 00:50:13 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CF763F5A1;
	Tue, 23 Jan 2024 00:49:25 -0800 (PST)
Date: Tue, 23 Jan 2024 08:49:23 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	rafael@kernel.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <Za99k-dksrwnrqfK@pluto>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123060827.a3vszziftj6pszt3@vireshk-i7>

On Tue, Jan 23, 2024 at 11:38:27AM +0530, Viresh Kumar wrote:
> On 17-01-24, 16:34, Sibi Sankar wrote:
> > This series adds provision to mark dynamic opps as boost capable and adds
> > boost frequency support to the scmi cpufreq driver.
> > 
> > Depends on:
> > HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/
> > scmi notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/

@Sudeep, I am going to start review on this series and the related one
these next few days.

Thanks,
Cristian

