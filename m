Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123F8777BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjHJPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjHJPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:12:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8F26A6;
        Thu, 10 Aug 2023 08:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691680324; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XizLHJw7yl3zi6N8hCtoxt5oplwQ4YrT1kIl3IQIpNKkyQJ+NrfYuZy4v2OYG+sruw
    b20+mPprgNcEn8GWVrkJV5M7g1PR1gIShCjVDRMTeIrdNpzcJioGAsn+YoBQMBm1TU1K
    cueKLoiWd9/zD6NuAvp5XvE/YyI+DkYHbdhW36Irx54JuJy/PSvWCQNvSZJKiJXLYDQX
    jevwfGnNS1yvvxLb18zKAOIrKM8Tf3SKs+qWCcnKTNgnKpQMIjDr/WIzY+8TiVroXYhN
    T9PksamUE9+uiwk2jABX1FGu7EWN3UpRFQw9RI99V6sfxAWsyl6lyUgqII3aB7B2gtQ1
    ruUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691680324;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=T9+zQBuT+g2tnRm61S5ACvqdYYVH+w2kKssk3QT+WNQ=;
    b=XPll/sJZuBqnz0G25319I5OpOyQtJ3d0DMG7VFb9h/20IYDgSGwhI10hh2EeetQ1aD
    TcijpiC/Uijzcd3Mv+H1WMKEihZ/Q/c9ckoKRPAFyuVCpoRtcWGyfwhExyLM4r09Gvue
    s2YRshJ3qhWN2aKswsM1uFh5VU/l/2c25CY9iz+x6bqkkqeFXi23AYnt1zW620wJ+iuZ
    g5BAu9C142c4/eeJgWDyZRhafSItzcdDR7kGFEn+s9eJFlymmWYcNlWHQbfgdE/sRAXs
    tJ43ko+W2KNf2EvVkkhwuH8SmOfrnQYr6pmZ0ArxNgPHkZ/pt52j/QJ8PgDSIXc3FQfs
    X2lA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691680324;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=T9+zQBuT+g2tnRm61S5ACvqdYYVH+w2kKssk3QT+WNQ=;
    b=DEt0qVePZOetbBYvODsIUppXal8WaDWUtaxVHt38WZF8eIh9aoE0sNWVSziaXfcT8g
    6igrVLgpryssux33BhFEBs5TdCxs1CgWmOn4i3cG8biEWT46KHs1DlJqxwVjjcUlg1jk
    1QL/IhbY190XjXuvR4qcFAJHdEjSZus8GTTFVjCN/YZJR1Xbmmvo6fEhQSaRmYDPj4+y
    k8K54POerT1rQuMeRcdIc3lRP3fNfHqKW3lj+Cf0i18/XBYKic2ek5aC3ewCAzFYCamA
    iYE/4v9xo6wTPibRmWT9/6NLBFC8m8nJb6flPQXt0W+wnZSOnNMGc12y4wVcvdWwB9Cf
    LNcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691680324;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=T9+zQBuT+g2tnRm61S5ACvqdYYVH+w2kKssk3QT+WNQ=;
    b=5vMJFEOg5zjM4y8rZnJRag+vqQudxh9Nbjx/Z15ARnmpQwrhICHq2H93i18+YIO538
    I1yxGf2dRiqVRsIXepAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z7AFC4rP1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Aug 2023 17:12:04 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:11:57 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom:
 apq8016-sbc-d3-camera-mezzanine: Move default ov5640 to a standalone dts
Message-ID: <ZNT9nLaSBZvm1HNe@gerhold.net>
References: <20230809202343.1098425-1-bryan.odonoghue@linaro.org>
 <20230809202343.1098425-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809202343.1098425-6-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_NONE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just some nitpicks. Some of them were present before already but maybe
you can prepend or append another cleanup patch while at it. :)

On Wed, Aug 09, 2023 at 09:23:42PM +0100, Bryan O'Donoghue wrote:
> At the moment we define a single ov5640 sensor in the apq8016-sbc and
> disable that sensor.
> 
> The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
> card. Move the definition from the apq8016-sbc where it shouldn't be to a
> standalone dts.
> 

I wonder what would be required to implement this using a DT overlay,
rather than a standalone separate DT? Seems like there are some .dtso
files in upstream Linux.

I'm also fine with the separate DTB personally, though.

> Enables the sensor by default, as we are adding a standalone mezzanine
> structure.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 55 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 49 -----------------
>  3 files changed, 56 insertions(+), 49 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f15548dbfa56e..19016765ba4c6 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> new file mode 100644
> index 0000000000000..ef0e76e424898
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Ltd.
> + */

I assume you have permission from the original contributor to relicense
this? apq8016-sbc.dts is GPL.

> +
> +/dts-v1/;
> +
> +#include "apq8016-sbc.dts"
> +

Please also move the fixed regulators here, they're part of the
mezzanine, not the DB410c.

> +&camss {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			reg = <0>;
> +			csiphy0_ep: endpoint {
> +				data-lanes = <0 2>;
> +				remote-endpoint = <&ov5640_ep>;
> +				status = "okay";

Should be unneeded since it's not set to disabled anywhere?

> +			};
> +		};
> +	};
> +};
> +
> +&cci {
> +	status = "okay";
> +};
> +
> +&cci_i2c0 {
> +	camera_rear@3b {

camera@

Thanks,
Stephan
