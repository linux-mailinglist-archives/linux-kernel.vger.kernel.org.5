Return-Path: <linux-kernel+bounces-28876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C51830419
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5B71C24052
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627C1DA4C;
	Wed, 17 Jan 2024 11:02:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508315AE0;
	Wed, 17 Jan 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489372; cv=none; b=iptyWCEcrwHLnBVFn5W0vWI+kjb38UjdB5ibECslheBL/2YGw8eSu82lTz5qyK66gFKtEz4ndagekpx0ivVnDZS23yRtd9Li6JEmHL6ZlAIZKxBWcLSfFYisz+pc897ddT9LujP7uM1tybPglhraMBkmlW/rZy53cAURYw22cxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489372; c=relaxed/simple;
	bh=qBhxjWTxSMHyxAL2dgWVe/jEhmG0UZFBOtjJ1wFLvDw=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=eU0mWC7BQyv+VnZLSNcZC2aarhejSI120jPLwOw/v2q5GpwSEitIdIqiFNG5G5hZj+PUwis9Xe7PIKirvbB6JNeo4VJS+Flrqe3y+frxUS6scI8yMtVmSmSuBEeIaJlefh+/SSLdZL2jAnahEshATdO8Cd7GGAUifrel37PJqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA3E11FB;
	Wed, 17 Jan 2024 03:03:32 -0800 (PST)
Received: from [10.57.78.6] (unknown [10.57.78.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921E53F5A1;
	Wed, 17 Jan 2024 03:02:44 -0800 (PST)
Message-ID: <fa850f73-c83d-47a1-8a0c-558ad532d0d3@arm.com>
Date: Wed, 17 Jan 2024 11:02:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/23] PM: EM: Add missing newline for the message log
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-2-lukasz.luba@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240117095714.1524808-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:56, Lukasz Luba wrote:
> Fix missing newline for the string long in the error code path.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   kernel/power/energy_model.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 7b44f5b89fa1..8b9dd4a39f63 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -250,7 +250,7 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>   
>   	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
>   	if (!policy) {
> -		dev_warn(dev, "EM: Access to CPUFreq policy failed");
> +		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>   		return;
>   	}
>   

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

