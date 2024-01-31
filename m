Return-Path: <linux-kernel+bounces-46268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3E843D49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A331F27536
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B99762D2;
	Wed, 31 Jan 2024 10:52:22 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD820762DD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698341; cv=none; b=aXUvWGEyp5IKc5CKpG2z8azwNPqJBqaIlI66UVGlDSdcItuZQwrEhMBbb4+kWyzrKXeFmgGidQZOVTN7cFzqckFaSPW/lsQuPUpkcTZv/ZRfWKX6Y3ik+3AyQnKTTitAJLTZU0UH14Kpeky8QcvEMEfOiLCGpGjhKFeSu5w4SgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698341; c=relaxed/simple;
	bh=SuEx50UjR4mvtKc/+qIPahjt8xlsD0d8Sb1tSW2xFKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZN6/nfQ2hHUztYWlrNI+k/lLBnf9ZRKBFs8CXPIAOuEkKFFb3VW4KWA/Ncr9GwhpONKRSX2ksPXEQwOlrdlNsBokN41B7lP7L4O60kxNyyWzDX3VVFhZgVxoQyA1s9y/abb6UPwIBiYa8mUIkaZ8JMakfzPtgdzCkbWkZxoJOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1706698334-1eb14e0c7d326b0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id PwrBgcLIFe8NDdPk (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 31 Jan 2024 18:52:14 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 18:52:13 +0800
Received: from [10.32.57.248] (10.32.57.248) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 18:52:11 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <f635eae6-c411-4791-90b8-c26d0a37ef2d@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.57.248
Date: Wed, 31 Jan 2024 18:52:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Add get the highest perf register value
 support
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 1/3] ACPI: CPPC: Add get the highest perf register value
 support
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <peterz@infradead.org>,
	<j.granados@samsung.com>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, <LindaChai@zhaoxin.com>
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
 <20231228075705.26652-2-TonyWWang-oc@zhaoxin.com>
 <20240117220742.GC13777@ranerica-svr.sc.intel.com>
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240117220742.GC13777@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1706698334
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1550
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.120187
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/1/18 06:07, Ricardo Neri wrote:
>
> [这封邮件来自外部发件人]
>
> On Thu, Dec 28, 2023 at 03:57:03PM +0800, Tony W Wang-oc wrote:
>> Add function cppc_get_highest_perf in generic CPPC driver to get the
>> highest perf register value for specified core.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 13 +++++++++++++
>>   include/acpi/cppc_acpi.h |  5 +++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 7ff269a78c20..1a77c514d007 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>        return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>>   }
>>
>> +/**
>> + * cppc_get_highest_perf - Get the highest performance register value.
>> + * @cpunum: CPU from which to get highest performance.
>> + * @highest_perf: Return address.
>> + *
>> + * Return: 0 for success, -EIO otherwise.
>> + */
>> +int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>> +{
>> +     return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> The Intel P-State driver uses cppc_get_perf_caps(). You would not need to
> export this function.
>
> Having said that, the Intel P-State driver could also use this new
> function, IMO. AFAICS, it does not *have* to use cppc_get_perf_caps().

Yes, you are right.


