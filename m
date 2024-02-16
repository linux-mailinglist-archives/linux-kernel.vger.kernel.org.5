Return-Path: <linux-kernel+bounces-68508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D46857B68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F068B20943
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F491C291;
	Fri, 16 Feb 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="THn4oTjP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6859B52;
	Fri, 16 Feb 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082356; cv=none; b=ldIgVSQRxmESyxG2IbWUidrTj0Y08eKCW/bk9uj/CB1Jsb5wVNqRyXZxWqBiQCwLLBO2ypekA4iWQI3sYQ6V8uyMlDih2Ci+QrpJYACU1x1ndOStfB7VZcjQ9jnSeREVVOzfnkFPiB8fBCieqDfrM1oOSfIJfR11pjwNjnrJRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082356; c=relaxed/simple;
	bh=iB6CRq25HlENFqGrsPH7JLQFt2BIJPW9dYbbZFCQLYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eyksR+miaHg7VqhhnaHIdCff3UtyrNgJP76vSGpz7BTVmdc6A1Ndyu5M/DuAnQKzT3cDoiAVAJ9fvmKd/GQbOCx8IiK/Nb/W82OOsolpS0YLznpXexPHYMeGctdJnth49/IVtfmYcUf7EOIVmQQhrvLrNhrIjEGJ0AWPhc4Ppik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=THn4oTjP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G5xJRE030155;
	Fri, 16 Feb 2024 11:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RLtP2rJDNQHP8tWz4lIqKNUcxLZ6TvPXZeB9bvCF4fQ=; b=TH
	n4oTjP3tc20wz+n0TBL6RQMqy/7dny+3Pf1mureOcsPx+H+bsNHbPT48mA20xP80
	p3joSG8cTD0NtSQwCnlGXI/8w/i20OO8+pqk3yWtUQ6vJRLbBEnSuPpyqU/fWwW/
	dJPEOUf5AjLkQeN8I4KL7trWcB1ZRG8+PH9EKgOdxf+J8XIWtspP1orHFRA/ncV7
	t3xqtk2FzbfBFyhbyI6J5egkDnur5ELbgg3XhQrPeglFmvKLRiAGm8+NcB8KW7+H
	zZeimwcpQDQkd/4n3GEEcrTEfKNOiWOb2vxUI9rwRlQxXB5xoaO4sUXdxXsyHj+O
	WI7n9nkj5r430KUJiDlA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa03r8qt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 11:18:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GBIk7K022931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 11:18:46 GMT
Received: from [10.218.16.59] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 03:18:34 -0800
Message-ID: <e491ec4a-f79b-4063-bd24-bbf3644ce486@quicinc.com>
Date: Fri, 16 Feb 2024 16:48:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>,
        <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
        <agross@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <linus.walleij@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_amelende@quicinc.com>,
        <quic_kamalw@quicinc.com>, <kernel@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
 <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
 <CAA8EJppsn2zsAXem-m=9U8izhtAZmVe62xS5qdkwJmFTqV30gA@mail.gmail.com>
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <CAA8EJppsn2zsAXem-m=9U8izhtAZmVe62xS5qdkwJmFTqV30gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3loeRtsLeLAhQLMDXOPPD-VezXsdvBWc
X-Proofpoint-GUID: 3loeRtsLeLAhQLMDXOPPD-VezXsdvBWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=908 lowpriorityscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402160091

Hi Dmitry,

On 2/16/2024 4:18 PM, Dmitry Baryshkov wrote:
> Hi Jishnu,
> 
> 
> On Fri, 16 Feb 2024 at 12:39, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> 
> Please disable sending HTML emails in your email client. It is
> generally frowned upon, it complicates replying, it breaks quotations,
> etc.

Sorry, I'm not sure how that happened, but I have fixed it now.

> 
>>
>> Hi Krzysztof,
>>
>> On 1/4/2024 1:48 PM, Krzysztof Kozlowski wrote:
>>
>> On 31/12/2023 18:12, Jishnu Prakash wrote:
>>
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>


>> +
>>
>> +      qcom,adc-tm:
>> +        description: |
>> +            Indicates if ADC_TM monitoring is done on this channel.
>> +            Defined for compatible property "qcom,spmi-adc5-gen3".
> 
> You are describing qcom,spmi-adc5-gen3, are you not? So this phrase
> adds nothing.

Yes, I'll remove this.

> 
>> +            This is the same functionality as in the existing QCOM ADC_TM
>> +            device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
>> +        type: boolean
>> +
>>
>> Why do you duplicate entire vadc file? Why it cannot be part of that
>> file? Oh wait, it was in v2.
>>
>> You now duplicated a lot of property definitions without clear reason.
>> If this is intention, then you need to put them in common schema.
>>
>>
>> Many of the properties used for earlier QCOM VADC devices will be used for this device too.....do you mean I can add a new schema file (named something like qcom,vadc.yaml) and move common properties into it (like qcom,hw-settle-time, qcom,decimation, etc) from this file and qcom,spmi-vadc.yaml?
>>
>> Can I do it in the same patch or should it be a separate patch coming before this one ?
> 
> I'd say, separate patch. Move first, extend later.

OK, I'll make it this way if no one else has any objections.

Thanks,
Jishnu

> 
>>
>>
>>

