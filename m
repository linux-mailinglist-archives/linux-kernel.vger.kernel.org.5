Return-Path: <linux-kernel+bounces-129220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF3896738
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0BCB2294A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB3286A6;
	Wed,  3 Apr 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JKjT50fK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8D5C8E6;
	Wed,  3 Apr 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130662; cv=none; b=sTiqeqVd1CtIaK4BIJXOcvFrLMSYUFy0f6mfXyhzK48zXKOoEU4Cp5pUansZx3sdf+04Ssy1LJOs5/IygmhzkQ+Bj2sW0l9zOIduhRzVXji1KdtDWSjgly1Do05hadxfuRiK8R0ScktZPomj4Wtk7n9OAlQVgrsfP4TRhusv+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130662; c=relaxed/simple;
	bh=xXt761hXGOhChVVs4hvJ3+oYCtJUQLEzwivwDFsgV6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ENkMpQJw8fbD/s7SqOhz4VjgtLeUfSS/2UGl4Ig6KoVD2WrPUtiv82xHzVZGz/cSTd54/9BOWV9YGAbJqeeoTaao1B6DH7+L844TBOgrmoyTbwHUJZf2TBs5MV/j8VTpO2E4aD9sfY3ehI9AQvF6AWUa/cWsB+HsOIssoGETZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JKjT50fK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4335Qtot010714;
	Wed, 3 Apr 2024 07:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5qlywn2ge3g3LY0/ZvHLN9/fbluGe4eXWRjDIrYfvhM=; b=JK
	jT50fKoi9esukAGMTXCUXLabOHr36KpTdyAScChJ7DrxK3pUxx+tdsgtfgEXNIDp
	blIGKKS4qRXiz9tFdp1FQCSmotWGYbsgPo2H23IlH/z78Sj/EyBk5WyZaAT+kqsM
	kXAmScz4QERxaqWzC8qCSPjN5gC+2Kz/FKJBEL9HS3/U2QYKLT0B35Nojt5Ue3MP
	/5j2gOsNHEhIWinzyGB5d45/DEwyVMKBThUPnKMK53pps60UOAKguCDqzvi1rPMz
	qpH1vTzM/zY0mPNe9K+Lp4VzBN8QPoaycFbaYFvvK9dXSBUBAThVY0y+XUN5Kaww
	sKJ7TuSv+bpkXpdfHkmA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9077gb25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:50:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4337orN6013826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 07:50:53 GMT
Received: from [10.216.63.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 00:50:49 -0700
Message-ID: <5354493b-63de-43bb-9871-73918f123661@quicinc.com>
Date: Wed, 3 Apr 2024 13:20:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Komal Bajaj <quic_kbajaj@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amrit Anand <quic_amrianan@quicinc.com>
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
 <20240319091020.15137-3-quic_kbajaj@quicinc.com>
 <CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com>
 <Zgs7Yau1/jYvys4i@hu-bjorande-lv.qualcomm.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <Zgs7Yau1/jYvys4i@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BXDdKxPkfqVEz4Hil2WW7hUn9PBp4Ku3
X-Proofpoint-ORIG-GUID: BXDdKxPkfqVEz4Hil2WW7hUn9PBp4Ku3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030053



On 4/2/2024 4:25 AM, Bjorn Andersson wrote:
> On Tue, Mar 19, 2024 at 11:52:15AM +0200, Dmitry Baryshkov wrote:
>> On Tue, 19 Mar 2024 at 11:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>>
>>> Enable both USB controllers and associated hsphy and qmp phy
>>> nodes on QDU1000 IDP. Add the usb type B port linked with the
>>> DWC3 USB controller switched to OTG mode and tagged with
>>> usb-role-switch.
>>>
>>> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
>>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 65 ++++++++++++++++++++++++
>>>   1 file changed, 65 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> index 89b84fb0f70a..26442e707b5e 100644
>>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> @@ -46,6 +46,33 @@ ppvar_sys: ppvar-sys-regulator {
>>>                  regulator-boot-on;
>>>          };
>>>
>>> +       usb_conn_gpio: usb-conn-gpio {
>>> +               compatible = "gpio-usb-b-connector";
>>
>> If this board has only a USB-B connector, can it really handle USB 3.0?
>>
> 
> Here's a USB 3.0 Type-B cable, so no problem there:
> https://en.wikipedia.org/wiki/USB_hardware#/media/File:USB_3.0_plug,_type_B_-_1709.jpg
> 
> 
> @Komal, please confirm that this is the connector you have on the IDP?
> 

Hi Bjorn,

  Sorry for the confusion. The QDU1000 IDP has a Type-C connector. The 
type-c switch present between SoC and the connector is HD3SS3220 (from TI).

  I think Dmitry's comment was that if it is 3.0, is it Type-C ? and if 
it is Type-C, then the compatible written in the being 
"gpio-usb-b-connector" would mean that there is a Type-B connector for 
someone who looks at the DT. (Dmitry, Please correct me if I understood 
the comment wrong).

  I tried to push a series for adding a compatible to gpio conn driver 
[1] to resolve this and explained the connection specifics to Dmitry [2] 
and he suggested me to add a compatible for just the switch present on 
qdu1000 idp.

Dmitry, Krzysztof,

I was looking into the code again and it turns out there is a driver 
specific to HD3SS3220 switch [3] in linux already. I tried to check if 
it can be reused here but that driver relies on I2C communication 
between the SoC and the HD3SS3220 chip to get information on role 
switch. But in QDU1000 IDP board, there is no I2C communication present 
between SoC and the switch. Those lines have been cut off. The SoC only 
knows about VBUS/ID pins (other than DM/DP/SS Lanes) and no other I2C 
connections between the switch and the SoC. We still need to make use of 
vbus/id pins to decide which role we need to shift into. Can we still go 
ahead with using usb-conn-gpio driver by adding the compatible 
(qcom,qdu1000-hd3ss3220) and using it in DT ?

Let me know your thoughts on this.

[1]: 
https://lore.kernel.org/all/6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com/

[2]: 
https://lore.kernel.org/all/6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com/

[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/hd3ss3220.c?h=v6.9-rc2

Regards,
Krishna,




