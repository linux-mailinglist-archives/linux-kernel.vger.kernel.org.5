Return-Path: <linux-kernel+bounces-63558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F0853144
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A3C1F2826C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53D4F5FA;
	Tue, 13 Feb 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b2qooR8G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12B3D99E;
	Tue, 13 Feb 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829522; cv=none; b=TS19QZKbXP2Kqn0F7VA00wG9V+N+H/kUYc6oszQ0YS6NfeHqontd/XByaHd82KX8GOGR6mSVx1SOFfLAmDy/f1YEOjCSitLc2DGSHhvVkrCJkt52KysQoAMLZInHDyx/wvg2CWQrPMdJIrtlZtncXjLDPcw3PzRVectBEyEIrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829522; c=relaxed/simple;
	bh=viMQpHUA0wyuSc0aYpDZXv2P8TIrUTd/nzpVXcOfqVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UgDb+kfIw7/ePcCwBsx2O1A/vjKwqHcKAvOvda3V+vDLuvCImGfddacRvuLweu0jbvbER0PKWw9/ky1ZcUXhfJYYJGz/lEtcp0FHz6LT0tjRPGalq0MmVey5HvbWiRPmQ/FfGsXrv+fns3ZYZTicTecNzXD5jWzldBXunHu2FIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b2qooR8G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DD0ZYg027948;
	Tue, 13 Feb 2024 13:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6mOL9PsbxyCYLHe4WBDlAcPGHq/NUHZ80ySMAvSLfSg=; b=b2
	qooR8GAI+7AxuDb10TLdHXzIlOG6UKGINlldMpmpp6fY/z2M8ewhk5OFsOLQL/oO
	VVDTxkhaOyFdrlJENeYAL98+HdWSF2hnt6iL84WlRSRLngTPXwRPLTs0mouVP3qr
	SoPQVQR0eXGnGe7NXoR3nq7mmIJA4G4XphOQcqMBjpsnHYhNe0QKLhTYBowMFiR/
	TT+IKhlf+fRBA2bpUE23sjmA7JamjQs0zuu0bwsBjq49IIbHIwV6l0QDbNEfE4Vs
	lHPasbwKSh+Eq+zW80UfuMtxjzcEQMFnRWBEMACTMslbkLeZ/2N7XNCjogChYZ+U
	PV2MRo3Ski8TPdRqUuTw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gse2ydp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:05:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DD554N000608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:05:05 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 05:04:58 -0800
Message-ID: <35907177-eecd-4b58-a5da-7186b0f60193@quicinc.com>
Date: Tue, 13 Feb 2024 18:34:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
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
 <20240122-gdsc-hwctrl-v4-3-9061e8a7aa07@linaro.org>
 <qbqsvxmnl2tuansxzr6u4vqxemw4dzrsvz2ill6qnyxdp5gtji@lsemt4asmsax>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <qbqsvxmnl2tuansxzr6u4vqxemw4dzrsvz2ill6qnyxdp5gtji@lsemt4asmsax>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rNU6xjxKFa-tBEBWMTsCjmh3A4wydkXb
X-Proofpoint-ORIG-GUID: rNU6xjxKFa-tBEBWMTsCjmh3A4wydkXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130104



On 1/31/2024 4:30 AM, Bjorn Andersson wrote:
> On Mon, Jan 22, 2024 at 10:47:03AM +0200, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> Add support for set and get hwmode callbacks to switch the GDSC between
>> SW and HW modes. Currently, the GDSC is moved to HW control mode
>> using HW_CTRL flag and if this flag is present, GDSC is moved to HW
>> mode as part of GDSC enable itself. The intention is to keep the
>> HW_CTRL flag functionality as is, since many older chipsets still use
>> this flag.
>>
> 
> This provides insight into why we end up with both HW_CTRL and
> HW_CTRL_TRIGGER. This doesn't describe why this change is needed, but
> rather just an implementation detail.
> 
>> But consumer drivers also require the GDSC mode to be switched dynamically
>> at runtime based on requirement for certain usecases. Some of these
>> usecases are switching the GDSC to SW mode to keep it ON during the
>> enablement of clocks that are dependent on GDSC and while programming
>> certain configurations that require GDSC to be ON. Introduce a new
>> HW_CTRL_TRIGGER flag to register the set_hwmode_dev and get_hwmode_dev
>> callbacks which allows the consumer drivers to switch the GDSC back and
>> forth between HW/SW modes dynamically at runtime using new
>> dev_pm_genpd_set_hwmode API.
>>
> 
> This still expresses the need for HW_CTRL_TRIGGER in terms of "some
> drivers need for some use case". We don't need these many words to say:
> "Introduce HW_CTRL_TRIGGER for client drivers that need it."
> 

Thanks Bjorn for your review.

Sure will update the commit text to be more precise in next series.

> 
> I find that it would be useful to document that every time a GDSC is
> turned on the mode will be switched to SW...
> 
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/clk/qcom/gdsc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/gdsc.h |  1 +
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index 5358e28122ab..71626eb20101 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -363,6 +363,56 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>>   	return 0;
>>   }
>>   
>> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
>> +{
>> +	struct gdsc *sc = domain_to_gdsc(domain);
>> +	u32 val;
>> +	int ret;
>> +
>> +	if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
> 
> Why is this a restriction only for GDSCs supplied by regulators? I don't
> find anything preventing this API from being called on GDSCs supplied by
> other genpd instances.

> 
> Also note that regulator_is_enabled() is racy, in that it tells us if
> the regulator is currently turned on, not if we're the one holding that
> vote. As such this might change at any moment - and hence shouldn't be
> significant here.
>
Below is the consumer's sequence that switch the GDSC's b/w HW & SW modes:-
1) Enable the GDSC in SW mode
2) Enable required clocks
3) Switch the GDSC to HW mode using dev_pm_genpd_set_hwmode(true)
4) Usecase start
5) Usecase end
6) Switch the GDSC back to SW mode using dev_pm_genpd_set_hwmode(false)
7) Disable clocks
8) Disable GDSC

Hence the new API dev_pm_genpd_set_hwmode() will always be called 
between gdsc_enable() and gdsc_disable(), which ensures GDSC's parent 
power domain/regulator is ON when this callback is being called. Also, 
we can remove the above regulator_is_enabled() check as well.

>> +		pr_err("Cannot set mode while parent is disabled\n");
>> +		return -EIO;
>> +	}
>> +
>> +	ret = gdsc_hwctrl(sc, mode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for 1usec for mode transition to properly complete */
>> +	udelay(1);
>> +
>> +	if (!mode) {
>> +		ret = regmap_read(sc->regmap, sc->gdscr, &val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/*
>> +		 * While switching from HW to SW mode, if GDSC is in enabled
>> +		 * state, poll for GDSC to complete the power up.
>> +		 */
> 
> I had to give this some thought, to conclude that this is relevant if HW
> has the GDSC disabled and we're switching to SW - which would then
> enable it. I think this comment can be improved slightly, to save the
> reader the need for figuring out this on their own.
> 

Sure, I will improvise the comment in next series.

>> +		if (!(val & SW_COLLAPSE_MASK))
> 
> This not being true, would imply that gdsc_disable() has been called
> already, in which case there's no guarantee that the parent still
> supplies power.
> 
> In the introduced API power on and hw control are orthogonal states, but
> not so in this implementation. This need to made clear, to reduce future
> surprises.
> 

Yes, above SW_COLLAPSE_MASK check is also not required and will remove 
it in next series.

>> +			return gdsc_poll_status(sc, GDSC_ON);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
>> +{
>> +	struct gdsc *sc = domain_to_gdsc(domain);
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(sc->regmap, sc->gdscr, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val & HW_CONTROL_MASK)
>> +		return true;
>> +
>> +	return false;
> 
> return !!(val & HW_CONTROL_MASK);
> 

Sure, will update this in the next series.

> Regards,
> Bjorn
> 
>> +}
>> +
>>   static int gdsc_init(struct gdsc *sc)
>>   {
>>   	u32 mask, val;
>> @@ -451,6 +501,10 @@ static int gdsc_init(struct gdsc *sc)
>>   		sc->pd.power_off = gdsc_disable;
>>   	if (!sc->pd.power_on)
>>   		sc->pd.power_on = gdsc_enable;
>> +	if (sc->flags & HW_CTRL_TRIGGER) {
>> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
>> +		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
>> +	}
>>   
>>   	ret = pm_genpd_init(&sc->pd, NULL, !on);
>>   	if (ret)
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index 803512688336..1e2779b823d1 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -67,6 +67,7 @@ struct gdsc {
>>   #define ALWAYS_ON	BIT(6)
>>   #define RETAIN_FF_ENABLE	BIT(7)
>>   #define NO_RET_PERIPH	BIT(8)
>> +#define HW_CTRL_TRIGGER	BIT(9)
>>   	struct reset_controller_dev	*rcdev;
>>   	unsigned int			*resets;
>>   	unsigned int			reset_count;
>>
>> -- 
>> 2.34.1
>>
> 

