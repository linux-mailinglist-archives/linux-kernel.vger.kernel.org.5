Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659527E085A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbjKCSkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:40:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90789BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:40:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3E0WtT025518;
        Fri, 3 Nov 2023 18:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KngwHfXRCLK6K5hYwxe5gr35M/ToT/KFeOoUtwaK7U8=;
 b=PhmOtIWRr6qkYC2+GzFXoMgED9+/zqvA4TOFTcbEb64pV84zfAeqJY45j+JqJI3p4n+f
 Bvjhjh4RLNH+u1m4fMnZ0RSOQbbHRAAseF8xYZNk1lgUIcg7isdkzPtkisSOK+r02vFm
 ZmBIk+9k7tYReSKda5eE/SaKWslGiNbYtBwEfiSy0z7IkMX8YuaQlHOHGchbuvTtAsUR
 e1eJd3nAidhEGrd89SBrOL1JGxMH6HVFRrtMu8IULnqhxGqThXr/8JM/31wuSMo989sa
 kYSnGa3hGOJjDgmtYmwIIUDfk86fmw9tPdvGo07POjnfKqB9GEEsOFYuksV/DYnmtdn0 QQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4rev9v0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 18:40:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3Ie3pZ001702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 18:40:03 GMT
Received: from [10.71.110.254] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 11:40:02 -0700
Message-ID: <6b80dfa4-66d2-40fc-bf3b-88a8ada09b50@quicinc.com>
Date:   Fri, 3 Nov 2023 11:39:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: starry-2081101qfh032011-53g: Fine tune the
 panel power sequence
Content-Language: en-US
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        <neil.armstrong@linaro.org>, <sam@ravnborg.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <xuxinxiong@huaqin.corp-partner.google.com>
References: <20231102130844.13432-1-xiazhengqiao@huaqin.corp-partner.google.com>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20231102130844.13432-1-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O6nGi1FJhHFr_aTE6J6eIv_F7a2Xtnh6
X-Proofpoint-ORIG-GUID: O6nGi1FJhHFr_aTE6J6eIv_F7a2Xtnh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2023 6:08 AM, xiazhengqiao wrote:
> For "starry, 2081101qfh032011-53g" this panel, it is stipulated in the

Hi Zhengqiao,

Nit: Can you reword this to "For the "starry, 2081101qfh032011-53g" 
panel..."?

> panel spec that MIPI needs to keep the LP11 state before the
> lcm_reset pin is pulled high.

Was this fixing some panel issue? If so, maybe we can add

Fixes: 6069b66cd962 ("drm/panel: support for STARRY 2081101QFH032011-53G 
MIPI-DSI panel")

Otherwise, with the commit msg fix, this looks good to me:

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 4f370bc6dca8..4ed8c2e28d37 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1765,6 +1765,7 @@ static const struct panel_desc starry_qfh032011_53g_desc = {
>   	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>   		      MIPI_DSI_MODE_LPM,
>   	.init_cmds = starry_qfh032011_53g_init_cmd,
> +	.lp11_before_reset = true,
>   };
>   
>   static const struct drm_display_mode starry_himax83102_j02_default_mode = {
> -- 
> 2.17.1
> 
