Return-Path: <linux-kernel+bounces-156655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7848B0657
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0CE1C22CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1651591E2;
	Wed, 24 Apr 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h3Fuyci2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201301E4A9;
	Wed, 24 Apr 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952069; cv=none; b=HZ3fbOxDkr5l6a+mh1tfW1K9m4Mqdf8cZqmrOoiZ6RuE3jKTFL9xv2+V9UJNUSYjobB+2FZKmQGpoduU7nzoJVHoz+RsLt3mX0Kgeum03nizoNbCt/m0HIR6SUh1JUUGzhbG+rsPcr4gzBJ+pzcvPxhBuqPxoMTUT7RFm8d8M1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952069; c=relaxed/simple;
	bh=XKyo2IBmB9lVYumLYVApJ0zP4Y5sWVSi6028oO0q90c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lEFhVwqYtApuNkP3c+79YHhk7ea03D7MCSgH0gELvzyKXI0iFhLYMPwVJZu8wSHjT87rX0fdXRjW7xhojFe5b1Uk6E+6ywxLjztikSK204MZWbwuqRh7EjYJcj00Fl5ibUf0XHkuUFuOJ+Eu6kxle6s1hZHkfou5wHNK3cWg644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h3Fuyci2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O7QB7u003144;
	Wed, 24 Apr 2024 09:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2QyNF4232FDhRJhM30YDmBvRJB0jPkiVSxWOh2BctCc=; b=h3
	Fuyci2vUgoKclPxFspYVPs3PfaYSCXaGkfJh+GK1xIJyJxNyTlkUYROrYR1OTWxb
	1jPQaTDfPt1ofuzw5QAGzG+S5YRpfJ9YCBvvkmTP+W4EhIQUSuBHsfRIWZLBmkwf
	9KdtvtT3ZFEDerNvUHtkuFaO74OB/b3pC2hr1v0+ND8PuuRmjxOveW1LfVKP0Ya4
	TYDTlQ3eWdq0bs3O+SSyrgSd7Vxs0Zti06VictpyBGjWELCSbleHPf3IWE9pCo2f
	OFeesAVVGUR35UEIMK33A4sllEHxZ5ak2LtwpvodeU+elbA+AvyhSJhMpL0/YZqE
	f6+dBJebs6Bme6S62jFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9ggf24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:47:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9lbm0023166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:47:37 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:47:28 -0700
Message-ID: <e419c6aa-6bb2-48ff-bacb-17a2e85856ea@quicinc.com>
Date: Wed, 24 Apr 2024 15:17:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-4-quic_jkona@quicinc.com>
 <e70e0379-cab0-4586-825e-ade6775ca67c@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <e70e0379-cab0-4586-825e-ade6775ca67c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _oVRB4IQ_H0SVb6TA6SA2Y7frdz8vfIL
X-Proofpoint-GUID: _oVRB4IQ_H0SVb6TA6SA2Y7frdz8vfIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240041



On 4/24/2024 5:18 AM, Bryan O'Donoghue wrote:
> On 13/04/2024 16:20, Jagadeesh Kona wrote:
>> Some GDSC client drivers require the GDSC mode to be switched dynamically
>> to HW mode at runtime to gain the power benefits. Typically such client
>> drivers require the GDSC to be brought up in SW mode initially to enable
>> the required dependent clocks and configure the hardware to proper state.
>> Once initial hardware set up is done, they switch the GDSC to HW mode to
>> save power. At the end of usecase, they switch the GDSC back to SW mode
>> and disable the GDSC.
>>
>> Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
>> get_hwmode_dev callbacks for GDSC's whose respective client drivers
>> require the GDSC mode to be switched dynamically at runtime using
>> dev_pm_genpd_set_hwmode() API.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/clk/qcom/gdsc.c | 37 +++++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/gdsc.h |  1 +
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index df9618ab7eea..c5f6be8181d8 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -363,6 +363,39 @@ static int gdsc_disable(struct generic_pm_domain 
>> *domain)
>>       return 0;
>>   }
>> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct 
>> device *dev, bool mode)
>> +{
>> +    struct gdsc *sc = domain_to_gdsc(domain);
>> +    int ret;
>> +
>> +    ret = gdsc_hwctrl(sc, mode);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Wait for 1usec for mode transition to properly complete */
>> +    udelay(1);
> 
> A delay I suspect you don't need - if the HW spec says "takes 1 usec for 
> this to take effect" that's 1 usec from io write completion from APSS to 
> another system agent.
> 
> You poll for the state transition down below anyway.
> 
> I'd be pretty certain that's a redundant delay.
> 

Thanks Bryan for your review!

This 1usec delay is needed every time GDSC is moved in and out of HW 
control mode and the reason for same is explained in one of the older 
gdsc driver change at below link

https://lore.kernel.org/all/1484027679-18397-1-git-send-email-rnayak@codeaurora.org/ 


Thanks,
Jagadeesh

>> +
>> +    /*
>> +     * When GDSC is switched to HW mode, HW can disable the GDSC.
>> +     * When GDSC is switched back to SW mode, the GDSC will be enabled
>> +     * again, hence need to poll for GDSC to complete the power up.
>> +     */
>> +    if (!mode)
>> +        return gdsc_poll_status(sc, GDSC_ON);
>> +
>> +    return 0;
>> +}
> 
> Other than that, seems fine.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 

