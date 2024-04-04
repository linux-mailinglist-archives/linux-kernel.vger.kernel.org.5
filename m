Return-Path: <linux-kernel+bounces-131002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59228981D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A99B28A81D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973DD55787;
	Thu,  4 Apr 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0rvSDcj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BB5479F;
	Thu,  4 Apr 2024 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214286; cv=none; b=R1OwidE7c7I6qcVFpCJWXuFp6hQSJpi8Cp2Ha9uI8JAO15M0FnjbDPzCtP1VoHh6xluyrET3+ZAqm5ft8Z5Dli1xPXRX1KL/AOCBoF/fndoxvYauBWe1abSq+6WpJfv6coPsYpExHqv2V4397CZTxW3O8LAimFRxFRfyKp0NqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214286; c=relaxed/simple;
	bh=Q8N83sEi5aysHaZb/xULFQFdwNCBz4B8WWpJwY6CoPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DKx/0BPtpZegmga/Hvqc1xwZH9xCDZzHU/4Nf7UG3PK7cP1c6RBSRuKlM9Zf5p71l4s/pQ987u6Qk8yFkDL+7UaKi3JVDXz53usNR+o09O1d+W3+ZiwxuZMHuwKAJREbQZJ3M77FzJIQXDmUP8kGBacMp6W5Ah7ggyxMr6KoqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0rvSDcj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4345N8M5013269;
	Thu, 4 Apr 2024 07:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=euasKFBMpnBl+higS5rxjxIYAk6jU33mlu6mDelQBvE=; b=C0
	rvSDcjyGfXF3NIoXzyP109TmuOXbmXz7yF7jYxXD8oGESnS8MC9BEFSq1vdATZJb
	+OAsQolGRN3Mzp0s9fuwaBgPvY/2UNIDQI89VpsPJPcI7fO7GHInKUgJPCVktahq
	UNPA7pK7NKON48PvbjzmWpuldV0INbp0WuN1OSDgXTbe+hbIX2kWTREJS8DZAfUZ
	36/NUq5KlfqT46x1gFkLSmPAOIzCGzZokB9SwdKedxUBCFT49Gua7R3Sbtl+Xmng
	bKQtUwa8Lrr9d2ICDRXNRq2YVpZPFn2B5fTuZAYGrWlzZNHFXLsZI714hPfoQezS
	WDciGbu4fj+va2z7U+iQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9eph8sj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 07:04:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43474duD023310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 07:04:39 GMT
Received: from [10.218.10.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 00:04:34 -0700
Message-ID: <7fd8c4ab-22a2-2d0c-2257-14441ae79c29@quicinc.com>
Date: Thu, 4 Apr 2024 12:34:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/7] dt-bindings: clock: qcom: Add DISPCC clocks for
 SM4450
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-3-quic_ajipan@quicinc.com>
 <d020d14a-6f57-4283-ab71-293f1d9a9cc9@linaro.org>
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <d020d14a-6f57-4283-ab71-293f1d9a9cc9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oukr3H6ohs_ZSi4B6sbxB-AYzoBb_50o
X-Proofpoint-ORIG-GUID: oukr3H6ohs_ZSi4B6sbxB-AYzoBb_50o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040045



On 3/31/2024 1:47 PM, Krzysztof Kozlowski wrote:
> On 30/03/2024 19:28, Ajit Pandey wrote:
>> Add support for qcom display clock controller bindings
>> for SM4450 platform.
> 
> You cannot add support for a binding. Either you add a binding or not.
> Please look at git history for inspiration.
> 
Thanks, will update commit msg in next series
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> 
> 
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Board active XO source
>> +      - description: Display AHB clock source from GCC
>> +      - description: sleep clock source
>> +      - description: Byte clock from DSI PHY0
>> +      - description: Pixel clock from DSI PHY0
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  '#power-domain-cells':
>> +    const: 1
> 
> No power-domain? This looks incomplete.
> 
> Best regards,
> Krzysztof
> 

SM4450 doesn't support MMCX hence power-domain isn't required
-- 
Thanks, and Regards
Ajit

