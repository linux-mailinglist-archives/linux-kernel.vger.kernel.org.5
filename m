Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43F7751EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjHIEa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHIEa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:30:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6BE1BC3;
        Tue,  8 Aug 2023 21:30:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3794UEKf067963;
        Tue, 8 Aug 2023 23:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691555414;
        bh=J3vaPqXrnLSOx9r2ta23Q24WycaG6AOs5979+peStBY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=X68666kRLaI6t8/TXf6RW9i5220K79/+SiMQrhvYcDvdkVe6f6qxPNA/yjF2cdw5f
         VIdX/mem4v2TJmnvRCwungezOLDKM3fqSVWww0041adt+ha1JP/UAYDqEXawXTwgpA
         nz5+wUArdt0j+nscSZmvjqk70QEHplVFugsFAjFw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3794UE53040119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 23:30:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 23:30:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 23:30:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3794UDTq115759;
        Tue, 8 Aug 2023 23:30:13 -0500
Date:   Wed, 9 Aug 2023 10:00:12 +0530
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
Subject: Re: [PATCH V3 2/2] dt-bindings: cpufreq: Convert ti-cpufreq to json
 schema
Message-ID: <20230809043012.gcsnn5bfr7j25ow7@dhruva>
References: <20230809023045.1870410-1-nm@ti.com>
 <20230809023045.1870410-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809023045.1870410-3-nm@ti.com>
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

On Aug 08, 2023 at 21:30:45 -0500, Nishanth Menon wrote:
> Move the ti-cpufreq binding over to opp and convert the free text
> binding to json-schema.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V2:
> * Just fixup for commit message and picked up Reviewed-by from Dhruva.
> 
> V2: https://lore.kernel.org/r/20230801233341.1416552-3-nm@ti.com
> V1: https://lore.kernel.org/all/20230724153911.1376830-6-nm@ti.com/
> 
> Side note: Cleanups in dt is picked up on Tony's tree:
> https://lore.kernel.org/all/20230731062551.GH5194@atomide.com/
> 
>  .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
>  .../opp/operating-points-v2-ti-cpu.yaml       |  88 ++++++++++++
>  2 files changed, 88 insertions(+), 132 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>  create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> 
[...]
> new file mode 100644
> index 000000000000..ada57bfc1da9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/operating-points-v2-ti-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI CPU OPP (Operating Performance Points)
> +
> +description:
> +  Certain TI SoCs, like those in the am335x, am437x, am57xx, am62x and dra7xx
> +  families support different OPPs depending on the silicon variant in use.
> +  The ti-cpufreq driver can use revision and an efuse value from the SoC to

Just learned about this yesterday, hence missed it in my earlier review.
Looks like the kernel docs [0] say that we DON'T refer to Linux or
"device driver" in bindings.

Bindings should be based on what the hardware has, not what an OS and
driver currently support.

> +  provide the OPP framework with supported hardware information. This is
> +  used to determine which OPPs from the operating-points-v2 table get enabled
> +  when it is parsed by the OPP framework.
> +
[...]

[0] https://docs.kernel.org/devicetree/bindings/writing-bindings.html

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
