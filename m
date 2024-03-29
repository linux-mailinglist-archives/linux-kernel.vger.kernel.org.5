Return-Path: <linux-kernel+bounces-125235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0A892294
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B6B21CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1F13699E;
	Fri, 29 Mar 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WvXz9p6z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B485C42;
	Fri, 29 Mar 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732936; cv=none; b=of6WqAsYXty+BB+efZyopD+TEpM33vq8Pp0hXWlK6BHKpGkNvn1nfH9tsffjGl/90zP32qG9BvZh9AdnUcABZqY0nRRKM7KWUQnaPGtMziY4mZRAAAP7UKG9frQGM43EhO/1srvqo2SM7A/MAaVyv2BX86KNXMXDJs6IJi8rN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732936; c=relaxed/simple;
	bh=WCIZA6mX5gjH8RzX9YbqxsbBGwEGAnP1EP/fz8dzdZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=su22NMDbDfN5PtiM6fLYxhHRNpB/3HY4LmbkybMuVi066Yav5YjkFWJfLokWwyHYA1XzMQ9hySWgCRozP6QIiVVcaNVl6HmkpQbL8RQ61MFRHO/xyO9vCcXiEzVVqGefKmkgMOjhpQjDspv5ODHh3QNaazM++kcTNDTjHbrG7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WvXz9p6z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TFrICQ000705;
	Fri, 29 Mar 2024 17:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eQOOo/+YLRBywV7F/YvrAHC9R4G5lFaFMPiUXR1ZsKY=; b=Wv
	Xz9p6zzDJY/xv8pazhvO41On3Y2LxnfoXkTIreNHfPH1TBZt8UsP24EeMdemc+CJ
	iSFEkyI+RCUVrrpCBDO4fVF2m0scMQ75le5Eg3xguikcRd5vC7gw1vLH9xal4DEP
	vML4qmq5FYEGz12bFqEfW8vYF4slv/s1CN8zTHTU/A0Mf0H1CexRbA0gS4w/jLiT
	fwJvqF0EOqQDPdJJ/XZs4HVvXwvSsRCrGiV7uVdAbusWmM60aXYGge6e3LpA2B49
	Vo9QemFTTyIqXA73Jkt0olNbypz3A7xEngyFgVtWhSRNKolhHkkrKZuo9ifjwh8/
	1bhlplv/oBnB4P5dK2ag==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5dkyk0wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:22:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THM1FZ031602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:22:01 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:22:01 -0700
Message-ID: <f78fa061-3b34-47d2-a40c-bbec744f0f97@quicinc.com>
Date: Fri, 29 Mar 2024 10:22:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath10k: sdio: simplify module initialization
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Brian Norris
	<briannorris@chromium.org>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu
 Beznea <claudiu.beznea@tuxon.dev>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NFnr0VM_OTwUVD74iUN7sN2Gp4I1WXUj
X-Proofpoint-GUID: NFnr0VM_OTwUVD74iUN7sN2Gp4I1WXUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=806 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290153

On 3/29/2024 10:10 AM, Krzysztof Kozlowski wrote:
> This driver's initialization functions do not perform any custom code,
> except printing messages.  Printing messages on modules
> loading/unloading is discouraged because it pollutes the dmesg
> regardless whether user actually has this device.  Core kernel code
> already gives tools to investigate whether module was loaded or not.
> 
> Drop the printing messages which allows to replace open-coded
> module_sdio_driver().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> 
> ---
> 
> FYI:
> I have ongoing patchset touching few lines above this patch chunk
> (sdio_driver) which might go via different tree. If that patchset is
> applied via different tree, it might result in a trivial conflict, but
> there is no dependency. They can go via separate trees (except that
> trivial conflict).

I'll let Kalle respond if he'll take this through the ath tree vs letting you
take it through your tree

