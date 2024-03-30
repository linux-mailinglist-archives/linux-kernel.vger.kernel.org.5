Return-Path: <linux-kernel+bounces-125641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD88929F4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB58C1C20E81
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144E101E8;
	Sat, 30 Mar 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dr+wzPEV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F04F9FF;
	Sat, 30 Mar 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790030; cv=none; b=lXU7Ekz5ncEDY/O9Boxjk5W+HMOOIeuSlYhhKi0CBZ/qUPspQ6Olg6S1qxV01F6VpVfqpKXOjrPe2Z8z7TFdsQlZXBRmwUkDtFdBlBvmasbPLpNDSdZ2YaeSuLkpWruig/HewhILtxGlhwVA3FWgdXK+pKVdSaek6zpCLqFzqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790030; c=relaxed/simple;
	bh=zZiTRe3m3NLbb+/Qp3yvgOHwujhfgKPzWdst81UulPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AMVPkQvKsvsggWlW2CXCR3/fJ8JDxZVGvlQ+uI3gMzYJx0cgJieHXKtCyJhx8DIgKz2I6NJcfqSkXX/cLd+lNtKDc0ulcDcP7hKb8701hkd1v3sYeB2zC3pOuZjAs8SXPxjDDCR5nl2cCijUt/VrjzdrY8Pu+y6/5LfYcG5zJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dr+wzPEV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42U8lmLF013098;
	Sat, 30 Mar 2024 09:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FhEb9K/BxdRk2okMHgeAtJuKVJhrSJebpoCQp1OmvdQ=; b=Dr
	+wzPEVwH7l3fpu5u9f0GQkCoTKNTSvm9ud24uR2CqFOkLT4jY/d1iNvdwK/gfikA
	MVhUZA/vXCcPd4tqHknfRWldfxOHAqyiz5eHDY6o9ua2iLkpneM0VwUkFef4KtIy
	U76UI5UQbdeDzKGxOMkDfKlOTNJF+2pAlDraJK+JPGlm7wz72lr+WCKpAiJnevvd
	AsZZeF9BI0+wrycErZrjVIPFubolxEwYTO2hFV1YfbVds5kmhSLIc/DAHr3IEz6o
	OvuEROLpFpa9K8qKLd1ckvoNCx3cPtZcgvR3dija5av+XnoW/vg93pm/vQbx4a36
	JZq1TgXVwPzht7KwoTIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x683s0vc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 09:13:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42U9DHR2016503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 09:13:17 GMT
Received: from [10.216.59.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 30 Mar
 2024 02:13:11 -0700
Message-ID: <6f2df222-36d4-468e-99a7-9c48fae85aa9@quicinc.com>
Date: Sat, 30 Mar 2024 14:43:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add gpio-usb-c-connector compatible
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miquel
 Raynal" <miquel.raynal@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Bjorn Helgaas" <bhelgaas@google.com>, Kyle Tso <kyletso@google.com>,
        Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
 <CAA8EJpqx+VFW8z6oG=+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpqx+VFW8z6oG=+pnhPN97Q3R6z+ygf85Uspve-9syQsUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w9l_gJ3vqg3mZzBvIWmjhsf3kITwbXlG
X-Proofpoint-ORIG-GUID: w9l_gJ3vqg3mZzBvIWmjhsf3kITwbXlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_05,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403300075



On 3/29/2024 6:23 PM, Dmitry Baryshkov wrote:
> On Fri, 29 Mar 2024 at 09:20, Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>>
>> QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
>> However it relies on usb-conn-gpio driver to read the vbus and id
>> gpio's and provide role switch. However the driver currently has
>> only gpio-b-connector compatible present in ID table. Adding that
>> in DT would mean that the device supports Type-B connector and not
>> Type-c connector. Thanks to Dmitry Baryshkov for pointing it out [2].
> 
> USB-B connector is pretty simple, it really has just an ID pin and
> VBUS input, which translates to two GPIOs being routed from the
> _connector_ itself.
> 
> USB-C is much more complicated, it has two CC pins and a VBus power
> pin. It is not enough just to measure CC pin levels. Moreover,
> properly handling USB 3.0 inside a USB-C connector requires a separate
> 'orientation' signal to tell the host which two lanes must be used for
> the USB SS signals. Thus it is no longer possible to route just two
> pins from the connector to the SoC.
> 
> Having all that in mind, I suspect that you are not describing your
> hardware properly. I suppose that you have a Type-C port controller /
> redriver / switch, which handles CC lines communication and then
> provides ID / VBUS signals to the host. In such a case, please
> describe this TCPC in the DT file and use its compatible string
> instead of "gpio-c-connector".
> 

Hi Dmitry,

  My bad. I must have provided more details of the HW.

  I presume you are referring to addition of a connector node, type-c 
switch, pmic-glink and other remote endpoints like in other SoC's like 
SM8450/ SM8550/ SM8650.

  This HW is slightly different. It has a Uni Phy for Super speed and 
hence no DP.

  For orientation switching, on mobile SoC's, there is a provision for 
orientation gpio given in pmic-glink node and is handled in ucsi_glink 
driver. But on this version of HW, there is a USB-C Switch with its own 
firmware taking care of orientation switching. It takes 8 SS Lines and 2 
CC lines coming from connector as input and gives out 4 SS Lines (SS 
TX1/TX2 RX1/RX2) as output which go to the SoC. So orientation switch is 
done by the USB-C-switch in between and it automatically routes 
appropriate active SS Lane from connector to the SoC.

  As usual like in other targets, the DP and DM lines from type-c 
connector go to the SoC directly.

  To handle role switch, the VBUS and ID Pin connections are given to 
SoC as well. There is a vbus controller regulator present to provide 
vbus to connected peripherals in host mode.

  There is no PPM entity (ADSP in mobile SoC's) and no UCSI involved 
here. Hence we rely on usb-conn-gpio to read the vbus/id and switch 
roles accordingly.

  Hope this answers the query as to why we wanted to use usb-conn-gpio 
and why we were trying to add a new compatible.

Regards,
Krishna,

>>
>> This series intends to add that compatible in driver and bindings
>> so that it can be used in QDU1000 IDP DT.
>>
>> [1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quicinc.com/
>> [2]: https://lore.kernel.org/all/CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com/
>>
>> Krishna Kurapati (2):
>>    dt-bindings: connector: Add gpio-usb-c-connector compatible
>>    usb: common: usb-conn-gpio: Update ID table to add usb-c connector
>>
>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +++
>>   drivers/usb/common/usb-conn-gpio.c                             | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> --
>> 2.34.1
>>
> 
> 
> --
> With best wishes
> Dmitry

