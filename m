Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28D80326D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjLDMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjLDMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:21:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D0E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:21:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso2598647a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1701692503; x=1702297303; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8RFfNckjuKt1jz+rzrb9C96eRyO85w6LaaTlbGWMzo=;
        b=zTrCvs2eCip52po00dOtx2DzzrpJtMPOcRbQDM41h23Lx7hyqZxquQ69VS47qcYEMu
         yG2brI5VZgUBHkfUJXTbD0K+qWqlZ/1GC/ZOHB8LD9LLFHTcfaDmXObrOoxtFjl2R3Gj
         mQtUppBX715VHQdSeTPR4z8hQovq8amq899U2XrnbiFWqxXwwAM5gqJgnMBwOwf19Ngs
         Kx5hWG5VOXcISr2x1YXfknjL/hHYkMMmOd3P2Gb09YWolz2PnH34nWfNQUDW0hRTRcVf
         /njPrbJORv8hDzE0T6SPXaXnAKEs3AZatCrws3M3WGs9Ln5eF7zRQAZhGaZnDGbWSJFw
         BoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701692503; x=1702297303;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8RFfNckjuKt1jz+rzrb9C96eRyO85w6LaaTlbGWMzo=;
        b=KlUl55Jh3k/2URg+WrsXHxmQhYwyKMXiVWy+vC+BsbzYBhLLnmYVLilEuqbJy+H/eP
         wvdHqEyCA7csvVXH5kXAnFLRxQt3HorJ4dAlduI9SDKuPK9iz6436+2fn5HpERvfAUzi
         99Z1GDSfgXTEkhGvH9e1XatG8vYExX46mN9eLPnBUh/v0xxG1KFd+m7/suA9pe/fmZF5
         KxM2weqIMwNZHVT+pvrdrbS8NtxcIkaEkdbNyNKIxILmsWyGiYrJXmMBW/tYCaIYZYpV
         7V29TFcvEGEXXv0ZRRQZVkJsxG2Ilai5wMiEEOp2jVN6E5YkyVANm3Fjkx5ujPPTvjSr
         5V+g==
X-Gm-Message-State: AOJu0YzMXJHtgMsAhSdW6pG1XHmP7nGWMnfNgVoX1c3KMfk3czi3U0zS
        cmRxC9L8BGRv3kZoJdRahNslRA==
X-Google-Smtp-Source: AGHT+IHKWbMqC/XghMiDqUXODnV4kB7sqmvxFiPQqj9C/x1YwTXvnOVPdhytEdl0d5XSJ62zUJ7Hsw==
X-Received: by 2002:a50:9b50:0:b0:54c:4837:9a9b with SMTP id a16-20020a509b50000000b0054c48379a9bmr2873330edj.66.1701692503652;
        Mon, 04 Dec 2023 04:21:43 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id dg28-20020a0564021d1c00b0054c9177d18esm2522554edb.2.2023.12.04.04.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:21:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Dec 2023 13:21:42 +0100
Message-Id: <CXFJNBNKTRHH.2CS6TO2MEGJWL@fairphone.com>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add UFS nodes for
 sc7280 soc
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Nitin Rawat" <quic_nitirawa@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
X-Mailer: aerc 0.15.2
References: <20231204-sc7280-ufs-v5-0-926ceed550da@fairphone.com>
 <20231204-sc7280-ufs-v5-2-926ceed550da@fairphone.com>
 <621388b9-dcee-4af2-9763-e5d623d722b7@quicinc.com>
In-Reply-To: <621388b9-dcee-4af2-9763-e5d623d722b7@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 4, 2023 at 1:15 PM CET, Nitin Rawat wrote:
>
>
> On 12/4/2023 3:54 PM, Luca Weiss wrote:
> > From: Nitin Rawat <quic_nitirawa@quicinc.com>
> >=20
> > Add UFS host controller and PHY nodes for sc7280 soc.
> >=20
> > Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QCM6490 FP5
> > [luca: various cleanups and additions as written in the cover letter]
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sc7280.dtsi | 74 +++++++++++++++++++++++++++=
++++++++-
> >   1 file changed, 73 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts=
/qcom/sc7280.dtsi
> > index 04bf85b0399a..8b08569f2191 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -15,6 +15,7 @@
> >   #include <dt-bindings/dma/qcom-gpi.h>
> >   #include <dt-bindings/firmware/qcom,scm.h>
> >   #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interconnect/qcom,icc.h>
> >   #include <dt-bindings/interconnect/qcom,osm-l3.h>
> >   #include <dt-bindings/interconnect/qcom,sc7280.h>
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -906,7 +907,7 @@ gcc: clock-controller@100000 {
> >   			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
> >   				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
> >   				 <0>, <&pcie1_phy>,
> > -				 <0>, <0>, <0>,
> > +				 <&ufs_mem_phy 0>, <&ufs_mem_phy 1>, <&ufs_mem_phy 2>,
> >   				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> >   			clock-names =3D "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
> >   				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
> > @@ -2238,6 +2239,77 @@ pcie1_phy: phy@1c0e000 {
> >   			status =3D "disabled";
> >   		};
> >  =20
> > +		ufs_mem_hc: ufs@1d84000 {
> > +			compatible =3D "qcom,sc7280-ufshc", "qcom,ufshc",
> > +				     "jedec,ufs-2.0";
> > +			reg =3D <0x0 0x01d84000 0x0 0x3000>;
> > +			interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > +			phys =3D <&ufs_mem_phy>;
> > +			phy-names =3D "ufsphy";
> > +			lanes-per-direction =3D <2>;
> > +			#reset-cells =3D <1>;
> > +			resets =3D <&gcc GCC_UFS_PHY_BCR>;
> > +			reset-names =3D "rst";
> > +
> > +			power-domains =3D <&gcc GCC_UFS_PHY_GDSC>;
> > +			required-opps =3D <&rpmhpd_opp_nom>;
> > +
> > +			iommus =3D <&apps_smmu 0x80 0x0>;
> > +			dma-coherent;
> > +
> > +			interconnects =3D <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> > +					 &cnoc2 SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
> > +			interconnect-names =3D "ufs-ddr", "cpu-ufs";
> > +
> > +			clocks =3D <&gcc GCC_UFS_PHY_AXI_CLK>,
> > +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> > +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> > +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> > +			clock-names =3D "core_clk",
> > +				      "bus_aggr_clk",
> > +				      "iface_clk",
> > +				      "core_clk_unipro",
> > +				      "ref_clk",
> > +				      "tx_lane0_sync_clk",
> > +				      "rx_lane0_sync_clk",
> > +				      "rx_lane1_sync_clk";
> > +			freq-table-hz =3D
> > +				<75000000 300000000>,
> > +				<0 0>,
> > +				<0 0>,
> > +				<75000000 300000000>,
> > +				<0 0>,
> > +				<0 0>,
> > +				<0 0>,
> > +				<0 0>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		ufs_mem_phy: phy@1d87000 {
> > +			compatible =3D "qcom,sc7280-qmp-ufs-phy";
> > +			reg =3D <0x0 0x01d87000 0x0 0xe00>;
> > +			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> > +				 <&gcc GCC_UFS_1_CLKREF_EN>;
> > +			clock-names =3D "ref", "ref_aux", "qref";
> > +
> > +			power-domains =3D <&gcc GCC_UFS_PHY_GDSC>;

Hi Nitin,

>
> GCC_UFS_PHY_GDSC is UFS controller GDSC. For sc7280 Phy we don't need thi=
s.

In the current dt-bindings the power-domains property is required.

Is there another power-domain for the PHY to use, or do we need to
adjust the bindings to not require power-domains property for ufs phy on
sc7280?

Also, with "PHY" in the name, it's interesting that this is not for the
phy ;)

Regards
Luca

>
> > +
> > +			resets =3D <&ufs_mem_hc 0>;
> > +			reset-names =3D "ufsphy";
> > +
> > +			#clock-cells =3D <1>;
> > +			#phy-cells =3D <0>;
> > +
> > +			status =3D "disabled";
> > +		};
> > +
> >   		ipa: ipa@1e40000 {
> >   			compatible =3D "qcom,sc7280-ipa";
> >  =20
> >=20

