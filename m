Return-Path: <linux-kernel+bounces-132653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130228997CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BF11C20E07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983ED146A94;
	Fri,  5 Apr 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtdK2RmT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A81145B3A;
	Fri,  5 Apr 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305798; cv=none; b=NXdiDWFpXKvt98qjeUVoZht/VZWDrnBmJXC1J5dCeTU2GtumbtkC2Cb1fmWoeMiyJHDdRJLaNQsUHBwO3LoruUOdbo/60X4VFN0yo7+MjKky1y175SnC5qAf9k20kO4RrYx7JK1nQYzPOqKPuxuCMyN1fTNRPaIbSD7V1yiBDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305798; c=relaxed/simple;
	bh=FoeVOgMwFaoVJU8txrUpqriYLH8fDMf3kDQnY5ZpSRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEZfMBEM58+wuyrfOJoa/T6BCGEhHHjoN1nCY0RSLhvDLutKeghieoGPT4b+l2pNWYY3e/otuwX/fevxdWqAFvPjdl+hwekmIrqSqqMtULj4XdqYeREXVD5YMZomC3DYNg+i0aeTSCj7f3Rofw+oGDmWxMQERACs74dB/gBlim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtdK2RmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012A8C433F1;
	Fri,  5 Apr 2024 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712305798;
	bh=FoeVOgMwFaoVJU8txrUpqriYLH8fDMf3kDQnY5ZpSRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtdK2RmTKX9NwDlPKJRn6RvGiZ1ugZMbMyFsjacOnfc1xkvxIM+IDh3VN2V+lU9vp
	 63FowDkfBUJPv4VU5bdLRNzExflstBbhGVnXcen+/8WQYB31Xb0Kn7TndT68usQnQT
	 Dz0MIDpkA5N0SOibLFuMW20u6KM11yjzmZbAAEmj6zXYcFJvFf6A76hByKQ1UCTs9l
	 pMfJmUqSpK4R4AhkTp5o6YtVyO2a/qEpSyqHXa7tUltEjufO0bJFtDUciLmvmxLNW2
	 EhsBUUvyfdtpVfWNfW7ZmYHrrtMFNgcwp6bEymLOVAw2/YtHRF9m5NKNfD2S2JsoW7
	 qlxw4qRKDaZ8g==
Date: Fri, 5 Apr 2024 13:59:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v8 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Message-ID: <20240405082944.GE2953@thinkpad>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-3-158285b86b10@quicinc.com>
 <20240304174111.GB31079@thinkpad>
 <9d878f69-c9d1-1ee4-f80e-1d8f16c6920e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d878f69-c9d1-1ee4-f80e-1d8f16c6920e@quicinc.com>

On Tue, Mar 05, 2024 at 04:23:21PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/4/2024 11:11 PM, Manivannan Sadhasivam wrote:
> > On Sat, Mar 02, 2024 at 09:29:57AM +0530, Krishna chaitanya chundru wrote:
> > > To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
> > > ICC (interconnect consumers) path should be voted otherwise it may
> > > lead to NoC (Network on chip) timeout. We are surviving because of
> > > other driver vote for this path.
> > > 
> > > As there is less access on this path compared to PCIe to mem path
> > > add minimum vote i.e 1KBps bandwidth always.
> > 
> > Please add the info that 1KBps is what shared by the HW team.
> > 
> Ack to all the comments
> > > 
> > > When suspending, disable this path after register space access
> > > is done.
> > > 
> > > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++++--
> > >   1 file changed, 36 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 10f2d0bb86be..a0266bfe71f1 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[...]

> > > +	ret = icc_disable(pcie->icc_cpu);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
> > 
> > "CPU-PCIe"
> > 
> > > +		if (pcie->suspended) {
> > > +			qcom_pcie_host_init(&pcie->pci->pp);
> > 
> > Interesting. So if icc_disable() fails, can the IP continue to function?
> > 
> As the ICC already enable before icc_disable() fails, the IP should work.

If icc_disable() fails, then most likely something is wrong with RPMh. How can
the IP continue to work in that case?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

