Return-Path: <linux-kernel+bounces-46766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9618443DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8028BCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E712BEB4;
	Wed, 31 Jan 2024 16:12:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21587BAFF;
	Wed, 31 Jan 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717539; cv=none; b=tpDMQlhCJpqSD7xaNzfbLUnkFXdPcdG1qQikrYcJ5/tZHblhJ70D3IMTh2eQVVVKFMXlSvi86WbYD4vYiQscVHO+MApNM3Uqon2Csr0xy+/45zlvEW0fKIlBWDng4ey3ylPwGZQVU8sT63AUJo8CuFPpfvqO58iR6TU3jtMWiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717539; c=relaxed/simple;
	bh=uOdYXEGnPke7pN6zLY42ifDeRAGGRDtMgqWsQY0vdgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMDcPUdPkBydmA2O9YBN4JSwmROBBObNbbXKrD/Ah34nGji1ycXmcZ5puXaRyvQdHvC+wsCfDZqLM2t8YPsSJRerKXgWEvyzDs4EEYU6ZL+qfuLcf3rcITiHy12eAYhO1cSn6jMs8PNY40GS8rWRsq665cZTfl9a+FAA8YDjucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DF3EDA7;
	Wed, 31 Jan 2024 08:13:00 -0800 (PST)
Received: from bogus (unknown [10.57.78.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED68F3F762;
	Wed, 31 Jan 2024 08:12:13 -0800 (PST)
Date: Wed, 31 Jan 2024 16:12:11 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, cristian.marussi@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
	morten.rasmussen@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <20240131161211.v3rhwidmdalfdvz7@bogus>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7>
 <Za-RtBrSxI-j4Jdx@bogus>
 <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>

On Wed, Jan 31, 2024 at 04:07:48PM +0100, Dietmar Eggemann wrote:

[...]

>
> root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
> 1
> 0
> 0

OK I admit, I wasn't aware of this per policy boost flag.
It must be enabled by default if it has any effect. Otherwise
it breaks the existing behaviour on all the SCMI based platforms.

-- 
Regards,
Sudeep

