Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECACD78FFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346830AbjIAPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjIAPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:17:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873EE10CF;
        Fri,  1 Sep 2023 08:17:24 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381Ad8Te010808;
        Fri, 1 Sep 2023 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=DS7hdx6E7VA2wQSfq1YDOlTUARyaDs3G14Q9M+H7yEc=;
 b=Mp13jdESrnqf1Pl4XbrA0BgUiSR0tE2QO0D7zBpmr6aM8UQQ9P58RrRznBaMwcpEZsQk
 NJwVWc+qcgdD3iTznKWEHTJJ+loHtbqndq3mw93YZ71/xKuqNj+W5uEYTHGo9/KojiSo
 EigBaGlmP7xPH/Mi70wygSWY2NcO+BGIhpyVB4MP/3TQZHDIRC5nzutodE1aZVMvkVWe
 7uYjfTe05r6v+Aqvp/OC2J43aXOPabacoKOf5l0rDXHg7WhtwPhm3FgFR2hTKdi5aHIJ
 oZEYLrTBAlqYTcJmkXR3LuNFGS2fRoBT+6WnvQSMZYH2GyQNUVwoiRuBfaBrEOkI/KjJ iQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suc9k12gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 15:17:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381FHEwo004407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 15:17:14 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 08:17:15 -0700
Date:   Fri, 1 Sep 2023 08:17:13 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
Subject: Re: [PATCH V6 1/6] scsi: ufs: qcom: Align mask for
 core_clk_1us_cycles
Message-ID: <20230901151713.GQ818859@hu-bjorande-lv.qualcomm.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-2-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901114336.31339-2-quic_nitirawa@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VyiaAMRnV7s9K8GcpnLmhOhppJ6sKyFv
X-Proofpoint-ORIG-GUID: VyiaAMRnV7s9K8GcpnLmhOhppJ6sKyFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:13:31PM +0530, Nitin Rawat wrote:
> Align core_clk_1us_cycles mask for Qualcomm UFS Controller V4.0.0

"Align clk mask for ... as per hardware specification."? Are you trying
to say "The DME_VS_CORE_CLK_CTRL register has changed in v4 of the
Qualcomm UFS controller, introduce support for the new register layout"?

You're not aligning the code to match the hardware specification, you're
fixing the code because the register has changed.

> onwards as per Hardware Specification.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 28 ++++++++++++++++++----------
>  drivers/ufs/host/ufs-qcom.h |  5 +++--
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index f88febb23123..fe36003faaa8 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1297,22 +1297,30 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>  }
> 
>  static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_cycles)
> +						       u32 cycles_in_1us)

This is a nice clarification, but changing the function prototype gives
a sense that you changed the parameters - and that's not the case.

So if you drop this rename, you make the purpose of the patch clearer.

>  {
> -	int err;
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	u32 core_clk_ctrl_reg;
> +	int ret;

Renaming err to ret is unrelated and only unnecessary complexity to the
patch.

> 
> -	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
> -		return -EINVAL;
> -
> -	err = ufshcd_dme_get(hba,
> +	ret = ufshcd_dme_get(hba,
>  			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>  			    &core_clk_ctrl_reg);
> -	if (err)
> -		return err;
> +	if (ret)
> +		return ret;
> 
> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
> -	core_clk_ctrl_reg |= clk_cycles;
> +	/* Bit mask is different for UFS host controller V4.0.0 onwards */
> +	if (host->hw_ver.major >= 4) {
> +		if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, cycles_in_1us))
> +			return -ERANGE;
> +		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
> +		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, cycles_in_1us);
> +	} else {
> +		if (!FIELD_FIT(CLK_1US_CYCLES_MASK, cycles_in_1us))
> +			return -ERANGE;
> +		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
> +		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
> +	}
> 
>  	/* Clear CORE_CLK_DIV_EN */
>  	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index d6f8e74bd538..8a9d3dbec297 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -129,8 +129,9 @@ enum {
>  #define PA_VS_CONFIG_REG1	0x9000
>  #define DME_VS_CORE_CLK_CTRL	0xD002
>  /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
> -#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
> -#define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
> +#define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
> +#define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
> +#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)

Hard to say without applying the patch, please double check that the
values here have matching indentation level.

Thank you,
Bjorn

> 
>  static inline void
>  ufs_qcom_get_controller_revision(struct ufs_hba *hba,
> --
> 2.17.1
> 
