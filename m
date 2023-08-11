Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710EA77959A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjHKREW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKREV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBDE54;
        Fri, 11 Aug 2023 10:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D77F677A4;
        Fri, 11 Aug 2023 17:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA2EC433C7;
        Fri, 11 Aug 2023 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773459;
        bh=LZGP/air+2wvae6xLeGOfYYOENdL4ySCVIGxTfx1yy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr/ZSU50g1LCjI6n2lyl8KXz0mUjPN6XnyorDImTEWlmWDuwEEBggyyouPT8GNF/8
         1c3ahRjhkbq2gYdjbiOGY+F6omPh4oVHOEwcgtoCx8c18GCKsajv5Mj8pKS+PMYYcE
         JplN7eBwHy/k7jN4SMhAQB2Fnzs8iSP1oyQhgA9eXo5MpJ55s10JQKjqJOHD1/KdvV
         SKo/NS4vYn/e6Xzqr3PhSq+nwwdimr/HnfxodbXmn2Bh3GNByPFg5dXjZ2XD+FlvVK
         y26ZhggKZc1/sPkc0+RIH9vr2LQcAdq1x+Ife+5zxtHV2qZj7GQUg1wZ15ViDiEieL
         on627zLQkfy4g==
Received: (nullmailer pid 3614707 invoked by uid 1000);
        Fri, 11 Aug 2023 17:04:15 -0000
Date:   Fri, 11 Aug 2023 11:04:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, ulf.hansson@linaro.org,
        stanimir.k.varbanov@gmail.com, airlied@gmail.com,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        quic_tdas@quicinc.com, linux-remoteproc@vger.kernel.org,
        agross@kernel.org, linux-clk@vger.kernel.org, rfoss@kernel.org,
        daniel@ffwll.ch, andersson@kernel.org, bhupesh.sharma@linaro.org,
        mani@kernel.org, mturquette@baylibre.com,
        quic_abhinavk@quicinc.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mchehab@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_vgarodia@quicinc.com,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, neil.armstrong@linaro.org,
        konrad.dybcio@linaro.org, mathieu.poirier@linaro.org,
        jonathan@marek.ca, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Message-ID: <169177345491.3614642.17326420788227805482.robh@kernel.org>
References: <1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 18:13:33 +0530, Rohit Agarwal wrote:
> Update the RPMHPD references with new bindings defined in rpmhpd.h
> for Qualcomm SoCs SM8[2345]50.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
> 
> Changes in v2:
>  - Removed the unnecessary inclusion of header rpmpd.h.
> 
> This patch is dependent on the series that includes the new rpmhpd.h header
> https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
> 
>  Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml   | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml  | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml    | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml   | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml  | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml   | 4 ++--
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml         | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8250-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 8 ++++----
>  .../devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 6 +++---
>  .../devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++----
>  .../devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml          | 4 ++--
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++----
>  Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml    | 4 ++--
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml              | 4 ++--
>  Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 6 +++---
>  18 files changed, 44 insertions(+), 44 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

