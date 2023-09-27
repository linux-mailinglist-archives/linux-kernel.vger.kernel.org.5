Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9BD7B048D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjI0Mn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjI0Mn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:43:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A6E6;
        Wed, 27 Sep 2023 05:43:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D0C433C8;
        Wed, 27 Sep 2023 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695818606;
        bh=hot0489NCeMODOQPnfql7FbJn28GF6c4vF2S/pF88X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyWPcsVLiZasHkrVXcm9nVnluFasSlBWl5wPJQBuv+eho/mQs2sCvJD+87VwOWmpf
         0JclVCe+5GHl9GEkjM0aTOmQN9XqmW0zIDD/bDtRMUMx3FLjK0qwsgv2GkJHCGzZVt
         vzB1HDekfqQROvqSd/RQbhjJ9N/5KhAqMDTD1jT113/dcGpJOfR8lgitEe9S5yn/u6
         nK1VB7/iUTzFXaxKAkdTaaWxwXDaY1LOzWfmOb8xjq7Cw5NtuOHivPuABzN6Fh4iG9
         /l2LruT31kaTAoa/cEIgOOe24Ir/M8POKw9CTlYbboazOmH35rDosXOdHnsR6MRT2l
         qCwZUpWUnJ+yA==
Date:   Wed, 27 Sep 2023 14:43:17 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        alim.akhtar@samsung.com, bvanassche@acm.org, avri.altman@wdc.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 3/4] arm64: dts: qcom: sc7280: Add UFS nodes for
 sc7280 IDP board
Message-ID: <20230927124317.GC18050@thinkpad>
References: <20230927081858.15961-1-quic_nitirawa@quicinc.com>
 <20230927081858.15961-4-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927081858.15961-4-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:48:57PM +0530, Nitin Rawat wrote:
> Add UFS host controller and PHY nodes for sc7280 IDP board.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 2ff549f4dc7a..a0059527d9e4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -499,6 +499,25 @@
>  	status = "okay";
>  };
> 
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l7b_2p9>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l9b_1p2>;
> +	vccq-max-microamp = <900000>;
> +	vccq2-supply = <&vreg_l9b_1p2>;
> +	vccq2-max-microamp = <900000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l10c_0p8>;
> +	vdda-pll-supply = <&vreg_l6b_1p2>;
> +
> +	status = "okay";
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
