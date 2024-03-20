Return-Path: <linux-kernel+bounces-109207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2288162D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958FD283CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11226A01C;
	Wed, 20 Mar 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eeIBqa5g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CA524B7;
	Wed, 20 Mar 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954662; cv=none; b=IrjADqT8QvBL4ZPtRB4dqoREA8b1lppvrAYT6hjGcrR9jXb3Lh4Gjz1baUllXgAEIfPAkihvNAXoRhVBfbG72oern2Tz88WS0mF+hFR5NyAzh9kEutTwa8giE5k4ZMMeu2ZABaRu+FTjuMlNvC2ap5Cfawk9NOSAv35hn8/8Fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954662; c=relaxed/simple;
	bh=758yDZKiS5NaJTvUE6Sej2pKrpl0pDcf5eSdOjc74PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uYzipQEaRV46bQQcBSZAWx1WbvWpXdL/RDoiqKcni4dzzv6KzU86odSTUyPMyN4plLOMfjIBlR77rc2OLq8S96dd+FIdncm69KXmjeDA3wWDH4wjB+8AySbd8hmxMO6JF9/TVLFWCm9YBSeHxvr4pBWpEuUkDS8gcJOAH+ttWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eeIBqa5g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KF9oON020300;
	Wed, 20 Mar 2024 17:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pdLpiI9b9nBDFs8TZQQCkNJrT1iuZX4mOpgogUQwDa4=; b=ee
	IBqa5gt3CDUQD4L6h3OxM9qzj1tIrmPABt4vyilW07MqULeNd5jerOKPQX2wyVEM
	Or8I2PM+qDdYMBDAVGpLNv4PMwKG71Lkc11hxbjOf3FN14VkxxnayE9A6dpjYWbK
	UtRNb9YqXZ8xDyc9QqB6jRfXNqdmkrJzh/99ms8m9VJlUeYcgxg69AV7mBDtHmzR
	jxoib4ze/4irUt6XQ7qoa57E7DekYMHWZ0Lb0lVQYrOrhxnRKky3s7Grz982dO0W
	9U9vgTUYbWuxPFTRCNIQ/MnIc4bWaIkurJBdaDVAcAEU483VNz4EfkkMdEMrmW8Q
	NKOGqkZ0Q0lpsi3Xu0Xw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01br8ey9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:10:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHAcR3001806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:10:38 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:10:38 -0700
Message-ID: <6ddf112f-29d7-42b6-8d80-b8ed8fd987ba@quicinc.com>
Date: Wed, 20 Mar 2024 10:10:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wireless: ti: Can we just remove this flexible array?
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>,
        Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
 <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
 <483362b8-ea79-4036-89eb-d6ab737e1e96@embeddedor.com>
 <e7204512f71e9232572fced208899f7b6baa920d.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e7204512f71e9232572fced208899f7b6baa920d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VBF4b4NDxXiCL6u_BdQoatlKZFDHzLP3
X-Proofpoint-ORIG-GUID: VBF4b4NDxXiCL6u_BdQoatlKZFDHzLP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=371 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200138

On 3/20/2024 2:03 AM, Johannes Berg wrote:
> On Tue, 2024-03-19 at 18:42 -0600, Gustavo A. R. Silva wrote:
>>
>>>> -       /* payload */
>>>> -       u8 data[];
>>>>    } __packed;
>>>
> 
> Why not keep (or even add in the cases where it's not) the comment
> though?

For something called <foo>_header isn't it implicit that something will
probably follow?


