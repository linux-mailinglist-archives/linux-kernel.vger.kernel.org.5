Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD47F31B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjKUOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKUOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:55:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F73A98
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:55:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE614C433C7;
        Tue, 21 Nov 2023 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700578502;
        bh=q975IMvHTp904h9O7b2W+x9yRvoCm+xt1tUto3RHfXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohE6HsT9sw+OZaAGQxe04Vqxub4vBcXHT/A0cMRrMvn03KPK1kbWQmE8jUXPb7gHV
         3TAKuiNmtTdqWNX+6FVBSOzIPAM+O+7UVApq3aXx96TFQkV/YjTRxHTuJA25HYtfHD
         /7VpleuYHdh+x8VYrdfAKBNbaQyEP8yB9VFayYdoNKlNMh+vsBs8tvdH2VoSPGuSjA
         A7hGhp+4SPYAhMvbdB4yL80v3shwE9gFqwL2KqWOO3NKqtEO1DINXEx1tMPciNhgYx
         CtNcLPCTpUVZbqLhhOaH37XV4al0dAjoR89oySpAF8mnlfdtZt7cDaaz1bu+lCaaXE
         iWkQfhtbU6B8Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5S9h-0007vM-0T;
        Tue, 21 Nov 2023 15:55:13 +0100
Date:   Tue, 21 Nov 2023 15:55:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP
 controller as cache coherent
Message-ID: <ZVzE0c8UsW4HXV_u@hovoldconsulting.com>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:08:13PM +0530, Mrinmay Sarkar wrote:
> The PCIe EP controller on SA8775P supports cache coherency, hence add
> the "dma-coherent" property to mark it as such.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 7eab458..ab01efe 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3620,6 +3620,7 @@
>  				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>  		interconnect-names = "pcie-mem", "cpu-pcie";
>  
> +		dma-coherent;
>  		iommus = <&pcie_smmu 0x0000 0x7f>;
>  		resets = <&gcc GCC_PCIE_0_BCR>;
>  		reset-names = "core";

What tree is this against? 

Both controllers are already marked as dma-coherent in mainline so this
patch makes no sense (and the context also looks wrong).

It was even you added them apparently:

	489f14be0e0a ("arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes")

Johan
