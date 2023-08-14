Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F51777C18A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjHNUeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjHNUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:34:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C520E5E;
        Mon, 14 Aug 2023 13:34:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EKXxTp040839;
        Mon, 14 Aug 2023 15:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692045239;
        bh=P8ifeBQlXDh7fx14sIDDQ/xLBaeGI5CPl7R+rtlKe60=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fZTkrOIl7Fn3II47C2EGI8V+LHEnavvap48rdxgRPLQw/znHb56HueLI0WDTw9dsA
         lfUCj5Z8ZLrH/9NU1lvcC5Xbb3XKCv5cgXkH2LlmBSZnGrCgk6IFp9Ln+Q/Op8+W4T
         oP6G8cuSq7Y6v5FpaQXnYPcxSA9G5jaNU8cobzmM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EKXxac039263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 15:33:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 15:33:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 15:33:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EKXw8S022754;
        Mon, 14 Aug 2023 15:33:58 -0500
Date:   Mon, 14 Aug 2023 15:33:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62P5 SoC and board
Message-ID: <20230814203358.tsx343ifog5tpldi@quicksand>
References: <20230811184432.732215-1-vigneshr@ti.com>
 <169179403348.1346194.1236976094485793819.b4-ty@ti.com>
 <5a1ed797-d29a-e047-ccec-adb1dde6d74f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a1ed797-d29a-e047-ccec-adb1dde6d74f@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:26-20230814, Krzysztof Kozlowski wrote:
> On 12/08/2023 00:49, Nishanth Menon wrote:

Looping in Vinod

[...]

> 
> A bit too fast. simple-mfd *is not allowed* on its own.
> 

Actually dtbs_check comes up clean, but more I dug at it, looks like we
should probably cleanup.

(everything):
https://gist.github.com/nmenon/5f5f689333c66697969f5d80ad94cfca
(am62p alone):
https://gist.github.com/nmenon/9aaa2067a619b12af338647d19b4cf9b

$ git grep 'compatible = "simple-mfd";' arch/arm64/boot/dts/ti/
arch/arm64/boot/dts/ti/k3-am62-main.dtsi:               compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-am62p-main.dtsi:              compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-am64-main.dtsi:               compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-am65-main.dtsi:               compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi:                compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:              compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi:                compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:              compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi:                compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi:             compatible = "simple-mfd";
arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi:               compatible = "simple-mfd";

It is all over our k3 dts folder for dma. Digging further, it looks to
have been explicitly permitted by the bindings:

$ git grep 'compatible = "simple-mfd";'  Documentation/devicetree/bindings/
Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:            compatible = "simple-mfd";
Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml:            compatible = "simple-mfd";
Documentation/devicetree/bindings/dma/ti/k3-udma.yaml:            compatible = "simple-mfd";

Looks like we will have to cleanup the yaml bindings and the dts nodes
in a manner that doesn't break the platforms.

I am not saying that simple-mfd usage is correct, but it was
explicitly permitted by schema in these instances, are you OK that we
clean that in the upcoming merge window as the very first thing we do
and let this series through?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
