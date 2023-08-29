Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2478C1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjH2Jv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjH2JvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:51:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8FE9;
        Tue, 29 Aug 2023 02:51:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T9gmk7016436;
        Tue, 29 Aug 2023 09:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nw22Af082mMcx1PWlB9NvRWV9MArnOcJJ7TIt+gTcdY=;
 b=IspwvJJnu/p2JjKqFkNgVKPaGo91hlI+PJhJhPE0PKYjIEtUgmrCkPoN74IYoY0dKcES
 lLv9o5Eg+2Gf9t91+G5ZPTI7hvmYJCZByXK32Lkf65CU9XMAz+WH6oxDAQUmWtYhY/RA
 0bdTOVSaK3MBeqFtAVhLBM67Aroi+Ez4LFPokgBtDOnNoLtXzOncwGEEspB82pZHp439
 vh+zwoZ/fnLp4FsHwfA7Nyg/Yo2cR4tMDxJ90wUyAHqOPelGxYR4gQqggkEVu6TQWiBd
 U9yCTlnwCHDnTBaocHilYVGkHm54HoNg3S6CAAfTcbJcP00pPSShHu8vkt6QLVbIlFeu qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr1brr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:50:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T9osL7011391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:50:54 GMT
Received: from [10.218.34.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 02:50:50 -0700
Message-ID: <a85f6541-ab15-b0bf-4903-215bcc138b27@quicinc.com>
Date:   Tue, 29 Aug 2023 15:20:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/2] irqchip/qcom-pdc: Add support for v3.2 HW
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230829092119.1017194-1-dmitry.baryshkov@linaro.org>
 <20230829092119.1017194-2-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20230829092119.1017194-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SkU9aFu80SDt8vxuu2ubTjPLJ0JjMuzS
X-Proofpoint-ORIG-GUID: SkU9aFu80SDt8vxuu2ubTjPLJ0JjMuzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290085
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/2023 2:51 PM, Dmitry Baryshkov wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
>
> Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
> IRQ_i_CFG register and requires a change of the driver to avoid
> writing into an undefined register address.
>
> Get the HW version from registers and set the IRQ_ENABLE bit to the
> correct register depending on the HW version.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> [DB: fix crash on sm8150 DTs which listed short PDC region]
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/irqchip/qcom-pdc.c | 73 ++++++++++++++++++++++++++++++--------
>   1 file changed, 59 insertions(+), 14 deletions(-)

Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>

Thanks,
Maulik

