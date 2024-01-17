Return-Path: <linux-kernel+bounces-28970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A4830572
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EB91F24FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B51DA46;
	Wed, 17 Jan 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X9rOO0Dw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86B6FBD;
	Wed, 17 Jan 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495013; cv=none; b=FkQ9g5kVqF8VPE1FFPbPGOh5YSN9enwi2hvZGQu02rRrvxKf40Ba7zv+UPPHKvZFRo/315lVjCqk+mF8ZDfZrpHdZs/Kvp51DAsVP1ArvP0KpbWHt7btUeDsxtOnfy1QPdzx+q/LtPyso30pcdb7chpdFKZeatkCG8RhZ4xwe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495013; c=relaxed/simple;
	bh=fhujXRioKysw0DqUGzrr93/167EZIM/mT33JCqKZRyE=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=ByN0h2g8YwTN46XaFPg9WM9XoE0USy8yfFgSYdtsawbGqePv4jAyvzAcvArIxVAkDkz7j7iKn7PjEEXsAcZSmmoCW3TeXeig945Igm1gOonQYrbqJghUduHc4wv5Rccg7bV8CbDzQb70si/hRAQhf8zG/hC+2XorgUBhyZiULJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X9rOO0Dw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HBjLgr022448;
	Wed, 17 Jan 2024 12:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z9yeJS2H66rNJ6UbZFMylMLt8iLZni9SyT4hwIrN224=; b=X9
	rOO0DwQjLaT5HcLZvuJ2+Tj6FE5i1V9oXy23Wbsmaj1qAyihhhWzHIF5xyL3JvDz
	gkY7Y9T9Xrd00XA+wVlUI7juunfaFcXTEkxJrxChG5V0FKcI2FIPT0nXKO4Ves2f
	OF1X3AajiLeEMn3dPmUtpOESrJkF/DmL9zLoS4+9g2kHN5aHfrgGSCAZ10YIeG3T
	coFnKxJpJ+1Tvfu8T753drZo1eh91vm+XKs4pv6EBswlSkJbhItxTq/XK6NHXU9c
	5/JtTe0rJO9FLMZdF9FK1fcjmJSsT+CzwKSDMnQoRfYV3qae/ByLq1f8juy4V2R4
	wAR7bScZFv+9UxrI5Ybw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp83frvcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 12:36:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HCaHBq001881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 12:36:17 GMT
Received: from [10.216.41.142] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 04:36:09 -0800
Message-ID: <510441c7-5a64-aaee-cafc-69bef2570da5@quicinc.com>
Date: Wed, 17 Jan 2024 18:05:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 06/12] soc: qcom: Add Qualcomm APSS minidump kernel
 driver
To: Randy Dunlap <rdunlap@infradead.org>, <corbet@lwn.net>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
 <20240109153200.12848-7-quic_mojha@quicinc.com>
 <63d9d1b9-6c2a-4d8a-9bf6-9973d76ae97d@infradead.org>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <63d9d1b9-6c2a-4d8a-9bf6-9973d76ae97d@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: khuxKn-8GGQFX7vV8u7c7ahHqsaWoCTA
X-Proofpoint-GUID: khuxKn-8GGQFX7vV8u7c7ahHqsaWoCTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170089

Thanks for review.

On 1/10/2024 3:48 AM, Randy Dunlap wrote:
> Hi--
> 
> On 1/9/24 07:31, Mukesh Ojha wrote:
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 1f81746131fc..56bc0c8a19f9 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -278,4 +278,17 @@ config QCOM_RPROC_MINIDUMP
>>   	  query predefined minidump segments associated with the remote processor
>>   	  and check its validity and end up collecting the dump on remote processor
>>   	  crash during its recovery.
>> +
>> +config QCOM_MINIDUMP
>> +	tristate "QCOM APSS Minidump driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on QCOM_SMEM
>> +	help
>> +	  This config enables linux core infrastructure for Application
> 
> 	                      Linux
> same as 2 lines below.
> 
>> +	  processor subsystem (APSS) minidump collection i.e, it enables
> 
> 	                                      collection, i.e., it enables
> 
>> +	  Linux clients drivers to register their internal data structures
> 
> 	        client drivers
> 
>> +	  and debug messages as part of the apss minidump table and when
> 
> 	                                    APSS
> as above and in Subject.
> 
>> +	  the SoC is crashed, these selective regions will be dumped
> 
> 	          has
> 
>> +	  instead of the entire DDR dump. This saves significant amount
> 
> 	                                  This saves a significant amount
> 
> Does it have to be DDR?

Noted, all the above points, Yes DDR, I should perhaps use RAM like i
did it in the Doc.

-Mukesh

> 
> 
>> +	  of time and/or storage space.
>>   endmenu
> 

