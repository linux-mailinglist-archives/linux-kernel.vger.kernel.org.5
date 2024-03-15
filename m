Return-Path: <linux-kernel+bounces-104463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C787CE39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F861F22A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6782C840;
	Fri, 15 Mar 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yw5zsOUi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4924A13
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510409; cv=none; b=fHi0RTCj9WTTaLKLOhjGLgjBnGWTrned9XtzVXLBQgCFfeFh1UDoyq2HDHmO9lhEptSuHcZUq4BQ0TC19NaYFcMxIKs2x3IjYX3nEkikmmK+Jv5HR2cKhJ7/SmBc+Q8nEGDBMEHUNsABE2TC3Ad+XL01QKO6FT4DAP5ZIf3gMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510409; c=relaxed/simple;
	bh=lIGlMjhgxBjOwoWLX8az0IX/MdQTbDSwBtsS4amvf9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WASg3DKCaAhM4FVSMrWpsadhf8zNPYLD6ghTcaq9QglFwIC0rTby1xa4j4KVpc4wJyWQW880HJZhBMHBFOac3AhcwQwE0TBeBvxAxu26hhKPjjusGXUYfoovI+BtXiHpgSixSRFaGVh/PNQBDZSAeqaz1guhHt1BzB98L9C9SlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yw5zsOUi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FDkUvg020529;
	Fri, 15 Mar 2024 13:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=e+IGmJBXKrtrKOajkQ3GI6SOU3R9/vNYo9L9+B2UR3Y=; b=Yw
	5zsOUiccSnMwdnSIM3imRPfxlL31npZY8vGi3zhnOHmU5j2AgbeA4NuEc3LqftGW
	KKHpYqAKs0j3YFyODKPtjuFViOFTSvnFymCHJoZcN+fYnFThT+ciZ8nNzkegShqb
	zhxUJt/EumTCOhFzdETSnFH9w1kprjT4jwy8leQDUbPJTv8QH4ZHNbc3F97QM1T5
	i8Z5VMPoJVCPDWLjii6Q6qzdqfrKLxJWpLYq8cH8OVHs0ggGgG6AL7fjrjrks/8b
	w2wyTVNliUlCUvMiL4/YeEJiORKcJ8BqN9JyTmTiqSk6uIs/jD/QPx3+MagoAudu
	zvOO0htbDL+PhzEEoamQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wva0819h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:46:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42FDkTEO000380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:46:29 GMT
Received: from [10.216.5.181] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Mar
 2024 06:46:11 -0700
Message-ID: <df221ae0-bfce-45dd-a6a4-486f3b3b3a77@quicinc.com>
Date: Fri, 15 Mar 2024 19:16:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i3c: master: Enable runtime PM for master controller
Content-Language: en-US
To: Joshua Yeong <joshua.yeong@starfivetech.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andersson@kernel.org" <andersson@kernel.org>,
        "vkoul@kernel.org"
	<vkoul@kernel.org>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>
References: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
 <b61f5f4a-7931-411d-9519-bbff1b7fd6f9@quicinc.com>
 <SH0PR01MB08419B8683E8F2DD05A791BBF928A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <SH0PR01MB08419B8683E8F2DD05A791BBF928A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _cKrxSJkhZOQC5FkGkc0nQ6UWTjTweX_
X-Proofpoint-GUID: _cKrxSJkhZOQC5FkGkc0nQ6UWTjTweX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403150110

Hi Joshua,

On 3/15/2024 1:35 PM, Joshua Yeong wrote:
> 
> 
>> -----Original Message-----
>> From: linux-i3c <linux-i3c-bounces@lists.infradead.org> On Behalf Of Mukesh
>> Kumar Savaliya
>> Sent: Monday, March 11, 2024 1:30 AM
>> To: alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Cc: andersson@kernel.org; vkoul@kernel.org;
>> manivannan.sadhasivam@linaro.org
>> Subject: Re: [PATCH v1] i3c: master: Enable runtime PM for master controller
>>
>> A Gentle reminder ! As i was not part of the linux-i3c group before raising this
>> gerrit, might not went into right folder.
>>
>> On 2/28/2024 3:04 PM, Mukesh Kumar Savaliya wrote:
>>> Enable runtime PM for i3c master node during master registration time.
>>>
>>> Sometimes i3c client device driver may want to control the PM of the
>>> parent (master) to perform the transactions and save the power in an
>>> efficient way by controlling the session. Hence device can call PM
>>> APIs by passing the parent node.
>>>
>>> Here, I3C target device when calls pm_runtime_get_sync(dev->parent)
>>> couldn't invoke master drivers runtime PM callback registered by the
>>> master driver because parent's PM status was disabled in the Master
>>> node.
>>>
>>> Also call pm_runtime_no_callbacks() and pm_suspend_ignore_children()
>>> for the master node to not have any callback addition and ignore the
>>> children to have runtime PM work just locally in the driver. This
>>> should be generic and common change for all i3c devices and should not
>>> have any other impact.
>>>
>>> With these changes, I3C client device works and able to invoke master
>>> driver registered runtime PM callbacks.
>>>
>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>> ---
>>>    drivers/i3c/master.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c index
>>> 3afa530c5e32..a3dc88974f92 100644
>>> --- a/drivers/i3c/master.c
>>> +++ b/drivers/i3c/master.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/kernel.h>
>>>    #include <linux/list.h>
>>>    #include <linux/of.h>
>>> +#include <linux/pm_runtime.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/spinlock.h>
>>>    #include <linux/workqueue.h>
>>> @@ -2812,6 +2813,10 @@ int i3c_master_register(struct
>>> i3c_master_controller *master,
>>>
>>>    	i3c_bus_notify(i3cbus, I3C_NOTIFY_BUS_ADD);
>>>
>>> +	pm_runtime_no_callbacks(&master->dev);
>>> +	pm_suspend_ignore_children(&master->dev, true);
>>> +	pm_runtime_enable(&master->dev);
>>> +
> 
> Will runtime pm impact on ibi request from target?
Don't think so. This change just enables target device driver to call PM 
apis and control the transfers under RT resume and RT suspend.
IBI comes asynchronously to the master driver and it should get handled 
accordingly. .
> 
>>>    	/*
>>>    	 * We're done initializing the bus and the controller, we can now
>>>    	 * register I3C devices discovered during the initial DAA.
>>> @@ -2849,6 +2854,7 @@ void i3c_master_unregister(struct
>> i3c_master_controller *master)
>>>    	i3c_master_i2c_adapter_cleanup(master);
>>>    	i3c_master_unregister_i3c_devs(master);
>>>    	i3c_master_bus_cleanup(master);
>>> +	pm_runtime_disable(&master->dev);
>>>    	device_unregister(&master->dev);
>>>    }
>>>    EXPORT_SYMBOL_GPL(i3c_master_unregister);
>>
>> --
>> linux-i3c mailing list
>> linux-i3c@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-i3c

