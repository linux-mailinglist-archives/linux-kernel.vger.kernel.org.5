Return-Path: <linux-kernel+bounces-121324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B317688E65E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FE1B248BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFE15217D;
	Wed, 27 Mar 2024 12:55:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8EC12F37F;
	Wed, 27 Mar 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544141; cv=none; b=K6E2oLhunFnQvbQNSRXveswcGDCAFo+gPypiUctUEd9Fyi5MsHVqm0/7+IesB9avRbGiPIr3UyjloE+urt/AyEle9FDTY8ZmWoUGynGAdR08f53gQpOD2f9yOGR2bh18uNg4mcW+uvH2HEFUO3VC1IWCWCbvsoL4HtAeE5cCmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544141; c=relaxed/simple;
	bh=3K5FY9zYoZ9NIYrs8JeXAE2pagjbwPp+dZ93De3oyV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EK9zmRbNONZeGke3kZ1HaNlR6pkeGZsagmRjRX7c6yD3qbYeHbagALPCEYFJrquVd1AVQZDaSDxYNkAUjUeKgN1bJ7qhV6Lp2cNNCZsvK2lbi6xeSkqxnJB84EROndmZM8amMtff6lhKhdQwMsc91k9PH0EFy0so/SrbWvxZRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27C1E2F4;
	Wed, 27 Mar 2024 05:56:12 -0700 (PDT)
Received: from [192.168.178.110] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD983F7C5;
	Wed, 27 Mar 2024 05:55:35 -0700 (PDT)
Message-ID: <410c5da7-c79c-4607-9aa3-2e78d991d2d7@arm.com>
Date: Wed, 27 Mar 2024 13:55:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 3/4] PM: EM: Add em_dev_update_chip_binning()
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-4-lukasz.luba@arm.com>
 <eb9f48f6-cca8-405b-82a2-352893a79f14@arm.com>
 <30ee98e9-3d9a-4be8-8127-043f68a7dcb1@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <30ee98e9-3d9a-4be8-8127-043f68a7dcb1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 21:32, Lukasz Luba wrote:
> 
> 
> On 3/26/24 10:09, Dietmar Eggemann wrote:
>> On 22/03/2024 12:08, Lukasz Luba wrote:

[...]

>>> +    return em_recalc_and_update(dev, pd, em_table);
>>> +}
>>> +EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
>>
>> In the previous version of 'chip-binning' you were using the new EM
>> interface em_dev_compute_costs() (1) which is now replaced by
>> em_recalc_and_update() -> em_compute_costs().
>>
>> https://lkml.kernel.org/r/20231220110339.1065505-2-lukasz.luba@arm.com
>>
>> Which leaves (1) still unused.
>>
>> That was why my concern back then that we shouldn't introduce EM
>> interfaces without a user:
>>
>> https://lkml.kernel.org/r/8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com
>>
>> What happens now with em_dev_compute_costs()?
>>
> 
> For now it's not used, but modules which will create new EMs
> with custom power values will use it. When such a module have
> e.g. 5 EMs for one PD and only switches on one of them, then
> this em_dev_compute_costs() will be used at setup for those
> 5 EMs. Later it won't be used.
> I don't wanted to combine the registration of new EM with
> the compute cost, because that will create overhead in the
> switching to new EM code path. Now we have only ~3us, which
> was the main goal.
> 
> When our scmi-cpufreq get the support for EM update this
> compute cost will be used there.

OK, I see. I checked the reloadable EM test module and
em_dev_compute_costs() is used there like you described it.


