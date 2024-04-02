Return-Path: <linux-kernel+bounces-128585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07ED895CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5CF1F21EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0A15B978;
	Tue,  2 Apr 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cKm8hf0m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CE15D5CA;
	Tue,  2 Apr 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086532; cv=none; b=NjCy8Ja9n01UkOEwFiFuq6yituwZhNH79QuYLwZ9/FEISi+u1L8Tl9iLHdlqjsJ6FOl8YvAEJRWJSxsg/l04qfl8wytxDxcNOlnF3q/bevqvhNB0EW4QVEBEj8yvA8OvDHVp6+7lNPEb+aTZfDbw2ZanZ7ATFLRECTmO9IKYwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086532; c=relaxed/simple;
	bh=ztl3jzpEH+oOBeEaIlj9fwEFVjcmkBTvpm6G6RzO3KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NHJth0OsFix1WHq7FPpiyNxgKTD9Q1XWfhnAbilYbyLOzIspZRuqDkqQyx6sgnCZtUtI2q36yL64IKVNtvvDg6sI2eVxq21QRkjGLecbczQiMiBlXCFjGU0RYoM160bpEjv97rygFhVe8v7al0E7kPLlGD9MYFlHNOqbwVGI6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cKm8hf0m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432IiAWb030990;
	Tue, 2 Apr 2024 19:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vYbnRItG2WvNQmUFuvUHXC0F8bQ8viqKAjt1DyD1iHU=; b=cK
	m8hf0m3FGfzqZswvVfnhXju51poeLVW5oe+dQQUkp9dAMwYsCO0EUoHhW48zH0oy
	gh9WCfEErlpNZBovYGY22KKjdjT9htmAI3tJ2Jcj4zMo9ctmY89lUkAVcQQ0QXc3
	3r8g8fF1YO/9XuumsiY0lai9gF/dFkKhNCe8laiP4NL05w5DnO+2d08kytprI8np
	z5hxEHpNmAAxqMVrdcKhPULJQgUzZKF7twtgfZ89PBkJ2INopZxFgHOrK7qosJsr
	F/1TpyEymZpY1Q99JpCYIpIV8ivONEQRuTdearYVjp27E0I+pk6ivaeAOndMngQP
	vmOeUWIL4Bx4mQrRzYjw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ny5gbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 19:35:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432JZ16g023919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 19:35:01 GMT
Received: from [10.71.108.209] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 12:34:58 -0700
Message-ID: <13ccc36a-c3cc-469a-ae0b-71fd0d24bf63@quicinc.com>
Date: Tue, 2 Apr 2024 12:34:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
 <20240329-llcc-broadcast-and-v4-2-107c76fd8ceb@quicinc.com>
 <d6b0f9d2-a489-4c0e-9c77-0e3eab49d3cb@linaro.org>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <d6b0f9d2-a489-4c0e-9c77-0e3eab49d3cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tT-YTDRg7tlai5cMvSdx_e4WcX8vpmoG
X-Proofpoint-ORIG-GUID: tT-YTDRg7tlai5cMvSdx_e4WcX8vpmoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020145

On 3/30/2024 4:46 AM, Krzysztof Kozlowski wrote:
> On 29/03/2024 22:53, Unnathi Chalicheemala wrote:
>> Define new regmap structure for Broadcast_AND region and initialize
>> this regmap when HW block version is greater than 4.1, otherwise
>> initialize as a NULL pointer for backwards compatibility.
>>
> 
>> +	struct regmap *regmap;
>>  	u32 act_ctrl_reg;
>>  	u32 act_clear_reg;
>>  	u32 status_reg;
>> @@ -849,7 +850,8 @@ static int llcc_update_act_ctrl(u32 sid,
>>  		return ret;
>>  
>>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
>> -		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>> +		regmap = drv_data->bcast_and_regmap ?: drv_data->bcast_regmap;
>> +		ret = regmap_read_poll_timeout(regmap, status_reg,
>>  				      slice_status, (slice_status & ACT_COMPLETE),
>>  				      0, LLCC_STATUS_READ_DELAY);
>>  		if (ret)
>> @@ -1284,6 +1286,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>  
>>  	drv_data->version = version;
>>  
>> +	/* Applicable only when drv_data->version >= 4.1 */
>> +	drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
>> +	if (IS_ERR(drv_data->bcast_and_regmap)) {
> 
> I am pretty sure this breaks all users. Can you please explain how do
> you maintain ABI and that IS_ERR() is applied only for version >= 4.1?
> 
> Best regards,
> Krzysztof
> 
IS_ERR() check is done for all versions.
If new register isn't defined in DT(for version < 4.1) it simply sets bcast_and_regmap to NULL.
Otherwise, for version >= 4.1, it goes to err(in the case bcast_and_regmap isn't set properly).

Thank you for reviewing Krzysztof!   


