Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE87B2324
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjI1REK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjI1REI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD9BF;
        Thu, 28 Sep 2023 10:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FBCC433C7;
        Thu, 28 Sep 2023 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695920645;
        bh=jE9tXKJu50DRo7zgYMe7bHQgTESkYh7mtAmR3OQEMpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlsIKJ7TuQZmmFT8Wjami1xXfBlzop3WKPQT6HsEijfovQ3Urvv0e33AUvrhlz+/U
         vjS88aYIuJq3cWfdrTZ4DhUo6In1syyXbSCHe4BToSuwslHkZH7dPQo8Ti78ycDuw9
         3fwBzw6aX2QFDYQ5S3JMRJHen/AQWkQaA7g0wuh4NjOCwaPN1epyjLOhIPyLFfqkil
         FuKjAn/kVXUYWOaX+r1TGiVoeeMAI/eSwXLNgkbvDMvXuDXWag5T/Hh5ZassG1vO10
         SuYQ0LBGWi6qnRLBg/uHUo5Kcpp0lRCzvnezd5rzufzlNRPRiKJGBxfnhzLWRBq7am
         s0emOKO5muLiw==
Received: (nullmailer pid 854231 invoked by uid 1000);
        Thu, 28 Sep 2023 17:04:02 -0000
Date:   Thu, 28 Sep 2023 12:04:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, alim.akhtar@samsung.com, bvanassche@acm.org,
        avri.altman@wdc.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 4/4] dt-bindings: ufs: qcom: Align clk binding
 property for Qualcomm UFS
Message-ID: <20230928170402.GA852313-robh@kernel.org>
References: <20230927082700.17593-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927082700.17593-1-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:57:00PM +0530, Nitin Rawat wrote:
> Align the binding property for clock such that "clocks" property
> comes first followed by "clock-names" property.

Why do we care?

> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  .../devicetree/bindings/ufs/qcom,ufs.yaml        | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 802640efa956..d17bdc4e934f 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -295,14 +295,6 @@ examples:
>                              <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
>              interconnect-names = "ufs-ddr", "cpu-ufs";
> 
> -            clock-names = "core_clk",
> -                          "bus_aggr_clk",
> -                          "iface_clk",
> -                          "core_clk_unipro",
> -                          "ref_clk",
> -                          "tx_lane0_sync_clk",
> -                          "rx_lane0_sync_clk",
> -                          "rx_lane1_sync_clk";
>              clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>                       <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>                       <&gcc GCC_UFS_PHY_AHB_CLK>,
> @@ -311,6 +303,14 @@ examples:
>                       <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>                       <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>                       <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +            clock-names = "core_clk",
> +                          "bus_aggr_clk",
> +                          "iface_clk",
> +                          "core_clk_unipro",
> +                          "ref_clk",
> +                          "tx_lane0_sync_clk",
> +                          "rx_lane0_sync_clk",
> +                          "rx_lane1_sync_clk";
>              freq-table-hz = <75000000 300000000>,
>                              <0 0>,
>                              <0 0>,
> --
> 2.17.1
> 
