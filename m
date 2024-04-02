Return-Path: <linux-kernel+bounces-127357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E1894A43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B262C1C21FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656CD17BAA;
	Tue,  2 Apr 2024 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnXJMWyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC47179A8;
	Tue,  2 Apr 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712030810; cv=none; b=YuHyhNijLa1A2TQDgj482LAGJxzERgWHfCR88lCR4ODlZxexISnOAAY+/1hWmp75PaSyKMgjKTVkKCOAesvSA1M60p2QiaaIU+VYySzwI1JcsAo2M6X7oaPpKd7p6Cf4ZjshhEpf1xx+kRuXkZmImYaEUxb/IGeC9e5Vp1Czbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712030810; c=relaxed/simple;
	bh=cqq0rX5kfGKvJZHle23cnOIeKwCuzcmQ47251nGGIZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsYB7sOjtH9P2OHP5EMEl6aWlVlACu4wfUfqjeggEi6CSVmir5VSR4oa6zoNM8Bg10v+OH4oPt0qHerqehk0F2xuLxbyJ58WHcX/p20OS1OsBSy7LWl/MDeCEkGgOHi0knL6UmL1VwGfVQQf7AU0vcqKWo3HoCxY9H8npyQNeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnXJMWyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80DBC433C7;
	Tue,  2 Apr 2024 04:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712030810;
	bh=cqq0rX5kfGKvJZHle23cnOIeKwCuzcmQ47251nGGIZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnXJMWyD3zzSj5MO91Jf5eMslBoHsCI3QFd3NSVN4tQ83JY42I/bvsHWIU2/J2gxT
	 YIMUbvdBuL8SoQb0YbB5aTlvVLYQ6BMZGjMHWiusYkVHIdJeTIc37LIjyQOpq89FfT
	 QR4PU8JG/TITIs0y3F5qdNwYz5xnOk7IGkvVvl8dHwDrsfEuneieYm9vNT7La5RXoW
	 a968jf/Ut5QJxhvFMLSyDRQey1/SzUYG2pQRjR7o8baseln3wkaM4yWiB2K3vArFHv
	 c5c0p3AJ7+Jps3jIetlTKyBLGJsfs4pyPEZ/ErIFqaUgglVSnQalPfbTE+cilrpdJP
	 2v+RTGLtnddCg==
Date: Tue, 2 Apr 2024 09:36:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add UFS nodes for
 sc7280 soc
Message-ID: <20240402040641.GA2933@thinkpad>
References: <20231204-sc7280-ufs-v5-0-926ceed550da@fairphone.com>
 <20231204-sc7280-ufs-v5-2-926ceed550da@fairphone.com>
 <621388b9-dcee-4af2-9763-e5d623d722b7@quicinc.com>
 <CXFJNBNKTRHH.2CS6TO2MEGJWL@fairphone.com>
 <20231204172829.GA69580@thinkpad>
 <D004BPW9N0FS.376F67CINO459@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D004BPW9N0FS.376F67CINO459@fairphone.com>

On Fri, Mar 22, 2024 at 08:59:12AM +0100, Luca Weiss wrote:
> On Mon Dec 4, 2023 at 6:28 PM CET, Manivannan Sadhasivam wrote:
> > On Mon, Dec 04, 2023 at 01:21:42PM +0100, Luca Weiss wrote:
> > > On Mon Dec 4, 2023 at 1:15 PM CET, Nitin Rawat wrote:
> > > >
> > > >
> > > > On 12/4/2023 3:54 PM, Luca Weiss wrote:
> > > > > From: Nitin Rawat <quic_nitirawa@quicinc.com>
> > > > > 
> > > > > Add UFS host controller and PHY nodes for sc7280 soc.
> > > > > 
> > > > > Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > > Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QCM6490 FP5
> > > > > [luca: various cleanups and additions as written in the cover letter]
> > > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/sc7280.dtsi | 74 +++++++++++++++++++++++++++++++++++-
> > > > >   1 file changed, 73 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > > > index 04bf85b0399a..8b08569f2191 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > > > @@ -15,6 +15,7 @@
> > > > >   #include <dt-bindings/dma/qcom-gpi.h>
> > > > >   #include <dt-bindings/firmware/qcom,scm.h>
> > > > >   #include <dt-bindings/gpio/gpio.h>
> > > > > +#include <dt-bindings/interconnect/qcom,icc.h>
> > > > >   #include <dt-bindings/interconnect/qcom,osm-l3.h>
> > > > >   #include <dt-bindings/interconnect/qcom,sc7280.h>
> > > > >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > @@ -906,7 +907,7 @@ gcc: clock-controller@100000 {
> > > > >   			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > > > >   				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
> > > > >   				 <0>, <&pcie1_phy>,
> > > > > -				 <0>, <0>, <0>,
> > > > > +				 <&ufs_mem_phy 0>, <&ufs_mem_phy 1>, <&ufs_mem_phy 2>,
> > > > >   				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> > > > >   			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
> > > > >   				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
> > > > > @@ -2238,6 +2239,77 @@ pcie1_phy: phy@1c0e000 {
> > > > >   			status = "disabled";
> > > > >   		};
> > > > >   
> > > > > +		ufs_mem_hc: ufs@1d84000 {
> > > > > +			compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
> > > > > +				     "jedec,ufs-2.0";
> > > > > +			reg = <0x0 0x01d84000 0x0 0x3000>;
> > > > > +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +			phys = <&ufs_mem_phy>;
> > > > > +			phy-names = "ufsphy";
> > > > > +			lanes-per-direction = <2>;
> > > > > +			#reset-cells = <1>;
> > > > > +			resets = <&gcc GCC_UFS_PHY_BCR>;
> > > > > +			reset-names = "rst";
> > > > > +
> > > > > +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> > > > > +			required-opps = <&rpmhpd_opp_nom>;
> > > > > +
> > > > > +			iommus = <&apps_smmu 0x80 0x0>;
> > > > > +			dma-coherent;
> > > > > +
> > > > > +			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
> > > > > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > > > > +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> > > > > +					 &cnoc2 SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
> > > > > +			interconnect-names = "ufs-ddr", "cpu-ufs";
> > > > > +
> > > > > +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> > > > > +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> > > > > +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> > > > > +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> > > > > +				 <&rpmhcc RPMH_CXO_CLK>,
> > > > > +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> > > > > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> > > > > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> > > > > +			clock-names = "core_clk",
> > > > > +				      "bus_aggr_clk",
> > > > > +				      "iface_clk",
> > > > > +				      "core_clk_unipro",
> > > > > +				      "ref_clk",
> > > > > +				      "tx_lane0_sync_clk",
> > > > > +				      "rx_lane0_sync_clk",
> > > > > +				      "rx_lane1_sync_clk";
> > > > > +			freq-table-hz =
> > > > > +				<75000000 300000000>,
> > > > > +				<0 0>,
> > > > > +				<0 0>,
> > > > > +				<75000000 300000000>,
> > > > > +				<0 0>,
> > > > > +				<0 0>,
> > > > > +				<0 0>,
> > > > > +				<0 0>;
> > > > > +			status = "disabled";
> > > > > +		};
> > > > > +
> > > > > +		ufs_mem_phy: phy@1d87000 {
> > > > > +			compatible = "qcom,sc7280-qmp-ufs-phy";
> > > > > +			reg = <0x0 0x01d87000 0x0 0xe00>;
> > > > > +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > > > > +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> > > > > +				 <&gcc GCC_UFS_1_CLKREF_EN>;
> > > > > +			clock-names = "ref", "ref_aux", "qref";
> > > > > +
> > > > > +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> > > 
> > > Hi Nitin,
> > > 
> > > >
> > > > GCC_UFS_PHY_GDSC is UFS controller GDSC. For sc7280 Phy we don't need this.
> > > 
> > > In the current dt-bindings the power-domains property is required.
> > > 
> > > Is there another power-domain for the PHY to use, or do we need to
> > > adjust the bindings to not require power-domains property for ufs phy on
> > > sc7280?
> > > 
> >
> > PHYs are backed by MX power domain. So you should use that.
> >
> > > Also, with "PHY" in the name, it's interesting that this is not for the
> > > phy ;)
> > > 
> >
> > Yes, confusing indeed. But the controllers (PCIe, UFS, USB etc...) are backed by
> > GDSCs and all the analog components (PHYs) belong to MX domain since it is kind
> > of always ON.
> >
> > I'll submit a series to fix this for the rest of the SoCs.
> 
> Hi Mani,
> 
> Did you get around to sending such series?
> 

Sorry not yet. I wanted to send this series after the cleanup of AUX_CLK, but
that got stalled due to different reasons.

Let me try to send this one asap.

- Mani

> This would also fix some binding warnings, e.g. on SM6350.
> 
>   arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: phy@1d87000: 'power-domains' is a required property
>           from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-ufs-phy.yaml#
> 
> Regards
> Luca
> 
> 
> >
> > - Mani
> >
> > > Regards
> > > Luca
> > > 
> > > >
> > > > > +
> > > > > +			resets = <&ufs_mem_hc 0>;
> > > > > +			reset-names = "ufsphy";
> > > > > +
> > > > > +			#clock-cells = <1>;
> > > > > +			#phy-cells = <0>;
> > > > > +
> > > > > +			status = "disabled";
> > > > > +		};
> > > > > +
> > > > >   		ipa: ipa@1e40000 {
> > > > >   			compatible = "qcom,sc7280-ipa";
> > > > >   
> > > > > 
> > > 
> 

-- 
மணிவண்ணன் சதாசிவம்

