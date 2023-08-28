Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC878A6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjH1Hk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjH1Hkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E410A;
        Mon, 28 Aug 2023 00:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C33CB60920;
        Mon, 28 Aug 2023 07:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A7FC433C8;
        Mon, 28 Aug 2023 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693208438;
        bh=m5t4L505tKfUf43Vq98wV5jNYWhSCYc4BDownJimxHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmmZd9HAwUpcSwCBfJjMFJr8Zdt225vXnoEh3vHN8jdelKdZj5LXIO8wEuhmU5s/x
         lqrdKuY8q0FVC54bUXjv7K7fZclXQpG4JQ5avIa+tccheQZ18QfLJgkkQMghmmgSZ8
         6wHSEUKEn0Or95SPPCmtfRximuv8FRGQaNmYVb5DhZnovysPuBOP/HLDyKaB4UaSGJ
         trT29QptvtpFXnsTmvVnBlGM7UZAxuZj1QqlpNDhYcA+AKKHa8WJg2JxVuyOTmzHu1
         svaeHQBRqNzb6twkUWucGNdifffSHryuQAmpayYF3c9LZLQLGeMSaprqiP8KAM+jpO
         soPj+RlE6AU8w==
Date:   Mon, 28 Aug 2023 13:10:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V5 2/6] scsi: ufs: qcom: Configure
 PA_VS_CORE_CLK_40NS_CYCLES for Unipro core clk
Message-ID: <20230828074023.GC5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-3-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823154413.23788-3-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:14:09PM +0530, Nitin Rawat wrote:
> For Qualcomm UFS controller V4.0 and above PA_VS_CORE_CLK_40NS_CYCLES
> attribute needs to be programmed with frequency of unipro core clk.
> Hence Configure PA_VS_CORE_CLK_40NS_CYCLES attribute for Unipro core clk.
> 

Same comment applies as patch 1.

- Mani

> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 45 ++++++++++++++++++++++++++++---------
>  drivers/ufs/host/ufs-qcom.h |  2 ++
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 1108b0cd43b3..abc0e7f7d1b0 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -93,8 +93,9 @@ static const struct __ufs_qcom_bw_table {
>  static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
> 
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_cycles);
> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
> +					u32 clk_cycles,
> +					u32 clk_40ns_cycles);
> 
>  static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>  {
> @@ -690,8 +691,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>  			 * set unipro core clock cycles to 150 & clear clock
>  			 * divider
>  			 */
> -			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
> -									  150);
> +			err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
> 
>  		/*
>  		 * Some UFS devices (and may be host) have issues if LCC is
> @@ -1296,12 +1296,13 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>  	phy_exit(host->generic_phy);
>  }
> 
> -static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_1us_cycles)
> +static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
> +					u32 clk_1us_cycles,
> +					u32 clk_40ns_cycles)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
> -	u32 core_clk_ctrl_reg;
> +	u32 core_clk_ctrl_reg, reg;
>  	u32 offset = 0;
>  	int err;
> 
> @@ -1326,9 +1327,33 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>  	/* Clear CORE_CLK_DIV_EN */
>  	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> 
> -	return ufshcd_dme_set(hba,
> +	err = ufshcd_dme_set(hba,
>  			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
>  			    core_clk_ctrl_reg);
> +	/*
> +	 * UFS host controller V4.0.0 onwards needs to program
> +	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
> +	 * frequency of unipro core clk of UFS host controller.
> +	 */
> +	if (!err && (host->hw_ver.major >= 4)) {
> +		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
> +			return -EINVAL;
> +
> +		err = ufshcd_dme_get(hba,
> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
> +				     &reg);
> +		if (err)
> +			return err;
> +
> +		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
> +		reg |= clk_40ns_cycles;
> +
> +		err = ufshcd_dme_set(hba,
> +				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
> +				     reg);
> +	}
> +
> +	return err;
>  }
> 
>  static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
> @@ -1345,7 +1370,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>  		return 0;
> 
>  	/* set unipro core clock cycles to 150 and clear clock divider */
> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
> +	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
>  }
> 
>  static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
> @@ -1381,7 +1406,7 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>  		return 0;
> 
>  	/* set unipro core clock cycles to 75 and clear clock divider */
> -	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
> +	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
>  }
> 
>  static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index a829296e11bb..325f08aca260 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -133,6 +133,8 @@ enum {
>  #define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
>  #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
>  #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
> +#define PA_VS_CORE_CLK_40NS_CYCLES	0x9007
> +#define PA_VS_CORE_CLK_40NS_CYCLES_MASK	0x3F
> 
>  static inline void
>  ufs_qcom_get_controller_revision(struct ufs_hba *hba,
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
