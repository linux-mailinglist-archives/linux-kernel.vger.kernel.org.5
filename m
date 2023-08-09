Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE2775207
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHIEso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIEsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:48:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F56B1729;
        Tue,  8 Aug 2023 21:48:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3794mRru071364;
        Tue, 8 Aug 2023 23:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691556507;
        bh=k0ddWsfj0z5+ln2wnlY4jvAThcDik4Lifga5Qvq+aQ4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=x0C1jh8CyjGwTy2DIHSTj4QesWObFq7hP9YYhBiqsViYVEFdTGkEOfv+O2J37Ksap
         fBqv8ZFCKSvLd717ZeUvSwzt/nRY/75SsqyGx0cw47pHiGYEMlXgOr+ymEQUxz44m0
         MLCClZaF7/4s7HIqS7W7zPeRUfceta1hlpOKhfgo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3794mRH6008170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 23:48:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 23:48:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 23:48:27 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3794mQjk002203;
        Tue, 8 Aug 2023 23:48:26 -0500
Date:   Wed, 9 Aug 2023 10:18:25 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: opp: Convert ti-omap5-opp-supply to
 json schema
Message-ID: <20230809044825.top2xma5meklzosc@dhruva>
References: <20230809023045.1870410-1-nm@ti.com>
 <20230809023045.1870410-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809023045.1870410-2-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 08, 2023 at 21:30:44 -0500, Nishanth Menon wrote:
> Rename ti-omap5-opp-supply to be bit more generic omap-opp-supply and
> convert the free text binding to json-schema.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V2:
> - None.
> 
> V2: https://lore.kernel.org/r/20230801233341.1416552-2-nm@ti.com
> V1: https://lore.kernel.org/all/20230724153911.1376830-5-nm@ti.com/
>  .../bindings/opp/ti,omap-opp-supply.yaml      | 103 ++++++++++++++++++
>  .../bindings/opp/ti-omap5-opp-supply.txt      |  63 -----------
>  2 files changed, 103 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> new file mode 100644
> index 000000000000..4db80e418829
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/ti,omap-opp-supply.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP compatible OPP supply
> +
> +description:
> +  OMAP5, DRA7, and AM57 family of SoCs have Class0 AVS eFuse registers which
> +  contain data that can be used to adjust voltages programmed for some of their
> +  supplies for more efficient operation. This binding provides the information
> +  needed to read these values and use them to program the main regulator during
> +  an OPP transitions.
> +
> +  Also, some supplies may have an associated vbb-supply which is an Adaptive Body
> +  Bias regulator which much be transitioned in a specific sequence with regards

s/much/must ?

> +  to the vdd-supply and clk when making an OPP transition. By supplying two
> +  regulators to the device that will undergo OPP transitions we can make use
> +  of the multi regulator binding that is part of the OPP core described

Existing txt seems to have:

 part of the OPP core described here [1]

Why get rid of the reference "[1]" here?

Going through Documentation/devicetree/bindings/opp/opp-v2.yaml didn't
tell me much about this multi regulator binding, I only see 1 example.

Please can you explain a bit more or make this line more clear?

> +  to describe both regulators needed by the platform.
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +properties:
> +  $nodename:
> +    pattern: '^opp-supply(@[0-9a-f]+)?$'
[...]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
