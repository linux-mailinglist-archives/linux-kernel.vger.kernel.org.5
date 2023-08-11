Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C677887E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHKHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHKHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:43:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B651FDD;
        Fri, 11 Aug 2023 00:43:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37B7hgYU048602;
        Fri, 11 Aug 2023 02:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691739822;
        bh=Dl8RPieEXeiZEbz73dFPq3V0iyFKJlept9ooTpzXOH8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=l17Am+s6UOZI3RnBL/wKdJGl82Pxt7PJ8EpXtyOTUBkFyHJ6qiAGvOKr8n0XEeRU0
         Jrj36GWPhUPxOO8gazWgJtbNmzA46ZwnXd8O8bwLi/+RzljtwjyoxriTPPUF3OkBzq
         9avXJtIUzPD7VYlHULQ7+qMWk1qF0yg56RE3W0oc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37B7hfs6053880
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 02:43:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 02:43:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 02:43:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37B7hfDs026904;
        Fri, 11 Aug 2023 02:43:41 -0500
Date:   Fri, 11 Aug 2023 13:13:40 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Vibhore Vardhan <vibhore@ti.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: opp: Convert ti-omap5-opp-supply to
 json schema
Message-ID: <20230811074340.jspxuw6zeaxdh2yf@dhruva>
References: <20230811031458.957624-1-nm@ti.com>
 <20230811031458.957624-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811031458.957624-2-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2023 at 22:14:57 -0500, Nishanth Menon wrote:
> Rename ti-omap5-opp-supply to be bit more generic omap-opp-supply and
> convert the free text binding to json-schema.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V3:
> * Rewrote the description of the binding to something more relevant to
>   current style of documentation.
> 
> V3: https://lore.kernel.org/all/20230809023045.1870410-2-nm@ti.com/
> V2: https://lore.kernel.org/all/20230801233341.1416552-2-nm@ti.com/
> V1: https://lore.kernel.org/all/20230724153911.1376830-5-nm@ti.com/
> 
>  .../bindings/opp/ti,omap-opp-supply.yaml      | 106 ++++++++++++++++++
>  .../bindings/opp/ti-omap5-opp-supply.txt      |  63 -----------
>  2 files changed, 106 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> new file mode 100644
> index 000000000000..25a0cb5ec6ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/ti,omap-opp-supply.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP compatible OPP supply
> +
> +description:
> +  OMAP5, DRA7, and AM57 families of SoCs have Class 0 AVS eFuse
> +  registers, which contain OPP-specific voltage information tailored
> +  for the specific device. This binding provides the information
> +  needed to describe such a hardware values and relate them to program
> +  the primary regulator during an OPP transition.
> +
> +  Also, some supplies may have an associated vbb-supply, an Adaptive
> +  Body Bias regulator, which must transition in a specific sequence
> +  w.r.t the vdd-supply and clk when making an OPP transition. By
> +  supplying two regulators to the device that will undergo OPP
> +  transitions, we can use the multi-regulator support implemented by
> +  the OPP core to describe both regulators the platform needs. The
> +  OPP core binding Documentation/devicetree/bindings/opp/opp-v2.yaml
> +  provides further information (refer to Example 4 Handling multiple

Thanks, this makes it much more clear to me :)

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> +  regulators).
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
[...]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
