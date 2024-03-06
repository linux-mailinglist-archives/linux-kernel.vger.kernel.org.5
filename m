Return-Path: <linux-kernel+bounces-94207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86166873B55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5211F29431
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC19136662;
	Wed,  6 Mar 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dBfwpnqe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B0134403;
	Wed,  6 Mar 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740594; cv=none; b=lRAVOWgvARLrE7pAiZ+Xak0z0anBCPPVe7M5IWKTIiUbfBMEWa2s8FJjGDDIqrcOemrRuUHt6x//W5r0/THTXFQrT+Z15+ERh91OCOsUFZvi7q6LvdDy3svWkmvj5MqVXr9PZR8wMxDRiyyhKZ+6sumzLBhLCq7Y7BH9vOGcMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740594; c=relaxed/simple;
	bh=Oz32/wMDNQyZ+GUkfWFCbi2LxQFupaz1KvZmM94gXOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IXjPYZqClXtRRz8PTNBO0kqIW22K+pFRgtn3h3WRH5Vzzui94pH/KUSM4io0q/UYH/BJMFrfUyIdfvqxxceEIySInjsp5t0oqCLFih4D7ERUNEAUxVjjD5xGsBMASVVdQ8O2Dsck3EGGHYwU2zqXAnpRp9GNzKTRRkARdvWNMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dBfwpnqe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426EOGkS023083;
	Wed, 6 Mar 2024 15:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ckAyNtrP5c4f3cs2RoVpKPD8Gp7l9mit7Cq+JM89jOM=; b=dB
	fwpnqesnlFVMUVteGHjp5KaK3Zrkg/rc6lB4t+xBIcfO2Y/pnWHd4NU49X3OE9uk
	dtK0u8xDZHxmTzu0T4wCFJ0Iqh6Cy4LU7yTLHYXfbOzu85oQ/Lsmx1Bkd2caYIwt
	upNff4oqQyh2AoABRYw32m+Rc9/gB/HRBqZJjYN7Tf873h67slwWMIjlpgLugdnB
	2/JI/ycvZ2ZAaRznLscQ+e+A7fIwnpWcxMxwsBH3/3g1L8i+j5zvNcT+DesiEQ6e
	IDpFWP+o4JBFg4SIyPTR6CjfUUf0AM0YE/ANV+1fPTpoR6L3jHiNPxY6HTDyCjWM
	ZBQK1tDgk1AmvJJgrKvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3s619-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:54:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426Fsq4e011446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 15:54:52 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 07:54:51 -0800
Message-ID: <0b9923a3-e9d9-40ba-8acd-a916785df769@quicinc.com>
Date: Wed, 6 Mar 2024 07:54:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Content-Language: en-US
To: Rand Deeb <rand.sec96@gmail.com>, Michael Buesch <m@bues.ch>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kvalo@kernel.org>, <deeb.rand@confident.ru>,
        <lvc-project@linuxtesting.org>, <voskresenski.stanislav@confident.ru>,
        <khoroshilov@ispras.ru>
References: <20240306123028.164155-1-rand.sec96@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240306123028.164155-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qQz6YbctqTfkH_2NapHeEo43O1Xy55CE
X-Proofpoint-ORIG-GUID: qQz6YbctqTfkH_2NapHeEo43O1Xy55CE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=683
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060128

On 3/6/2024 4:30 AM, Rand Deeb wrote:
> The ssb_device_uevent function first attempts to convert the 'dev' pointer
> to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
> performing the NULL check, potentially leading to a NULL pointer
> dereference if 'dev' is NULL.
> 
> To fix this issue, this patch moves the NULL check before dereferencing the

see
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
do frotz", as if you are giving orders to the codebase to change its
behaviour."

so please use imperative mood: s/this patch moves/move/

> 'dev' pointer, ensuring that the pointer is valid before attempting to use
> it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>  drivers/ssb/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index b9934b9c2d70..070a99a4180c 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
>  
>  static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  {
> -	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
> +	const struct ssb_device *ssb_dev;
>  
>  	if (!dev)
>  		return -ENODEV;
>  
> +	ssb_dev = dev_to_ssb_dev(dev);
> +
>  	return add_uevent_var(env,
>  			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
>  			     ssb_dev->id.vendor, ssb_dev->id.coreid,


