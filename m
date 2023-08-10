Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62E877809F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjHJSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjHJSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:46:28 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C5270A;
        Thu, 10 Aug 2023 11:46:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIkIlJ004452;
        Thu, 10 Aug 2023 13:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691693178;
        bh=hY1PBNg5pfJh7+pS32maH/DjEtbdSixMkbxY2x7Qf+8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=K7YQF0Cx4iJT8Q0fFFgGG3JBydFH9HUkcVv3rpcsXnfXCC7Wykp7IIn2BL7egJGgV
         5RrgSyolYOt//nqrVq7qdMryfLG0nvwk2E91b3auLV0qQ39NE+yPrEH0V5E+FL4dz0
         a3Z1bAxOSu4dqEuj7vHpZhMq/M1coy5w+KcjpnGg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIkI08112364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:46:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:46:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:46:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIkHSC114028;
        Thu, 10 Aug 2023 13:46:17 -0500
Date:   Thu, 10 Aug 2023 13:46:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: Introduce AM62P SoCs
Message-ID: <20230810184617.vukybhvlimivrr66@silly>
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

On 10:23-20230810, Vignesh Raghavendra wrote:
> This series adds basic support for AM62P family of SoCs and specifically
> AM62P5 variant. Also adds AM62P5-SK EVM support with basic peripheral
> like UART.
> 
> TRM at [0] and Schematics is at [1]
> 
> [0]: https://www.ti.com/lit/pdf/spruj83
> [1]: https://www.ti.com/lit/zip/sprr487
> 

Can you share a bootlog?

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




-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
