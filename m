Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78C7845B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbjHVPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjHVPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:38:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B6CC1;
        Tue, 22 Aug 2023 08:38:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MAxHRD012387;
        Tue, 22 Aug 2023 15:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uqPV0WC5qCv0Haem1x/KFGsbjyXb1C15zztq61dqCvo=;
 b=fWP+tF5baOpiCbBSLrExyvraPZVy7mILkAFHQgMYX25LREzsBejOUT1Jw+Pnl3bC6bko
 icbVBvcTACp1W8JqEkfA3FOLB3u7R0/mW7dp9tQojl6uJ+4gZgJTai4BY0gHrwjK5xoz
 /3LqphStay0Rck9vy8h0MpefzUV3XNzo3vrfvI3AzkPxwbK05wT8YEEKREkvLcGdoPrZ
 t6bLY+FGxN+j1qdXpqBtbpZ2TyTVfEYvz9lytiWIccU/p/b0mXflJ8hP9sRzJ2MBkRbb
 94eVbM+ZCVZ2pvKp9gl1x/ajBB5IF4lbiUVyjKiR3+s58RWYbWbaPB6GdotFWBAGLsbY jQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smf3qa2vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:38:16 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MFcG92008357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:38:16 GMT
Received: from [10.216.24.163] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 08:38:12 -0700
Message-ID: <ff9ec6f5-9c7c-546b-5814-159d7e2843a8@quicinc.com>
Date:   Tue, 22 Aug 2023 21:07:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <computersforpeace@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
 <20230816164641.3371878-2-robimarko@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230816164641.3371878-2-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cCUnGAt8uEwqZbYTD48bdkKhdazqIuKF
X-Proofpoint-ORIG-GUID: cCUnGAt8uEwqZbYTD48bdkKhdazqIuKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308220120
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 10:15 PM, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> Luckily, SDI can be disabled via an SCM call.
> 
> So, lets use the boolean DT property to identify boards that have SDI
> enabled by default and use the SCM call to disable SDI during SCM probe.
> It is important to disable it as soon as possible as we might have a WDT
> assertion at any time which would then leave the board in debug mode,
> thus disabling it during SCM removal is not enough.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v3:
> * Squashed ("firmware: qcom: scm: Add SDI disable support") and
> ("firmware: qcom_scm: disable SDI if required")
> ---
>   drivers/firmware/qcom_scm.c | 29 +++++++++++++++++++++++++++++
>   drivers/firmware/qcom_scm.h |  1 +
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 06fe8aca870d..de9d1a11d097 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -403,6 +403,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
>   
> +static int qcom_scm_disable_sdi(void)
> +{
> +	int ret;
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_BOOT,
> +		.cmd = QCOM_SCM_BOOT_SDI_CONFIG,
> +		.args[0] = 1, /* Disable watchdog debug */
> +		.args[1] = 0, /* Disable SDI */
> +		.arginfo = QCOM_SCM_ARGS(2),
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +	struct qcom_scm_res res;
> +
> +	ret = qcom_scm_clk_enable();
> +	if (ret)
> +		return ret;
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);

Would you not be wanting this call to be atomic ?

> +
> +	qcom_scm_clk_disable();
> +
> +	return ret ? : res.result[0];
> +}
> +
>   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
> @@ -1468,6 +1491,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	if (download_mode)
>   		qcom_scm_set_download_mode(true);
>   
> +	/*
> +	 * Disable SDI if indicated by DT that it is enabled by default.
> +	 */
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
> +		qcom_scm_disable_sdi();

Why don't we do this call in qcom_scm_shutdown()
also does it not conflict with above download_mode
we have enabled download mode but disabling SDI
means (hard reset) and will not be collecting
crash dump?

-Mukesh

> +
>   	return 0;
>   }
>   
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index e6e512bd57d1..7b68fa820495 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>   #define QCOM_SCM_SVC_BOOT		0x01
>   #define QCOM_SCM_BOOT_SET_ADDR		0x01
>   #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
> +#define QCOM_SCM_BOOT_SDI_CONFIG	0x09
>   #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
>   #define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
>   #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
