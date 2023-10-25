Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F07D78FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjJYXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:53:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C003C8F;
        Wed, 25 Oct 2023 16:53:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PNetsK032586;
        Wed, 25 Oct 2023 23:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kg5RzAGUeK1kFQGeDYfHFl8jAbCXGHl3ARcoYff6sbc=;
 b=F+Xqgjp/uWO5CovuQ0w4x9prEMwtJ4e03DH+R4WHb58YfkdDMJMdnB0XmqsZmqn49NH0
 VlEXppkcUmNSr0txZAmajxTChgOmqeK9xZ4oUhTRNl/IitBq8xsdaWCLIJr1boHPNz+J
 8bPvL/FvOxYUg7uJQtrVYX5xDNO/4/SnSZ3bki9O2Fo1v1R/HHlVa0VK52O+hKI56xtQ
 g/jtPWXvpoPGvmUhwy43KHO3L5oSMSYje7lRAT2ltX7u+xdqnrlbXxUIBAYCvRfb29ar
 Zyr8+D3PvpJgDQ2im2TinWAOiY1wDRKJ1Oyemewt9rjOCVATw/F5TyJx7DHjJ8kXQwZ0 DQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txmhxb1dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 23:53:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PNrdbJ029266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 23:53:39 GMT
Received: from [10.71.108.203] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 16:53:38 -0700
Message-ID: <8b0d1ab1-e4e6-4152-bcb6-c83909060652@quicinc.com>
Date:   Wed, 25 Oct 2023 16:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] firmware: scm: Modify only the download bits in
 TCSR register
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
References: <1698235506-16993-1-git-send-email-quic_mojha@quicinc.com>
 <1698235506-16993-3-git-send-email-quic_mojha@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <1698235506-16993-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HQ7uBl6RvDnl82D8ytW186ZTTvkEjEEx
X-Proofpoint-GUID: HQ7uBl6RvDnl82D8ytW186ZTTvkEjEEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 5:05 AM, Mukesh Ojha wrote:
> Crashdump collection is done based on DLOAD bits of TCSR register.
> To retain other bits, scm driver need to read the register and
> modify only the DLOAD bits, as other bits in TCSR may have their
> own significance.
> 
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 25549178a30f..f1c4a9f9a53f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/cpumask.h>
> @@ -117,6 +119,10 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>  #define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
>  #define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
>  
> +#define QCOM_DLOAD_MASK		GENMASK(5, 4)
> +#define QCOM_DLOAD_FULLDUMP	0x1
> +#define QCOM_DLOAD_NODUMP	0x0
> +


Enum would be better here for related constants.

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index f1c4a9f9a53f..95f73a8c51d7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -122,4 +122,6 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 #define QCOM_DLOAD_MASK                GENMASK(5, 4)
-#define QCOM_DLOAD_FULLDUMP    0x1
-#define QCOM_DLOAD_NODUMP      0x0
+enum qcom_dload_mode {
+       QCOM_DLOAD_NODUMP       = 0,
+       QCOM_DLOAD_FULLDUMP     = 1,
+};
 


>  static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_UNKNOWN] = "unknown",
>  	[SMC_CONVENTION_ARM_32] = "smc arm 32",
> @@ -523,6 +529,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  
>  static void qcom_scm_set_download_mode(bool enable)
>  {
> +	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
>  	bool avail;
>  	int ret = 0;
>  
> @@ -532,8 +539,9 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
> +					       QCOM_DLOAD_MASK,
> +					       FIELD_PREP(QCOM_DLOAD_MASK, val));
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");

- Elliot
