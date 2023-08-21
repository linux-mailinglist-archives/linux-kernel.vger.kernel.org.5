Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E0782856
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHULzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjHULzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D30123;
        Mon, 21 Aug 2023 04:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A17631B1;
        Mon, 21 Aug 2023 11:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC4C433C7;
        Mon, 21 Aug 2023 11:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692618933;
        bh=igfPK8Ut0G6WW9AgjVkO2dIZKnXUDkIdWv6y8DUVBtU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jPUZgDWXRA0kI9T8IdWEZjlzn50ZLdy+d8JKJlI5iwbppWAJEfcSEfkvA4sjdbOc1
         HqC+/w5124SiKljJLUCZZVGTOdF1bWE1IptWcZH91elOVyCDwzx09CtaJZ62jniuv0
         3Bkt4p/KbbQnu33KkUaGbp62ybqIdaK5iQuu3kj1LuIRXLyvbLaTZRzCnUXBMzJeB9
         vzpxGaYEY2LD8ruQwXXCsCAII+Lbo9VlaShZJ+RQmA2LcE7o+FmfdFaKc3LNxjYU8s
         xaSI2qhN+QvhMgmfocvyzfHf0jcutAj1JODTh52MGBt6Lzm/Z4XwI4CF7MgOqJx0w+
         BplsdCbRpr8DA==
Message-ID: <ac153c9b-f698-47f4-9d52-b3ea5c9ba213@kernel.org>
Date:   Mon, 21 Aug 2023 13:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Enable tsens and thermal for
 sa8775p SoC
Content-Language: en-US
To:     Priyansh Jain <quic_priyjain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com
References: <20230821112928.19284-1-quic_priyjain@quicinc.com>
 <20230821112928.19284-3-quic_priyjain@quicinc.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230821112928.19284-3-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.2023 13:29, Priyansh Jain wrote:
> Add tsens and thermal devicetree node for sa8775p SoC.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1096 +++++++++++++++++++++++++
>  1 file changed, 1096 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index b130136acffe..b9c622b3bf7e 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -2306,6 +2306,1102 @@
>  
>  			#freq-domain-cells = <1>;
>  		};
> +
> +		tsens0: thermal-sensor@c222000 {
> +			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
> +			reg = <0x0C263000 0x1ff>,  /* TM */
> +				<0x0C222000 0x1ff>; /* SROT */
1. Test your patches. This will obviously not work due to the
   #address/size-cells values of /soc@0.

2. Use lowercase hex.

3. Align subsequent entries for a property with the previous line

4. Are you sure SROT is 0x1ff-long?

5. The usefulness of these comments is questionable, many DTs have
   them because of copypasta but I think it's time to stop that.

6. No pdc wake-capable interrupts?

> +			#qcom,sensors = <12>;
> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow","critical";
Missing space after the comma

Please move interrupt properties right after 'reg'.

Konrad
