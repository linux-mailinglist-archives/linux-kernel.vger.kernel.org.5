Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB6794491
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbjIFUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjIFUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:30:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EA4172E;
        Wed,  6 Sep 2023 13:30:13 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KLKvv027970;
        Wed, 6 Sep 2023 20:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gdlzlWQRw3rpmc1P8I6D+v3GIq0GxPGh6WgJvFpEvLw=;
 b=hkMuJt99CCzOEl45/cBt0rf24W8Hzd8R+AczuUN+Ln7L2Xc7iRVQyUZmqst/aaY+aAFL
 v6q5sZ2uIfKgfYvRd7HVoHDUS4Z4QF6FuhDSBT1ZgUvmojOq5VpSVuBM0bTW7imy3XWp
 M6lINsMo88yuZIYeG8uaXmriMe0yRLmJ2tac4dxy/TGXTHlaUm7RDNT4TV2A19orSVC9
 QpvBro2sxhjg1jHkNNFRjdKILmMCACkqfl2Ut/8JtL8e+04orcCszR8FjzbjcTljLGiX
 QgrMd0I74PYMtESImba1PW+Kw1kaCUJsJ5Ev75FUaikHLH6Y1paZ+WeKslctohVtFSB5 3Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxwes0dhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:30:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386KTxSe030542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 20:29:59 GMT
Received: from [10.110.123.61] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 13:29:55 -0700
Message-ID: <b3871c05-7cab-57ae-592c-1cfcba4e61af@quicinc.com>
Date:   Wed, 6 Sep 2023 13:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/5] drm/msm: add trailing newlines to drm_dbg msgs
Content-Language: en-US
To:     Jim Cromie <jim.cromie@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>
CC:     <daniel.vetter@ffwll.ch>, <daniel@ffwll.ch>,
        <jani.nikula@intel.com>, <ville.syrjala@linux.intel.com>,
        <seanpaul@chromium.org>, <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
 <20230906190224.583577-4-jim.cromie@gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230906190224.583577-4-jim.cromie@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qmD0UM9MrO1hmEZkdOndKzAmFeF2twY5
X-Proofpoint-GUID: qmD0UM9MrO1hmEZkdOndKzAmFeF2twY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=537
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060177
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim

On 9/6/2023 12:02 PM, Jim Cromie wrote:
> By at least strong convention, a print-buffer's trailing newline says
> "message complete, send it".  The exception (no TNL, followed by a call
> to pr_cont) proves the general rule.
> 
> Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
> 1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

May I know what 207, 1288 mean here? Is it the number of callers already 
having \n?

If so, this might be a big confusing as its subjective to the code-base 
you are referring to. So I will just stop with "Most DRM.debug calls 
already comport with this".

> 
> No functional changes.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>   drivers/gpu/drm/msm/msm_fb.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

The change itself LGTM, hence

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
