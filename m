Return-Path: <linux-kernel+bounces-19802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268382746F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC92288F23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F051C4E;
	Mon,  8 Jan 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K18NBLOx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962B4C624
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FC7C433C8;
	Mon,  8 Jan 2024 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704728831;
	bh=xZf7HgTSs0TPw8seFOnVxgkf8gzG6qnO13LphD2q7S4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K18NBLOxChr5hnf0k38Eqiq+WqD2GcgfXKLex2WUmtkRL7ROuAQmKQfH64itmqkME
	 ZMqO5yACFXi6y0WFhhJzfa/+A+tEWmuk0rF4fmihdnMmyuy9bpQA266WoaOMsTAL8W
	 zbpln2sSIz/tDiqFLAQIlQKyiotrjtw1mlzJwKbkaE/mBCjBsECQ47jmJ2ASsz0mJa
	 2rq2Nnqzia4ZNKtIG724/6+ws5hF7Y3qTCbgNWbaSIcagoYWgnSFSy8pWI4g0EHjVJ
	 5EhtNKk7Q0HB35GLRdd8WCm9K5xKkWKjusfhe3SDhcCum8qukzTCizFOvYDsH4qO2V
	 joBnAr41XSATw==
Message-ID: <5499a078-a4de-47fb-ad2c-aa478699eb77@kernel.org>
Date: Mon, 8 Jan 2024 16:47:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() on qcom
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
 <20231227-topic-psci_fw_sus-v1-2-6910add70bf3@linaro.org>
 <20231228102801.fzaubcjq5thfwgxg@bogus>
 <f34dd5de-9e56-4c58-b9bf-2356b41d17b1@linaro.org>
 <20231228115053.zlypgc5uxxvghi4a@bogus>
 <376d3040-b9ed-4574-90d7-fb864d694e3c@linaro.org>
 <20231228124348.mmtceqeuean7ly6y@bogus>
 <7e31d489-de96-42f0-a72a-a581859e7131@linaro.org>
 <20240103094442.mlh2pf3odof3ze3s@bogus>
From: Konrad Dybcio <konradybcio@kernel.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240103094442.mlh2pf3odof3ze3s@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.01.2024 10:44, Sudeep Holla wrote:
> On Tue, Jan 02, 2024 at 07:17:50PM +0100, Konrad Dybcio wrote:
>> On 28.12.2023 13:43, Sudeep Holla wrote:
>>> On Thu, Dec 28, 2023 at 01:16:28PM +0100, Konrad Dybcio wrote:
>>>> On 28.12.2023 12:50, Sudeep Holla wrote:
>>>>> On Thu, Dec 28, 2023 at 12:47:51PM +0100, Konrad Dybcio wrote:
>>>>>> On 28.12.2023 11:28, Sudeep Holla wrote:
>>>>>>> On Wed, Dec 27, 2023 at 11:15:31PM +0100, Konrad Dybcio wrote:
>>>>>>>> Most Qualcomm platforms implementing PSCI (ab)use CPU_SUSPEND for
>>>>>>>> entering various stages of suspend, across the SoC. These range from a
>>>>>>>> simple WFI to a full-fledged power collapse of the entire chip
>>>>>>>> (mostly, anyway).
>>>>>>>>
>>>>>>>> Some device drivers are curious to know whether "the firmware" (which is
>>>>>>>> often assumed to be ACPI) takes care of suspending or resuming the
>>>>>>>> platform. Set the flag that reports this behavior on the aforementioned
>>>>>>>> chips.
>>>>>>>>
>>>>>>>> Some newer Qualcomm chips ship with firmware that actually advertises
>>>>>>>> PSCI SYSTEM_SUSPEND, so the compatible list should only grow slightly.
>>>>>>>>
>>>>>>>
>>>>>>> NACK, just use suspend-to-idle if SYSTEM_SUSPEND is not advertised. It is
>>>>>>> designed for such platforms especially on x86/ACPI which don't advertise
>>>>>>> Sx states. I see no reason why that doesn't work on ARM platforms as well.
>>>>>>
>>>>>> Not sure if I got the message through well, but the bottom line is, on
>>>>>> Qualcomm platforms the "idle" states aren't actually just "idle" (read:
>>>>>> they're not like S0ix). All but the most shallow ones shut down quite a
>>>>>> chunk of the entire SoC, with the lowest ones being essentially S3 with
>>>>>> power being cut off from the entire chip, except for the memory rail.
>>>>>>
>>>>>
>>>>> No I understood that and S2I is exactly what you need.
>>>>> Have you checked if S2I already works as intended on these platforms ?
>>>> Yes, simple CPU idling works OOTB and the SoC power collapse only works
>>>> given the developer doesn't cut corners when bringing up the platform
>>>> (read: works on some of the ones we support, trying hard to expand that
>>>> group!)
>>>>
>>>>> What extra do you achieve with this hack by advertising fake S2R ?
>>>> Uh.. unless I misunderstood something, I'm not advertising s2ram..
>>>> Quite the opposite, I'm making sure only s2idle is allowed.
>>>>
>>>
>>> Right, I didn't notice that in suspend_valid_all(), it can be rename
>>> suspend_valid_s2i or something. "All" indicates all state is valid.
>>>
>>> Anyways that is not the main point. IIUC S2I must still work if there is
>>> at-least one CPU idle state other than WFI without these changes. Right ?
>>
>> Yes, and it does
>>
> 
> Thanks for the confirmation.
> 
>>>
>>> If all these changes is to support S2I wih WFI only, then we can look at
>>> some generic solution as there were previous attempts to do something
>>> similar on other platforms IIRC.
>>
>> No, I'm just interested in setting the resume/suspend_via_firmware()
>> markers and the PSCI driver seems like a good place for it, be it on
> 
> Agreed and your PATCH 1/2 does that exactly and hence I have acked it
> already.
> 
>> all platforms with SYSTEM_SUSPEND and Qualcomm which sneaked equivalent
>> functionality into the CPU_SUSPEND call.
>>
> 
> But I don't like the Qualcomm specific changes.

Is that because of the matching table, or due to the slightly more
convoluted way of suspending the platform through CPU_SUSPEND?

If the former, I can think of other solutions. If the latter, I'm
open to keep convincing you :D There are probably things I skipped
over when explaining how it's wired up..

Konrad

