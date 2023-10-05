Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C146F7B9EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjJEOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjJEOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:12:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0FC26FC4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:01:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9adca291f99so166399766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696510884; x=1697115684; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnG0sR/xGQYYsyFaEt/vfjkPa8+Rqti/iCkeoYG1xiY=;
        b=OcVh4o85DKq0RIi0L2YWQQ5/omCian82i8NVwd2fWWeLZKuQ1S3xNvPbCrVIaL3aR+
         gESPkq87ecsbi+XSqzcVrOljqPY2ZHcS7DrtNpiHvIHf/tnwHrdsiQy1dZKXbbnRMyNT
         9BPqHbf6CWGd5u07MeLMIfGC94iRnS6rcswgG44g7cxCzaUpCr8Ex/1LQ3xxYqvPlI2P
         b52JIv/Xj9s+cRDT9SJLmrC/nJxcw4M9jVo6/7afRd8SOaUU2174e/bSOWt2kYEkh/I3
         wY0ioOOIqthdnAuksgtOKxLO5clVyUe2pAh03CfdIy1pwEGwCYszISFMxlSXj4qqKHVF
         Fc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510884; x=1697115684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnG0sR/xGQYYsyFaEt/vfjkPa8+Rqti/iCkeoYG1xiY=;
        b=L94zi5DmeZ3WZpaq8G7+HDEFUt0mEfurCa2JZ+sbfCJ0mz86GQWYa9Jhh2psEHsgIs
         j5LK0QJTVS19FXc0C0avbHWltCHhVtiUPj9Oa811043qNVB9ZAtbii0qp13BnKnXttJS
         9nQO6hYiNcNvX/wScWU7Qf+1IVfb5xlMIY3zPaq1wuC/7GhF6XjQN1l6UP5bgwa9Al30
         vuGiZdHfw1SyFNKRGkCIivQP3XfTo8HxEQb0xyI9e2Xv54KpUX3EkSon8fUWmgwtsnV+
         eyqoibm6qRPHmm42uDBcqd0TrajWfVTwqYGnJw7VxTF1cydTgDft1rTydJfQiqYKaGNR
         Fiqw==
X-Gm-Message-State: AOJu0YwgHHAqvkVb4okXMffClCgOV0tkqOIXfUfOyk4EUA8KCncGozD7
        cKqT36bPFwagVSWEvmC86BBL0A==
X-Google-Smtp-Source: AGHT+IFG8s+97gnXPNAdl7stS8nrro27q9Tek5RX5a8f1kLRhXzS+/P1ypSsYAbnG7kRBJjHdTyusg==
X-Received: by 2002:a17:907:6c14:b0:9a5:cf6f:3efc with SMTP id rl20-20020a1709076c1400b009a5cf6f3efcmr3536424ejc.77.1696510883979;
        Thu, 05 Oct 2023 06:01:23 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b009ad875d12d7sm1149455eja.210.2023.10.05.06.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 06:01:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 05 Oct 2023 15:01:22 +0200
Message-Id: <CW0IX09PNB86.36RDKF8LNWIBM@fairphone.com>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH V4 2/4] arm64: dts: qcom: sc7280: Add UFS nodes for
 sc7280 soc
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Nitin Rawat" <quic_nitirawa@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>, <alim.akhtar@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
X-Mailer: aerc 0.15.2
References: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
 <20230929131936.29421-3-quic_nitirawa@quicinc.com>
In-Reply-To: <20230929131936.29421-3-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 29, 2023 at 3:19 PM CEST, Nitin Rawat wrote:
> Add UFS host controller and PHY nodes for sc7280 soc.

Hi Nitin,

I left some comments for v3 that maybe you missed before sending v4:
https://lore.kernel.org/linux-arm-msm/CVVA1OVF4W9E.380D6QC1K9GD6@otso/

At least the clock part should definitely be fixed, ICE we can do later.

Regards
Luca

>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 66 ++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/q=
com/sc7280.dtsi
> index 66f1eb83cca7..163e3df60966 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3353,6 +3353,72 @@
>  			};
>  		};
>
> +		ufs_mem_hc: ufs@1d84000 {
> +			compatible =3D "qcom,sc7280-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg =3D <0x0 0x01d84000 0x0 0x3000>;
> +			interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys =3D <&ufs_mem_phy>;
> +			phy-names =3D "ufsphy";
> +			lanes-per-direction =3D <2>;
> +			#reset-cells =3D <1>;
> +			resets =3D <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names =3D "rst";
> +
> +			power-domains =3D <&gcc GCC_UFS_PHY_GDSC>;
> +			required-opps =3D <&rpmhpd_opp_nom>;
> +
> +			iommus =3D <&apps_smmu 0x80 0x0>;
> +			dma-coherent;
> +
> +			interconnects =3D <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0=
>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_UFS_MEM_CFG 0>;
> +
> +			clocks =3D <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			clock-names =3D "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +			freq-table-hz =3D
> +				<75000000 300000000>,
> +				<0 0>,
> +				<0 0>,
> +				<75000000 300000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>;
> +			status =3D "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@1d87000 {
> +			compatible =3D "qcom,sc7280-qmp-ufs-phy";
> +			reg =3D <0x0 0x01d87000 0x0 0xe00>;
> +			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&gcc GCC_UFS_1_CLKREF_EN>;
> +			clock-names =3D "ref", "ref_aux", "qref";
> +
> +			resets =3D <&ufs_mem_hc 0>;
> +			reset-names =3D "ufsphy";
> +
> +			#clock-cells =3D <1>;
> +			#phy-cells =3D <0>;
> +
> +			status =3D "disabled";
> +		};
> +
>  		usb_1_hsphy: phy@88e3000 {
>  			compatible =3D "qcom,sc7280-usb-hs-phy",
>  				     "qcom,usb-snps-hs-7nm-phy";
> --
> 2.17.1

