Return-Path: <linux-kernel+bounces-68866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF385811E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FE028109C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58EB131E52;
	Fri, 16 Feb 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HBRTcxo9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFD12F590;
	Fri, 16 Feb 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097006; cv=none; b=ls34K3/w3/znfcRno5yy7GGuifyGBVqeK3KP+/yIXyU+IRnnEP2sE4GTxIGjjOIizjcwQxtDI7I3AY1AxezsiaZjhORXhMk6jlbBYbb1nVOXO7BRzE1+Ayfgxdh4B+EHJbjEgF+BwDJLny6G6Z+i/w2/Fn7Ww5bxpMZmUF6Q2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097006; c=relaxed/simple;
	bh=Xx5jSFVmR8kKsbKaSAkT+6yVkSDIJYlTfxO/EtUuVWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KWdlNH7TkeaNbAdWfjfiIWeg8dG9I12ZOAOwcPFkaB4zS0UV7LNKc2gdOptzp8aU4jRHy5qDGxwxt1bGMcskbqLzugtOZG5YcCIeNokw5swW5wDlq6V4D5YWUmkCPIpb5feL8NcZ0zqqNTpWv/wolHWalX9Xeg1n4jXz7Wpp5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HBRTcxo9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GEAWsI009953;
	Fri, 16 Feb 2024 15:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uIq/Agw0yupQT4M4DimqqSBPa70+vSSr+DSeONVRZJ0=; b=HB
	RTcxo9hbAG52xOOWunETTnrcmN70eacSwyRX0O+bLrNCKOJYrUmtmvDx2sbM+bwH
	eh209jlA2T0jKd+70J4jJWS4skSRu3hUGVn0JI0d1w3HUWka8VFPa6bfLKcU1y7w
	vTFFgDbbq6tZFKgFdr2tlY9WAgLSXCPK9EOXbVT0qnOi6vJlb9cYgnHQ/ATy5RWc
	c2Cl0h2FR0Gf+n4jfTCC5V/lVghWebbKH4OlB/LF3qdQfy+KTHAVNWqsH/jpqPwm
	LvEp4kYAFcL3aDHjVX6WYIpiV2z/OZ44zCwNFlpCOS0ec+ATjTUtEwiCYlsevkfB
	H9Yzb0CrPSIPKh9OsgGA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfbw56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:22:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GFMsDd003794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:22:54 GMT
Received: from [10.216.32.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 07:22:48 -0800
Message-ID: <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
Date: Fri, 16 Feb 2024 20:52:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
 <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
 <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9F9jTJZpwa9-J3H6FxCCvQ93vX9fb8bx
X-Proofpoint-GUID: 9F9jTJZpwa9-J3H6FxCCvQ93vX9fb8bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160122



On 2/14/2024 8:14 PM, Andrew Lunn wrote:
> On Wed, Feb 14, 2024 at 02:49:41PM +0530, Kathiravan Thirumoorthy wrote:
>>
>>
>> On 1/26/2024 1:35 AM, Andrew Lunn wrote:
>>> On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
>>>> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
>>>> enabled by default and it's RCG is properly configured by bootloader.
>>>
>>> Which bootloader? Mainline barebox?
>>
>>
>> Thanks for taking time to review the patches. I couldn't get time to respond
>> back, sorry for the delay.
>>
>> I was referring to the U-boot which is delivered as part of the QSDK. I will
>> call it out explicitly in the next patch.
> 
> I've never used QSDK u-boot, so i can only make comments based on my
> experience with other vendors build of u-boot. That experience is, its
> broken for my use cases, and i try to replace it as soon as possible
> with upstream.
> 
> I generally want to TFTP boot the kernel and the DT blob. Sometimes
> vendor u-boot has networking disabled. Or the TFTP client is
> missing. If it is there, the IP addresses are fixed, and i don't want
> to modify my network to make it compatible with the vendor
> requirements. If the IP addresses can be configured, sometimes there
> is no FLASH support so its not possible to actually write the
> configuration to FLASH so that it does the right thing on reboot
> etc...
> 
> Often the vendor u-boot is a black box, no sources. Can you give me a
> git URL for the u-boot in QSDK? If the sources are open, i could at
> least rebuild it with everything turned on.


You can get the source at 
https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/tree/NHSS.QSDK.12.2?ref_type=heads

You should be able to TFTP the images, write into the flash and 
configure the IP and so on...


> 
> But still, it is better that Linux makes no assumptions about what the
> boot loader has done. That makes it much easier to change the
> bootloader.
> 
>>>> Some of the NSS clocks needs these clocks to be enabled. To avoid
>>>> these clocks being disabled by clock framework, drop these entries
>>>> from the clock table and enable it in the driver probe itself.
>>>
>>> If they are critical clocks, i would expect a device to reference
>>> them. The CCF only disabled unused clocks in late_initcall_sync(),
>>> which means all drivers should of probed and taken a reference on any
>>> clocks they require.
>>
>>
>> Some of the NSSCC clocks are enabled by bootloaders and CCF disables the
>> same (because currently there are no consumers for these clocks available in
>> the tree. These clocks are consumed by the Networking drivers which are
>> being upstreamed).
> 
> If there is no network drivers, you don't need clocks to the
> networking hardware. So CCF turning them off seems correct.


Yeah agree with your comments.

QSDK's u-boot enables the network support, so the required NSSCC clocks 
are turned ON and left it in ON state. CCF tries to disables the unused 
NSSCC clocks but system goes for reboot.


Reason being, to access the NSSCC clocks, these GCC clocks 
(gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
should be turned ON. But CCF disables these clocks as well due to the 
lack of consumer.


> 
> Once you have actual drivers, this should solve itself, the drivers
> will consume the clocks.


Given that, NSSCC is being built as module, there is no issue in booting 
the kernel. But if you do insmod of the nsscc-ipq5332.ko, system will 
reset.

Without the networking drivers, there is no need to install this module. 
And as you stated, once the drivers are available, there will be no issues.

So can I explain the shortcomings of installing this module without the 
networking drivers in cover letter and drop this patch all together?



> 
>> However looking back, gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
>> gcc_nssnoc_nsscc_clk are consumed by the networking drivers only. So is it
>> okay to drop these clocks from the GCC driver and add it back once the
>> actual consumer needs it?
> 
> But why should you remove them. If nothing is using them, they should
> be turned off.
> 
>     Andrew

