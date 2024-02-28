Return-Path: <linux-kernel+bounces-84670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C9586A9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7271C22348
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75AF2C859;
	Wed, 28 Feb 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NG/D2gkU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427B2C6B9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108850; cv=none; b=ka6mKz0yF6OURZmqm6ozQYu7+EyWlHYYnS0FX20HsAmMIoYAVBDckNm4Vs+DLlkifJnz5f8mpWE7z1oe08bxI1E2wZtsq03O5eEFCmnju/0gAWhwL3ZvsfaGQrOLjpXLf72Pqj4mtFQxhTfxZXs6WMDPYSuwsQmuT1aZX76K42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108850; c=relaxed/simple;
	bh=I88DtZNi7pERfcMYlYxj3ugr4fGI2LFYnnSnecXE4Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ldEhKo5IDqedrTohvb1Mt7Smw4Y0DIL/RFAiFklzLfritRoG9wCygsGaJlziFRAD0OCEX0AjajnDmtshvpkFn1Lk9cqjTVaHER8CxqMLt+1ZTMK0xTXY3yfbr1dV2xloVdhaiCzk/J2yBCMnNViFPWhjsVINuMiLKQj73etKhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NG/D2gkU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S4twrA021683;
	Wed, 28 Feb 2024 08:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wsEWQ3QUsZVhNCo9dRnsW5c+SXw+Ssb7NEUatGHZr1E=; b=NG
	/D2gkUp8QlKzRMom6zUZtV+2rmAS6wkjF+M1zpwHJOdRyJ1rk2a2MonL1U/o2WO2
	ylmfg+ToR4mEgint8C9ADPry+LQb2c2QztXXEagaUWGQK2JLHhCXhU2HP/Ye2y5/
	be2rw4JjTEpWaMyqzj/Ssu1/j23cdt45UzQOQUXchoqTr6o5rtALdWjkINAhDvqb
	7V9s5zHtGa87yiN8eGdx5/mB62hr+uM/yYnYh7ZQ8BCBfKtz1a4IyH7UperLJgv+
	jn2NH57Z4RcKJoUiJKl6665jtxW0FiWIOWEOYO5XzXTAfffLQdMtqUTQkGESR6dx
	ktvRdz5HuW+hZSB3PMvQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whtbw8r94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 08:27:21 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S8QxO8010087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 08:26:59 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 00:26:57 -0800
Message-ID: <27b24aa4-f5d8-0936-051d-59f298da2315@quicinc.com>
Date: Wed, 28 Feb 2024 13:56:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] devcoredump: Add dev_coredump_timeout_set()
Content-Language: en-US
To: =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>
References: <20240227210008.182904-1-jose.souza@intel.com>
 <20240227210008.182904-2-jose.souza@intel.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240227210008.182904-2-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rCVqc3m1TCZ9raiuZE0_9veRAzXkZTVc
X-Proofpoint-ORIG-GUID: rCVqc3m1TCZ9raiuZE0_9veRAzXkZTVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280066



On 2/28/2024 2:30 AM, José Roberto de Souza wrote:
> Add function to set a custom coredump timeout.
> 
> Current 5-minute timeout may be too short for users to search and
> understand what needs to be done to capture coredump to report bugs.
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>   drivers/base/devcoredump.c  | 23 +++++++++++++++++++++++
>   include/linux/devcoredump.h |  6 ++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index e96427411b87c..2857ceb3eb3aa 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -326,6 +326,29 @@ void dev_coredump_put(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dev_coredump_put);
>   
> +/**
> + * dev_coredump_timeout_set - set coredump timeout
> + * @dev: the struct device for the crashed device
> + * @secs_timeout: new timeout in seconds
> + *
> + * If giving device has a coredump this sets a new timeout for coredump.
> + */
> +void dev_coredump_timeout_set(struct device *dev, unsigned long secs_timeout)
> +{
> +	struct device *existing;
> +	struct devcd_entry *devcd;
> +
> +	existing = class_find_device(&devcd_class, NULL, dev,
> +				     devcd_match_failing);
> +	if (!existing)
> +		return;
> +
> +	devcd = dev_to_devcd(existing);
> +	mod_delayed_work(system_wq, &devcd->del_wk, HZ * secs_timeout);
> +	put_device(existing);
> +}
> +EXPORT_SYMBOL_GPL(dev_coredump_timeout_set);

Why don't we provide a new exported function like [1] as calling
dev_coredumpm() and just another function to configure the timeout
does not look good.

[1]

dev_coredump_timeout(..., timeout);
  __dev_coredump_timeout(...);

dev_coredumpm(..)
  __dev_coredump_timeout(..., DEVCD_TIMEOUT);

dev_coredumpv()
  __dev_coredump_timeout(..., DEVCD_TIMEOUT);

dev_coredumpsg()
   __dev_coredump_timeout(..., DEVCD_TIMEOUT);

-Mukesh

> +
>   /**
>    * dev_coredumpm - create device coredump with read/free methods
>    * @dev: the struct device for the crashed device
> diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
> index c8f7eb6cc1915..70fe72a5c6d36 100644
> --- a/include/linux/devcoredump.h
> +++ b/include/linux/devcoredump.h
> @@ -65,6 +65,7 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>   		    size_t datalen, gfp_t gfp);
>   
>   void dev_coredump_put(struct device *dev);
> +void dev_coredump_timeout_set(struct device *dev, unsigned long secs_timeout);
>   #else
>   static inline void dev_coredumpv(struct device *dev, void *data,
>   				 size_t datalen, gfp_t gfp)
> @@ -90,6 +91,11 @@ static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>   static inline void dev_coredump_put(struct device *dev)
>   {
>   }
> +
> +static inline void dev_coredump_timeout_set(struct device *dev,
> +					    unsigned long secs_timeout)
> +{
> +}
>   #endif /* CONFIG_DEV_COREDUMP */
>   
>   #endif /* __DEVCOREDUMP_H */

