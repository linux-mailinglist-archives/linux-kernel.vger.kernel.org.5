Return-Path: <linux-kernel+bounces-156654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03E8B0652
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8991F2567E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11713158DDE;
	Wed, 24 Apr 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OncNtkAG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02515884A;
	Wed, 24 Apr 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951982; cv=none; b=GZO0qcBXR7//jK0WJS45g8rA8k9U8tWxYtc6KQPjAVnY59TVP5IBkcvs6mj2nEhV+/cX3dUy+Y6PO6W0j/I6xejaMACQ3esFYwfuEFOK27fKaklWtwMv/nkmm8zBs0KrppHxTliUajqqFFlB5W2bEmxXrvRgD35VttIDug+4e9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951982; c=relaxed/simple;
	bh=RVYaFBXBPDQnthdzqRIG0iBp4XMdZ4Os/iRRg38QOI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RVbQeCAmk11dgerE0HjwP3mKyIF5V9DNpNp7FU58371gH0Qu3JQUyo9Hn8KtahM16ZIQBzcnzj3sVgrc4f0vv76YdJKMNsqWgxM+Jnu/0Fli8fPktF5aWEg9+mQVhnoGbszFwM8V6unqZuUYKCDb0hGhh+FpjngOCya6riB9uqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OncNtkAG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6ZRbt008358;
	Wed, 24 Apr 2024 09:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ENSpFwfSSCRhBncfpf2kpAaKcLVVIBb71rBSrFRLfjg=; b=On
	cNtkAGGP3Rb0inVjZx0nnXnG6rHIhuPI1hQwR6CtHN2yzmabCx9r9S6BG54naurT
	1FSZpuVYdbUoq0ptmx5YueljWpTHJKVNbl762WfAhJFj2wGY2KHNTkhdTBo4YUL1
	Y324yCW7xqI/JNfmx48ViNpFp2tfHDVuz+E1Vq4vpiO2MKk1Mq49QEzKjBjx3Zlx
	3cr6iozy98qbyDiA+6BHlrdizHsVKfoenzUPCjErLC99x4eYmKrrIVwcyQL2E140
	edWrdpgX2nBoYxMDXkD0FSHjN7K/gAr59/QaxW52MNUIjF8yy8F0tczfFDwGV5RK
	jjriJdUNI7kFT33JfeTA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fgep4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:46:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9k8Be018171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:46:08 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:45:59 -0700
Message-ID: <dbd1b86c-7b5f-4b92-ab1f-fecfe1486cfc@quicinc.com>
Date: Wed, 24 Apr 2024 15:15:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
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
 <20240413152013.22307-6-quic_jkona@quicinc.com>
 <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
 <b96ef82c-4033-43e0-9c1e-347ffb500751@quicinc.com>
 <a522f25f-bb38-4ae1-8f13-8e56934e5ef5@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <a522f25f-bb38-4ae1-8f13-8e56934e5ef5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iutdcThsPua_kmWE2xsdKobXhPj7NIS1
X-Proofpoint-GUID: iutdcThsPua_kmWE2xsdKobXhPj7NIS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240041



On 4/24/2024 5:46 AM, Bryan O'Donoghue wrote:
> On 14/04/2024 15:52, Jagadeesh Kona wrote:
>>
>>
>> On 4/14/2024 6:09 PM, Bryan O'Donoghue wrote:
>>> On 13/04/2024 16:20, Jagadeesh Kona wrote:
>>>> The Venus driver requires vcodec GDSC to be ON in SW mode for clock
>>>> operations and move it back to HW mode to gain power benefits. Earlier,
>>>> as there is no interface to switch the GDSC mode from GenPD framework,
>>>> the GDSC is moved to HW control mode as part of GDSC enable callback 
>>>> and
>>>> venus driver is writing to its POWER_CONTROL register to keep the 
>>>> GDSC ON
>>>> from SW whereever required. But the POWER_CONTROL register addresses
>>>> are not constant and can vary across the variants.
>>>>
>>>> Also as per the HW recommendation, the GDSC mode switching needs to be
>>>> controlled from respective GDSC register and this is a uniform approach
>>>> across all the targets. Hence use dev_pm_genpd_set_hwmode() API which
>>>> controls GDSC mode switching using its respective GDSC register.
>>>>
>>>> In venus V6 variants, the vcodec gdsc gets enabled in SW mode by 
>>>> default
>>>> with new HW_CTRL_TRIGGER flag and there is no need to switch it to SW
>>>> mode again after enable, hence add check to avoid switching gdsc to 
>>>> SW mode
>>>> again after gdsc enable. Similarly add check to avoid switching GDSC 
>>>> to HW
>>>> mode before disabling the GDSC, so GDSC gets enabled in SW mode in 
>>>> the next
>>>> enable.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>> ---
>>>
>>> When I tested this out on sm8250 a few months ago it was broken.
>>>
>>> I don't quite see in your commit logs, how the breakage was addressed.
>>>
>>> Can you provide some details ?
>>>
>>
>> Thanks Bryan for your review!
>>
>> In earlier series, venus driver is switching the vcodec GDSC to HW 
>> control mode before disabling the GDSC by invoking 
>> vcodec_control_v4(..., false) in poweroff_coreid(). Due to this, the 
>> subsequent GDSC enable from venus driver is failing while polling for 
>> GDSC power ON status, since GDSC is under HW control mode and HW can 
>> keep the GDSC in disabled state.
>>
>> Now a check is added in poweroff_coreid() to avoid switching the GDSC 
>> to HW control mode before disabling the GDSC for Venus V6 variants 
>> that use this new API. Hence during the next GDSC enable, GDSC will be 
>> in SW mode and GDSC will powerup properly.
> 
> Right so the intention is to have HW GDSC control during playback only - 
> and then revert to SW control when no stream is active, right ?
> 
> I tried your series on today's -next.
> 
> Here is -next without your changes
> 
> https://drive.google.com/file/d/1PFuLOlEp582rBQUvuwc9PNZUBxn1ioYf/view?usp=sharing
> 
> and here is -next with your changes
> 
> https://drive.google.com/file/d/1PHR4rZnWUH9Wp2B-itT5yCUXIMOMZrwM/view?usp=sharing
> 
> The first time I tried that test the stopping/stuttering was worse.
> 
> So yes the original crash was fixed but, this looks like a performance 
> regression to me.
> 

Thanks Bryan for testing this series. Can you please confirm if this 
issue is observed in every run or only seen during the first run? Also 
please let me know on which platform this issue is observed?

Thanks,
Jagadeesh


> Here's the tree I tested with.
> 
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-05-23-review?ref_type=heads
> 
> ---
> bod
> 

