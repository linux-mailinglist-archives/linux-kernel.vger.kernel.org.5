Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A88768672
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjG3Qb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjG3QbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:31:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A579EB;
        Sun, 30 Jul 2023 09:31:23 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36UGUrpZ100932;
        Sun, 30 Jul 2023 11:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690734653;
        bh=XKtNxckA/XWO2NAsROeQTCyFJZHbB19LMoO2JprXf3g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UgtXhNlxbg37JbuX4E7Wfa5GZcg44techGXloHYcx1wW8eICj2Vt3aucZROKr7rUB
         YJPd5ulMgI4jvL4HZmSsWuQk44G4tWOT4nXxWBDmK2nGRy5hgDLs3FblsM1r67KNJ4
         mBqcXjOqI9BGIa5TZvSX5Ec/Yy89SfNf2oQsbiEI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36UGUro2114094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Jul 2023 11:30:53 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jul 2023 11:30:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jul 2023 11:30:52 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36UGUqla002529;
        Sun, 30 Jul 2023 11:30:52 -0500
Date:   Sun, 30 Jul 2023 11:30:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v3 1/8] arm64: dts: ti: k3-am62x-sk-common: Update
 main-i2c1 frequency
Message-ID: <20230730163052.w5y5a25xgpxzuhzs@serving>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
 <20230728173438.12995-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230728173438.12995-2-a-bhatia1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:04-20230728, Aradhya Bhatia wrote:
> The Display Data Channel (DDC) transactions between an HDMI transmitter
> (SIL9022A in this case) and an HDMI monitor, occur at a maximum of
> 100KHz. That's the maximum supported frequency within DDC standards.
> 
> While the SIL9022A can transact with the core at 400KHz, it needs to
> drop the frequency to 100KHz when communicating with the monitor,
> otherwise, the i2c controller times out and shows warning like this.
> 
> [  985.773431] omap_i2c 20010000.i2c: controller timed out
> 
> That feature, however, has not been enabled in the SIL9022 driver.
> 
> Since, dropping the frequency doesn't affect any other devices on the
> bus, drop the main-i2c1 frequency from 400KHz to 100KHz.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 34c8ffc553ec..540ed8a0d7fb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -300,7 +300,7 @@ &main_i2c1 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c1_pins_default>;
> -	clock-frequency = <400000>;
> +	clock-frequency = <100000>;
>  
>  	tlv320aic3106: audio-codec@1b {
>  		#sound-dai-cells = <0>;
> -- 
> 2.40.1
> 

I know we had issues with level shifters on the dev platform previously,
but do we need this patch anymore with the production boards?

if so, use Fixes and I can pick for next.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
