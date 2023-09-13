Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5879E4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbjIMKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbjIMKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:18:03 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043A1727;
        Wed, 13 Sep 2023 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1694600274; x=1694859474;
        bh=o04ZkDhGEQiMSjegGwkSlBK9o//0n7IC0xvMsy4y6zM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=cGjQpMVqhLgjT7lMXdRF/pwQdOZwQxW3t3RUKfmyz2TCtcRlRYJbItv+V9FVKLkVv
         r0uaitQJrw182K3KWyjHl/ABEwuegveaIODXVLt8f6CopA00DZdX2Dphu1uSJUG0Ly
         7pB+T/jWOQakfTYK8N0BA86+h5kXuLRUCOsaaqYqOO+oRyH8dDCLIEx3UdCJVHSFHC
         25yDD5PthDOzWnDaB/kIiUYB7J4nKtx6J8IRqCt0Sxs/se0XFUwDE1br7hpH0d1Kdz
         ymb7pyfY3wIjzSNvcKsBeBjqqiVDNR4KPiaa/oSl4sch1WwNAkVdp/9VVqkdo3jmc3
         8pJRPIACUtdKw==
Date:   Wed, 13 Sep 2023 10:17:39 +0000
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 02/14] arm64: dts: qcom: msm8996: Drop RPM bus clocks
Message-ID: <92bc6544-b652-41f5-8819-016c4f93e827@protonmail.com>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 4:31 pm, Konrad Dybcio wrote:
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 27 ++++-----------------------
>   1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/=
qcom/msm8996.dtsi
> index c8e0986425ab..acef67ab0581 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -798,9 +798,6 @@ bimc: interconnect@408000 {
>   =09=09=09compatible =3D "qcom,msm8996-bimc";
>   =09=09=09reg =3D <0x00408000 0x5a000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_BIMC_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_BIMC_A_CLK>;
>   =09=09};
>  =20
>   =09=09tsens0: thermal-sensor@4a9000 {
> @@ -851,18 +848,12 @@ cnoc: interconnect@500000 {
>   =09=09=09compatible =3D "qcom,msm8996-cnoc";
>   =09=09=09reg =3D <0x00500000 0x1000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_CNOC_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_CNOC_A_CLK>;
>   =09=09};
>  =20
>   =09=09snoc: interconnect@524000 {
>   =09=09=09compatible =3D "qcom,msm8996-snoc";
>   =09=09=09reg =3D <0x00524000 0x1c000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_SNOC_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>   =09=09};
>  =20
>   =09=09a0noc: interconnect@543000 {
> @@ -882,19 +873,14 @@ a1noc: interconnect@562000 {
>   =09=09=09compatible =3D "qcom,msm8996-a1noc";
>   =09=09=09reg =3D <0x00562000 0x5000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_AGGR1_NOC_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_AGGR1_NOC_A_CLK>;
>   =09=09};
>  =20
>   =09=09a2noc: interconnect@583000 {
>   =09=09=09compatible =3D "qcom,msm8996-a2noc";
>   =09=09=09reg =3D <0x00583000 0x7000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a", "aggre2_ufs_axi", "ufs_axi";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
> -=09=09=09=09 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
> +=09=09=09clock-names =3D "aggre2_ufs_axi", "ufs_axi";
> +=09=09=09clocks =3D <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
>   =09=09=09=09 <&gcc GCC_UFS_AXI_CLK>;
>   =09=09};
>  =20
> @@ -902,19 +888,14 @@ mnoc: interconnect@5a4000 {
>   =09=09=09compatible =3D "qcom,msm8996-mnoc";
>   =09=09=09reg =3D <0x005a4000 0x1c000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a", "iface";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_MMAXI_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_MMAXI_A_CLK>,
> -=09=09=09=09 <&mmcc AHB_CLK_SRC>;
> +=09=09=09clock-names =3D "iface";
> +=09=09=09clocks =3D <&mmcc AHB_CLK_SRC>;
>   =09=09};
>  =20
>   =09=09pnoc: interconnect@5c0000 {
>   =09=09=09compatible =3D "qcom,msm8996-pnoc";
>   =09=09=09reg =3D <0x005c0000 0x3000>;
>   =09=09=09#interconnect-cells =3D <1>;
> -=09=09=09clock-names =3D "bus", "bus_a";
> -=09=09=09clocks =3D <&rpmcc RPM_SMD_PCNOC_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
>   =09=09};
>  =20
>   =09=09tcsr_mutex: hwlock@740000 {

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>



