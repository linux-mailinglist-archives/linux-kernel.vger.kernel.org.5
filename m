Return-Path: <linux-kernel+bounces-85122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDE86B0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7960E1F25E62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBEC14F996;
	Wed, 28 Feb 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RajPwTXj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF7130AEF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127790; cv=none; b=irhzKdlaCKuBTvZ8G+gJdzLZFV8Y4vXwxu/rAv723EjJjGtafKsMp1T67oyw7mb+9VO35vBQ85yzxKMnOfApfDYrG8LAiqjlvA5rfFPOHPwv0iAbj05YUyzd6UJtI/fsSB9G66KokPuj3Lxs6ZaV+8eiwOVZBI21LKQo626SXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127790; c=relaxed/simple;
	bh=SvOjEBM6XaTjawBpJfnC/vAcSjjGGP5H8FoPZUwyDR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TnQcSjh2G30hDlVe+6t1ngZ8nXLls+OK9Z/M6vo8U7aR0fmE9o9vlb0CaEcrlC3ypVC6s/dsZKo1X1GvcOWtDpdivBYdOIgs3t+skqYh5aOKZSkfOYQt6xWdnIUWTGKUq+XEEAgye4O096CxmXBQ2Z51MmQAIVN5WCd2TdcIJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RajPwTXj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SDe2Qc012073;
	Wed, 28 Feb 2024 13:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gbbaIjKyJYqdiJn3LCuTCwFTxGo+XR59Kj1/OOErhfk=; b=Ra
	jPwTXjsRX23YHsuwKQ3s0tKtcBH8rGAfIDCf5hw0PrgKaJXahj10wk/B14U+T2dS
	pNOYvJ0mXRHI04MBDWZa90wuznxC3OoyqYIpbo8UaIxItAezyrz7k4wvdZUcQwRg
	znrR75nd7kb4oFQCM4iE8hTgOHjWocGE1QkfKCRN+ZlWxfpghdEFLxWt9ITzNVJ4
	Lm8CxgRerdON0W3WGdKs5uzfpvBmYX16dq1o1TaHhgPFsrtO0OUx1fVZ2fceuSX+
	4wYfob+rSnkltURFsO5iP7MzvsF1kmFSfExC9i2UWyXWZMtKAbMNyxIsBl/oDwCg
	awS2JATXPlQN0hqbmBZg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj5wc8093-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:43:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SDh0sc004702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:43:00 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 05:42:58 -0800
Message-ID: <d8b52875-1eea-5eba-55d0-d6acedf206ef@quicinc.com>
Date: Wed, 28 Feb 2024 19:12:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] devcoredump: Add dev_coredump_put()
Content-Language: en-US
To: =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>
References: <20240227210008.182904-1-jose.souza@intel.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240227210008.182904-1-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c4sVrRvDN_S1dI-labytC-2CfvTIQqnA
X-Proofpoint-ORIG-GUID: c4sVrRvDN_S1dI-labytC-2CfvTIQqnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_06,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=928 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280108



On 2/28/2024 2:30 AM, José Roberto de Souza wrote:
> This is useful for drivers that don't want to keep a coredump
> available after unloading.
> Otherwise, the coredump would only be removed after DEVCD_TIMEOUT
> seconds.
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>   drivers/base/devcoredump.c  | 22 ++++++++++++++++++++++
>   include/linux/devcoredump.h |  5 +++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 7e2d1f0d903a6..e96427411b87c 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -304,6 +304,28 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
>   				  offset);
>   }
>  
[...]

> +/**
> + * dev_coredump_put - remove device coredump
> + * @dev: the struct device for the crashed device
> + *
> + * If giving device has a coredump this removes it from file system and free
> + * associated data otherwise does nothing.
> + * This is useful for drivers that don't want to keep a coredump
> + * available after unloading.
> + */

[...]

Slight rephrasing..

""
dev_coredump_put() removes coredump, if exists, for a given device from 
the file system and free its associated data otherwise, does nothing.

It is useful for modules that do not want to keep coredump
available after its unload.
""

Overall, LGTM..

-Mukesh

> +void dev_coredump_put(struct device *dev)
> +{
> +	struct device *existing;
> +
> +	existing = class_find_device(&devcd_class, NULL, dev,
> +				     devcd_match_failing);
> +	if (existing) {
> +		devcd_free(existing, NULL);
> +		put_device(existing);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dev_coredump_put);
> +
>   /**
>    * dev_coredumpm - create device coredump with read/free methods
>    * @dev: the struct device for the crashed device
> diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
> index c008169ed2c6f..c8f7eb6cc1915 100644
> --- a/include/linux/devcoredump.h
> +++ b/include/linux/devcoredump.h
> @@ -63,6 +63,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   
>   void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>   		    size_t datalen, gfp_t gfp);
> +
> +void dev_coredump_put(struct device *dev);
>   #else
>   static inline void dev_coredumpv(struct device *dev, void *data,
>   				 size_t datalen, gfp_t gfp)
> @@ -85,6 +87,9 @@ static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>   {
>   	_devcd_free_sgtable(table);
>   }
> +static inline void dev_coredump_put(struct device *dev)
> +{
> +}
>   #endif /* CONFIG_DEV_COREDUMP */
>   
>   #endif /* __DEVCOREDUMP_H */

