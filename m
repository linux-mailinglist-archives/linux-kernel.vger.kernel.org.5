Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4978928B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHYX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHYX6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:58:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84562E7F;
        Fri, 25 Aug 2023 16:58:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PNmNBv014063;
        Fri, 25 Aug 2023 23:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KoF9wl0GgT/DGQMTTMM+L3Y9798bfjFqBmcVrq7K6TI=;
 b=J5smUHO3d7od2mnkGJT18rbAS6IDALWlKS7PkdPESVzM5CQLjxgyXPUpxd7s+AHGOcAM
 3jPphnkmEJ5G83LfazTCTSC+oKwK+lj5I9wss2Eax+fBwLG22YhM1fJ0Ru5PIDDdds/0
 8J1euS4zjz8USAivGHRa0mILaPeh05tLiJn9rY7hmk14BUXBaH5Ef4fa3hGTBNjJzTa6
 Efm3679yJ4OWY6i2IvFbvnt1HN8NUfZ096OdG1bLxgIY6uS0yb2UL+Vxc18wOvAZ/6fe
 5mMFh0p51YTUw9GfJNlvhquFtRdAv4sA0jot5hVAJbmmRlTbIzdzrap33FeKNfEg7KUL 1w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmtxt3kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 23:57:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PNvr39017061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 23:57:53 GMT
Received: from [10.110.6.4] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 16:57:51 -0700
Message-ID: <c229f00b-5e8b-b010-70bd-3478216c65a3@quicinc.com>
Date:   Fri, 25 Aug 2023 16:57:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dp: Add newlines to debug printks
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
References: <20230825230109.2264345-1-swboyd@chromium.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230825230109.2264345-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PNniYBoW1ULYTyXTx-ztQig96nOHizxK
X-Proofpoint-GUID: PNniYBoW1ULYTyXTx-ztQig96nOHizxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=698
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250214
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 4:01 PM, Stephen Boyd wrote:
> These debug printks are missing newlines, causing drm debug logs to be
> hard to read. Add newlines so that the messages are on their own line.
> 
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_link.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 42427129acea..6375daaeb98e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -1090,7 +1090,7 @@ int dp_link_process_request(struct dp_link *dp_link)
>   	} else if (dp_link_read_psr_error_status(link)) {
>   		DRM_ERROR("PSR IRQ_HPD received\n");
>   	} else if (dp_link_psr_capability_changed(link)) {
> -		drm_dbg_dp(link->drm_dev, "PSR Capability changed");
> +		drm_dbg_dp(link->drm_dev, "PSR Capability changed\n");
>   	} else {
>   		ret = dp_link_process_link_status_update(link);
>   		if (!ret) {
> @@ -1107,7 +1107,7 @@ int dp_link_process_request(struct dp_link *dp_link)
>   		}
>   	}
>   
> -	drm_dbg_dp(link->drm_dev, "sink request=%#x",
> +	drm_dbg_dp(link->drm_dev, "sink request=%#x\n",
>   				dp_link->sink_request);

perhaps we can move sink_request to the previous line itself with this 
patch and we can avoid the line break.

But thats a very minor comment, otherwise LGTM

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

>   	return ret;
>   }
> 
> base-commit: 706a741595047797872e669b3101429ab8d378ef
