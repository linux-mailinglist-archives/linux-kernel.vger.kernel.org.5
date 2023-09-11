Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF579A5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjIKIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjIKIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:17:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2032012C;
        Mon, 11 Sep 2023 01:17:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5bFQp011277;
        Mon, 11 Sep 2023 08:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vd49uihco+SPsQfPVH/VVRtFAb/2at6I8TeWhJKhFv8=;
 b=AYWSkM5Q/s/wucNIXiIS9TNkxtAPd2vpzozsS75c58wCvygZwFuqGPHKhF7CeNuFCdwG
 tIOP09TNOGeWkh7f+4EyQB5uzMD/c7kEzmgYsG0qUTpWw8XYEoAOAdwciN1oqPXSy6px
 B78WTWcbI1H824606dJQNyPUkAy4m/KS02V9lBxplCqEqGSLyt4/755mKQ2U4A3FHbTH
 aRizdEAy+SpOC92Gtpzp6EQZQsGViAYHKHKciTQYpqPFgAjIWP+5ZgeSeJI7odv+kJqv
 F1YbmTkSjiB1UaKWCQBCEbCX9g8X8fLVM9IrVYa6bMkQs2ymT/44ozNzfVWJh6OG8E+0 Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hvyk1dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 08:16:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B8Gr6H030203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 08:16:54 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 01:16:42 -0700
Message-ID: <2c12d4a7-f790-42e6-84dc-d93783b1b2d5@quicinc.com>
Date:   Mon, 11 Sep 2023 13:46:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/17] firmware: scm: Modify only the download bits in
 TCSR register
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-16-git-send-email-quic_mojha@quicinc.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <1694290578-17733-16-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6qtM1FG44tF2q9BDqDrBGrPE85BHbk47
X-Proofpoint-GUID: 6qtM1FG44tF2q9BDqDrBGrPE85BHbk47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/10/2023 1:46 AM, Mukesh Ojha wrote:
> Crashdump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the
> DLOAD bit as the other bits have their own significance.
>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>


Poovendhan's signed-off is also required. Please refer [1]

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/submitting-patches.rst#n489


> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/firmware/qcom_scm.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 5ea8fc4fd4e8..eda92f713019 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -5,6 +5,8 @@
>   #include <linux/platform_device.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>   #include <linux/completion.h>
>   #include <linux/cpumask.h>
>   #include <linux/export.h>
> @@ -30,6 +32,10 @@ module_param(download_mode, bool, 0);
>   #define SCM_HAS_IFACE_CLK	BIT(1)
>   #define SCM_HAS_BUS_CLK		BIT(2)
>   
> +#define QCOM_DLOAD_MASK		GENMASK(5, 4)
> +#define QCOM_DLOAD_FULLDUMP	0x1
> +#define QCOM_DLOAD_NODUMP	0x0
> +
>   struct qcom_scm {
>   	struct device *dev;
>   	struct clk *core_clk;
> @@ -444,6 +450,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   
>   static void qcom_scm_set_download_mode(bool enable)
>   {
> +	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
>   	bool avail;
>   	int ret = 0;
>   
> @@ -453,8 +460,9 @@ static void qcom_scm_set_download_mode(bool enable)
>   	if (avail) {
>   		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>   	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
> +					       QCOM_DLOAD_MASK,
> +					       FIELD_PREP(QCOM_DLOAD_MASK, val));
>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
