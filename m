Return-Path: <linux-kernel+bounces-124173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88215891364
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C7AB2310A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A43D3AC;
	Fri, 29 Mar 2024 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xu5IY2V3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C983BBFD;
	Fri, 29 Mar 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691320; cv=none; b=PF4sZhhARuqVFfdWJYpeV3j2ijKdNB7pURSAlCR5DC40L8tEuXLAJNlmw8e7ToKgKV2XUIvkl6TT7M5akZSnNGps8ucEPOL4YCoD/vtxivl5FkR5zflu8QkHOIs8lb1e3bm3wwklOgnRqn5YBkWZtVLdnb+H0seoEqh+rbWcMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691320; c=relaxed/simple;
	bh=qvcY6w0n6m27gqcAzYeE6OlzeN+znnWVJJsgLbLsT/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hlJn9tkbSUGN5+lethzGIIjACyBBVwKXsTUk7znq4iKpcvyTkXcKIVOG0o5rGKqwfbiEatKl9tUoLe/d1c9kIQqsvO4UkcTz+A4K6I1DBsG1ck/oQo5LUarzJq2UbSVKOH97ZPoGaZ0AnlGp+SZXgOJZO4GyGL6he5AKNzADFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xu5IY2V3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T51Uwt019330;
	Fri, 29 Mar 2024 05:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JXKIUdVUxa4Tbw/Vyh4B+9mxuatZC7Y14h4N11zw6Fo=; b=Xu
	5IY2V3xHsf1hih1amUl9ZXnZTyB0m+RNAYaHfUBfS7x4qTlZZfplbARHKuK9iVI4
	SWKeoMx2QG/Zz1WEETCmKaawa83yf6t4JL0U6m2xXrATjmqwiF0gU/4033WZ1vR0
	KZESPX/mee9WkNvatDp7em2WXbwx7aosGKu1shb/U1jBqtD4ncNPNw2s8L4p6c4p
	WMVlQQza1/PqRVFiXu82Dc0iiGJhIZ5VuhE6hv7NpqWViNv6Q59xeFmACo16ZM5x
	t9yqLd35aBFB6EAKtGapq34DiozZbxhrDFQ6zlOIxshbx/8L6dNJOJmp/FKnJJGm
	wAIxk/faNCjQe/s36nrw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x575maf28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:48:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T5mXh0030504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:48:33 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 22:48:28 -0700
Message-ID: <9bdee018-8439-42ab-057a-f3241a66f09d@quicinc.com>
Date: Fri, 29 Mar 2024 11:18:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] clk: qcom: gcc-sm8150: De-register
 gcc_cpuss_ahb_clk_src
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240213-gcc-ao-support-v2-1-fd2127e8d8f4@quicinc.com>
 <39b26447-80c2-4d71-b859-32b4a40cb31d@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <39b26447-80c2-4d71-b859-32b4a40cb31d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qc2vGYnsGXSOBRJZgUWG9GW3_CnPbO86
X-Proofpoint-GUID: Qc2vGYnsGXSOBRJZgUWG9GW3_CnPbO86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_04,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290046


On 3/28/2024 3:05 AM, Konrad Dybcio wrote:
> On 13.02.2024 7:47 AM, Satya Priya Kakitapalli wrote:
>> De-register the gcc_cpuss_ahb_clk_src and its branch clocks
>> as there is no rate setting happening on them.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>> Remove gcc_cpuss_ahb_clk_src and its branch clocks.
>> ---
>> Changes in v2:
>> - As per Konrad's comments, de-register the gcc_cpuss_ahb_clk_src
>>    instead of adding AO support as no rate-setting is happening on it.
>> - Link to v1: https://lore.kernel.org/r/20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com
>> ---
> Could you please confirm that this clock is governed by something external
> like RPMh and needs no input whatshowever from HLOS?


Yes, this clock is configured to a certain frequency and controlled from 
boot loader and runs at the same frequency always. There is no use case 
in HLOS which modifies this rate, hence removing the modelling doesn't 
cause any issue.


> Konrad

