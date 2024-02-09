Return-Path: <linux-kernel+bounces-59018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8884EFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC33B24108
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AB956B85;
	Fri,  9 Feb 2024 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8XiOT8n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94D57306;
	Fri,  9 Feb 2024 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455753; cv=none; b=TWzhycfwvzngQeLwnp4s+smmsR5OUcwpRRCyScVA2OB+n6nai2fUfikyQJgdSx7BMm27LupqCkuRZTjlW8ZDY/ViiNrgqhn2GRhz+3WphxQkL8yVUxt9Aj3NUcw3aAO3vCV5d6fKc0BjCqu2kylUA8oHtNWoDbAJbzQXhMYwDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455753; c=relaxed/simple;
	bh=0rNVz2XKiSLlsn7TQCspdS3Ei1ryZjvI9nwcSD+0rWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AGSFtiY4Utu1ogfAqJDSVfY+Gmidisv3/3w+As3PMr2krRNImGi8CcenMiwrPkWuRh0qAlbJoGfJgQaJ9BstYo70rrixNfsMP+0XVtA9UYdYLbI5NXldxiEopAA2+GyZYL7OhJKnMLNGsfOf21z4buDdifSObKXqrDVDeR7JJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8XiOT8n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4194SHsK029525;
	Fri, 9 Feb 2024 05:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=llKrerDN6c4994tK+OcIJdQrxxYkY+gY/ZPpsf/PFaI=; b=L8
	XiOT8nHhfEhSLRvUYaQNObgytIlqWPQZXx87XwOOHFwmHio0hqsqZlhi+NHA6iSC
	Lj/pWHnFZVe2v7CyQBDL7ffTvGXQdikRw1onGuxTItXlmluTB1OjxZvjlHSObS64
	+1BRPhbYdGWxHAZ1e+oeLyIieA1vpDl6EGIK+SKVJOWIVamlalG2eL56p2SPY+F5
	BUCIpHKzV0z5wPCX4lS0afVGXN3umhzBUbsIxZzsmLMuPLM50JIBRoSXmT83NVTC
	o0rRmwmDTj9So/JxhHRcd1ifs+kg6hZ+3tL9h57etHx2Xho5IaJeWyhiLQJB1ySP
	PRu8eZ4JiMd9NkiI72vA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4m3akjxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 05:15:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4195Fh9q027469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 05:15:43 GMT
Received: from [10.216.50.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 21:15:39 -0800
Message-ID: <9918eeab-9f56-469f-9f42-7890ccdb2623@quicinc.com>
Date: Fri, 9 Feb 2024 10:45:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com>
 <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com>
 <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
 <ofunpypiiyyhbn5dtrotaluyf3bq7rfj5gwbrku4ibw2dqh4dt@6sxsks33yw5b>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ofunpypiiyyhbn5dtrotaluyf3bq7rfj5gwbrku4ibw2dqh4dt@6sxsks33yw5b>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hX_81DwZgyXECkMPVh1x7M8Pi6iM521b
X-Proofpoint-GUID: hX_81DwZgyXECkMPVh1x7M8Pi6iM521b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_02,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=695 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090036



On 2/9/2024 8:11 AM, Bjorn Andersson wrote:
> On Tue, Feb 06, 2024 at 03:24:45PM +0200, Dmitry Baryshkov wrote:
>> On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
>> <quic_kriskura@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
>>>> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>>>>
>>>>> Enable tertiary controller for SA8295P (based on SC8280XP).
>>>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>>>
>>>> These are not just pinctrl entries. They hide VBUS regulators. Please
>>>> implement them properly as corresponding vbus regulators.
>>>>
>>>
>>> Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
>>> implementation was fine as Konrad reviewed it in v13 [1]. I removed his
>>> RB tag as I made one change of dropping "_state" in labels.
>>
>> My comment is pretty simple: if I'm not mistaken, your DT doesn't
>> reflect your hardware design.
>> You have actual VBUS regulators driven by these GPIO pins. Is this correct?
>> If so, you should describe them properly in the device tree rather
>> than describing them just as USB host's pinctrl state.
>>
> 
> This is correct, these gpios are wired to the enable-pin of a set of
> regulators providing the VBUS voltage. Please, Krishna, represent them
> as always-on fixed-regulators instead.
> 
Hi Dmitry, Krzysztof, Bjorn,

  Thanks for the review on this patch. Will convert the pinctrl DT's to 
regulator entries.

Regards,
Krishna,

