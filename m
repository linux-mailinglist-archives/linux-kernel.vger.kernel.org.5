Return-Path: <linux-kernel+bounces-118460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C418188BB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E854D1C2FB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E7130AEC;
	Tue, 26 Mar 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KDadHnYj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920A130A65;
	Tue, 26 Mar 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438221; cv=none; b=HDQCmNF5Bz8mevPfAeWICnmMBlhYPEkyjNR3s7n/wU5hFesmXp1lPBZTuiDL6x42cUQ2SifVXvSsQ0IiCyOK7LWMCKJypjML67bZYzUpy0TQC/mUb31LEYgRHhxo0zvJxfOUM+Z7AbAp/ITjasRtsozyCdTdRdSNDQ3cQOuUMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438221; c=relaxed/simple;
	bh=CRjcQUa1O1VQEkrYah3aU2Dfmn8ieNgrULDmwX0FhP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ErHi+er5u/5KTNEylCe8aTZIyMEjN5RFliAHD1OMqlXw/a7Lb2xf5sjlgxM/WHJirZaidvl5G2Qa8s7oIEAdWCtakpJTJ7aYiV9SKJx/cqiSM2RsO1snCUi8nzcotJ23yrp/9ypzpnqfgaIb93ZjkRUWnUeetkNSpGnkzVcK+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KDadHnYj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q5k0G7010711;
	Tue, 26 Mar 2024 07:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OQDARmuA9qghqlPbUPmWsGdH3pMdroUx/3+mtg0evH0=; b=KD
	adHnYjqGppY7eCZWWLDkLQUWgcAsYiC8AIcYjjWh5QPXO7C6ymazrSC8S0ELzbi/
	fdn6sVCmFncM8RDVKRarC62/ETS3ufa2Uf6saP3Rt5ZvPVO5XDKwDLSZee7uEiqf
	WkJQ/PPBkDed8Ft1ZFZ6UBkLgzZV/FjAF0j222U2lIKzaMMQHcAPHH8Ubx4oAG3t
	sPykcp0IcTue+Cy+U5VtRwmsEUk6boEINgBGAR08EUnRYpxyDUfi/0JN9f1Q9r5d
	TU/pvJyYx+9q0gdz8NMIA9UKLtACthIGbn0JGy+ovcRcr1I5slHdzCKCjA4hHgLt
	ZoyFv1UWCA3tbItmzKQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rghrake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:30:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q7U8qE003245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:30:08 GMT
Received: from [10.218.47.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 00:30:05 -0700
Message-ID: <b0e7ce76-486a-727a-4ef4-d08f38be8408@quicinc.com>
Date: Tue, 26 Mar 2024 12:59:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
To: Amit Kucheria <amitk@kernel.org>
CC: Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_manafm@quicinc.com>
References: <20240227160928.2671-1-quic_priyjain@quicinc.com>
 <CAHLCerModb=01WX=q6XU0XO8dr5EaSQ5RaBoFLFc_=vpOGAgaw@mail.gmail.com>
 <06ab4347-3ed0-432a-cc36-49837d8a28de@quicinc.com>
 <CAHLCerPnyT56WukNqX6_4gM7siczYBpSsb7XM_eW=vb5dBwceA@mail.gmail.com>
Content-Language: en-US
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <CAHLCerPnyT56WukNqX6_4gM7siczYBpSsb7XM_eW=vb5dBwceA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mFW-xWMYQRRI7meO7VJnxmielf6eQJfM
X-Proofpoint-ORIG-GUID: mFW-xWMYQRRI7meO7VJnxmielf6eQJfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=991
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260050



On 3/21/2024 6:21 PM, Amit Kucheria wrote:
> On Tue, Mar 19, 2024 at 4:19 PM Priyansh Jain <quic_priyjain@quicinc.com> wrote:
>>
>>
>>
>> On 3/17/2024 1:37 AM, Amit Kucheria wrote:
>>> On Tue, Feb 27, 2024 at 9:40 PM Priyansh Jain <quic_priyjain@quicinc.com> wrote:
>>>>
>>>> As part of suspend to RAM, tsens hardware will be turned off.
>>>> While resume callback, re-initialize tsens hardware.
>>>>
>>>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>>>> ---
>>>> V2 -> V3: Remove suspend callback & interrupt enablement part from
>>>> resume callback.
>>>> V1 -> V2: Update commit text to explain the necessity of this patch
>>>>
>>>>    drivers/thermal/qcom/tsens-v2.c |  1 +
>>>>    drivers/thermal/qcom/tsens.c    | 40 +++++++++++++++++++++++++++++++++
>>>>    drivers/thermal/qcom/tsens.h    |  6 +++++
>>>>    3 files changed, 47 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>>>> index 29a61d2d6ca3..0cb7301eca6e 100644
>>>> --- a/drivers/thermal/qcom/tsens-v2.c
>>>> +++ b/drivers/thermal/qcom/tsens-v2.c
>>>> @@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>>>    static const struct tsens_ops ops_generic_v2 = {
>>>>           .init           = init_common,
>>>>           .get_temp       = get_temp_tsens_valid,
>>>> +       .resume         = tsens_resume_common,
>>>>    };
>>>
>>> Please add resume callbacks for the other tsens hardware too and make
>>> sure that your reinit function handles them too.
>>>
>> We have discussed internally on this and we think that if someone wants
>> to extend the support (and do the validation) of one of those old
>> platforms they can add the resume ops for that platform. There are many
>> versions of tsens hardware so we are bit skeptical to add reinit support
>> for all these platforms with any validations(since S2R mode is not
>> enabled for all these older platforms so it is not possible to validate).
> 
> Then why does tsens_reinit refer to tsens_version(priv) >= VER_0_1
> when re-enabling the irq?
> 
> Perhaps we should explicitly disable platforms that are not validated
> for this functionality (.resume = NULL) and have the reinit function
> only work for validated platforms (tsens_version >= VER_2_X)?
> 
Sure i will update tsens_reinit to handle only tsens_version >= VER_2_X 
in next patch. Also will add (.resume = NULL ) for all the platforms for 
which this functionality is not validated in next patch.

Regards,
Priyansh

> Regards,
> Amit

