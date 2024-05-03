Return-Path: <linux-kernel+bounces-167725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA78BAE15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A48B1F2301B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47096154439;
	Fri,  3 May 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNAGdOLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F478153BCE;
	Fri,  3 May 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744370; cv=none; b=JDFyPx7/Smk2+8r/sqZGaO5ZQ8UjJI/1KICg622dBr6F/Yfrqow8v4lJj/J+oBu0HCv1VXGxyM9YqN+DwkdrAfbSr5m5Y4ygFltwr84ns9yzs+L1o9YarGrUmcBtW7llnCr8n+2GCOsgVXNy0rFygYpd7S9KAE0+NKn4YVv8Tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744370; c=relaxed/simple;
	bh=/ikARJU0dNJFx1ZbYtIVaOCPwhf9eJ3Xsa4ZMvOGqcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDk2++TUadwonJ38qmkLFR0bFOMvFPQm1eD/Y4zqJnOTtaYSgWlq4tq9aakJX/P5rpkOXm5ZSkXfwksoxC6Tj11TGiWLsvh9UCyzZ5AnHRYn5tmZ8PCrOIOMebY8/W92gauEAP8Qqf9LYKnFi2nLl8hj318ugKa0vqbVjyiMCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNAGdOLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F46DC116B1;
	Fri,  3 May 2024 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714744369;
	bh=/ikARJU0dNJFx1ZbYtIVaOCPwhf9eJ3Xsa4ZMvOGqcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mNAGdOLX5oyQ5YP0lG4U7x79x6bCeNSRq6WOS/kCDdWBqe0g555viimFTlV6qnEkS
	 SrGffaB11PJ1xeB9DaLFEd/k9J+aB30ujqWYePQwl8fUaU5Ve+BlI9f9kpiL8bacWn
	 St2f3ZRk4PccwEzZw1fzI2QYq5SCgZptNo9S/AhAfO5/OpKQfUkmFULupIIt8sgXSy
	 AeiPfiromWKfpyJsmdoP8TqvTqho96uKbDWDuOh8ELWFKi6gOer9UorEfC73jXfc65
	 xYenV/YDqOHceMrt8LVom4UH4vAeX/6lACYhPcglA9tEiYPTgkiF79+cARMk/NvSpO
	 lMdMmkThkPavQ==
Message-ID: <c015b3a5-2213-4ebd-b960-d97ed1fe7062@kernel.org>
Date: Fri, 3 May 2024 16:51:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
 <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
 <Ziov6bWBXYXJ4Zp8@hu-varada-blr.qualcomm.com>
 <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
 <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Varada,

Thank you for your work on this!

On 2.05.24 12:30, Varadarajan Narayanan wrote:
> On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
>> On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
>>> On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 4/18/24 11:23, Varadarajan Narayanan wrote:
>>>>> IPQ SoCs dont involve RPM in managing NoC related clocks and
>>>>> there is no NoC scaling. Linux itself handles these clocks.
>>>>> However, these should not be exposed as just clocks and align
>>>>> with other Qualcomm SoCs that handle these clocks from a
>>>>> interconnect provider.
>>>>>
>>>>> Hence include icc provider capability to the gcc node so that
>>>>> peripherals can use the interconnect facility to enable these
>>>>> clocks.
>>>>>
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>> ---
>>>>
>>>> If this is all you do to enable interconnect (which is not the case,
>>>> as this patch only satisfies the bindings checker, the meaningful
>>>> change happens in the previous patch) and nothing explodes, this is
>>>> an apparent sign of your driver doing nothing.
>>>
>>> It appears to do nothing because, we are just enabling the clock
>>> provider to also act as interconnect provider. Only when the
>>> consumers are enabled with interconnect usage, this will create
>>> paths and turn on the relevant NOC clocks.
>>
>> No, with sync_state it actually does "something" (sets the interconnect
>> path bandwidths to zero). And *this* patch does nothing functionally,
>> it only makes the dt checker happy.
> 
> I understand.
> 
>>> This interconnect will be used by the PCIe and NSS blocks. When
>>> those patches were posted earlier, they were put on hold until
>>> interconnect driver is available.
>>>
>>> Once this patch gets in, PCIe for example will make use of icc.
>>> Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
>>>
>>> The 'pcieX' nodes will include the following entries.
>>>
>>> 	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
>>> 			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
>>> 	interconnect-names = "pcie-mem", "cpu-pcie";
>>
>> Okay. What about USB that's already enabled? And BIMC/MEMNOC?
> 
> For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
> clock. Hence, interconnect is not specified there.
> 
> MEMNOC to System NOC interfaces seem to be enabled automatically.
> Software doesn't have to turn on or program specific clocks.
> 
>>>> The expected reaction to "enabling interconnect" without defining the
>>>> required paths for your hardware would be a crash-on-sync_state, as all
>>>> unused (from Linux's POV) resources ought to be shut down.
>>>>
>>>> Because you lack sync_state, the interconnects silently retain the state
>>>> that they were left in (which is not deterministic), and that's precisely
>>>> what we want to avoid.
>>>
>>> I tried to set 'sync_state' to icc_sync_state to be invoked and
>>> didn't see any crash.
>>
>> Have you confirmed that the registers are actually written to, and with
>> correct values?
> 
> I tried the following combinations:-
> 
> 1. Top of tree linux-next + This patch set
> 
> 	* icc_sync_state called
> 	* No crash or hang observed
> 	* From /sys/kernel/debug/clk/clk_summary can see the
> 	  relevant clocks are set to the expected rates (compared
> 	  with downstream kernel)
> 
> 2. Top of tree linux-next + This patch set + PCIe enablement
> 
> 	* icc_sync_state NOT called

If sync_state() is not being called, that usually means that there
are interconnect consumers that haven't probed successfully (PCIe?)
or their dependencies. That can be checked in /sys/class/devlink/.../status
But i am not sure how this works for PCI devices however.

You can also manually force a call to sync_state by writing "1" to
the interconnect provider's /sys/devices/.../state_synced

Anyway, the question is if PCIe and NSS work without this driver?
If they work, is this because the clocks are turned on by default
or by the boot loader?

Then if an interconnect path (clock) gets disabled either when we
reach a sync_state (with no bandwidth requests) or we explicitly
call icc_set_bw() with 0 bandwidth values, i would expect that
these PCIe and NSS devices would not function anymore (it might
save some power etc) and if this is unexpected we should see a
a crash or hang...

Can you confirm this?

Thanks,
Georgi

> 	* No crash or hang observed
> 	* From /sys/kernel/debug/clk/clk_summary can see the
> 	  relevant clocks are set to the expected rates (compared
> 	  with downstream kernel)
> 
> Does this answer your question? Please let me know if you were
> looking for some other information.
> 
> Thanks
> Varada
> 


