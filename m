Return-Path: <linux-kernel+bounces-24761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DCE82C201
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B27B1F23BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002266E2AB;
	Fri, 12 Jan 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oGSpI0Hc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3006DD05;
	Fri, 12 Jan 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C6JMr5025394;
	Fri, 12 Jan 2024 14:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pwMDkgroSGYEImjOj0FjTPpXnnYl3fh4fHyLyRieYAM=; b=oG
	SpI0HcHsMTEG0VPoQtYtVscmy4J/iVmN1JZIm9nkGOK/Ft9vyLi0ysZ+KazQWGTD
	lLWpiK2k1d4OOLGwNe3brqQaCXctetRnWWDR+7VrvDEcH+XwtO69n2TWuE0wU1+U
	sner9x7jLDV3DD9U7/yYdrliAekNpiVj4e0d+DJavFI9aORHYJ3PCi0oM/eF59I0
	ehUGrYo1yKjess3duQ8VzJI2R47sEOHOIHTchiwjqMy/4vOXIM+XdC1MmJAu3Tkz
	UiV98XMqY4UAMObv5yjLX++JcxO36fo+MwP+yb7+7qCEzKCXDTyu6DFt3tymdhz7
	Y/sfCd9tjqrIT/G4yYlg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjymn99g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:40:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CEe9oU032191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:40:10 GMT
Received: from [10.253.78.164] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 06:40:05 -0800
Message-ID: <6fc9e65a-709a-4923-b0b3-7c460199417a@quicinc.com>
Date: Fri, 12 Jan 2024 22:40:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_soni@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_souravp@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-2-quic_luoj@quicinc.com>
 <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org>
 <de0ad768-05fa-4bb1-bcbc-0adb28cb2257@quicinc.com>
 <CAA8EJppeQdB4W8u0ux16pxBBwF_fpt1j-5aC0f849n9_iaaYtQ@mail.gmail.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <CAA8EJppeQdB4W8u0ux16pxBBwF_fpt1j-5aC0f849n9_iaaYtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kjM5EZ7lijKxsSS_w7Rz57nu8buEP20m
X-Proofpoint-GUID: kjM5EZ7lijKxsSS_w7Rz57nu8buEP20m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120114



On 1/12/2024 12:06 AM, Dmitry Baryshkov wrote:
> On Thu, 11 Jan 2024 at 17:31, Jie Luo <quic_luoj@quicinc.com> wrote:
>>
>>
>>
>>
>> Ok, will update to use a generic name in the link, Thanks for the
>> guidance and the link.
>>>
>>>
>>>> +                    compatible = "qcom,ipq9574-ppe";
>>>
>>> I don't see this documented. I don't see reference to posted bindings.
>>
>> The DT bindings patch was part of the driver series as below. This
>> property was documented in the DT bindings patch. Attaching it to DTSI
>> series should make it more clear. If this is fine, I will update the
>> DTSI series with the DT bindings patch.
>> https://lore.kernel.org/netdev/20240110142428.52026d9e@kernel.org/
>>
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>>> warnings can be ignored, but the code here looks like it needs a fix.
>>> Feel free to get in touch if the warning is not clear.
>>>
>>> Ignoring this warning is a sign you don't really check your patches
>>> before sending.
>>
>> We have run the checkpatch.pl on the whole patch series including this
>> device tree patch set together with PPE driver patch set.
>> As mentioned above, I will add the DT bindings patch into the DTS
>> series. This should help with the checkpatch issue.
> 
> This will cause even more confusion, as there will be two instances of
> the dt-bindings patch. One in the driver patchset, another one in the
> DT changes. You just have to specify the dependencies in the cover
> letter. Another option is to wait for the bindings + driver to be
> accepted, then send the DTSI changes (and again, specify the
> dependency).
> 

Thanks Dmitry for the suggestions.


As per the ongoing discussion on this series, we will hold off this DTS 
patch series for some time. We will update the cover letter of the DTSI 
series to point to the below driver series as a dependency, when we 
resume the series.

https://lore.kernel.org/netdev/20240110154414.GH9296@kernel.org/

>>
>>>
>>>> +                    reg = <0x3a000000 0xb00000>;
>>>> +                    #address-cells = <1>;
>>>> +                    #size-cells = <1>;
>>>> +                    ranges;
>>>
>>> Put after reg.
>> Ok.
>>
>>>
>>>> +                    status = "okay";
>>>
>>> Drop
>> Ok.
>>
>>>
>>> All of above comments apply to your entire patchset and all places.
>>>
>>> Looking at code further, it does not look like suitable for mainline,
>>> but copy of downstream code. That's not what we expect upstream. Please
>>> go back to your bindings first. Also, I really insist you reaching out
>>> to other folks to help you in this process.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> We will do internal review of the gaps and update the patches as per
>> your comments.
>>
>> Thanks for the review comments.
> 
>  From the first glance, the bindings do not follow upstream principles.
> You have all the settings (tdm, port config, etc) in the DT, while
> they should instead go to the driver. Well, unless you expect that the
> board might need to override them.
> 
Hi Dmitry,
The TDM configuration varies per SoC type, since the ethernet port 
capabilities of the SoCs vary. So we will have two different TDM 
configurations for IPQ5332 and IPQ9574 SoC. The driver also will
need to support future SoC, so we choose to configure this from the 
DTSI. The same reason applies to the port scheduler config as well.

Thanks for review comments.

