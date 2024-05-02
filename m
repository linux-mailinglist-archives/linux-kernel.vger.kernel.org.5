Return-Path: <linux-kernel+bounces-166248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB98B9806
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB41B26112
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F556446;
	Thu,  2 May 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E4u5ylQd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA665490A;
	Thu,  2 May 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643304; cv=none; b=a+BypEd93T3HIs1FW06mc8FobS9U7ieAVQxujBgOPvPwNaRiA4eCm5lqr5MvlW81gXmOtivS/9FXR8gDGqoxpbRK0Alr2GQyjCVaIjYbFa61pgV/Z+J46w7q9tCgFbx2lcMLJ7jKF8CebiGlTWkOiY2js9TbkTEHH3tHT4Eo4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643304; c=relaxed/simple;
	bh=Qtow55VBHXnQW0e9Rstp6Mcwo51xVDOUn/UazpjWcK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NGA0WUYQFJHXs+zTA18CbNsxvTI9aVadXYNaGIaXK3ZdDnQEGobOHtzbnZtbuPcA23NjtKbRUKmlULw7nWY5YDuUZkzOdgjDjzS4uZGj2JsLorc8s62rG5XCl0k7aViOatYipYifX9Vd3Hau7NWwlSzfjOxhrGLDvi4Gik+zRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E4u5ylQd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4426LBHw025698;
	Thu, 2 May 2024 09:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VuUpTmSHU54n7Os5jeaIfRBwwWQbIaOdLoYboZcS+rg=; b=E4
	u5ylQdXdb9684w/96x7FH2WsxkK0NoeRxXdnbdKHelETj/+LCzhq+Wtt3gLudvQr
	AvlE2Qse2WDNDNLyf7ZihjIBiwdJmlT1lguRCFg0oWvYSs2OB/8vIzYd/lqYrnis
	WuWlknckVMRQldfmEuA31IVV5yV0UuJBYNI1uVr6RCqrD+InpiqczAJk/14aLiRI
	Tvf/YREka+7Rost06CB/ASl22QBPUZhh68h0xlCzQD1Mt+DEgKbZ5wSFPa0jVuCg
	lgsLZ2dQPuD7v81zZTE/kuLU4h0oh73JaSBRcdmMAPNFCceFz3EmYukvVfEVkJym
	e6dgbGZnI0dpkhdOp6RA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv41mgh5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:48:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4429mDX0021374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 09:48:13 GMT
Received: from [10.216.23.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 02:48:09 -0700
Message-ID: <5134c012-60b1-4c07-9e1f-c48c3d88d404@quicinc.com>
Date: Thu, 2 May 2024 15:18:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add devicetree support of USB for QDU/QRU1000
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Komal Bajaj
	<quic_kbajaj@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_ppratap@quicinc.com>, Jack Pham
	<quic_jackp@quicinc.com>
References: <20240502090326.21489-1-quic_kbajaj@quicinc.com>
 <CAA8EJprPLqj7GQM0vmN25U2+3kDow=NH8=-VC2N-0p92Ub3iCA@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJprPLqj7GQM0vmN25U2+3kDow=NH8=-VC2N-0p92Ub3iCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 70-auOsRtB6TNmn-0Ljuwlt317cmELzk
X-Proofpoint-ORIG-GUID: 70-auOsRtB6TNmn-0Ljuwlt317cmELzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=548 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020059



On 5/2/2024 2:39 PM, Dmitry Baryshkov wrote:
> On Thu, 2 May 2024 at 12:04, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>> This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
>> This is based on previously sent driver series[1].
>>
>> ------
>> Changes in v3:
>> * As per comments on upstream[2], to get role-switch working on QDU/QRU1000, it was recommended to
>>    use the actual TI switch driver. Since driver doesn't have the functionality to provide role-switch
>>    based on gpio, thus reverting back USB dr_mode to peripheral and removed the remote end-point nodes
>>    and usb-conn-gpio based role switch functionality.
> 
> This is not correct. The recommendation was to describe hardware properly.
> Which means adding schema description, adding  ti,your-switch
> compatible to the usb-conn-gpio.c driver, etc.
> 

Hi Dmitry,

  Sorry for the confusion. In the comments [1],

"So the compatible string should be "ti,hd3ss3220". Which is fine to be
used in the platform driver. Just describe the differences in the
schema."

The compatible "ti,hd3ss3220" is already associated with a TI switch 
driver [2]. But it works based on I2C. So we assumed you wanted us to 
make changes to [2] by adding GPIO functionality (which usb-conn-gpio 
exactly does), since the compatible you suggested matched with the TI 
driver.

If it was to add compatible in usb-conn-gpio, then we can support OTG 
functionality with no schema changes I believe, but the compatible 
string might need a different name to avoid clashing with the name in [2].

[1]: 
https://lore.kernel.org/all/CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com/

[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/hd3ss3220.c?h=v6.9-rc2

Regards,
Krishna,

>> * Link to v2: https://lore.kernel.org/linux-arm-msm/20240319091020.15137-1-quic_kbajaj@quicinc.com/
>>
>> Changes in v2:
>> * Changes qmpphy node name
>> * Changes dr_mode to otg and added USB-B port USB role switch
>> * Dropped maximum-speed property from usb dwc3 node
>> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/
>>
>> [1] https://lore.kernel.org/linux-arm-msm/20240502082017.13777-1-quic_kbajaj@quicinc.com/
>> [2] https://lore.kernel.org/all/CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com/
>> ------
>>
>> Komal Bajaj (3):
>>    arm64: dts: qcom: qdu1000: Add USB3 and PHY support
>>    arm64: dts: qcom: qdu1000-idp: enable USB nodes
>>    arm64: dts: qcom: qru1000-idp: enable USB nodes
>>
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  23 +++++
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 120 +++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/qru1000-idp.dts |  23 +++++
>>   3 files changed, 166 insertions(+)
>>
>> --
>> 2.42.0
>>
>>
> 
> 

