Return-Path: <linux-kernel+bounces-56177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7284C708
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B09828284B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405D20DC5;
	Wed,  7 Feb 2024 09:15:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3A20B0C;
	Wed,  7 Feb 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297304; cv=none; b=LFMkCCSqn5Thbq9UvvEYQIFjgmMHYSnXgUjoo0MEkNMTFpBaiEGBXr0f6Hgcnnp5h2LgHrA2MFaD2QMu3xtUjPDiT78ccQ1t4gd0PNqg5eadl2anYf8ioqZyPmorizURIEi2LENirmzEiW8RolZfVg0s4Tw6wDPHZ9TyBLTLjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297304; c=relaxed/simple;
	bh=eDDAm5T9Y1wfXHivGFyISzxgExo700soJgRTSIPVd90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYINMscz82DKADF4r6Op/4pHA9Jbwme9C3OsTU/HuSHnVIv4Rp/g/jNDVGWXuqBWN7kMl0DFGeA+mkKAPI7noNS5IgGx99PwzQEDt97hHgWI78gn/ICS/kWj+hY5nug8mn5thvFRAzUE0Uppk/XglQIDCW+i9MO+VIZP+X8vN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E7E1FB;
	Wed,  7 Feb 2024 01:15:43 -0800 (PST)
Received: from [10.57.9.121] (unknown [10.57.9.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59AEC3F762;
	Wed,  7 Feb 2024 01:14:58 -0800 (PST)
Message-ID: <5a38043f-6de3-4038-b1d9-314090e7b44e@arm.com>
Date: Wed, 7 Feb 2024 09:15:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To: rafael@kernel.org
Cc: dietmar.eggemann@arm.com, linux-pm@vger.kernel.org, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 linux-kernel@vger.kernel.org, wvw@google.com, xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 1/17/24 09:56, Lukasz Luba wrote:
> Hi all,
> 
> This patch set adds a new feature which allows to modify Energy Model (EM)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in EAS.
> 

[snip]

> 
> 
> Lukasz Luba (23):
>    PM: EM: Add missing newline for the message log
>    PM: EM: Extend em_cpufreq_update_efficiencies() argument list
>    PM: EM: Find first CPU active while updating OPP efficiency
>    PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
>    PM: EM: Introduce em_compute_costs()
>    PM: EM: Check if the get_cost() callback is present in
>      em_compute_costs()
>    PM: EM: Split the allocation and initialization of the EM table
>    PM: EM: Introduce runtime modifiable table
>    PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
>    PM: EM: Add functions for memory allocations for new EM tables
>    PM: EM: Introduce em_dev_update_perf_domain() for EM updates
>    PM: EM: Add em_perf_state_from_pd() to get performance states table
>    PM: EM: Add performance field to struct em_perf_state and optimize
>    PM: EM: Support late CPUs booting and capacity adjustment
>    PM: EM: Optimize em_cpu_energy() and remove division
>    powercap/dtpm_cpu: Use new Energy Model interface to get table
>    powercap/dtpm_devfreq: Use new Energy Model interface to get table
>    drivers/thermal/cpufreq_cooling: Use new Energy Model interface
>    drivers/thermal/devfreq_cooling: Use new Energy Model interface
>    PM: EM: Change debugfs configuration to use runtime EM table data
>    PM: EM: Remove old table
>    PM: EM: Add em_dev_compute_costs()
>    Documentation: EM: Update with runtime modification design
> 
>   Documentation/power/energy-model.rst | 183 ++++++++++-
>   drivers/powercap/dtpm_cpu.c          |  39 ++-
>   drivers/powercap/dtpm_devfreq.c      |  34 +-
>   drivers/thermal/cpufreq_cooling.c    |  45 ++-
>   drivers/thermal/devfreq_cooling.c    |  49 ++-
>   include/linux/energy_model.h         | 165 ++++++----
>   kernel/power/energy_model.c          | 472 +++++++++++++++++++++++----
>   7 files changed, 819 insertions(+), 168 deletions(-)
> 

The patch set went through decent review. If you don't have any issues,
I will collect the tags and send the v8 which will be re-based on some
recent linux next (or please tell me your preferred branch).

Regards,
Lukasz

