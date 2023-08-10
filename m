Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D200A777F52
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHJRnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjHJRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:43:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B322705;
        Thu, 10 Aug 2023 10:43:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AHh32V120173;
        Thu, 10 Aug 2023 12:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691689383;
        bh=40V40KUVcWvIPsfl6EPTZMQ2VrkesPK1K7+evx9nSkg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UQayD+ZopAuS/QVf52PBwGz+H/PWvoK9EFLa/I5IN2HdcxnSNvWahWb3qwph/RCd0
         GkHIiXZtME/M7i0FErQFQbOo0S6jZZjISC+vQdjS5dxHxNPmhGPEIIdF8oAkRiGR6s
         vpYOMOfjYnP91y9JmJJks9Ugl7JuAqknCr2cL6fg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AHh38t074676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 12:43:03 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 12:43:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 12:43:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AHh1Gc083723;
        Thu, 10 Aug 2023 12:43:02 -0500
Date:   Thu, 10 Aug 2023 23:13:01 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: Introduce AM62P SoCs
Message-ID: <20230810174301.sadb6jrtxrbjjwlw@dhruva>
References: <20230810045314.2676833-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810045314.2676833-1-vigneshr@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2023 at 10:23:11 +0530, Vignesh Raghavendra wrote:
> This series adds basic support for AM62P family of SoCs and specifically
> AM62P5 variant. Also adds AM62P5-SK EVM support with basic peripheral
> like UART.

Thanks for posting this upstream! Series looks good to me.

> 
> TRM at [0] and Schematics is at [1]
> 
> [0]: https://www.ti.com/lit/pdf/spruj83
> [1]: https://www.ti.com/lit/zip/sprr487
> 
> Bryan Brattlof (3):
>   dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
>   arm64: dts: ti: Introduce AM62P5 family of SoCs
>   arm64: dts: ti: Add support for the AM62P5-SK
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
>  arch/arm64/boot/dts/ti/Makefile               |   3 +
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 129 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi      |  16 ++
>  arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi   |  30 ++++
>  arch/arm64/boot/dts/ti/k3-am62p.dtsi          | 109 +++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 169 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi         | 107 +++++++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +

For the series,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  9 files changed, 572 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> 
> -- 
> 2.41.0
> 
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
