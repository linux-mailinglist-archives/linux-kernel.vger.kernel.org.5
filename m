Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE07FB122
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjK1FTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1FTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:19:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867EB194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:19:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967B3C433C8;
        Tue, 28 Nov 2023 05:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701148776;
        bh=g9llaC8ltgxTxxvDGbWBf0eVeSzPP+QM99uu9MtnmlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXwl340KlxLh/Qcxd819majfF8sVbrLImgzxRb0XIM3UJXo9uVOwgFoOG6k2guHVI
         o7wPhMQBCL597BEc7kaByIivM7gxNy6wUfy+VwvYGy2T69BXMDcN7iIXaq3KMMpSD8
         DMntNWM6zyieKYqDLGTFAb2AMTd2cP6YIszs2GfO1yV5W/NTUB3D6F7jZkJRNCkwwY
         bg5qFcB05MIMr8z4AQSLpYvJqxJw+Qq//wppIkK1qThhMT5z+GkzuREQuTeDJw80YU
         R0eip+0k28A07SNOfVge7HbQxAuWfa5K+RQxtoM4+l1dpfdfhNw/U3V9IFXumkI7S/
         u+NB9JHi/1u1g==
Date:   Tue, 28 Nov 2023 10:49:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Brian Masney <bmasney@redhat.com>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v5 01/10] scsi: ufs: host: Rename structure
 ufs_dev_params to ufs_host_params
Message-ID: <20231128051917.GB3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-2-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700729190-17268-2-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:46:21AM -0800, Can Guo wrote:
> Structure ufs_dev_params is actually used in UFS host vendor drivers to
> declare host specific power mode parameters, like ufs_<vendor>_params or
> host_cap, which makes the code not very straightforward to read. Rename the
> structure ufs_dev_params to ufs_host_params and unify the declarations in
> all vendor drivers to host_params.
> 
> In addition, rename the two functions ufshcd_init_pwr_dev_param() and
> ufshcd_get_pwr_dev_param() which work based on the ufs_host_params to
> ufshcd_init_host_param() and ufshcd_negotiate_pwr_param() respectively to
> avoid confusions.
> 
> This change does not change any functionalities or logic.
> 
> Acked-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-exynos.c    |  7 ++--
>  drivers/ufs/host/ufs-hisi.c      | 11 +++----
>  drivers/ufs/host/ufs-mediatek.c  | 12 +++----
>  drivers/ufs/host/ufs-qcom.c      | 12 +++----
>  drivers/ufs/host/ufshcd-pltfrm.c | 69 ++++++++++++++++++++--------------------
>  drivers/ufs/host/ufshcd-pltfrm.h | 10 +++---
>  6 files changed, 57 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index 71bd6db..674f2f4 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -765,7 +765,7 @@ static int exynos_ufs_pre_pwr_mode(struct ufs_hba *hba,
>  {
>  	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
>  	struct phy *generic_phy = ufs->phy;
> -	struct ufs_dev_params ufs_exynos_cap;
> +	struct ufs_host_params host_params;
>  	int ret;
>  
>  	if (!dev_req_params) {
> @@ -774,10 +774,9 @@ static int exynos_ufs_pre_pwr_mode(struct ufs_hba *hba,
>  		goto out;
>  	}
>  
> -	ufshcd_init_pwr_dev_param(&ufs_exynos_cap);
> +	ufshcd_init_host_param(&host_params);
>  
> -	ret = ufshcd_get_pwr_dev_param(&ufs_exynos_cap,
> -				       dev_max_params, dev_req_params);
> +	ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
>  	if (ret) {
>  		pr_err("%s: failed to determine capabilities\n", __func__);
>  		goto out;
> diff --git a/drivers/ufs/host/ufs-hisi.c b/drivers/ufs/host/ufs-hisi.c
> index 0229ac0..bb0c9a7 100644
> --- a/drivers/ufs/host/ufs-hisi.c
> +++ b/drivers/ufs/host/ufs-hisi.c
> @@ -293,9 +293,9 @@ static int ufs_hisi_link_startup_notify(struct ufs_hba *hba,
>  	return err;
>  }
>  
> -static void ufs_hisi_set_dev_cap(struct ufs_dev_params *hisi_param)
> +static void ufs_hisi_set_dev_cap(struct ufs_host_params *host_params)
>  {
> -	ufshcd_init_pwr_dev_param(hisi_param);
> +	ufshcd_init_host_param(host_params);
>  }
>  
>  static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
> @@ -365,7 +365,7 @@ static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
>  				       struct ufs_pa_layer_attr *dev_max_params,
>  				       struct ufs_pa_layer_attr *dev_req_params)
>  {
> -	struct ufs_dev_params ufs_hisi_cap;
> +	struct ufs_host_params host_params;
>  	int ret = 0;
>  
>  	if (!dev_req_params) {
> @@ -377,9 +377,8 @@ static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		ufs_hisi_set_dev_cap(&ufs_hisi_cap);
> -		ret = ufshcd_get_pwr_dev_param(&ufs_hisi_cap,
> -					       dev_max_params, dev_req_params);
> +		ufs_hisi_set_dev_cap(&host_params);
> +		ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
>  		if (ret) {
>  			dev_err(hba->dev,
>  			    "%s: failed to determine capabilities\n", __func__);
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> index fc61790..016067d 100644
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -996,16 +996,14 @@ static int ufs_mtk_pre_pwr_change(struct ufs_hba *hba,
>  				  struct ufs_pa_layer_attr *dev_req_params)
>  {
>  	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> -	struct ufs_dev_params host_cap;
> +	struct ufs_host_params host_params;
>  	int ret;
>  
> -	ufshcd_init_pwr_dev_param(&host_cap);
> -	host_cap.hs_rx_gear = UFS_HS_G5;
> -	host_cap.hs_tx_gear = UFS_HS_G5;
> +	ufshcd_init_host_param(&host_params);
> +	host_params.hs_rx_gear = UFS_HS_G5;
> +	host_params.hs_tx_gear = UFS_HS_G5;
>  
> -	ret = ufshcd_get_pwr_dev_param(&host_cap,
> -				       dev_max_params,
> -				       dev_req_params);
> +	ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
>  	if (ret) {
>  		pr_info("%s: failed to determine capabilities\n",
>  			__func__);
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5..aee66a3 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -898,7 +898,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  				struct ufs_pa_layer_attr *dev_req_params)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_dev_params ufs_qcom_cap;
> +	struct ufs_host_params host_params;
>  	int ret = 0;
>  
>  	if (!dev_req_params) {
> @@ -908,15 +908,13 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
> -		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
> +		ufshcd_init_host_param(&host_params);
> +		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
>  
>  		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> -		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
>  
> -		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
> -					       dev_max_params,
> -					       dev_req_params);
> +		ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
>  		if (ret) {
>  			dev_err(hba->dev, "%s: failed to determine capabilities\n",
>  					__func__);
> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index da2558e..9ec11b9 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -285,61 +285,60 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>  }
>  
>  /**
> - * ufshcd_get_pwr_dev_param - get finally agreed attributes for
> - *                            power mode change
> - * @pltfrm_param: pointer to platform parameters
> + * ufshcd_negotiate_pwr_param - find power mode settings that are supported by
> +				both the controller and the device
> + * @host_param: pointer to host parameters
>   * @dev_max: pointer to device attributes
>   * @agreed_pwr: returned agreed attributes
>   *
>   * Return: 0 on success, non-zero value on failure.
>   */
> -int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
> -			     const struct ufs_pa_layer_attr *dev_max,
> -			     struct ufs_pa_layer_attr *agreed_pwr)
> +int ufshcd_negotiate_pwr_param(const struct ufs_host_params *host_param,
> +			       const struct ufs_pa_layer_attr *dev_max,
> +			       struct ufs_pa_layer_attr *agreed_pwr)
>  {
> -	int min_pltfrm_gear;
> +	int min_host_gear;
>  	int min_dev_gear;
>  	bool is_dev_sup_hs = false;
> -	bool is_pltfrm_max_hs = false;
> +	bool is_host_max_hs = false;
>  
>  	if (dev_max->pwr_rx == FAST_MODE)
>  		is_dev_sup_hs = true;
>  
> -	if (pltfrm_param->desired_working_mode == UFS_HS_MODE) {
> -		is_pltfrm_max_hs = true;
> -		min_pltfrm_gear = min_t(u32, pltfrm_param->hs_rx_gear,
> -					pltfrm_param->hs_tx_gear);
> +	if (host_param->desired_working_mode == UFS_HS_MODE) {
> +		is_host_max_hs = true;
> +		min_host_gear = min_t(u32, host_param->hs_rx_gear,
> +					host_param->hs_tx_gear);
>  	} else {
> -		min_pltfrm_gear = min_t(u32, pltfrm_param->pwm_rx_gear,
> -					pltfrm_param->pwm_tx_gear);
> +		min_host_gear = min_t(u32, host_param->pwm_rx_gear,
> +					host_param->pwm_tx_gear);
>  	}
>  
>  	/*
> -	 * device doesn't support HS but
> -	 * pltfrm_param->desired_working_mode is HS,
> -	 * thus device and pltfrm_param don't agree
> +	 * device doesn't support HS but host_param->desired_working_mode is HS,
> +	 * thus device and host_param don't agree
>  	 */
> -	if (!is_dev_sup_hs && is_pltfrm_max_hs) {
> +	if (!is_dev_sup_hs && is_host_max_hs) {
>  		pr_info("%s: device doesn't support HS\n",
>  			__func__);
>  		return -ENOTSUPP;
> -	} else if (is_dev_sup_hs && is_pltfrm_max_hs) {
> +	} else if (is_dev_sup_hs && is_host_max_hs) {
>  		/*
>  		 * since device supports HS, it supports FAST_MODE.
> -		 * since pltfrm_param->desired_working_mode is also HS
> +		 * since host_param->desired_working_mode is also HS
>  		 * then final decision (FAST/FASTAUTO) is done according
>  		 * to pltfrm_params as it is the restricting factor
>  		 */
> -		agreed_pwr->pwr_rx = pltfrm_param->rx_pwr_hs;
> +		agreed_pwr->pwr_rx = host_param->rx_pwr_hs;
>  		agreed_pwr->pwr_tx = agreed_pwr->pwr_rx;
>  	} else {
>  		/*
> -		 * here pltfrm_param->desired_working_mode is PWM.
> +		 * here host_param->desired_working_mode is PWM.
>  		 * it doesn't matter whether device supports HS or PWM,
> -		 * in both cases pltfrm_param->desired_working_mode will
> +		 * in both cases host_param->desired_working_mode will
>  		 * determine the mode
>  		 */
> -		agreed_pwr->pwr_rx = pltfrm_param->rx_pwr_pwm;
> +		agreed_pwr->pwr_rx = host_param->rx_pwr_pwm;
>  		agreed_pwr->pwr_tx = agreed_pwr->pwr_rx;
>  	}
>  
> @@ -349,9 +348,9 @@ int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
>  	 * the same decision will be made for rx
>  	 */
>  	agreed_pwr->lane_tx = min_t(u32, dev_max->lane_tx,
> -				    pltfrm_param->tx_lanes);
> +				    host_param->tx_lanes);
>  	agreed_pwr->lane_rx = min_t(u32, dev_max->lane_rx,
> -				    pltfrm_param->rx_lanes);
> +				    host_param->rx_lanes);
>  
>  	/* device maximum gear is the minimum between device rx and tx gears */
>  	min_dev_gear = min_t(u32, dev_max->gear_rx, dev_max->gear_tx);
> @@ -364,26 +363,26 @@ int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
>  	 * what is the gear, as it is the one that also decided previously what
>  	 * pwr the device will be configured to.
>  	 */
> -	if ((is_dev_sup_hs && is_pltfrm_max_hs) ||
> -	    (!is_dev_sup_hs && !is_pltfrm_max_hs)) {
> +	if ((is_dev_sup_hs && is_host_max_hs) ||
> +	    (!is_dev_sup_hs && !is_host_max_hs)) {
>  		agreed_pwr->gear_rx =
> -			min_t(u32, min_dev_gear, min_pltfrm_gear);
> +			min_t(u32, min_dev_gear, min_host_gear);
>  	} else if (!is_dev_sup_hs) {
>  		agreed_pwr->gear_rx = min_dev_gear;
>  	} else {
> -		agreed_pwr->gear_rx = min_pltfrm_gear;
> +		agreed_pwr->gear_rx = min_host_gear;
>  	}
>  	agreed_pwr->gear_tx = agreed_pwr->gear_rx;
>  
> -	agreed_pwr->hs_rate = pltfrm_param->hs_rate;
> +	agreed_pwr->hs_rate = host_param->hs_rate;
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(ufshcd_get_pwr_dev_param);
> +EXPORT_SYMBOL_GPL(ufshcd_negotiate_pwr_param);
>  
> -void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param)
> +void ufshcd_init_host_param(struct ufs_host_params *host_param)
>  {
> -	*dev_param = (struct ufs_dev_params){
> +	*host_param = (struct ufs_host_params){
>  		.tx_lanes = UFS_LANE_2,
>  		.rx_lanes = UFS_LANE_2,
>  		.hs_rx_gear = UFS_HS_G3,
> @@ -398,7 +397,7 @@ void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param)
>  		.desired_working_mode = UFS_HS_MODE,
>  	};
>  }
> -EXPORT_SYMBOL_GPL(ufshcd_init_pwr_dev_param);
> +EXPORT_SYMBOL_GPL(ufshcd_init_host_param);
>  
>  /**
>   * ufshcd_pltfrm_init - probe routine of the driver
> diff --git a/drivers/ufs/host/ufshcd-pltfrm.h b/drivers/ufs/host/ufshcd-pltfrm.h
> index a86a3ad..2d4d047 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.h
> +++ b/drivers/ufs/host/ufshcd-pltfrm.h
> @@ -10,7 +10,7 @@
>  #define UFS_PWM_MODE 1
>  #define UFS_HS_MODE  2
>  
> -struct ufs_dev_params {
> +struct ufs_host_params {
>  	u32 pwm_rx_gear;        /* pwm rx gear to work in */
>  	u32 pwm_tx_gear;        /* pwm tx gear to work in */
>  	u32 hs_rx_gear;         /* hs rx gear to work in */
> @@ -25,10 +25,10 @@ struct ufs_dev_params {
>  	u32 desired_working_mode;
>  };
>  
> -int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *dev_param,
> -			     const struct ufs_pa_layer_attr *dev_max,
> -			     struct ufs_pa_layer_attr *agreed_pwr);
> -void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param);
> +int ufshcd_negotiate_pwr_param(const struct ufs_host_params *host_param,
> +			       const struct ufs_pa_layer_attr *dev_max,
> +			       struct ufs_pa_layer_attr *agreed_pwr);
> +void ufshcd_init_host_param(struct ufs_host_params *host_param);
>  int ufshcd_pltfrm_init(struct platform_device *pdev,
>  		       const struct ufs_hba_variant_ops *vops);
>  int ufshcd_populate_vreg(struct device *dev, const char *name,
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
