Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4C80925C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443905AbjLGUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:33:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5971713;
        Thu,  7 Dec 2023 12:33:35 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7Fvb0w002794;
        Thu, 7 Dec 2023 20:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KE84m7jSCLDZSitSp0ZCXBSAkzsdFgASbeQ45RDczPc=;
 b=G4VspXtwpHUHrK9s7xxFlHoeiVr+1t8cvJu+dxd3ezziRdkqpuyMxXB6STOxvumH1WY9
 RCPL8Zs6WiOQztNGBf8rFYMwepVGH5mhPA+qGaoju8hMqd6OlTgANI/rXKgxCONrkmfm
 UN/ezKyvVONn0t3hiuwQfHGaPKS3I5MHU8Dqf5Gqz+Gd0pKl+cEubdJTP+Ze09Zg/SAY
 NcO5LzfKTM9ie7N8EjkBjFhSo2v9SmVbhbBHq5QYVOKovgS9R+PWesT9mOJcr6IX43wB
 ENgUz7/SRvb1H7ufC8Rlvh1IjqqgyW27tk+iRqVqc4IUm4+oDm6SVe4K6vrNQKKR0pjU +A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2trjpv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 20:33:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7KXNRD009969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 20:33:23 GMT
Received: from [10.110.31.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 12:33:21 -0800
Message-ID: <6a05436d-a89f-43f9-b2d3-a664a6a36185@quicinc.com>
Date:   Thu, 7 Dec 2023 12:33:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v2 2/6] drm/msm/dsi: set video mode widebus enable bit
 when widebus is enabled
To:     Jonathan Marek <jonathan@marek.ca>,
        <freedreno@lists.freedesktop.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231114225857.19702-1-jonathan@marek.ca>
 <20231114225857.19702-3-jonathan@marek.ca>
Content-Language: en-US
In-Reply-To: <20231114225857.19702-3-jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hAd7VvXACY9sPzVUcJGz1ElWYnTCORUe
X-Proofpoint-ORIG-GUID: hAd7VvXACY9sPzVUcJGz1ElWYnTCORUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=856
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2023 2:58 PM, Jonathan Marek wrote:
> The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
> driver is doing in video mode. Fix that by actually enabling widebus for
> video mode.
> 
> Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index 2a7d980e12c3..f0b3cdc020a1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -231,6 +231,7 @@ static inline uint32_t DSI_VID_CFG0_TRAFFIC_MODE(enum dsi_traffic_mode val)
>   #define DSI_VID_CFG0_HSA_POWER_STOP				0x00010000
>   #define DSI_VID_CFG0_HBP_POWER_STOP				0x00100000
>   #define DSI_VID_CFG0_HFP_POWER_STOP				0x01000000
> +#define DSI_VID_CFG0_DATABUS_WIDEN				0x02000000
>   #define DSI_VID_CFG0_PULSE_MODE_HSA_HE				0x10000000
>   
>   #define REG_DSI_VID_CFG1					0x0000001c
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index deeecdfd6c4e..f2c1cbd08d4d 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -745,6 +745,8 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>   		data |= DSI_VID_CFG0_TRAFFIC_MODE(dsi_get_traffic_mode(flags));
>   		data |= DSI_VID_CFG0_DST_FORMAT(dsi_get_vid_fmt(mipi_fmt));
>   		data |= DSI_VID_CFG0_VIRT_CHANNEL(msm_host->channel);
> +		if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
> +			data |= DSI_VID_CFG0_DATABUS_WIDEN;

Hi Jonathan,

Now that widebus is enabled for video mode, I think you can also drop 
the TODO here [1]. Other than that, this LGTM.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

[1] 
https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/msm/dsi/dsi_host.c#L772

>   		dsi_write(msm_host, REG_DSI_VID_CFG0, data);
>   
>   		/* Do not swap RGB colors */
> -- 
> 2.26.1
> 
