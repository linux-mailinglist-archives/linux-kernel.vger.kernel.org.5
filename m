Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F9178FFF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350268AbjIAPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbjIAPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:30:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F409E70;
        Fri,  1 Sep 2023 08:30:49 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3818dgRF002034;
        Fri, 1 Sep 2023 15:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=/z8h1E4pQ9UfDKMX4ShUPzXvFy/0qSADplfL8hfWhR8=;
 b=g9YcYXlJvDoFa1IDKSwJ1OitQLKrZgq0mDHwgooVoaPTla8BP9POV4RR/FSG15Syfb9l
 8WIGCbKlojH0pOGAkc2xxWPGTRjeT8VH0dzRKElaSeXos3TKJdaZbpV6VBLw6ksoup7g
 orsK2U2HXaeivS1XzCDeDN2+96zjVpdUHnSyhUHwhFkigy6zES2mD9khfBFCJUwdWC8U
 QK16/1eaDklPJtimMRcY2S39RAH7Gxn9ujltnEw+K6y8xEBFEWb7d4UTrs5BAtdFBVtP
 0zfCRJwPjHDW1PXrQENIiTer3+b/jm5sOJPWGWADT5lr5QwEWrwr7MsM/R34O+EqqYyr lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3su89e9n8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 15:30:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381FUZWg009050
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 15:30:35 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 08:30:35 -0700
Date:   Fri, 1 Sep 2023 08:30:34 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
Subject: Re: [PATCH V6 2/6] scsi: ufs: qcom: Configure
 PA_VS_CORE_CLK_40NS_CYCLES
Message-ID: <20230901153034.GS818859@hu-bjorande-lv.qualcomm.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-3-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901114336.31339-3-quic_nitirawa@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hECzBEO5igY41-9RNHggE0ypivefuFpQ
X-Proofpoint-GUID: hECzBEO5igY41-9RNHggE0ypivefuFpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:13:32PM +0530, Nitin Rawat wrote:
> Configure PA_VS_CORE_CLK_40NS_CYCLES with frequency of unipro core clk
> for Qualcomm UFS controller V4.0 and onwards to align with the hardware
> specification.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 47 ++++++++++++++++++++++++++++---------
>  drivers/ufs/host/ufs-qcom.h |  2 ++
>  2 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index fe36003faaa8..018e391c276e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -93,8 +93,9 @@ static const struct __ufs_qcom_bw_table {
>  static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
> 
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_cycles);
> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
> +						       u32 clk_cycles,
> +						       u32 clk_40ns_cycles);
> 
>  static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>  {
> @@ -690,8 +691,8 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>  			 * set unipro core clock cycles to 150 & clear clock
>  			 * divider
>  			 */
> -			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
> -									  150);
> +			err = ufs_qcom_set_core_clk_ctrl(hba,
> +									  150, 6);

There's no reason to maintain the line wrap here, and the new
indentation looks wrong.

> 
>  		/*
>  		 * Some UFS devices (and may be host) have issues if LCC is
> @@ -1295,12 +1296,12 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>  	phy_power_off(host->generic_phy);
>  	phy_exit(host->generic_phy);
>  }
> -
> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 cycles_in_1us)
> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
> +					u32 cycles_in_1us,

Following my comment on this rename in the last commit, here you do
change the prototype, so here you need the rename to clarify the intent,
so make it here instead.

> +					u32 cycles_in_40ns)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	u32 core_clk_ctrl_reg;
> +	u32 core_clk_ctrl_reg, reg;

Please keep one variable declaration per line, in particular when using
names like "core_clk_ctrl_reg" which looks much more like a type than a
variable name...

I would have preferred "reg" instead of core_clk_ctrl_reg" and you could
have used that same variable for both sections.

>  	int ret;
> 
>  	ret = ufshcd_dme_get(hba,
> @@ -1325,9 +1326,33 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>  	/* Clear CORE_CLK_DIV_EN */
>  	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> 
> -	return ufshcd_dme_set(hba,
> +	err = ufshcd_dme_set(hba,

I might be confused, but didn't you remove "err" in patch 1? Does this
patch compile?

>  			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>  			    core_clk_ctrl_reg);
> +	/*
> +	 * UFS host controller V4.0.0 onwards needs to program
> +	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
> +	 * frequency of unipro core clk of UFS host controller.
> +	 */
> +	if (!err && (host->hw_ver.major >= 4)) {

Rather than if (previous-block-didn't-fail), add an explicit return if
err is unfavourable. That will make it more obvious that this section
relates to version >= 4 and nothing else.


That said, you now have one function:

core_clk_ctrl(int a, int b)
{
	do stuff based on a;

	if (version > 4)
		do stuff based on b;
}

It's pretty much one function for cycles_in_1us, with a separate
function for cycles_in_40us bolted on at the end. How about just
splitting it in two functions instead, and provide a small wrapper that
calls one or both functions?

> +		if (cycles_in_40ns > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
> +			return -EINVAL;
> +
> +		err = ufshcd_dme_get(hba,
> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
> +				     &reg);

Leaving this line unwrapped seems to end up at 89 characters wide.
Perfectly reasonable to do, in the name of readability.

> +		if (err)
> +			return err;
> +
> +		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
> +		reg |= cycles_in_40ns;
> +
> +		err = ufshcd_dme_set(hba,
> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
> +				     reg);

Same as above.

Regards,
Bjorn
