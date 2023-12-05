Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1E805C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbjLEPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjLEPMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:12:42 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1CA9;
        Tue,  5 Dec 2023 07:12:47 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FCZpo017705;
        Tue, 5 Dec 2023 09:12:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701789155;
        bh=fHSoPyjS9SZQBJpx/ERIiHnFNDewwIjQ6bUqR4bHoeo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OI+X/js77TcXK9p1SJRlhNBXOkZELoY1fFlfNglFWzTL0Jt+/JfPSNAfMzZX+Fwus
         /HmlN7la4S9IaDuee1efp/GUhDmi9vdYu9f1rdPI5/5VxqgEreVC9sXYPeEYZ41yF6
         DYvWSEW3ARgTW8FxHZz17GVluQvMej+zm2IWIrqs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FCZAw019858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 09:12:35 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:12:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:12:35 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FCZ6a092905;
        Tue, 5 Dec 2023 09:12:35 -0600
Date:   Tue, 5 Dec 2023 09:12:35 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Garrett Giordano <ggiordano@phytec.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <w.egorov@phytec.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Lower
 I2C1 frequency
Message-ID: <20231205151235.y6qb7pzvrar24opm@regally>
References: <20231204222811.2344460-1-ggiordano@phytec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231204222811.2344460-1-ggiordano@phytec.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:28-20231204, Garrett Giordano wrote:
> The gpio-expander on i2c-1 has a maximum frequency of 100kHz. Update our
> main_i2c1 frequency to allow the nxp,pcf8574 gpio-expander to function
> properly.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> index a438baf542c2..171354b13e33 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -187,7 +187,7 @@ cpsw3g_phy3: ethernet-phy@3 {
>  &main_i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c1_pins_default>;
> -	clock-frequency = <400000>;
> +	clock-frequency = <100000>;
>  	status = "okay";
>  
>  	gpio_exp: gpio-expander@21 {
> -- 
> 2.25.1
> 
https://lore.kernel.org/all/bd5284ec-6f25-464a-9ee7-4c50496482f1@phytec.de/

please make sure to pick up the previous Reviewed-by when you post an
update of your series.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
