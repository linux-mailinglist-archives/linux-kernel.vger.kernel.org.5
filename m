Return-Path: <linux-kernel+bounces-64730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2185420D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932C11C255FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E87C2D0;
	Wed, 14 Feb 2024 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bM5FP0xN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE2BA38;
	Wed, 14 Feb 2024 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707884989; cv=none; b=nOXY4GdYhdWJVOUmIIb0pyysCspPIwvKlaEuqXVwb+Di505rV5JHZ1QnpHDT1NYlE2Vwz5aSGqbCym6yKiVkjug0xizqacxzaotfJYyG44ATQLNh6ZD8ZdOW9VXsxpTcMVnazKou6utrJmqvyHn0vEyfo7W+jVmrvpKlaC77ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707884989; c=relaxed/simple;
	bh=soNF9FVM5OrcEyfvV//2qdMFKYHZZo58NagGsnNR5MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LM0pnXh0VMTL6Vvf+v5ngaUvuf6lCyNTvd+j7VqZpXw55SDfwyi4eMUJGiuJRmGnOw7NK4DHkqSAU9SOo58Dhz+gwxOOecL6YaXJpK2MujHCXbyy38caspQo26fxkjgilKoNWD4P/fud6jghmrXAT++g/pX6dD4gfkfySNuur+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bM5FP0xN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E40DsC014695;
	Wed, 14 Feb 2024 04:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=E5rxHYHkB0OjFcatv+zmGPh1ez6bAKXIDbqU3Ulp4h0=; b=bM
	5FP0xNVbs3/IcLl3ivU6BpGneoeQ8za+9/QBG3p37KKG22nYE6OGaLaWdx04sRzs
	uPulD2S9cqDC33ShH0VpgqFZUkZtuo0TICiL0tYBCR5HaenLokDjuPl7PRLs16oI
	WRzgH9BZnHpEUGoyuF1W4b0Zv+uRE3LJqPRtzyRfOSnvAd1FiNnaJxDSzS6pTovm
	o/DDMZ1Rkdd5Rjnek9Luhcn0crb3kVWhEUXVmOnBo3k9pnvkA3uS6Ryl3UgY9aJ1
	vTXQvKrNqHYZtRsDl8vsvS6rrx473cRr0y5kgGSubbL4Vm+j/2mnpuP95g8gJqTi
	I7NhQhbw8ktfgBvSNTJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8jrj8ahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 04:29:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E4TN2n002441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 04:29:23 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 20:29:16 -0800
Message-ID: <a1c2641f-80c0-4e6e-9c44-ef7209da97a5@quicinc.com>
Date: Wed, 14 Feb 2024 09:59:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-media@vger.kernel.org>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
 <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
 <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com>
 <l7icfezpajren25545n4cjtqehhividt5b2dxnxgetdsshc3k3@tdws423qdblk>
 <CAPDyKFp1vg2+-pHJ_idkdhb_zZUMpq7W17DnCCGj0eTwd4jFbQ@mail.gmail.com>
 <87b7967f-d8c4-426e-92ed-5a418c702481@quicinc.com>
 <CAPDyKFqy0osJRTU1mL0Ew_3pnYOe5z20ZWNrew8B6t99UFO0pg@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAPDyKFqy0osJRTU1mL0Ew_3pnYOe5z20ZWNrew8B6t99UFO0pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3WKGYU3flknvPdKbxmR4CBffYFs3Jo6N
X-Proofpoint-ORIG-GUID: 3WKGYU3flknvPdKbxmR4CBffYFs3Jo6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402140031



On 2/13/2024 7:21 PM, Ulf Hansson wrote:
> On Tue, 13 Feb 2024 at 14:10, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 2/2/2024 5:59 PM, Ulf Hansson wrote:
>>> On Fri, 2 Feb 2024 at 00:51, Bjorn Andersson <andersson@kernel.org> wrote:
>>>>
>>>> On Wed, Jan 31, 2024 at 01:12:00PM +0100, Ulf Hansson wrote:
>>>>> On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
>>>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>>
>>>>>>> Some power-domains may be capable of relying on the HW to control the power
>>>>>>> for a device that's hooked up to it. Typically, for these kinds of
>>>>>>> configurations the consumer driver should be able to change the behavior of
>>>>>>> power domain at runtime, control the power domain in SW mode for certain
>>>>>>> configurations and handover the control to HW mode for other usecases.
>>>>>>>
>>>>>>> To allow a consumer driver to change the behaviour of the PM domain for its
>>>>>>> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
>>>>>>> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
>>>>>>> which the genpd provider should implement if it can support switching
>>>>>>> between HW controlled mode and SW controlled mode. Similarly, add the
>>>>>>> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
>>>>>>> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
>>>>>>> genpd provider can also implement for reading back the mode from the
>>>>>>> hardware.
>>>>>>>
>>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>> ---
>>>>>>>    drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>    include/linux/pm_domain.h | 17 ++++++++++++
>>>>>>>    2 files changed, 86 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>>>>>>> index a1f6cba3ae6c..41b6411d0ef5 100644
>>>>>>> --- a/drivers/pmdomain/core.c
>>>>>>> +++ b/drivers/pmdomain/core.c
>>>>>>> @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
>>>>>>>    }
>>>>>>>    EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
>>>>>>>
>>>>>>> +/**
>>>>>>> + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
>>>>>>
>>>>>> This isn't proper kernel-doc
>>>>>
>>>>> Sorry, I didn't quite get that. What is wrong?
>>>>>
>>>>
>>>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>>>> says that there should be () after the function name, and below there
>>>> should be a Return:
>>>
>>> Thanks for the pointers!
>>>
>>>>
>>>>>>
>>>>>>> + *
>>>>>>> + * @dev: Device for which the HW-mode should be changed.
>>>>>>> + * @enable: Value to set or unset the HW-mode.
>>>>>>> + *
>>>>>>> + * Some PM domains can rely on HW signals to control the power for a device. To
>>>>>>> + * allow a consumer driver to switch the behaviour for its device in runtime,
>>>>>>> + * which may be beneficial from a latency or energy point of view, this function
>>>>>>> + * may be called.
>>>>>>> + *
>>>>>>> + * It is assumed that the users guarantee that the genpd wouldn't be detached
>>>>>>> + * while this routine is getting called.
>>>>>>> + *
>>>>>>> + * Returns 0 on success and negative error values on failures.
>>>>>>> + */
>>>>>>> +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
>>>>>>> +{
>>>>>>> +     struct generic_pm_domain *genpd;
>>>>>>> +     int ret = 0;
>>>>>>> +
>>>>>>> +     genpd = dev_to_genpd_safe(dev);
>>>>>>> +     if (!genpd)
>>>>>>> +             return -ENODEV;
>>>>>>> +
>>>>>>> +     if (!genpd->set_hwmode_dev)
>>>>>>> +             return -EOPNOTSUPP;
>>>>>>> +
>>>>>>> +     genpd_lock(genpd);
>>>>>>> +
>>>>>>> +     if (dev_gpd_data(dev)->hw_mode == enable)
>>>>>>
>>>>>> Between this and the gdsc patch, the hw_mode state might not match the
>>>>>> hardware state at boot.
>>>>>>
>>>>>> With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
>>>>>> false) will not bring control to SW - which might be fatal.
>>>>>
>>>>> Right, good point.
>>>>>
>>>>> I think we have two ways to deal with this:
>>>>> 1) If the provider is supporting ->get_hwmode_dev(), we can let
>>>>> genpd_add_device() invoke it to synchronize the state.
>>>>
>>>> I'd suggest that we skip the optimization for now and just let the
>>>> update hit the driver on each call.
>>>
>>> Okay.
>>>
>>>>
>>>>> 2) If the provider doesn't support ->get_hwmode_dev() we need to call
>>>>> ->set_hwmode_dev() to allow an initial state to be set.
>>>>>
>>>>> The question is then, if we need to allow ->get_hwmode_dev() to be
>>>>> optional, if the ->set_hwmode_dev() is supported - or if we can
>>>>> require it. What's your thoughts around this?
>>>>>
>>>>
>>>> Iiuc this resource can be shared between multiple clients, and we're
>>>> in either case returning the shared state. That would mean a client
>>>> acting upon the returned value, is subject to races.
>>>
>>> Not sure I understand this, but I also don't have in-depth knowledge
>>> of how the HW works.
>>>
>>> Isn't the HW mode set on a per device basis?
>>>
>>>>
>>>> I'm therefore inclined to say that we shouldn't have a getter, other
>>>> than for debugging purposes, in which case reading the HW-state or
>>>> failing would be reasonable outcomes.
>>>
>>> If you only want this for debug purposes, it seems better to keep it
>>> closer to the rpmh code, rather than adding generic callbacks to the
>>> genpd interface.
>>>
>>> So to conclude, you think having a ->set_hwmode_dev() callback should
>>> be sufficient and no caching of the current state?
>>>
>>> Abel, what's your thoughts around this?
>>>
>>
>> We believe it is good to have get_hwmode_dev() callback supported from
>> GenPD, since if multiple devices share a GenPD, and if one device moves
>> the GenPD to HW mode, the other device won't be aware of it and second
>> device's dev_gpd_data(dev)->hw_mode will still be false.
>>
>> If we have this dev_pm_genpd_get_hwmode() API supported and if we assign
>> dev_gpd_data(dev)->hw_mode after getting the mode from get_hwmode_dev()
>> callback, consumer drivers can use this API to sync the actual HW mode
>> of the GenPD.
> 
> Hmm, I thought the HW mode was being set on a per device basis, via
> its PM domain. Did I get that wrong?
> 
> Are you saying there could be multiple devices sharing the same PM
> domain and thus also sharing the same HW mode? In that case, it sure
> sounds like we have synchronization issues to deal with too.
> 

Sorry my bad, currently we don't have usecase where multiple devices 
sharing the same PM domain that have HW control support, so there is no 
synchronization issue.

But it would be good to have .get_hwmode_dev() callback for consumer 
drivers to query the actual GenPD mode from HW, whenever they require it.

Thanks,
Jagadeesh


