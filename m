Return-Path: <linux-kernel+bounces-57466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C867A84D96E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EFCB236C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AC67A14;
	Thu,  8 Feb 2024 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KyLsgFOy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224E679F8;
	Thu,  8 Feb 2024 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707367709; cv=none; b=Lujk/gvUuUqg3VXgYWRD6oxpzn9LbCrJjMco3Lclt6nJizGe9wxY83hKHeW+DHF0HLKQ0rf8Hy8egqhSxt99KGvnR9DeW2SMboADZSDUjM6RsNAavj2Ha7qyWLZN1D7qajqL7OMLLuU+bNPn4JLLS4GytVpWGLPLmp3+XMlutCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707367709; c=relaxed/simple;
	bh=kPtJPhKhm6zFTjkp+nsXqycQ5MLkVr6QmfvGNYifTFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ex+GpaYOJVf/nJc1S2VlLb+Z+Zufi+3VZrr5wFvQFT8yheGJal3jmhxR/YhT+9TNf8Go2rItBtzBqsKeed0w8B8yFsYgujdmguuGmQXixakCicRB8YxF2opJvmV2TXBZ094iEj+mG8usOphOzQJl2tnYFyBOp8mRAXioCuP3pAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KyLsgFOy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4184ba2X000421;
	Thu, 8 Feb 2024 04:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6mBo36jd0eUhpi32VDcylBEhhD0XmvjZ+0/CEDOcvh8=; b=Ky
	LsgFOyYqQzYah+2Cx0QTvSl8EM6jwHssb7vywgd19WbYj3HV0s/7wodJHtJu5dkF
	0m7M6UXbA/npgsbgpV4yxNt92lvd/3Q8c/XiZTw7XEkb9TB1GOLqd1IbpdSsdCos
	Jp4XZgTtqFOhKq4L5u+ZIfOb6/Bge6igczbGYY0AW4I4qw/b8cAsP53LUMsHzKE7
	ORyKiVG3xP5TptOferMr978K6ysrNeE42InLWlqGaFtMnEKZNPlW5gponmzO9l9e
	4J0y2Jwd7xmvJYtC9wDG38+HRb3KFvqQdggdaSJU3yYPiXaGtjP6Nrc1FpTaOTBi
	/kMpY7BCqReIQ1tyb+nA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4hhk8qff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 04:48:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4184mKf0018231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 04:48:21 GMT
Received: from [10.216.53.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 20:48:17 -0800
Message-ID: <7500f1f8-1d97-4fa9-a7cd-7dea0ad52e00@quicinc.com>
Date: Thu, 8 Feb 2024 10:18:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com>
 <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com>
 <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
 <fd4f4cc8-3366-485b-b540-b05ef59dd5d4@quicinc.com>
 <CAA8EJppi+3cJqzkhcaDR_3w_Qhy_AzLBJsW7-dtugzE1egM3Kg@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJppi+3cJqzkhcaDR_3w_Qhy_AzLBJsW7-dtugzE1egM3Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: awHsPcJpjndywQK65G6arvL2q3aTze8X
X-Proofpoint-GUID: awHsPcJpjndywQK65G6arvL2q3aTze8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=727 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080023



On 2/8/2024 10:11 AM, Dmitry Baryshkov wrote:
> On Thu, 8 Feb 2024 at 04:40, Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
>> On 2/6/2024 6:54 PM, Dmitry Baryshkov wrote:
>>> On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
>>> <quic_kriskura@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>>>>>
>>>>>> Enable tertiary controller for SA8295P (based on SC8280XP).
>>>>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>>>>
>>>>> These are not just pinctrl entries. They hide VBUS regulators. Please
>>>>> implement them properly as corresponding vbus regulators.
>>>>>
>>>>
>>>> Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
>>>> implementation was fine as Konrad reviewed it in v13 [1]. I removed his
>>>> RB tag as I made one change of dropping "_state" in labels.
>>>
>>> My comment is pretty simple: if I'm not mistaken, your DT doesn't
>>> reflect your hardware design.
>>> You have actual VBUS regulators driven by these GPIO pins. Is this correct?
>>> If so, you should describe them properly in the device tree rather
>>> than describing them just as USB host's pinctrl state.
>>>
>>
>> Hi Dmitry,
>>
>>    I have very little idea about the gpio controller regulators. I will
>> go through it and see how I can implement it. I just found this :
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> 
> Much simpler, it can be found at
> Documentation/devicetree/bindings/regulator/fixed-regulator.yaml

Thanks for the reference.

> 
>> One query. If we model it as a regulator, do we need to add it as a
>> supply and call regulator_enable in dwc3_qcom probe again ?
> 
> Not in probe(), but yes. It needs to be enabled when the VBUS has to
> be powered up, when the device is initialised or switched to the host
> mode, and disabled when the VBUS has to be powered down, if the device
> is being switched to the device mode.
> 

Actually since we never go to device mode, can't we just stick to this 
pinctrl approach and skip turning on regulator in driver ?

Regards,
Krishna,

