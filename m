Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E17805535
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbjLEMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjLEMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ECEA0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:52:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E0C433C8;
        Tue,  5 Dec 2023 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701780752;
        bh=6OBtOvpyrx0wR/KfCMCttoDVEX6P49xuNZ+3YdQODp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dslG6bDOrwrTyl6vp44aPHWUHLlJ/2JZtiQINypEYJ7wyuFWkCCmtiHLH1AgFPoJf
         5PKDllxff8XfWof763DKBaWf50/QUTpxD0HO+Vc4LiFZTIX5BMlJ8MBAdIxfQSZXnZ
         YrMUEg+VcD7BOujNZwCHN0Og2q+lddUC7mHiX56hoh/yxuPxTD33C/5JPdVrYjvrL4
         /2zKIez1jDnH6aWIzkOWPiAj/w6xCgoBMon/+6lcHkvdRHoLZnuAn8BtTXLE4Ji2xf
         sRegasgnca3c/1e38Awrn028ADeyKbMAKYQkTGmw7oa+Zruvse270rL7BgSH2dHEup
         vT6aTXveaUrsw==
Date:   Tue, 5 Dec 2023 18:22:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>,
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
Message-ID: <20231205125216.GA3208@thinkpad>
References: <20231204-sc7280-ufs-v5-0-926ceed550da@fairphone.com>
 <20231204-sc7280-ufs-v5-2-926ceed550da@fairphone.com>
 <621388b9-dcee-4af2-9763-e5d623d722b7@quicinc.com>
 <CXFJNBNKTRHH.2CS6TO2MEGJWL@fairphone.com>
 <20231204172829.GA69580@thinkpad>
 <CXG8INYXCEXN.C6TF6FALDP6D@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CXG8INYXCEXN.C6TF6FALDP6D@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:51:05AM +0100, Luca Weiss wrote:
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
> 
> Sounds reasonable (though I understand little how the SoC is wired up
> internally).
> 

I digged a bit more and found that the new SoCs (SM8550, etc,...) has
separate GDSC for PHY and UFS HC. So for those SoCs, we should use the
respective GDSC as the power domain.

But for old SoCs like this one, we should use MX as the power domain.

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
> Great!
> 
> So I'll send v6 with power-domains = <&rpmhpd SC7280_MX>; for the phy.
> 

Sounds good.

- Mani

> Regards
> Luca
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
