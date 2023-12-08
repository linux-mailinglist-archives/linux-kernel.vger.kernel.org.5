Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8A809A74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573082AbjLHDdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:33:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043310EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:33:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AF4C433C7;
        Fri,  8 Dec 2023 03:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702006439;
        bh=gvbTjN36aMg/8pd0wDaFdxIHv1L9nizj9pVmZyQNfvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XT/f7OFCQw+yUyR8eYvAXk3PZ0ZScodSRv43KEThVVXSFdT5lRTRXm6vr8zT5m1og
         P+W4Drkj4mrQiNkL4zSo6u24njZNzCpBzxEStx2lKX7Bn2elODmrJRjdjK0MRG4j2L
         osOT9U3Q1XSJseKVhrQW6Qz1PI+THOt65SN6d7jzHeRydw918SG1k2sX+H3IcEIi+v
         nAYqXYWjK1AF09RPymVhJ6ZgiS72sRLnnRfucYOY6yZ61/pXK8ASkWT5QCqhs8S0al
         PVsoIOxs3t1WTniTWQ+HIrYHRaIlwqrfnDC5EirMXD4KrpMfkHKkyMk3dw6MbvEA/Z
         TaMmtJO8IjRRg==
Date:   Thu, 7 Dec 2023 19:38:33 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650: Add DisplayPort device
 nodes
Message-ID: <bcecxzpogq6pndwmhgrl52ia3orni2q5brg6mpc6fkn5widigb@v6dy4minwajx>
References: <20231207-topic-sm8650-upstream-dp-v1-0-b762c06965bb@linaro.org>
 <20231207-topic-sm8650-upstream-dp-v1-3-b762c06965bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-topic-sm8650-upstream-dp-v1-3-b762c06965bb@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 05:37:19PM +0100, Neil Armstrong wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
[..]
> +
> +			mdss_dp0: displayport-controller@af54000 {
> +				compatible = "qcom,sm8650-dp";
> +				reg = <0 0xaf54000 0 0x200>,
> +				      <0 0xaf54200 0 0x200>,
> +				      <0 0xaf55000 0 0xc00>,
> +				      <0 0xaf56000 0 0x400>,
> +				      <0 0xaf57000 0 0x400>;
> +
> +				interrupts-extended = <&mdss 12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +
> +				power-domains = <&rpmhpd RPMHPD_MX>;

Are you sure the DP TX block sits in MX? I'd expect this to be
RPMHPD_MMCX, and then the PHY partially in MX...

> +
> +				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						mdss_dp0_out: endpoint {
> +						};
> +					};
> +				};
> +
> +				dp_opp_table: opp-table {

Is there any reason why we keep sorting 'o' after 'p' in these nodes?

Regards,
Bjorn
