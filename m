Return-Path: <linux-kernel+bounces-139901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF98A08F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D1E285BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6013DDC6;
	Thu, 11 Apr 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iHG3m7pr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9713D622;
	Thu, 11 Apr 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818713; cv=none; b=Aqfz92tuDp6WkuyJOdnKoAZ83Vhaw1xHznMHhnmTABgSaSH5Z38esy1yhfOGoifyxjfQqJwBEVtGjJzR7Rd8hd5QyCcKJyP6hekmkjLKIuAGEV+n+Jlrtn9caLeKZmQfX10NDEsVG19V4Yj6yC1nZD0yCIVLs6x6Qqsc6zFHdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818713; c=relaxed/simple;
	bh=kzfkR7Nf9Px5mfhdw6SO9VUjHqXz5tShkGg2fEBVLCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ibOGnDbIwNeObixt9RMrtPMGsJAXbGHC96r4Iak+bHeonYoNOjdCalmRd0lG2/Z/84IMr3JUV37/9B92gTvNF2otFoEt7UbalTP8QbtRIyxkHaLJWiK3wQbyzpRnDxJ3w4xHVvzUjwB/rjAwv1Rjeu9c7DCvG5yhIyCI99YQQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iHG3m7pr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B5CP3m030910;
	Thu, 11 Apr 2024 06:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HznUP1GEpxyDEujedrVeW8QT40sNoRwnMZ5vjMKDYxI=; b=iH
	G3m7prKdg1YHci8A8iJMAM2rsYfhG9MxFyKP0amMdBPY6TOIzxSd7axUEi2p1Axt
	ZPS86bbVHGmOlyDbdnvUfEgCc7wwhE+q2IMW3/fP4tHma6nvi5B2+Tui+k/2j4EO
	DJwo1jMT9fWO4dOhvHHcri/woRLVu5+FD3eNFjgghu+BytkZohOShjT874UpVudC
	AxkNALTkSkZCo1Q1bW6iK1iFIShfGZlyc2NjoHbN9cDc0IYy6Q6E4ih/qvZ9xdA0
	YKWr5Q8ZjoyzPZDthJbxAiRaoD0EXeAVZXpX3ifJV5lf+hKfkqr/jF3VyxzDVUKh
	hh5n5JhRkK34ywiWGXUA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdquhvsem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:58:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43B6wP3L022483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:58:25 GMT
Received: from [10.253.12.44] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 23:58:20 -0700
Message-ID: <229fb5b2-34c9-402b-9812-f91e6cc31c57@quicinc.com>
Date: Thu, 11 Apr 2024 14:58:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] input: pm8xxx-vibrator: add new SPMI vibrator
 support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <kernel@quicinc.com>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240401-pm8xxx-vibrator-new-design-v8-0-6f2b8b03b4c7@quicinc.com>
 <20240401-pm8xxx-vibrator-new-design-v8-3-6f2b8b03b4c7@quicinc.com>
 <3f8c970c-6a0d-4fc3-a2d3-e0797e7055cf@linaro.org>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <3f8c970c-6a0d-4fc3-a2d3-e0797e7055cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3rYAA5HCMwsUzQ4-R7R_mCoI_ADh6Or3
X-Proofpoint-GUID: 3rYAA5HCMwsUzQ4-R7R_mCoI_ADh6Or3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=685
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110048

Hi Konrad,

On 4/11/2024 2:10 AM, Konrad Dybcio wrote:
> 
> 
>> +    if (regs->drv2_mask) {
>> +        if (on)
>> +            val = (vib->level << regs->drv2_shift) & regs->drv2_mask;
>> +        else
>> +            val = 0;
>> +        rc = regmap_write(vib->regmap, vib->drv2_addr, val);
> 
> Are you purposefuly zeroing out the other bits?
> 
> If yes, consider regmap_write_bits here
> If not, consider regmap_update_bits here
> 
>> +        if (rc < 0)
>> +            return rc;
> 
> Ignore regmap_r/w errors, these mean a complete failure of the API and
> we don't generally assume MMIO accesses can fail
> 
> Unless SPMI is known to have issues here
> 
Sorry, forgot to reply on this comment. Yes, SPMI transaction would fail 
(even with very low odds) on some boards if the layout of SPMI lines is 
not good enough. I'd like to keep the consistence since the whole driver 
also checks the regmap_r/w errors.



