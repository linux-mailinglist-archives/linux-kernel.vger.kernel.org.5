Return-Path: <linux-kernel+bounces-145045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 410188A4EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2830B218AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5276EB40;
	Mon, 15 Apr 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg0KzrXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E976A005;
	Mon, 15 Apr 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183127; cv=none; b=doy6lfsJypX9WET+MGbe6CjlhmOqD/hBxW4fcbFWiudexytjbTn7E9OYeK6pEjGQ4N9+uWLR4giPGsQyE1RPfab9E5NAaDaJw+6lqj90Zex42WN0CpqNprusmMP0311qSdkBFRTflsQ9Zo1oZObxUawOM1M5ZgjUE9Opo7gIbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183127; c=relaxed/simple;
	bh=49BXH0ae9TmsC+ZVdMQDanlSwY5xhkGJJZaqFTj7XJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQwzRYCk+p0XTiawHFaltf35Sq33sA0IMWK9eucdlq2dHVctFFaZH6Mw1WlxCoDPkbaFWMvervdozV9iLAupCfoZwJPjW49uaSgZciglh51fdEMhHjx0Ei9fd4upT47T8IycFg2E3lKoTkGseG3knAfkcMjuI45UMyU0uwIjRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg0KzrXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D662C3277B;
	Mon, 15 Apr 2024 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183127;
	bh=49BXH0ae9TmsC+ZVdMQDanlSwY5xhkGJJZaqFTj7XJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg0KzrXcO4+o1oyoPNMzpuTpiKH1aOwgXCKdUveLdMW39FtPzn/bXuUxi2bkFFKMc
	 BwgHBko0f+Z5gulFsfxZJHVj6QJ8DNRqt8NV+e/5sQRlXZROA7WOqmtPhC0NmAjKxp
	 ky5xMm5I5lG5EaN6bPmVvD7hDtLyljNws0U3jvGclknWBfAQjrCcfbqa72LctqNrKN
	 SVX58dv3AHaANUxzSMn/SX0cpeXGewgyK8ovqfd2aAaUlqzg+fFTPRcA0NSFGXP1x7
	 ZdmtkwtxdYYZp/XMurJ1NdrM4di6+XDAxJPtXI5s+QG7k0ZO1lU8QHYgZzMhH1ZxwP
	 JUeJf81lhCPXw==
Date: Mon, 15 Apr 2024 17:42:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 3/3] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Message-ID: <20240415121200.GH7537@thinkpad>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713170945-44640-4-git-send-email-quic_qianyu@quicinc.com>

On Mon, Apr 15, 2024 at 04:49:05PM +0800, Qiang Yu wrote:

bus: mhi: host: pci_generic: Add support for triggering EDL mode in modems

> Add mhi_pci_generic_edl_trigger as edl_trigger for some devices (eg. SDX65)
> to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
> doorbell register and forcing an SOC reset afterwards.
> 

'Some of the MHI modems like SDX65 based ones are capable of entering the EDL
mode as per the standard triggering mechanism defined in the MHI spec <enter
spec version>. So let's add a common mhi_pci_generic_edl_trigger() function that
triggers the EDL mode in the device when user writes to the <insert full sysfs
entry here> file.'

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 47 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 51639bf..cbf8a58 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -27,12 +27,19 @@
>  #define PCI_VENDOR_ID_THALES	0x1269
>  #define PCI_VENDOR_ID_QUECTEL	0x1eac
>  
> +#define MHI_EDL_DB			91
> +#define MHI_EDL_COOKIE			0xEDEDEDED
> +
> +/* Device can enter EDL by first setting edl cookie then issuing inband reset*/
> +#define MHI_PCI_GENERIC_EDL_TRIGGER	BIT(0)

This is not needed as of now. Let the edl_trigger be bool for now. When vendors
want to add their own methods of triggering EDL, we can extend it.

> +
>  /**
>   * struct mhi_pci_dev_info - MHI PCI device specific information
>   * @config: MHI controller configuration
>   * @name: name of the PCI module
>   * @fw: firmware path (if any)
>   * @edl: emergency download mode firmware path (if any)
> + * @edl_trigger: each bit represents a different way to enter EDL

'capable of triggering EDL mode in the device (if supported)'

>   * @bar_num: PCI base address register to use for MHI MMIO register space
>   * @dma_data_width: DMA transfer word size (32 or 64 bits)
>   * @mru_default: default MRU size for MBIM network packets
> @@ -44,6 +51,7 @@ struct mhi_pci_dev_info {
>  	const char *name;
>  	const char *fw;
>  	const char *edl;
> +	unsigned int edl_trigger;
>  	unsigned int bar_num;
>  	unsigned int dma_data_width;
>  	unsigned int mru_default;
> @@ -292,6 +300,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>  	.name = "qcom-sdx75m",
>  	.fw = "qcom/sdx75m/xbl.elf",
>  	.edl = "qcom/sdx75m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>  	.config = &modem_qcom_v2_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -302,6 +311,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>  	.name = "qcom-sdx65m",
>  	.fw = "qcom/sdx65m/xbl.elf",
>  	.edl = "qcom/sdx65m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -312,6 +322,7 @@ static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
>  	.name = "qcom-sdx55m",
>  	.fw = "qcom/sdx55m/sbl1.mbn",
>  	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
>  	.config = &modem_qcom_v1_mhiv_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -928,6 +939,39 @@ static void health_check(struct timer_list *t)
>  	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>  }
>  
> +static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
> +{
> +	void __iomem *base = mhi_cntrl->regs;
> +	void __iomem *edl_db;
> +	int ret;
> +	u32 val;
> +
> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> +	if (ret) {
> +		dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail before trigger EDL\n");

'Failed to wakeup the device'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

