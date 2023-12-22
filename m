Return-Path: <linux-kernel+bounces-9533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FA81C727
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A8C1C21CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00970DDCB;
	Fri, 22 Dec 2023 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hVOjVLwW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0904D512;
	Fri, 22 Dec 2023 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM0oWRi016607;
	Fri, 22 Dec 2023 09:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Lkv5cExqbgBfEYwPN2LzjTfOWK6VQMomkTuKOAgayGQ=; b=hV
	OjVLwWU0KI77djXTtp2Unxzt++fe6xahYC0CEtfHHMTeVd2niC7uon1qemQtweWX
	zS7kLHw5bH3QVVXFNrnD3YRdC7fog6QdKKtZQMNdcMS+pcgO+xX9FMeFNfvvYEFu
	z8FyFZuR4LSyRlrOeslb/Y3NARbpGRjWA3siFpGRI80xBXmNAUEajCW4rluMb6p/
	DnCORbgGg8z5B0FZEOAPPqivizc7hL03NasLErbkkGdmlxypIKa+5sn6CW+v14Ef
	kdGt0KQupcZR24hMtNwiGKTJG6F4wUqs/Q8PE2gyGdmmVvzguHE5M3Ji7lzU/7vj
	d3jDdmgP/V3lfGPFuPsA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4tue9qe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 09:10:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM9AQW4007949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 09:10:26 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Dec
 2023 01:10:19 -0800
Message-ID: <459ef8e4-bbbc-4a7d-969c-43f269ef6793@quicinc.com>
Date: Fri, 22 Dec 2023 17:10:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Tengfei Fan <quic_tengfan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com>
 <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com>
 <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
 <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com>
 <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
 <A45746C4-54C9-48D2-9DB7-52B4B56854E6@linaro.org>
 <4e328cd8-9ef7-42ce-b592-7f2216c00c0b@quicinc.com>
 <CAA8EJprE8v3bhHfyZJM9SJT=ShJ-LQvk5mR=gpdAWXF2yANWbQ@mail.gmail.com>
 <e88787dc-ed03-42d2-a6e7-fb88bbc89357@quicinc.com>
 <6a4356e2-e201-4b87-bac0-056b29a07fc8@linaro.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <6a4356e2-e201-4b87-bac0-056b29a07fc8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RH3ULBYQU0Wd-WIavAZYZ4eMUWlWP0BD
X-Proofpoint-ORIG-GUID: RH3ULBYQU0Wd-WIavAZYZ4eMUWlWP0BD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220064



On 12/21/2023 4:57 PM, Krzysztof Kozlowski wrote:
> On 21/12/2023 09:49, Aiqun Yu (Maria) wrote:
>> For example:
>>
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
>>
>> @@ -55,14 +50,7 @@ patternProperties:
>>              - const: qcom,sm8350-dp
>>
>>      "^dsi@[0-9a-f]+$":
>> -    type: object
>> -    additionalProperties: true
>> -
>> -    properties:
>> -      compatible:
>> -        items:
>> -          - const: qcom,sm8550-dsi-ctrl
>> -          - const: qcom,mdss-dsi-ctrl
>> +    $ref: ../dsi-controller-main.yaml#
>>
>> With above unified reference change, it will be easier for other
>> developers to reference bindings files next time.
>> Also dsi@[0-9a-f] node in mdss node will be correctly fully described.
> 
> No, this does not make sense and allows anything as dsi. It is opposite
> of what we want in bindings, so NAK.
> 
>>>
>>>> In my opinion if the example have "#address-cells" "#size-cells", then
>>>> it's better to also include "panel@0" with "reg = <0>" to not confuse.
>>>
>>> It is already there, see dsi-controller.yaml.
>>>
>>>>>> 3. Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we align them into 1 binding files.
>>>>>
>>>>> There is just one.
>>>> Currently I mentioned bindings files was searched the compatible
>>>> "qcom,mdss-dsi-ctrl", and find binding docs like "qcom,sm8550-mdss.yaml"
>>>> "qcom,sm8450-mdss.yaml" etc.
>>>> There is duplicate information on "qcom,sm8550-mdss.yaml" etc, while
>>>> "qcom,mdss-common.yaml" is not common enough for my understanding.
>>>
>>> If you had compared the qcom,SOC-mdss.yaml, you would have seen that
>>> they provide tight binding between compatible strings used for all the
>>> subblocks. The `mdss-common.yaml` describes MDSS common properties. It
>>> describes everything except the platform specifics. It can not be made
>>> more common. And there is no duplication.
>>>
>>> If you think you can improve the bindings, please send the patches.
>> I am thinking of a unified qcom,mdss.yaml instead of "qcom,*each
>> SOC*-mdss.yaml". I will try to have a patch.
> 
> I asked first of you to read previous discussions. If you still insist
> on sending patch for this, it means you did not read them.
Do you have the previous discussion title/link that you are refereed 
here pls?
> 
> How you wrote this idea, sounds like exactly opposite of what we were
> doing and what I was recommending few times on the list, so it is very
> likely I will NAK it.
> 
>>> They must pass the `make dt_binding_check` check.
>> Thx for the remind.
> 
> And follow bindings guidelines.
> 
>>>
>>>>>> 4. enhance the dtc warning check if we still want to have "#address-cells" "#size-cells" even if there is no "panel@0" attached.
>>>>>
>>>>> In my opinion this is a way to go, if any. Did you include devicetree@ ML and the corresponding maintainers into the discussion?
>>>> Already included devicetree@ ML at the very beginning.
>>>
>>> Good, thanks for the confirmation.
>>>
>>>> If the required properties part in each yaml is marked good enough, I
>>>> think it can be an input for avoid unnecessary dtc warnings.
>>>
>>> Patches are welcome.
>> Improving developer efficiency with unnecessary warnings is one of my
>> interest as well.
>> First of all, I'd better to make sure "Required properties" attribute in
>> current bindings are good enough. Let me try to get back on this in a
> 
> I don't understand why do you keep mentioning the "required properties".
> They have nothing to do with any of this here.
> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

