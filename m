Return-Path: <linux-kernel+bounces-5087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2481866D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E9B238AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112915AE3;
	Tue, 19 Dec 2023 11:32:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B4171C3;
	Tue, 19 Dec 2023 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB601FB;
	Tue, 19 Dec 2023 03:33:39 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 974763F738;
	Tue, 19 Dec 2023 03:32:52 -0800 (PST)
Message-ID: <49306168-c0bb-4d22-affe-6129ab35ffd8@arm.com>
Date: Tue, 19 Dec 2023 11:33:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/23] PM: EM: Introduce runtime modifiable table
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-9-lukasz.luba@arm.com>
 <c2bacbf0-1aed-4c8d-816e-da0f77217f0d@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <c2bacbf0-1aed-4c8d-816e-da0f77217f0d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:50, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> The new runtime table can be populated with a new power data to better
>> reflect the actual efficiency of the device e.g. CPU. The power can vary
>> over time e.g. due to the SoC temperature change. Higher temperature can
>> increase power values. For longer running scenarios, such as game or
>> camera, when also other devices are used (e.g. GPU, ISP) the CPU power can
> 
> Don't understand this sentence. So CPU power changes with higher
> temperature and for longer running scenarios when other devices are
> involved? Not getting the 2. part.

Total power consists of:
1. dynamic power - related to the freq, voltage^2 and logic capacitance
    size involved in switching during the computation
2. static power - aka. leakage - depends on voltage and
    temperature of the silicon. The higher the temperature, the higher
    the static power.

When you heat up the SoC using e.g. GPU, you start seeing on our CPU
power plot in time a raising function. Even if your CPU was running
constantly the same workload and data for long time, this effect
will happen after you add the heat from GPU in the same chip die.

IMO this is not the right place to educate people about physics of
the chip... Some understating and higher level education would
be needed otherwise even the best patch header description won't help.
So, I would keep those patch descriptions simple.

Beside, I have explained that in a few LPC and OSPM conferences.
In the cover letter there are links to them.

> 
>> change. The new EM framework is able to addresses this issue and change
>> the EM data at runtime safely.
> 
> Maybe better:
> The new EM framework addresses this issue by allowing to change the EM
> data at runtime.
> 

Sounds good, I can change that.

