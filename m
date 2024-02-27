Return-Path: <linux-kernel+bounces-83758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42FD869E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80638290A10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551894EB21;
	Tue, 27 Feb 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1yoGKMje"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07A2557F;
	Tue, 27 Feb 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055858; cv=none; b=CI3iq0t1Czjf2Q3GKhw3FBq5/on6JYJM8C6yqfF6ZdHS0HIGi2DrbDeWgwnJpy6rOHONJs9lWw7lmSYXUo269sxAgF2de6ONDd99aXWr+3dTyXi9JbsSRHPvDtaYtYZUF7GdxcuQixlaGDeCpwDpu7218AMqmhYtUumb1Qt1hH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055858; c=relaxed/simple;
	bh=3BzQKjJGF7tof5rGJyDKufTYQlj8ezjC6ENk83SsZ4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m5ST3hlKHJXI/A/xBRtIrI8U3Y8k3wHLEZTqFBNbYpVXw3xG1IrtOlFdpI4ziyu8yLB6nks7dbKa7IAc4pR70WDaZjS6yvdta0yAp+argBBrCCZ5981vlaozGjWdahJzuh9SijiRcDe+51AnOEHwLWoDJ6wy+rtyasDEhKRNg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1yoGKMje; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBi2s0029650;
	Tue, 27 Feb 2024 18:44:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=jTtuR9h+G7uKqcRPnsVn7E2jeHnidr9oglBzqkI2a+U=; b=1y
	oGKMjeYvQjnK1+hUSuaiK0UBujfXx++pour4YAnDdLL46F0nOa+bV3MvljzLkF75
	aKl5JdLHn/hkoxcay9PA/SHFQQVoFG3WEAuNZMk1Qiig2SYkTH2j/8pdI4wT+B+C
	dzn2eKcpujpqjvteWr9aM2fSJAiaWNkW4jS8v2dnI0gsGIwx5HUDvCV/03VwJlj5
	tRAGw4nt8Xj2p/OUFtVc/mbTpsA0kRWxYp7vnZiLIjAL5YFKWf9Q2IxnrrIu87sq
	8rsUuq3pzZusu6OwHOHCOOjEKp31ggt4oVM7ACQ0e8cz5bkMpoyZJYujfQ5jjO+W
	fTyMUduEb5bZnKdsYyWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4b9dp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:44:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EED2440045;
	Tue, 27 Feb 2024 18:44:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A2F4D2ADF49;
	Tue, 27 Feb 2024 18:43:38 +0100 (CET)
Received: from [10.252.26.109] (10.252.26.109) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:43:35 +0100
Message-ID: <599a7357-b4d6-4581-9d5c-c1d0ade3e410@foss.st.com>
Date: Tue, 27 Feb 2024 18:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] counter: stm32-timer-cnt: introduce clock signal
Content-Language: en-US
To: William Breathitt Gray <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-5-fabrice.gasnier@foss.st.com>
 <ZZwm7ZyrL7vFn0Xd@ubuntu-server-vm-macos>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZZwm7ZyrL7vFn0Xd@ubuntu-server-vm-macos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02

On 1/8/24 17:46, William Breathitt Gray wrote:
> On Wed, Dec 20, 2023 at 03:57:20PM +0100, Fabrice Gasnier wrote:
>> Introduce the internal clock signal, used to count when in simple rising
>> function. Also add the "frequency" extension to the clock signal.
>>
>> With this patch, signal action reports a consistent state when "increase"
>> function is used, and the counting frequency:
>>     $ echo increase > function
>>     $ grep -H "" signal*_action
>>     signal0_action:none
>>     signal1_action:none
>>     signal2_action:rising edge
>>     $ echo 1 > enable
>>     $ cat count
>>     25425
>>     $ cat count
>>     44439
>>     $ cat ../signal2/frequency
>>     208877930
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> 
> The code is all right, but some minor suggestions below.
> 
>> +static struct counter_comp stm32_count_clock_ext[] = {
>> +	COUNTER_COMP_SIGNAL_U64("frequency", stm32_count_clk_get_freq, NULL),
> 
> It might be worth introducing a new COUNTER_COMP_FREQUENCY() macro now
> that we have a second driver with the 'frequency' extension
> (ti-ecap-capture also has 'frequency'). But it's up to you if you want
> to add a precursor patch to this series, or I'll introduce it separately
> myself in a independent patch.

Thanks for suggesting.

I added a precursor patch to this series.
I guess you wishes to see it used in both ti-ecap-capture and
stm32-timer-cnt. I only cared about stm32-timer-cnt in this series.

Can I let you do ti-ecap-capture change if/when you're going to apply it?

> 
>> @@ -287,7 +321,13 @@ static struct counter_signal stm32_signals[] = {
>>  	{
>>  		.id = STM32_CH2_SIG,
>>  		.name = "Channel 2"
>> -	}
>> +	},
>> +	{
>> +		.id = STM32_CLOCK_SIG,
>> +		.name = "Clock Signal",
> 
> The word "Signal" feels unnecessary to me when both the sysfs path and
> data structure will have 'signal' already. Do you think "Clock" by
> itself is clear enough?

Agreed, I updated in v4.

Best Regards,
Fabrice

> 
> William Breathitt Gray

