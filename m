Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6FE7A8459
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjITN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbjITN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:58:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D373AD;
        Wed, 20 Sep 2023 06:57:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KDvNoI041151;
        Wed, 20 Sep 2023 08:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695218243;
        bh=Isj7eqsKx9FCy6BZpg1GJ4YhPYCfsGGScCWlCPgi0zE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RlxhI0FqDBNg0YWbq2W+j+JUzjQoXVEv8RKF99att3JpYLEN7WllhrTiDUUHwVAsL
         TzGtlO5T/eWN6UtKZOQOs/LWtRJblUE40kO7xIrw5xJ98b04kqyjTC7V5zyLiO1krN
         lMJwY3wyajgdodsxY+56tiq4SJXJ0MRYcJ+h3Stc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KDvN84043531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 08:57:23 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 08:57:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 08:57:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KDvMfs118823;
        Wed, 20 Sep 2023 08:57:22 -0500
Date:   Wed, 20 Sep 2023 08:57:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: Enable support for overlays for
 relevant boards
Message-ID: <20230920135722.tl2yupwpffa3ryfy@jaunt>
References: <20230920133450.54226-1-rogerq@kernel.org>
 <20230920133450.54226-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920133450.54226-2-rogerq@kernel.org>
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

On 16:34-20230920, Roger Quadros wrote:
> Enable __symbols__ in board DT files for which we expect
> overlays to be supported.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e7b8e2e7f083..06d6f264f292 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -72,8 +72,16 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>  
>  # Enable support for device-tree overlays
> +DTC_FLAGS_k3-am625-beagleplay += -@
>  DTC_FLAGS_k3-am625-sk += -@
>  DTC_FLAGS_k3-am62-lp-sk += -@
> +DTC_FLAGS_k3-am62a7-sk += -@
> +DTC_FLAGS_k3-am642-evm += -@
> +DTC_FLAGS_k3-am654-base-board += -@
>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
> +DTC_FLAGS_k3-am68-sk-base-board += -@
> +DTC_FLAGS_k3-am69-sk += -@
>  DTC_FLAGS_k3-j721e-common-proc-board += -@
> +DTC_FLAGS_k3-j721e-sk += -@
>  DTC_FLAGS_k3-j721s2-common-proc-board += -@
> +DTC_FLAGS_k3-j784s4-evm += -@

is'nt it better to do it in context of the changes introduced?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
