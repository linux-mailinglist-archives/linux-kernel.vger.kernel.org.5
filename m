Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5750979E4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjIMKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjIMKZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:25:21 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 03:25:17 PDT
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A342719B2;
        Wed, 13 Sep 2023 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1694600715; x=1694859915;
        bh=j2bZUbHn1fYvLLZAU6epHZ10YTHV4Zbb2PaB882T1Us=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=nS505dD0/EbnrmYip73Pl4Ik5XTe3GnsP1SIdmtdCjOtSMaQer2JrTDY4QmXBLMX0
         Ux5Hn+FmKi1Cdu3n5rl0V7NB4H00VAr4LgIACw/2WKzudJ4GsqZVMf03fjH3O8w7YV
         8gLxI+QaLyVWCckZ5RQx6+gxbeUReMhcIfqmXLT+O9ha8Skyo3VNYw6tm/1Rc9ok94
         xNSkxpGcKpEUfvMx/dSr1/OKP+MkyC5FfjFyAxKHYKLhnZvChqAslh6m2NBuEeOfsp
         oJHeFQt+yFpns3Q3VWCHWIIj6uUcEhdHk7qWIoFWb8OwrdztXfPBAwo6Rpb2GlvnNO
         79HoMuvnqhpuA==
Date:   Wed, 13 Sep 2023 10:25:05 +0000
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
Subject: Re: [PATCH v2 12/14] arm64: dts: qcom: msm8996: Remove AGGRE2 clock from SLPI
Message-ID: <d72b7d68-afa4-45a4-ab2a-7c86954cde12@protonmail.com>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 4:31 pm, Konrad Dybcio wrote:
> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
> within the interconnect driver. Attaching it to SLPI was a total hack.
> Get rid of it.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/=
qcom/msm8996.dtsi
> index acef67ab0581..7061a8e12c81 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2433,9 +2433,8 @@ slpi_pil: remoteproc@1c00000 {
>   =09=09=09=09=09  "handover",
>   =09=09=09=09=09  "stop-ack";
>  =20
> -=09=09=09clocks =3D <&xo_board>,
> -=09=09=09=09 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -=09=09=09clock-names =3D "xo", "aggre2";
> +=09=09=09clocks =3D <&xo_board>;
> +=09=09=09clock-names =3D "xo";
>  =20
>   =09=09=09memory-region =3D <&slpi_mem>;
>  =20

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>

