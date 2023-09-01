Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2176790091
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjIAQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbjIAQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:14:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618DE66;
        Fri,  1 Sep 2023 09:14:02 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381AN3v5002267;
        Fri, 1 Sep 2023 16:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=D6BD8lu7M170piKgEeDyJDTQX30KQ8FXTrlYp2xoQw0=;
 b=khkrvtKgOkZQ1YnYsZh5B9SQP3AV0n5GRzs3L6dw2Tun0bg5lrI5akJh2s309WEise5y
 Q5BJdP6gOKhdi7oIt8glFKLJjj4FzVF+VxXlYaGW1RHmOajKyy6lg6yI/XHjJv8Itm8E
 q7zVwItFSwga0ZF9/5ryI7lUBjYWbuC1TKEiofoblSPO9outNH9IafQ5ubNtlDMyemBg
 triMxBls8jhbLDL562PIf+dsJ5Y43SC5mccGIOx23NGKPaz57rnnwcJ+m0d5Ddb8f+5Q
 uvGGrPpxw8ZuOO57fgiJ1CEwFR+9oAvwrlnERJJpurn9zF/PBOMa2kIShwYtKnTktZRB Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3su36v26ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 16:13:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381GDrTV000445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 16:13:53 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 09:13:53 -0700
Date:   Fri, 1 Sep 2023 09:13:51 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
Subject: Re: [PATCH V6 6/6] scsi: ufs: qcom: Configure clk HW division based
 on scaling conditions.
Message-ID: <20230901161351.GW818859@hu-bjorande-lv.qualcomm.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-7-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901114336.31339-7-quic_nitirawa@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H9wlssHvEVUGZFenlxxt7zz_yzgS8fHX
X-Proofpoint-GUID: H9wlssHvEVUGZFenlxxt7zz_yzgS8fHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:13:36PM +0530, Nitin Rawat wrote:
> a) Enable internal HW division of unipro core_clk for scale up condition.
> b) Clear internal HW division of unipro core_clk for scale down condition.
> 

This commit message isn't good.

> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 31 +++++++++++++++++--------------
>  drivers/ufs/host/ufs-qcom.h |  2 +-
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index c251c98a74f0..2ddda9356abc 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1389,18 +1389,21 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>  		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
>  	}
> 
> -	/* Clear CORE_CLK_DIV_EN */
> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> +	/* Enable CORE_CLK_DIV_EN for scale up condition */
> +	if (is_max_freq)
> +		core_clk_ctrl_reg |= CORE_CLK_DIV_EN_BIT;
> 
>  	ret = ufshcd_dme_set(hba,
>  			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>  			    core_clk_ctrl_reg);
> +	if (ret)
> +		return ret;

Nice, but don't mix logical and stylistic changes in the same patch.

>  	/*
>  	 * UFS host controller V4.0.0 onwards needs to program
>  	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
>  	 * frequency of unipro core clk of UFS host controller.
>  	 */
> -	if (!ret && (host->hw_ver.major >= 4)) {
> +	if (host->hw_ver.major >= 4) {
>  		if (cycles_in_40ns > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
>  			return -EINVAL;
> 
> @@ -1451,26 +1454,26 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>  static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	int err;
> -	u32 core_clk_ctrl_reg;
> +	int ret;
> +	u32 reg;

This just obfuscates the logical changes you're making.


Frankly, I've been staring at this for several minutes now. The commit
message says there is a change here (but fails to describe what problem
is solves or what the change is)...but I can't find the change!

Regards,
Bjorn

> 
>  	if (!ufs_qcom_cap_qunipro(host))
>  		return 0;
> 
> -	err = ufshcd_dme_get(hba,
> +	ret = ufshcd_dme_get(hba,
>  			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -			    &core_clk_ctrl_reg);
> +			    &reg);
> +	if (ret)
> +		return ret;
> 
>  	/* make sure CORE_CLK_DIV_EN is cleared */
> -	if (!err &&
> -	    (core_clk_ctrl_reg & DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT)) {
> -		core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> -		err = ufshcd_dme_set(hba,
> +	if (reg & CORE_CLK_DIV_EN_BIT) {
> +		reg &= ~CORE_CLK_DIV_EN_BIT;
> +		ret = ufshcd_dme_set(hba,
>  				    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -				    core_clk_ctrl_reg);
> +				    reg);
>  	}
> -
> -	return err;
> +	return ret;
>  }
> 
>  static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index bc176ef58e3e..bf0c370c79c7 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -141,7 +141,7 @@ enum {
>  /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
>  #define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
>  #define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
> -#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)
> +#define CORE_CLK_DIV_EN_BIT				BIT(8)
>  #define PA_VS_CORE_CLK_40NS_CYCLES			0x9007
>  #define PA_VS_CORE_CLK_40NS_CYCLES_MASK			GENMASK(6, 0)
> 
> --
> 2.17.1
> 
