Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D239376798F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjG2Aas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG2Aaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:30:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB0E48;
        Fri, 28 Jul 2023 17:30:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36T0QaJ3019726;
        Sat, 29 Jul 2023 00:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4ryQ4VY2iuPwio/zUiaUR4jB8wu6z2TdFVd/vX6F7v4=;
 b=AszBDm8PXwfmrMnprkeyAR2zxd08l1omk8EwLl12wS22evqwnpOymHOez2Xt2CnONJki
 eseDB5N/vE2Ylu3LGcOltFKu1KHZRpEwI1vJ4NKEB9wjejbX4m5Q5oyRO4eV2cyUVrxO
 dU/PL9FozlXdP9G76+p3D7tx4JJJBHzyUrKAVyypw4BI/ad1AYfieQAVj7QTnbbxXBYj
 SKVPf97Db84trQp5KX4LnQ3gB/IMlHTtQCQrnHik01j8TXfbWI+q1amVXEqXoGuQAzx/
 PLBiLo9zBkardGeYhWj7FEab8zNwTjXdd+04ehiOZQMi9xCQhqbJJI8B1PjIP3iVUrgo 2Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4j0g0p69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 00:30:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36T0Udxs006544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 00:30:39 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 17:30:38 -0700
Date:   Fri, 28 Jul 2023 17:30:37 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: Re: [PATCH v4 07/11] firmware: qcom_scm: ipq5332: add msa
 lock/unlock support
Message-ID: <20230729003037.GA25463@quicinc.com>
References: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
 <20230728063412.1641856-8-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230728063412.1641856-8-quic_mmanikan@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rgHczPV4G-qsl8fDBqaZtPgFe6lm6HnU
X-Proofpoint-ORIG-GUID: rgHczPV4G-qsl8fDBqaZtPgFe6lm6HnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307290002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28 2023 12:04, Manikanta Mylavarapu wrote:
> IPQ5332 user pd remoteproc firmwares need to be locked
> with MSA(modem secure access) features. This patch add
> support to lock/unlock MSA features.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in v4:
> 	- Rebased on linux-next
> 
>  drivers/firmware/qcom_scm.c            | 78 ++++++++++++++++++++++++++
>  drivers/firmware/qcom_scm.h            |  2 +
>  include/linux/firmware/qcom/qcom_scm.h |  2 +
>  3 files changed, 82 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 3bc8c63a997f..2275cf7bc887 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -676,6 +676,84 @@ bool qcom_scm_pas_supported(u32 peripheral)
>  }
>  EXPORT_SYMBOL(qcom_scm_pas_supported);
>  
> +/**
> + * qcom_scm_msa_lock() - Lock given peripheral firmware region as MSA
> + *
> + * @peripheral:	peripheral id
> + *
> + * Return 0 on success.
> + */
> +int qcom_scm_msa_lock(u32 peripheral)
> +{
> +	int ret;
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_PIL,
> +		.cmd = QCOM_SCM_MSA_LOCK,
> +		.arginfo = QCOM_SCM_ARGS(1),
> +		.args[0] = peripheral,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +	struct qcom_scm_res res;
> +
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_MSA_LOCK))
> +		return 0;
> +
> +	ret = qcom_scm_clk_enable();
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_bw_enable();
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	qcom_scm_bw_disable();
> +	qcom_scm_clk_disable();
> +
> +	return ret ? : res.result[0];
> +}
> +EXPORT_SYMBOL(qcom_scm_msa_lock);

Could you please convert this to EXPORT_SYMBOL_GPL? 

> +
> +/**
> + * qcom_scm_msa_unlock() - Unlock given peripheral MSA firmware region
> + *
> + * @peripheral:	peripheral id
> + *
> + * Return 0 on success.
> + */
> +int qcom_scm_msa_unlock(u32 peripheral)
> +{
> +	int ret;
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_PIL,
> +		.cmd = QCOM_SCM_MSA_UNLOCK,
> +		.arginfo = QCOM_SCM_ARGS(1),
> +		.args[0] = peripheral,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +	struct qcom_scm_res res;
> +
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_MSA_UNLOCK))
> +		return 0;
> +
> +	ret = qcom_scm_clk_enable();
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_bw_enable();
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	qcom_scm_bw_disable();
> +	qcom_scm_clk_disable();
> +
> +	return ret ? : res.result[0];
> +}
> +EXPORT_SYMBOL(qcom_scm_msa_unlock);

This one too?

Reference: [1]
The whole driver has now moved to using EXPORT_SYMBOL_GPL() now.

[1] https://lore.kernel.org/lkml/19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com/

Thank you.

Guru Das.
