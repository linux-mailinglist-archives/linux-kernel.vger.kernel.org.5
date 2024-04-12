Return-Path: <linux-kernel+bounces-143116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587048A347D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC82844B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0E14C584;
	Fri, 12 Apr 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3Z0ASd1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C063148313;
	Fri, 12 Apr 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941757; cv=none; b=SloBFHao6cAQk6HKVdu0VA4LgoQvbZa7alpqPz+Um1/M8hioWrPNDPf3g0am+HmTI68BXiMSNl/xIqdvIXgD/sXeknqVzzmDgLtCZ+OwU4h0wY694oT+YBMt09DOq3q4l4ryKC2ri1fYq+shohtvEGbcMQWyfPnZZXx+16pWwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941757; c=relaxed/simple;
	bh=rODVTp50yYh7uHyWLRmbneyBP6EM4zG3s6ciF0ijsFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8I1svBbqgcSP36TyMuNCdbACPjhTHTl9ZGbj1zcqckAWeFEfmgqcDNlyycVGCqX7XLSF1RW7DVZshRz+savlRCLOM3sDMA/ievzJb2CHXRhplK/qnQEdFgxXldmffu4I1sEllsfvM9j7o/3Fdkh3CytSWzwRvUai1Nnyn6DIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3Z0ASd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C47C113CC;
	Fri, 12 Apr 2024 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712941757;
	bh=rODVTp50yYh7uHyWLRmbneyBP6EM4zG3s6ciF0ijsFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3Z0ASd1Vbz2BCHg856p6HeTst7bRy6ZsqyXB2MPPhztelw89YGgJdwfb26UO9PhP
	 v64xiouHlIWYFFTKKQykYPSLp1P1f0BAZlFKZlJQkEGWV/srZcakZ5Bm6r2Dv2Or3A
	 5TeD7cKC3+MU5LlBPYJcWBGYP7BzIjIfvPQZi4BobvEXrbzZwXZwL0sfzRRZbq398T
	 0GyMAPOjmDLEJeUtaeFaYWK8gMO+4FTZ1okPz0kxmghQ1evPREBo9eo2nAoqErVAP0
	 e+C7x0hi1ITEnrgSS3YkxeV4sYEiGFlbxDZCfPm9Y/7gby+EhiXmiV+j8veUiFaVBz
	 PjpmnUwVJALzQ==
Date: Fri, 12 Apr 2024 22:39:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, mani@kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v2 2/2] bus: mhi: host: pci_generic: Add edl callback to
 enter EDL
Message-ID: <20240412170910.GA21555@thinkpad>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
 <1712805329-46158-3-git-send-email-quic_qianyu@quicinc.com>
 <78de32be-7e3b-e7e9-61f3-9679993dbe71@quicinc.com>
 <a901549e-c3ec-47b5-9523-a6342eca455f@quicinc.com>
 <95ee53a5-e261-9106-1104-09077e348a99@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95ee53a5-e261-9106-1104-09077e348a99@quicinc.com>

On Fri, Apr 12, 2024 at 08:16:52AM -0600, Jeffrey Hugo wrote:
> On 4/12/2024 1:13 AM, Qiang Yu wrote:
> > 
> > On 4/11/2024 10:46 PM, Jeffrey Hugo wrote:
> > > On 4/10/2024 9:15 PM, Qiang Yu wrote:
> > > > Add mhi_pci_generic_edl_trigger as edl_trigger for some devices
> > > > (eg. SDX65)
> > > > to enter EDL mode by writing the 0xEDEDEDED cookie to the channel 91
> > > > doorbell register and forcing an SOC reset afterwards.
> > > > 
> > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > ---
> > > >   drivers/bus/mhi/host/pci_generic.c | 50
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 50 insertions(+)
> > > > 
> > > > diff --git a/drivers/bus/mhi/host/pci_generic.c
> > > > b/drivers/bus/mhi/host/pci_generic.c
> > > > index 51639bf..a529815 100644
> > > > --- a/drivers/bus/mhi/host/pci_generic.c
> > > > +++ b/drivers/bus/mhi/host/pci_generic.c
> > > > @@ -27,12 +27,23 @@
> > > >   #define PCI_VENDOR_ID_THALES    0x1269
> > > >   #define PCI_VENDOR_ID_QUECTEL    0x1eac
> > > >   +#define MHI_EDL_DB            91
> > > > +#define MHI_EDL_COOKIE            0xEDEDEDED
> > > > +
> > > > +/* Device can enter EDL by first setting edl cookie then
> > > > issuing inband reset*/
> > > > +#define MHI_PCI_GENERIC_EDL_TRIGGER    BIT(0)
> > > > +
> > > > +#define CHDBOFF            0x18
> > > 
> > > This is already in drivers/bus/mhi/common.h why duplicate it here?
> > 
> > I only see common.h be included in ep/internal.h host/internal.h and
> > host/trace.h. So I thought it can only be used by MHI stack. Can we
> > include common.h in pci_generic.c?
> 
> Up to Mani, but duplicating the definition seems like it would result in
> maintence overhead over time.  An alternative to including the header might
> be a new API between MHI and controller which allow the setting of a CHDB to
> a specific value.
> 

+1 to the new API suggestion.

- Mani

> > > 
> > > > +#define CHDBOFF_CHDBOFF_MASK 0xFFFFFFFF
> > > > +#define CHDBOFF_CHDBOFF_SHIFT    0
> > > > +
> > > >   /**
> > > >    * struct mhi_pci_dev_info - MHI PCI device specific information
> > > >    * @config: MHI controller configuration
> > > >    * @name: name of the PCI module
> > > >    * @fw: firmware path (if any)
> > > >    * @edl: emergency download mode firmware path (if any)
> > > > + * @edl_trigger: each bit represents a different way to enter EDL
> > > >    * @bar_num: PCI base address register to use for MHI MMIO
> > > > register space
> > > >    * @dma_data_width: DMA transfer word size (32 or 64 bits)
> > > >    * @mru_default: default MRU size for MBIM network packets
> > > > @@ -44,6 +55,7 @@ struct mhi_pci_dev_info {
> > > >       const char *name;
> > > >       const char *fw;
> > > >       const char *edl;
> > > > +    unsigned int edl_trigger;
> > > >       unsigned int bar_num;
> > > >       unsigned int dma_data_width;
> > > >       unsigned int mru_default;
> > > > @@ -292,6 +304,7 @@ static const struct mhi_pci_dev_info
> > > > mhi_qcom_sdx75_info = {
> > > >       .name = "qcom-sdx75m",
> > > >       .fw = "qcom/sdx75m/xbl.elf",
> > > >       .edl = "qcom/sdx75m/edl.mbn",
> > > > +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
> > > >       .config = &modem_qcom_v2_mhiv_config,
> > > >       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> > > >       .dma_data_width = 32,
> > > > @@ -302,6 +315,7 @@ static const struct mhi_pci_dev_info
> > > > mhi_qcom_sdx65_info = {
> > > >       .name = "qcom-sdx65m",
> > > >       .fw = "qcom/sdx65m/xbl.elf",
> > > >       .edl = "qcom/sdx65m/edl.mbn",
> > > > +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
> > > >       .config = &modem_qcom_v1_mhiv_config,
> > > >       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> > > >       .dma_data_width = 32,
> > > > @@ -312,6 +326,7 @@ static const struct mhi_pci_dev_info
> > > > mhi_qcom_sdx55_info = {
> > > >       .name = "qcom-sdx55m",
> > > >       .fw = "qcom/sdx55m/sbl1.mbn",
> > > >       .edl = "qcom/sdx55m/edl.mbn",
> > > > +    .edl_trigger = MHI_PCI_GENERIC_EDL_TRIGGER,
> > > >       .config = &modem_qcom_v1_mhiv_config,
> > > >       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> > > >       .dma_data_width = 32,
> > > > @@ -928,6 +943,38 @@ static void health_check(struct timer_list *t)
> > > >       mod_timer(&mhi_pdev->health_check_timer, jiffies +
> > > > HEALTH_CHECK_PERIOD);
> > > >   }
> > > >   +static int mhi_pci_generic_edl_trigger(struct mhi_controller
> > > > *mhi_cntrl)
> > > > +{
> > > > +    int ret;
> > > > +    u32 val;
> > > > +    void __iomem *edl_db;
> > > > +    void __iomem *base = mhi_cntrl->regs;
> > > 
> > > It looks like this file follows reverse christmas tree, but this
> > > function does not. you should fix it.
> > 
> > Will fix it in next version patch.
> > > 
> > > > +
> > > > +    ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> > > > +    if (ret) {
> > > > +        dev_err(mhi_cntrl->cntrl_dev, "Wake up device fail
> > > > before trigger EDL\n");
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
> > > > +    mhi_cntrl->runtime_get(mhi_cntrl);
> > > > +
> > > > +    mhi_cntrl->read_reg(mhi_cntrl, base + CHDBOFF, &val);
> > > > +    val = (val & CHDBOFF_CHDBOFF_MASK) >> CHDBOFF_CHDBOFF_SHIFT;
> > > > +
> > > > +    edl_db = base + val + (8 * MHI_EDL_DB);
> > > > +
> > > > +    mhi_cntrl->write_reg(mhi_cntrl, edl_db + 4,
> > > > upper_32_bits(MHI_EDL_COOKIE));
> > > > +    mhi_cntrl->write_reg(mhi_cntrl, edl_db,
> > > > lower_32_bits(MHI_EDL_COOKIE));
> > > > +
> > > > +    mhi_soc_reset(mhi_cntrl);
> > > > +
> > > > +    mhi_cntrl->runtime_put(mhi_cntrl);
> > > > +    mhi_device_put(mhi_cntrl->mhi_dev);
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   static int mhi_pci_probe(struct pci_dev *pdev, const struct
> > > > pci_device_id *id)
> > > >   {
> > > >       const struct mhi_pci_dev_info *info = (struct
> > > > mhi_pci_dev_info *) id->driver_data;
> > > > @@ -962,6 +1009,9 @@ static int mhi_pci_probe(struct pci_dev
> > > > *pdev, const struct pci_device_id *id)
> > > >       mhi_cntrl->runtime_put = mhi_pci_runtime_put;
> > > >       mhi_cntrl->mru = info->mru_default;
> > > >   +    if (info->edl_trigger & MHI_PCI_GENERIC_EDL_TRIGGER)
> > > > +        mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
> > > > +
> > > >       if (info->sideband_wake) {
> > > >           mhi_cntrl->wake_get = mhi_pci_wake_get_nop;
> > > >           mhi_cntrl->wake_put = mhi_pci_wake_put_nop;
> > > 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

