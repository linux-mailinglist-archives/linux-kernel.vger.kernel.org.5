Return-Path: <linux-kernel+bounces-158644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A78B2360
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38C028AB62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204EB149DF3;
	Thu, 25 Apr 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjFvDYeI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199E149C52;
	Thu, 25 Apr 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053673; cv=none; b=iMhrsdf1LRVm40ofpbYuQyvXrIt+RJq+geygG/qCL2C7jmu/fbRdlUVaDzUXkJqwjprBvZrw3wU5cQ4FUWondSE0lrzDLZyA6eg9gJUpzYYF9HSLBEl1XwJjCrOw9yn6fUgKzEwr/5z/FShJOte5eK6+xZ0ym5i8dQPCWe9yQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053673; c=relaxed/simple;
	bh=Nb/EYWJi0ha97Uh0+IpoBR6DF1ibajY3g34psIbNSQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTFA1e3Xj0QOzWYcXIfAuYc/MqKN2yH4lqsbchTQz8TQjzVf4QZgFaxq3vWsJnq9N0jYB2VvAJuRQWXIKehVKrHbxufZvZsffcIkLNelby8RjRWWs5aeQO0i3mdqG+YKalp+ptehHuXhUw9nREVPPVNGTTK0I1FzaGikz8NHpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjFvDYeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994CAC113CC;
	Thu, 25 Apr 2024 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053672;
	bh=Nb/EYWJi0ha97Uh0+IpoBR6DF1ibajY3g34psIbNSQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjFvDYeI8tBC/vJpFmCbM0Q/jPU6llQsaNTX6uuZ8JAqXizv4rYwjiTJv/i5k2mdV
	 sUZBl8r622lC20BT8TWYYnJaSPctmzJ+ZMXb4JuDYtzKMju5AvQhLRxaFj/+Pc9o8l
	 G9wi0BTW+ABisEetDdqzeU+GY6+h7LXi4RzXNLC5Xl4opLr4w2GDhKoHpUYAR0Yqq0
	 fCV6CQcigf+hFVpQ6Q8V0fvZygKjmeR+SkLyjuwVZUIZ7Ts6HQKXgHxIbflIs7bdOC
	 qxWpaOOskjvNw3ttmF9RAiwo/3O4uF2O6h0YfzbqnX7LHrVMRF6wjRgeAjD+OD9dNs
	 tlN6w40rIcD7Q==
Date: Thu, 25 Apr 2024 19:31:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Message-ID: <20240425140106.GG3449@thinkpad>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
 <1713868417-37856-4-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713868417-37856-4-git-send-email-quic_qianyu@quicinc.com>

On Tue, Apr 23, 2024 at 06:33:37PM +0800, Qiang Yu wrote:
> Some of the MHI modems like SDX65 based ones are capable of entering the EDL
> mode as per the standard triggering mechanism defined in the MHI spec v1.2. So
> let's add a common mhi_pci_generic_edl_trigger() function that triggers the EDL
> mode in the device when user writes to the /sys/bus/mhi/devices/.../trigger_edl
> file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Same comment as previous.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/bus/mhi/host/pci_generic.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 51639bf..c65eaa8 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -27,12 +27,16 @@
>  #define PCI_VENDOR_ID_THALES	0x1269
>  #define PCI_VENDOR_ID_QUECTEL	0x1eac
>  
> +#define MHI_EDL_DB			91
> +#define MHI_EDL_COOKIE			0xEDEDEDED
> +
>  /**
>   * struct mhi_pci_dev_info - MHI PCI device specific information
>   * @config: MHI controller configuration
>   * @name: name of the PCI module
>   * @fw: firmware path (if any)
>   * @edl: emergency download mode firmware path (if any)
> + * @edl_trigger: capable of triggering EDL mode in the device (if supported)
>   * @bar_num: PCI base address register to use for MHI MMIO register space
>   * @dma_data_width: DMA transfer word size (32 or 64 bits)
>   * @mru_default: default MRU size for MBIM network packets
> @@ -44,6 +48,7 @@ struct mhi_pci_dev_info {
>  	const char *name;
>  	const char *fw;
>  	const char *edl;
> +	bool edl_trigger;
>  	unsigned int bar_num;
>  	unsigned int dma_data_width;
>  	unsigned int mru_default;
> @@ -292,6 +297,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>  	.name = "qcom-sdx75m",
>  	.fw = "qcom/sdx75m/xbl.elf",
>  	.edl = "qcom/sdx75m/edl.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_qcom_v2_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -302,6 +308,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>  	.name = "qcom-sdx65m",
>  	.fw = "qcom/sdx65m/xbl.elf",
>  	.edl = "qcom/sdx65m/edl.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -312,6 +319,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
>  	.name = "qcom-sdx55m",
>  	.fw = "qcom/sdx55m/sbl1.mbn",
>  	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -928,6 +936,40 @@ static void health_check(struct timer_list *t)
>  	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>  }
>  
> +static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
> +{
> +	void __iomem *base = mhi_cntrl->regs;
> +	void __iomem *edl_db;
> +	int ret = 0;

No need to initialize 'ret'.

- Mani

> +	u32 val;
> +
> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> +	if (ret) {
> +		dev_err(mhi_cntrl->cntrl_dev, "Failed to wakeup the device\n");
> +		return ret;
> +	}
> +
> +	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
> +	mhi_cntrl->runtime_get(mhi_cntrl);
> +
> +	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
> +	if (ret)
> +		goto err_get_chdb;
> +
> +	edl_db = base + val + (8 * MHI_EDL_DB);
> +
> +	mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4, upper_32_bits(MHI_EDL_COOKIE));
> +	mhi_cntrl->write_reg(mhi_cntrl, edl_db, lower_32_bits(MHI_EDL_COOKIE));
> +
> +	mhi_soc_reset(mhi_cntrl);
> +
> +err_get_chdb:
> +	mhi_cntrl->runtime_put(mhi_cntrl);
> +	mhi_device_put(mhi_cntrl->mhi_dev);
> +
> +	return ret;
> +}
> +
>  static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
> @@ -962,6 +1004,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>  	mhi_cntrl->mru = info->mru_default;
>  
> +	if (info->edl_trigger)
> +		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
> +
>  	if (info->sideband_wake) {
>  		mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
>  		mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

