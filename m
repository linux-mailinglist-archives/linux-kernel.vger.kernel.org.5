Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE47ECAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjKOSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKOSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:41:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5F9B;
        Wed, 15 Nov 2023 10:41:28 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDxWMc014687;
        Wed, 15 Nov 2023 18:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PuFShW91pLCSKKRSr5TB0Kzh1Ye2y9QdBmcBG1d4LLo=;
 b=A45+UnlBOrODk8jEkvyk9I3LDsY5Yj34tyqSYs4Fsc54r5tpfGUq5BGoqxgtyij3WciF
 8c1VNHJPbtE/BbJI0y3h0AVGjE5Jzmm5LFQgX0obFRRZ1KI1iqyaoMrIYNYzDxs5n9bp
 NxOXe68evw/3gmVcowyGaF8dqHe7YStnSxh0SxdJUOaYdoTmeQFJkcDlFITVL8U1ziWy
 CnEJw6q1e9qs7HudziLVsxLwe8+MlTihn7bOM1A+0Km4PdlEMe5E8mz0W3cL8sqrVmqb
 W+0R+EDBsVky/aJMhGSTTTa4cnJorN4KVEsWLDyjVu+saW5bZ0lxxLfL+WUqFUMWoxyj FA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucmbaj3uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 18:41:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFIfHeW009144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 18:41:17 GMT
Received: from [10.110.71.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 10:41:16 -0800
Message-ID: <ad9f92d8-9aa6-14d1-7444-bb64131044b5@quicinc.com>
Date:   Wed, 15 Nov 2023 10:41:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David Airlie" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     Johan Hovold <johan@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>
References: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AclYIrKBsC7tOZwgZDgYgqZm0qk-nLBA
X-Proofpoint-ORIG-GUID: AclYIrKBsC7tOZwgZDgYgqZm0qk-nLBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_18,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150146
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 4:23 PM, Bjorn Andersson wrote:
> During USB transfers on the SC8280XP __arm_smmu_tlb_sync() is seen to
> typically take 1-2ms to complete. As expected this results in poor
> performance, something that has been mitigated by proposing running the
> iommu in non-strict mode (boot with iommu.strict=0).
> 
> This turns out to be related to the SAFE logic, and programming the QOS
> SAFE values in the DPU (per suggestion from Rob and Doug) reduces the
> TLB sync time to below 10us, which means significant less time spent
> with interrupts disabled and a significant boost in throughput.
> 
> Fixes: 4a352c2fc15a ("drm/msm/dpu: Introduce SC8280XP")
> Cc: stable@vger.kernel.org
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Matches what we have in downstream DT, hence

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> index 1ccd1edd693c..4c0528794e7a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> @@ -406,6 +406,7 @@ static const struct dpu_perf_cfg sc8280xp_perf_data = {
>   	.min_llcc_ib = 0,
>   	.min_dram_ib = 800000,
>   	.danger_lut_tbl = {0xf, 0xffff, 0x0},
> +	.safe_lut_tbl = {0xfe00, 0xfe00, 0xffff},
>   	.qos_lut_tbl = {
>   		{.nentry = ARRAY_SIZE(sc8180x_qos_linear),
>   		.entries = sc8180x_qos_linear
> 
> ---
> base-commit: c503e3eec382ac708ee7adf874add37b77c5d312
> change-id: 20231030-sc8280xp-dpu-safe-lut-9769027b8452
> 
> Best regards,
