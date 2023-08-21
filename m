Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3C782D07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjHUPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHUPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102FFE2;
        Mon, 21 Aug 2023 08:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A8C63B79;
        Mon, 21 Aug 2023 15:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E35C433C8;
        Mon, 21 Aug 2023 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692630872;
        bh=SvjRdmL3sxMUPdLqrPttTfYUZ41b5af4QloayQ4ToIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ky1vUZCZ4gDmoSWG7UW4FDtmImLdp2g/6tXXoJUGsRpTGCh1btt0XtsGFpR9eo9DS
         CV8hD11GORvkfXziUXK/v9sb4jnnuUa/LOLOb3uyldk0JAJ8zq+KYneENycsuoqwij
         wkaG0RWfVQfKESdLPlNXU74ZyfmiXyDab+XtqSAD+SE8fg2UFitpMpmUrGv6oJu5Dv
         sVXgVBfvTudmnFEvdbAQEgYOlw4idlx2C5aJnwwGD4AYm684KnrgHn8PLVSfHM3pxq
         oWlYGwRFdZTng4KvrfOqbtuy0JJ4q/YDwQsKIlDJmM6w+3YzXwVPLP9qrxrRGYxN+a
         v0e6wwNjPU6WQ==
Received: (nullmailer pid 1674094 invoked by uid 1000);
        Mon, 21 Aug 2023 15:14:30 -0000
Date:   Mon, 21 Aug 2023 10:14:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm: dts: qcom: Add the rpmhpd header
Message-ID: <20230821151430.GA1643924-robh@kernel.org>
References: <1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690781104-2290-3-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690781104-2290-3-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:55:02AM +0530, Rohit Agarwal wrote:
> Add the rpmhpd header having the definition of the regulator levels
> for Qualcomm SoCs.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 +
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index df3cd9c..8ffb2a0 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/interconnect/qcom,sdx55.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/power/qcom,rpmhpd.h>

If patch 4 isn't applied, aren't you going to get warnings about 
redefining the defines since you have them twice?

>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> index 1a35830..f990f5d 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/interconnect/qcom,sdx65.h>
>  
> -- 
> 2.7.4
> 
