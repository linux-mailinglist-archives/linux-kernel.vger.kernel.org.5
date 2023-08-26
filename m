Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DFB7892B6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjHZAX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHZAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:23:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26102117;
        Fri, 25 Aug 2023 17:23:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37Q0M31M012741;
        Sat, 26 Aug 2023 00:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UVrA7hFTknaYMrfth6agguVc8LsTfqzkHFmMYsvCLEc=;
 b=Aw/IX2WpSBXMMfSTZOyKy0IvbTq7OM8DwyUZwxiClnj7pX4Sae0QKAlIenwEXsiZUFeM
 jaZ9ARUFYxI0UyTfE1ezL9Y6hyDROVP0VPBkiCke/k8rPCWTTRwThCUZEqj0ppY1lZrI
 ZQhOaTATyA2yEEExtaMaCmjWBOtY7o7Gkd3rwH6piyHOC+25RdQl9UdxWYJF6D3gjAnV
 N34eR+EV3iYSNEpEVM2dGJtk6uQfNRutsQJbeCZalLcf0qA8tTgJGX0If2K3WVJ0QnZf
 GO4vzbvJZSGXVHXNXJdhDO+bgwVzshOpZu+GDAMO84/CkwgdzvPM6RiEkIMwdKPT6jCd gQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmm6a96k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Aug 2023 00:23:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37Q0NF2H018497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Aug 2023 00:23:15 GMT
Received: from [10.110.6.4] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 17:23:14 -0700
Message-ID: <6772a956-e511-484d-771e-529df8fbc199@quicinc.com>
Date:   Fri, 25 Aug 2023 17:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/4] drm/msm/dsi: Enable widebus for DSI
Content-Language: en-US
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
 <20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DAuK1jenotUUm5yEXhV82UoS-ocl2ec9
X-Proofpoint-GUID: DAuK1jenotUUm5yEXhV82UoS-ocl2ec9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=716 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308260001
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 10:42 AM, Jessica Zhang wrote:
> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
> 48 bits of compressed data instead of 24.
> 
> Enable this mode whenever DSC is enabled for supported chipsets.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.c      |  2 +-
>   drivers/gpu/drm/msm/dsi/dsi.h      |  1 +
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 31 +++++++++++++++++++++++++++----
>   3 files changed, 29 insertions(+), 5 deletions(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
