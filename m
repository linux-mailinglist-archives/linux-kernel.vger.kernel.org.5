Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105387E2ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKFRWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFRWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:22:06 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4E1BC;
        Mon,  6 Nov 2023 09:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699291320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TbvFJH4XprGZfb2hvMmc5ctU8eEq21Oh5g6LOJJdkowBZupRkiv26u49ZCsj8DgBSq
    lR76qWA/4/oNjZAyoYvTNiBKmwXDz+4uH76Qs/Q+Ar701gGHy+XZCjYwAv+DqqMsazyR
    NGlC0OjUpb/BlMo85ojxyorVsLhFo2P3BlYSwOJzDXxMpp4dYycizQSQ5LUG9uMRHuH8
    d4c+Jv3BliIGQcZITW/HxcUmao37YJS2COuT7+Dh3pKFb0xhDpAJzQFyhTOBZUDnJXKW
    gf+/vdzEDxfhGOi9bSNv99Pwp2r/l7I6loK9sTSRnOikw/YwkpgcoxIXRJqzKUMq8qPV
    jxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699291320;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xhpTO12snhTyUAudCCBknK/y5KS1BxQ8Az7BF7pqWV8=;
    b=qrYBKbbHO6JObFJMSAryUKngOdRg+UlGqO46xU8f1TkEFdIZib1+D9u+3UOmK1VQG8
    K2Gh9HJhsV1EOtDE0iuMmEE2eENob4mYuFIeNnfF4qLIV62gDOZQgSAP/1s1ioih4EKT
    vaejLZHJwINN3ako5nOnZTRF+XTCgvtVhkZbHDzZ5JxsBaQFXBx9LaDclvDfAv1hgam6
    Dt71wg+OV67MufuQvA4zW3bz+m5nrjralo4D7rc02uZ2tRIA1rcsYMeYX2FAAW33CxTa
    LGVTPwWNKLA8bWHSurP3VEaN7/FrbvAwr8w/XzhcG7lmJAP06v5WKUCFVV7HsgQwJwtc
    vJmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699291320;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xhpTO12snhTyUAudCCBknK/y5KS1BxQ8Az7BF7pqWV8=;
    b=LXNAN7IKiWGOs2CPJoHeQzmNma/6JEW6U+IX7NYsP9CXTYkswXoftiSz8wSYupCpvM
    YjcKAHbST0itDn8+70faXGYSPAdUl2l3L8T+GCVUx3/BnHxi9j1LnwKNKDJCYCBxBJiR
    4nQTyC5wS0bvcZZ5txQZ9rEUznb2V+pAJvguLKFNuVw3XVffCjmS2Mwa5VYsYwaGYUrR
    6x+lMwO8w+SVe+SQ7u57ca4UBiouHkF+iCKXX6BGzCDH6GRqqlpN9ljPonfGfDfQ4J58
    6kM3HMn6pSqYOGYtwxvfdNA2BZCgFUjT3rEnE8I7/8FT9mXSvteCjF6EpxK3rjtNYNlI
    ZvbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699291320;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xhpTO12snhTyUAudCCBknK/y5KS1BxQ8Az7BF7pqWV8=;
    b=flX/bOirgwI//BSG7vd8VfmRD6zPXJC4wHgnejIbeEYvO3dNRud3C03D0a1aE9kjDj
    e6mO8fPfqgAm1drbZbDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Lbb8e2zA6HLxXHV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Nov 2023 18:21:59 +0100 (CET)
Date:   Mon, 6 Nov 2023 18:21:53 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] arm64: dts: qcom: Add PM8937 PMIC
Message-ID: <ZUkgsW4pyojMBtD9@gerhold.net>
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
 <20231106-pm8937-v1-7-ec51d9eeec53@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-pm8937-v1-7-ec51d9eeec53@riseup.net>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 07:08:35PM +0700, Dang Huynh wrote:
> The PM8937 features integrated peripherals like ADC, GPIO controller,
> MPPs, PON keys and others.
> 
> Add the device tree so that any boards with this PMIC can use it.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/pm8937.dtsi | 202 +++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
> new file mode 100644
> index 000000000000..6091d6938885
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> [...]
> +&spmi_bus {
> +	pmic@0 {
> +		compatible = "qcom,pm8937", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x800>;
> +			mode-bootloader = <0x2>;
> +			mode-recovery = <0x1>;
> +
> +			pm8937_pwrkey: pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +			};
> +
> +			pm8937_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_VOLUMEDOWN>;

Please move the linux,code into the board-specific part and make this
status = "disabled" by default, like in the other PMIC dtsi files.

One could theoretically assign any other function to this key. Also,
some devices don't have this hooked up at all.

Thanks,
Stephan
