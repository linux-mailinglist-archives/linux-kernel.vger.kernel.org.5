Return-Path: <linux-kernel+bounces-89207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9586EC05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C80A286AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93685EE6F;
	Fri,  1 Mar 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pLpxeHY2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFE59153;
	Fri,  1 Mar 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333294; cv=none; b=AlWn9mZW8SX8a4hScrKtxMaMyn4YQO6ar6x01rST0CuRbi6Twh5kWzgPW+hWKFrl5IVU/MuevSW2EypjhlofDGdZFUbMY+ATRkUNL4wM8SnWwXhr0bUWpvtrbIu+gqKydYIK8JohvCdsnr7MgALXUfjGSp+B9HSv0H4HbI5YEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333294; c=relaxed/simple;
	bh=8odwCgk7CbX2gctz1vPXXNFyNOwD1JQX6J9mRg+tmcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K5qH0IY4w8whQ6Ap+DbAid3zQPbcPNTWJOvfyLr4Q9yenaQW37onkglSSuGckKMnXSnOr3HAthnfwH/+SMo/jR1q8Kj+1EyH6uplNyPlnMEwud0oAiMOIIVJmbJaKOHCuRPMuRNxsIeaU5uHOLqo7S6P04p+b47G8vyEuA6PlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pLpxeHY2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421McPGS029083;
	Fri, 1 Mar 2024 22:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hC9XfH14jR/Jjd0ksk05wyObel9iSA8jmEXEdQ3SeWE=; b=pL
	pxeHY2GgPUJ8Ecncmh5a0IynTeBsOcyBWcJ1d2ytFVhc3Y5sd6r0M77HKNY20oJQ
	5Eiimqu3c42txaPm0dwdhMrAY5x5WgUHuOamwCgGUhove65s4ImVWb1Xn+y5KLSr
	9oyL2X+j/VyNMzOueJcAaVzE/p4+loiagRkLwYKGwxlJksbvhhMxxurB6q8fye09
	ABdksJyDOlQE1nm9UTlvtpyTs5r94T9oxCWXLLrc6k0LUW0t8C/uSJTb0ozXjgBS
	0p1QnFkvtBuusTFIpM25y+aXNtby5ceypTQh6A5kP8G9eGjUCpX6QDfITjxIcTnJ
	yTmb/mcTgNKKCi6/dgjg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkqx880jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 22:48:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421Mm57t013246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 22:48:05 GMT
Received: from [10.110.118.13] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 14:48:04 -0800
Message-ID: <44f00418-b09b-5ee5-c70c-d4580ffd0049@quicinc.com>
Date: Fri, 1 Mar 2024 14:47:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] usb: dwc3: core: Add DWC31 version 2.00a controller
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <Thinh.Nguyen@synopsys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20240301213554.7850-1-quic_wcheng@quicinc.com>
 <2024030121-unfold-murky-aae1@gregkh>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <2024030121-unfold-murky-aae1@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y7AeXh1rH5g_v7u71miYFrOpq6enyo0k
X-Proofpoint-GUID: y7AeXh1rH5g_v7u71miYFrOpq6enyo0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010188

Hi Greg,

On 3/1/2024 1:45 PM, Greg KH wrote:
> On Fri, Mar 01, 2024 at 01:35:54PM -0800, Wesley Cheng wrote:
>> Add revision value for identifying DWC31 version 2.00a based controllers.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index df544ec730d2..f3bbbc1947bd 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1259,6 +1259,7 @@ struct dwc3 {
>>   #define DWC31_REVISION_170A	0x3137302a
>>   #define DWC31_REVISION_180A	0x3138302a
>>   #define DWC31_REVISION_190A	0x3139302a
>> +#define DWC31_REVISION_200A	0x3230302a
> 
> What code uses this define?
> 

Don't think there is anything within the DWC3 core that would be 
different specifically for 2.00a versus previous revisions. (so far)

> Why add a define that is not used?
> 

There is a running list of all the DWC3 revisions.  Not all of them are 
being used, so my understanding was that we're just keeping track of all 
possible version values that can be read from the DWC3 version HW 
register.  If this is the not the case, maybe we can just leave this out 
until we find a need to add it.

Thanks
Wesley Cheng

