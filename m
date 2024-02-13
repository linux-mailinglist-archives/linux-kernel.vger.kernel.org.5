Return-Path: <linux-kernel+bounces-63560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E45853154
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574321F2452E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226350A96;
	Tue, 13 Feb 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D/Fmq+vK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BE4CB22;
	Tue, 13 Feb 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829642; cv=none; b=GKGAdaE5ApMVsKN/lIFNSGCWXxhRUBPqS4TSc9Z7Qz8G+EqiaPNVOXBbMfNP8e7vAsDtfxZrjacEhfCINahDbtFOqC+JfQzSP4aafqIPz9anYy5bMCnFWxuYc5kwbFdBuktqifEnQu172DsWj6TTOAiKB1HQ0w3SiUmSd9bjkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829642; c=relaxed/simple;
	bh=bS6YCU50qdUP7pOA+IgMKFXC6b2zvRoa/NpZXX8x3fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MRPKaR+IXHrSfKonMNmId+XFpBfHmN7O2DBlR7JTUfg/NLw8uxRMBWUfPfVm3ptk0pEZqDBeBUbU1yq6CDbiTI1NJBgvv9VjxGCo4uLbjqL7N4KpmLpopzjjYr24cz3MZMO3s/ZwIn8QjRNQJy6B1aYQ6q2INPEDr0cvWGKsX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D/Fmq+vK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D8Em4L026735;
	Tue, 13 Feb 2024 13:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+kAkGk7nkaOH9/Fv65lof5Q3RmI7KRKfx/dcixunyJk=; b=D/
	Fmq+vK3PyNAUWUOaiUVcJVT2Tu7apumgEJyOOaHwa2LvCLyASelZQhoUmdLSy7L9
	/IBdUpchVSYYwyarDXuEI9Od8b7aO7F+FQDSueHMAz/BaKMA+SIZ33eeUYYKtRxe
	S/4F7vzcUWtSpQCrF2wCzW3dloY7Fz9rh2GoUuUCQwdMuFvynbxWT2gufxrMHz0Y
	nbFXZGE08ZXd68KlFHTmQdxs5ilgX7AEcG9tQJUF+2PidvUlmlUz4KRXAveN2uR5
	U1sNoehYB8erckBL7CkEUm3+js6eqOYYp2wwo09H1I/8P/IjKABcQS71OmfF1MlO
	5odo3D+weEBdVO/rltcg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ww5s5m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:07:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DD731Z018122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:07:03 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 05:06:56 -0800
Message-ID: <18ac6a8d-09f8-4195-b55e-353d3e80555e@quicinc.com>
Date: Tue, 13 Feb 2024 18:36:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to
 switch GDSC mode
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
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
 <20240122-gdsc-hwctrl-v4-5-9061e8a7aa07@linaro.org>
 <kxovcqes5pfo2lsdmdi4msaqjjavvnwxbjp3haymeqpsbhnm3i@43nwohjzocj3>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <kxovcqes5pfo2lsdmdi4msaqjjavvnwxbjp3haymeqpsbhnm3i@43nwohjzocj3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 59IgBWBqwjKEcKTjqlasn98vlkl6cgpp
X-Proofpoint-ORIG-GUID: 59IgBWBqwjKEcKTjqlasn98vlkl6cgpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130104



On 1/31/2024 6:35 AM, Bjorn Andersson wrote:
> On Mon, Jan 22, 2024 at 10:47:05AM +0200, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> Use dev_pm_genpd_set_hwmode API to switch the vcodec gdsc to SW/HW
>> modes at runtime based on requirement for venus V6 variants.
>>
>> Before the GDSC HWCTL was available to the consumer, the venus driver
>> needed to somehow keep the power from collapsing while under the driver
>> control. The only way to do that was to clear the CORE_PWR_DISABLE bit
>> (in wrapper POWER_CONTROL register) and, respectively, set it back after
>> the driver control was completed. Now, that there is a way to switch the
>> GDSC HW/SW control back and forth, the CORE_PWR_DISABLE toggling in
>> vcodec_control_v4() can be dropped for V6 variants.
>>
> 
> The purpose of this commit is to warrant the need of this new mechanism,
> but I don't find that it actually describes a problem to be solved.
> 
>> With newer implementation, the mode of vcodec gdsc gets switched only in
> 
> Does "With newer implementation" mean "after these patches are applied"?
> 

Thanks Bjorn for your review!

Yes, after all these patches are applied, will update the commit text to 
be bit more precise.

>> set_hwmode API and the GDSC should not be switched to HW control mode
>> before turning off the GDSC, else subsequent GDSC enable may fail, hence
>> add check to avoid switching the GDSC to HW mode before powering off the
>> GDSC on V6 variants.
>>
> 
> Is this saying that "if we return the GDSC to HW control after turning
> off the clocks, it might not be possible to turn it on again"?
> 

Yes, if the GDSC is left in HW control mode before GDSC disable, the 
subsequent GDSC enable callback may fail while polling for GDSC status, 
since HW can keep the GDSC in disabled state.


> How come? Today this GDSC is operating in HW control mode, before,
> during and after the clock operation.
> 

Currently once GDSC is moved to HW control mode, Venus driver is using 
it's POWER_CONTROL register to keep the GDSC ON before the clock 
operations and reset it back after clock operations to handover control 
back to HW.

And these venus POWER_CONTROL register addresses are not constant and 
vary from one venus variant to other. With this new API Venus driver can 
avoid these register writes and use this standard API everywhere to 
switch the GDSC mode as required.

>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index a1b127caa90a..55e8ec3f4ee9 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -412,10 +412,9 @@ static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
>>   	u32 val;
>>   	int ret;
>>   
>> -	if (IS_V6(core)) {
>> -		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
>> -		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
>> -	} else if (coreid == VIDC_CORE_ID_1) {
>> +	if (IS_V6(core))
>> +		return dev_pm_genpd_set_hwmode(core->pmdomains[coreid], !enable);
>> +	else if (coreid == VIDC_CORE_ID_1) {
>>   		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
>>   		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
>>   	} else {
>> @@ -451,9 +450,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
>>   
>>   		vcodec_clks_disable(core, core->vcodec0_clks);
>>   
>> -		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
>> -		if (ret)
>> -			return ret;
>> +		if (!IS_V6(core)) {
>> +			ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
> 
> First I had this expectation that the GDSC will always be in SW control
> when the GDSC turns on - like the downstream implementation.
> 
> In this case I felt we should have a similar condition in
> poweron_coreid() - as there's no point in switching to SW mode when we
> know we're in SW mode already.
> 
> 
> But as I finally realized that this is not the case, I now see that by
> skipping the transition to HW mode here, dev_pm_genpd_set_hwmode() will
> find the domain in SW mode, and through
> 
>    if (dev_gpd_data(dev)->hw_mode == enable)
> 
> Will turn the vcodec_control_v4(, true) into a nop.
> 
> So, my first first instinct of feeling that this should be symmetric
> between poweron/poweroff was reasonable...I think...
> 

Yes, we can add similar check in poweron_coreid() also to be symmetric 
but since it will be nop haven't added it. Shall I add similar check in 
poweron_coreid() as well?

> 
> I find that this interface does not match the expectations that people
> will bring from downstream and this example isn't helpful in explaining
> how to use the new interface.
> 

There are 3 consumers that currently use this HW control mode for 
GDSC's:- display, camera and display.

Display driver is able to operate with GDSC always in HW mode. Camera 
drivers don't have power saving features enabled on upstream yet and 
hence not using the HW control mode of GDSC's currently, but will need 
this API support to enable camera power saving features on upstream.

Currently on upstream, only venus driver requires GDSC HW and SW modes 
switching, and hence added support in this driver to use the new interface.


> PS. I trust there's no case whre legacy_binding = true, or that that
> code path does not need similar workaround?
> 
This change is applicable only to sc7280 and sm8250 targets for which 
legacy_binding will be false.

Thanks,
Jagadeesh

> Regards,
> Bjorn
> 
>> +			if (ret)
>> +				return ret;
>> +		}
>>   
>>   		ret = pm_runtime_put_sync(core->pmdomains[1]);
>>   		if (ret < 0)
>> @@ -467,9 +468,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
>>   
>>   		vcodec_clks_disable(core, core->vcodec1_clks);
>>   
>> -		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
>> -		if (ret)
>> -			return ret;
>> +		if (!IS_V6(core)) {
>> +			ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
>> +			if (ret)
>> +				return ret;
>> +		}
>>   
>>   		ret = pm_runtime_put_sync(core->pmdomains[2]);
>>   		if (ret < 0)
>>
>> -- 
>> 2.34.1
>>

