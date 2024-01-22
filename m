Return-Path: <linux-kernel+bounces-34059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B28372B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F7B1F280AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8063F8EE;
	Mon, 22 Jan 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EOpCfM5K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549F3E49E;
	Mon, 22 Jan 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952149; cv=none; b=BLpB2doXg0zghTG48Ee8loYAzs9/l1l5h9YeD3LPlVmTRurE/f84JGiAg7ss2DgTHXf+TBKvYdDzkDmIgONczhCSQy/q+4UZDPpcrWgdj9irlGb7YQVgca54cmSd4ALa9BHNnOXPVixlUtg7a/WFQltT+4ysGZACfBDoi0MrKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952149; c=relaxed/simple;
	bh=haT/AD72cVJuSdHy1jeAPFd2n5sHagIc/kkcLqP5A0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oTNBP62EZGhSMmnqqPjYfRY7QKTweYEpy0GgYIwKEb8m9FlZWqrHRax2VCsvZRgnkrVuUF8/DmlsLWT/8jlWKP6sYCy3LHHmiQVBekGXNeX/pKf8Xco+lpz6eSKYxPQdVOtoXXTIGpoC8xJ4p7XJK82NDhPLs39TayXJDwIXUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EOpCfM5K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MJGSQE006734;
	Mon, 22 Jan 2024 19:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9isa3JFSy6VdY+glkUp9HPdVmPFw++kMzlZhCC5EJ3s=; b=EO
	pCfM5KGyN8NG3l254NXIRUa8iiY4TWY33MNYu9T/cIvlUXj5IajqcJsqFhDW13p9
	9O8fko5KcGTrPySVDLPDUiDhtED5kodh/kCEpmgMX99HRGenkMhlU1RAjoT+H9Kk
	j6uM8rZYMZ7PLNLillM1v3edU0VY4AeI2SEGvQEqhxqM1cy7od7b7tzn41kTI0C6
	9MQ/G8hjrSkuO9fNGns85bpUzbZh6uklaAMXZ2GFrvLnM30MCsK08ZGbsDNTof4u
	RS9sOpuy7BUhm4bkSdG+JFiymuEDXv23i9Ezw4/x1ZtxC/qL8omLrfinT2Iw7Mbm
	RkeevhF+s9BNCORJuFNw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vstd98nxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 19:35:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MJZRAj027331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 19:35:27 GMT
Received: from [10.226.49.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 11:35:26 -0800
Message-ID: <62e299a8-c82e-40e0-854b-6fee1275cb2d@quicinc.com>
Date: Mon, 22 Jan 2024 12:35:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 16/22] net: fill in MODULE_DESCRIPTION()s for
 Qualcom drivers
To: Breno Leitao <leitao@debian.org>, <kuba@kernel.org>, <davem@davemloft.net>,
        <abeni@redhat.com>, <edumazet@google.com>,
        Timur Tabi
	<timur@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Sean Tranchetti
	<quic_stranche@quicinc.com>
CC: <dsahern@kernel.org>, <weiwan@google.com>,
        "open list:QUALCOMM EMAC
 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-17-leitao@debian.org>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20240122184543.2501493-17-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8LLGFYo3DoZ0xGqE-a4xHbJ5br91V7ya
X-Proofpoint-ORIG-GUID: 8LLGFYo3DoZ0xGqE-a4xHbJ5br91V7ya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220139


On 1/22/2024 11:45 AM, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Qualcom rmnet and emac drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/qualcomm/emac/emac.c          | 1 +
>   drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
> index 3270df72541b..4c06f55878de 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac.c
> @@ -771,5 +771,6 @@ static struct platform_driver emac_platform_driver = {
>   
>   module_platform_driver(emac_platform_driver);
>   
> +MODULE_DESCRIPTION("Qualcomm EMAC Gigabit Ethernet driver");
>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:qcom-emac");
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 5b69b9268c75..f3bea196a8f9 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -520,4 +520,5 @@ static void __exit rmnet_exit(void)
>   module_init(rmnet_init)
>   module_exit(rmnet_exit)
>   MODULE_ALIAS_RTNL_LINK("rmnet");
> +MODULE_DESCRIPTION("Qualcomm RmNet MAP driver");
>   MODULE_LICENSE("GPL v2");

For rmnet

Reviewed-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

