Return-Path: <linux-kernel+bounces-75782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA985EEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C71B23545
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3E168BD;
	Thu, 22 Feb 2024 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANE5BU/y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEF1428E;
	Thu, 22 Feb 2024 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567554; cv=none; b=QjNFJbb3Ol2YZlnCy2bagkC3HYpon9bfVj1OFjayQOto7yZ2i2utzreeLSW75KToAVeNklwc14O0nFU2e5JQqvOJ/BCV0ByXuBGmWyMtkdGqQ7J3KI+Mw7dMbeKq5Myqm6qDdAmKOqcuAT1pJJsUMcPdJRnVCNNLD4DIzIg+sHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567554; c=relaxed/simple;
	bh=WQlrre1Af5DqGIugnUw+jmEueTMMr/mxLhUYg0DM6WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fzSPn4Mltfy4GHU7iGfvsbnjz2uYBvRQBwxrNVGl1vRQw4/qp7uuhlSWd8rfdMwZkGOm/TfjKy8svvinSFLsFUSaOnwHDNalABsLq0siLDx9584+Yww/LvTPChvAEQ9tqqXyVWGzBWuF2lccxzMzCMO3y3FBn+dHQC9j4oJR6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ANE5BU/y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M25IGx025387;
	Thu, 22 Feb 2024 02:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HoXQqCATqr7GEXryHy+jw904VeUxzRGQm/kjpO84j1M=; b=AN
	E5BU/yhJXaW8MSIfTTHiGlb6R1pErQRjpgopC4Yxamq4xGK/GRA6dWRqQBjaKYXF
	SKq0YGuxcW8PKAgo67NzR3dpqlWY3oN3OeV5EoJFfgjUeRsoNAGSjoTSMK942z9N
	eKbW3IfikF/197kCdq9IE/XUpjoLmnheAGQHxU+G410BSRU3v4ylDA0kKjh3pJ6n
	CLxTUabhdMtW6pwUV2tiaNp4qbIigw6vRsyALi6lJU49L9UKke8MccO6AdvBO4rC
	XA4wse66m5xTaSjyulD3BgyOLQkS35S9LB8LXIkzu0ghsy1Jm4lllzUcKJK7szHZ
	T18ao7zK5xUYV8z9aF6g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdgge1uea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:05:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M25ZDP016088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:05:35 GMT
Received: from [10.253.11.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 18:05:33 -0800
Message-ID: <cca63e1e-e16e-476c-b646-b6ff2cfb70a5@quicinc.com>
Date: Thu, 22 Feb 2024 10:05:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
To: Bart Van Assche <bvanassche@acm.org>, Rohit Ner <rohitner@google.com>,
        Bean Huo <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>
CC: Avri Altman <avri.altman@wdc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240220090805.2886914-1-rohitner@google.com>
 <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
 <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
 <0f959cca-ad29-4b8b-966d-55eb37156ef8@acm.org>
Content-Language: en-US
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <0f959cca-ad29-4b8b-966d-55eb37156ef8@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YmPo6bM0N78jZsWaMbNB5podNQkPmEvc
X-Proofpoint-ORIG-GUID: YmPo6bM0N78jZsWaMbNB5podNQkPmEvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_10,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=809
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220014



On 2/22/2024 1:55 AM, Bart Van Assche wrote:
> On 2/21/24 01:13, Can Guo wrote:
>> I am going to push some BUG fixes for Qualcomm UFSHCI MCQ engine, one 
>> of which would count on a vops in ufshcd_send_command(). My original 
>> plan was to add a new vops.mcq_setup_xfer_req() to differentiate from 
>> the existing one used in legacy mode. But if Rohit moves the existing 
>> .setup_xfer_req() up, I can use it instead of introducing the new one.
> 
> Hi Can,
> 
> If an if-statement can be avoided in the hot path by introducing a new
> callback pointer for MCQ code then I prefer the approach of introducing
> a new callback instead of moving the setup_xfer_req() call.

Hi Bart,

The if-statement you are mentioning here, is it the if (hba->vops && 
hba->vops->setup_xfer_req) or if (is_mcq_enabled(hba))?

Thanks,

Can Guo.

> 
> Thanks,
> 
> Bart.
> 

