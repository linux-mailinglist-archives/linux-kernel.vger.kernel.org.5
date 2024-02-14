Return-Path: <linux-kernel+bounces-64943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F38544F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C615B21EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CB14015;
	Wed, 14 Feb 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HUxMlD7v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9F12B7B;
	Wed, 14 Feb 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902405; cv=none; b=V36/r+zuuGLQuecs7K+h7Ykci7agRy4u2jx8MqrUG6sh7br5s0bVql4HEpUjTLy76eVur4N979bBgWOAVQji0naC0Y7P+TMp5WxfaFbkR/wSCI0E/ZU86tQMhUM70X3fcPDcSLxRMEXPBAYVYgvTiqaZqrpHaytAck+cCuLIpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902405; c=relaxed/simple;
	bh=2fMXcYcvWxaz1npIo1pKnK5llUMcCFybitnqrZX3Ang=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bg3TggqnIQzHfXIaozk+6ZufROki9jdJKauLbJMjfQY6Wazs5NhKUtGbHhl3Lq5b07bZPhMQI5iiXrNIfI3U4Xwsmj6VXF5Yox3G8pw1V5TD14CkZFRJepkIqoWkbJ2saZsCn4ynX7I8BHj45rJUJTihS+xbgUAt7K9DwlppyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HUxMlD7v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E7kG5f024087;
	Wed, 14 Feb 2024 09:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Rmqg+vYr2399W1bV/8QxckiS9s0iEj0WPITAUROA/Tk=; b=HU
	xMlD7vkMY5bV3o13nV3teuOeBqdIDgzH4WnJaEGBOdHlzRP66cjto+G7tpDDbQm7
	kxX3NqRwAVBaXotKNmSbh+AIPRRBfAPOYgTHIzcaQ3wzg5bn3TiIGYFWAnp2tTAH
	lI2BTZrv9AwIBBeB0xtofUV4EvdvUB4Fii5GCIUdPlITWrStD00D+42Aog7HBwpk
	oPN4QOuTHxOpBB0diGmaLDIRfs7HgLkU6RwOpHvBO/i1At64WX935yL3o/8mEF2v
	ZcLkl16LqcyB3DV0vtl55vOsKhk80nOSW+hqw9wHhR9a9r8PY6SLE8XkKj2U+2mj
	xYVK59hD+1bgsPVOSoHA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8jrj8rfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:19:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E9JorD026448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:19:50 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 01:19:44 -0800
Message-ID: <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
Date: Wed, 14 Feb 2024 14:49:41 +0530
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
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YNUVd4LGqR4M-i4n7A4gWk_p2qnpAhr4
X-Proofpoint-ORIG-GUID: YNUVd4LGqR4M-i4n7A4gWk_p2qnpAhr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=734 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402140071



On 1/26/2024 1:35 AM, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
>> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
>> enabled by default and it's RCG is properly configured by bootloader.
> 
> Which bootloader? Mainline barebox?


Thanks for taking time to review the patches. I couldn't get time to 
respond back, sorry for the delay.

I was referring to the U-boot which is delivered as part of the QSDK. I 
will call it out explicitly in the next patch.

> 
>> Some of the NSS clocks needs these clocks to be enabled. To avoid
>> these clocks being disabled by clock framework, drop these entries
>> from the clock table and enable it in the driver probe itself.
> 
> If they are critical clocks, i would expect a device to reference
> them. The CCF only disabled unused clocks in late_initcall_sync(),
> which means all drivers should of probed and taken a reference on any
> clocks they require.


Some of the NSSCC clocks are enabled by bootloaders and CCF disables the 
same (because currently there are no consumers for these clocks 
available in the tree. These clocks are consumed by the Networking 
drivers which are being upstreamed). To access the NSSCC clocks, 
gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk clocks 
needs to be enabled, else system is going to reboot. To prevent this, I 
enabled it in probe.

However looking back, gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, 
gcc_nssnoc_nsscc_clk are consumed by the networking drivers only. So is 
it okay to drop these clocks from the GCC driver and add it back once 
the actual consumer needs it? So that we don't have to enable it in probe.

Please let me know your thoughts.


> 
> Please correctly describe the clock tree in device tree, not hide
> clocks because your DT description is not complete.
> 
>      Andrew
> 
> ---
> pw-bot: cr

