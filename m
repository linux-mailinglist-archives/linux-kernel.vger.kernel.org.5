Return-Path: <linux-kernel+bounces-45044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31D842AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2851F26652
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1712BF0A;
	Tue, 30 Jan 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bxsIG6Gq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307A129A89;
	Tue, 30 Jan 2024 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635786; cv=none; b=GUO5Iy+mT2Db/Hs9jEH8p4uoPfxrCcVwgJYwXk6v+5cDy7nHCnu7b/I3qfGlii/0q6JO3r3VzY3yKqGQ4XdCAnym0KLTxVBwN8GlsJ1wlrnAVkxxWTNT9ySvRFHyPZYHaofqyEyDEv0vE191Xd3gscC2CPm+6uMw5uFpeGbc32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635786; c=relaxed/simple;
	bh=7az4Waz8J1QeluuvlOX7oECI86AAEqC9k4ksYPBPl80=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/3Bcw5C9V277VWGJ1rYkLYEJhyo9//Kjm6+8PVMvLujgSziJIJ4V3LjlhrkLTNMtf32mGa3Mt4Fu+xphJVx8HlBySz0Aj7A0nXhHUw/DWfpWt4eNml4U1fqOEwoxlbPxOf7DpSgR9pxaUaaDysFw73vHWaMbXjRkttlkkOE5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bxsIG6Gq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UHD1Jx018567;
	Tue, 30 Jan 2024 17:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0GIBVRrE0qEAyu+uD125mgu8V031EIjyhavhlO2/X1k=; b=bx
	sIG6GqhStLSXcLEF9TkjuuW4c2T3GeWd5wpvM1DanzjaGHtAMrj849RjGcPwwJvQ
	+InMTy/aCtTl5q5+jnM+9+gwKMfT6vNXT0xW0PwqC/21Qd0oijo3j6NwIBDfJZnF
	Ip3BvvbixOr0HTUV2uZMwjz3ekuY/luUCM9OWHZoZJsuvyYIyf+cjRfxS3wtuK/Z
	JYM2v5hxUUguK7UNI8s6ii+UWjmljHk77VLUZ9UezcbI0GJpnUf8y/DcvhsuLHj6
	q5mL3h5t6LgH76x3MZaP28djBgsF5eKWAwOmjSaqZFmDBH8pF4trAHVzTFWj7Hy1
	flZw/rVLlMt8PmVWgemg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvsr1c2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:29:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UHTJ1q019556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:29:19 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:29:18 -0800
Message-ID: <175dcf69-0859-4475-8054-ccd417c38645@quicinc.com>
Date: Tue, 30 Jan 2024 09:29:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/9] wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, <kuba@kernel.org>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <edumazet@google.com>,
        Loic
 Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>
CC: <dsahern@kernel.org>, <weiwan@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>, <andrew@lunn.ch>,
        <leit@fb.com>,
        "open list:QUALCOMM WCN36XX WIRELESS DRIVER"
	<wcn36xx@lists.infradead.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)"
	<linux-wireless@vger.kernel.org>
References: <20240130104243.3025393-1-leitao@debian.org>
 <20240130104243.3025393-6-leitao@debian.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130104243.3025393-6-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qanf808Oxw3oHs_4etkwAM3em9V9HxXG
X-Proofpoint-ORIG-GUID: qanf808Oxw3oHs_4etkwAM3em9V9HxXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300129

On 1/30/2024 2:42 AM, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Qualcomm Atheros WCN3660/3680 wireless driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 41119fb177e3..4e6b4df8562f 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1685,6 +1685,7 @@ static struct platform_driver wcn36xx_driver = {
>  
>  module_platform_driver(wcn36xx_driver);
>  
> +MODULE_DESCRIPTION("Qualcomm Atheros WCN3660/3680 wireless driver");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Eugene Krasnikov k.eugene.e@gmail.com");
>  MODULE_FIRMWARE(WLAN_NV_FILE);


