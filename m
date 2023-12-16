Return-Path: <linux-kernel+bounces-2140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1481586B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2278B1F25818
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867314280;
	Sat, 16 Dec 2023 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P2mcD+70"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAA13AED;
	Sat, 16 Dec 2023 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG8AlnW011556;
	Sat, 16 Dec 2023 08:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UrutHSPGcLDRLLUpSzQn97qPAwY9DBQLxCjQ9z93DWs=; b=P2
	mcD+70T0TpAXVrwTaecPrUvY+EWWkwBu4MIT0j4DciDLrbngCVypQxXrEz8EW1Ev
	Fol2HOa2iQp54LLF3T8GXZHMqUBXdzSIUt/bn56b1z/WJpEB582DL2VntRr5KzT0
	Qv2djQvJ7mqROMv7lIkNXx1urqlqug0xttGL4ks+KAXN2CEirAVKPHHuV4RIfgrG
	/y0VisQtm1ara5PT+tcR4Lmj/8ChbSY+zXy5/JpLZyh8XEYEsN4Hhi9Gct2DCSVY
	iZ7tOlEHVGSv7YDFN9WVz3Php6Ury7U1ZIGjfuueaJakfV1GfPyM9Wyjc82N/j0T
	X2S8QUAY2kICJHHPJZGw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vjg7vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 08:15:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG8FLdL011863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 08:15:21 GMT
Received: from [10.216.47.123] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 00:15:17 -0800
Message-ID: <89ca6eb2-9a33-c37e-14ae-6181edb8626c@quicinc.com>
Date: Sat, 16 Dec 2023 13:45:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] power: reset: msm: Process register_restart_handler()
 error
Content-Language: en-US
To: Nikita Kiryushin <kiryushin@ancud.ru>, Andy Gross <agross@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd
	<sboyd@codeaurora.org>,
        Pramod Gurav <pramod.gurav@smartplayin.com>,
        Guenter
 Roeck <linux@roeck-us.net>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <feeb1a89-59bd-4fd6-81a5-1d828f95b0f0@ancud.ru>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <feeb1a89-59bd-4fd6-81a5-1d828f95b0f0@ancud.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iPeTEqpyHD1CYQFA_s5Qs3YqJqvzId4w
X-Proofpoint-GUID: iPeTEqpyHD1CYQFA_s5Qs3YqJqvzId4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160062



On 11/8/2023 10:57 PM, Nikita Kiryushin wrote:
> If registering restart handler fails for msm-restart result is not checked.
> It may be irrelevant now (as stated in comment to register_restart_handler,
> the function currently always returns zero), but if the behavior changes
> in the future, an error at registration of handler will be silently 
> skipped.
> 
> Add return error code and print error message too debug log in case of
> non-zero result of register_restart_handler.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 18a702e0de98 ("power: reset: use restart_notifier mechanism for 
> msm-poweroff")
> 
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/power/reset/msm-poweroff.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/msm-poweroff.c 
> b/drivers/power/reset/msm-poweroff.c
> index b9a401bd280b..5877a1ba2778 100644
> --- a/drivers/power/reset/msm-poweroff.c
> +++ b/drivers/power/reset/msm-poweroff.c
> @@ -35,11 +35,16 @@ static void do_msm_poweroff(void)
>    static int msm_restart_probe(struct platform_device *pdev)
>   {
> +    int ret = -EINVAL;

This does not add up anything., no need to initialize.

-Mukesh


>       msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
>       if (IS_ERR(msm_ps_hold))
>           return PTR_ERR(msm_ps_hold);
>   -    register_restart_handler(&restart_nb);
> +    ret = register_restart_handler(&restart_nb);
> +    if (ret) {
> +        dev_err(&pdev->dev, "unable to register restart handler, %d\n", 
> ret);
> +        return ret;
> +    }
>        pm_power_off = do_msm_poweroff;
>   -- 2.34.1
> 

