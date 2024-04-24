Return-Path: <linux-kernel+bounces-156519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D828B03CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9183D2828A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90C158855;
	Wed, 24 Apr 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G/3br72e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353E158200;
	Wed, 24 Apr 2024 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945662; cv=none; b=AAdis1hLfD15FIlNanjsHo73s3wObPByKdFLsbOdFxQpa9YBc0kMnY8bJS/CDOq7ahsU7m/ZEZZ2vDKRUKgxVbnn6CmJzwjifYcNiCRGfWHogHVID6sf0oU4OkagZPlniSo1+PAa8uYS+GFtEzA05vlyxTh3KI8TYzL1mE7vL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945662; c=relaxed/simple;
	bh=LcdTzFCDw8C8NoVPpUF3vlrV91vivEgOlX7L8BPsYVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fr0K/6B5LU+3AUQ3lFC++t77lf8AIQz7xomvQApdrhtlYgFIxykYzZzgD5AWyxBqCkIrXmtjUevqJdGB1o1TZ/WOeQ9gZldXpXFgrlcVm0OU/4AMgGW9ytLhFM8H49kH5xtC+3o1rh8HTTa/oZiBWCEWfcRkKldtoMjfhL9yzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G/3br72e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6Wx48022925;
	Wed, 24 Apr 2024 08:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=teAhyNyCOAqaVQyQEZCfHHFPJ+raYnKY8VjTqlmb3dI=; b=G/
	3br72es78kZ3jpcSLGBHFk8XJ1fZGZcI+SR9KzgrJJXBiiNUmiBCcm9D6y70v1k7
	ThsBX18QAVfCcZ26sa9yJPlPf3prJZAS6W37TlOkxwwX3zHPIFrr3wvxSWrFQE9j
	JFmYixGIcIlbOsiZvkpdgKBuBmLUSuO1RfzrOiFsxInSjcj8KInwhjQ0xm7ySQPo
	XE4JorUToMCD1zWAYbbhNx8mn0jbCX4oYH9syh7HwCw7gViP9J02QB9HtSX2HXIB
	lxRhDAACjzz1C7+0p65wrxMlVHLiCob6FY450xXGHQXw9rTVXxAmRWuycpQOx3AT
	mtpj8VK9K115NCIwagkw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fg84p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:00:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O80C76000642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 08:00:12 GMT
Received: from [10.216.52.243] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 01:00:07 -0700
Message-ID: <7ea10ef9-04f0-4786-bd34-551c065c4d9d@quicinc.com>
Date: Wed, 24 Apr 2024 13:30:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Remove CTS/RTS configuration
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss
	<luca.weiss@fairphone.com>,
        <cros-qcom-dts-watchers@chromium.org>, <andersson@kernel.org>,
        <swboyd@chromium.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rajpat@codeaurora.org>, <mka@chromium.org>, <rojay@codeaurora.org>
CC: <quic_msavaliy@quicinc.com>, <quic_anupkulk@quicinc.com>
References: <20240416105650.2626-1-quic_vdadhani@quicinc.com>
 <D0LINETM8WNA.27BORT75W1N0C@fairphone.com>
 <886befb2-2be2-4db0-b205-b3d1043cde62@linaro.org>
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <886befb2-2be2-4db0-b205-b3d1043cde62@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tn_AaSAN9zlOxOZVeDqfVPfjplIE5921
X-Proofpoint-ORIG-GUID: Tn_AaSAN9zlOxOZVeDqfVPfjplIE5921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_05,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=859 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240034



On 4/16/2024 8:09 PM, Konrad Dybcio wrote:
> 
> 
> On 4/16/24 13:38, Luca Weiss wrote:
>> On Tue Apr 16, 2024 at 12:56 PM CEST, Viken Dadhaniya wrote:
>>> Remove CTS and RTS pinctrl configuration for UART5 node as
>>> it's designed for debug UART for all the board variants of the
>>> sc7280 chipset.
>>>
>>> Also change compatible string to debug UART.
>>
>> This change has little to do with the SoC design though and is dependent
>> on the usage on a given board, right? Also the QCM6490 datasheet
>> mentions gpio21 & gpio22 can be used for UART_CTS and UART_RFR.
> 
> Yeah, using it as a debug uart doesn't rule out flow control I don't think
> 
>>
>> But at least consistency-wise this change makes sense, in practically
>> all other SoCs one UART is marked as geni-debug-uart.
>>
>> But with this patch you should then also remove some overrides that are
>> placed in various boards already?
>>
>> arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts:     compatible = 
>> "qcom,geni-debug-uart";
>> arch/arm64/boot/dts/qcom/qcm6490-idp.dts:       compatible = 
>> "qcom,geni-debug-uart";
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts:   compatible = 
>> "qcom,geni-debug-uart";
>> arch/arm64/boot/dts/qcom/sc7280-idp.dtsi:       compatible = 
>> "qcom,geni-debug-uart";
>> arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi:     compatible = 
>> "qcom,geni-debug-uart";
> 
> Definitely

Updated in V2.

> 
> Konrad

