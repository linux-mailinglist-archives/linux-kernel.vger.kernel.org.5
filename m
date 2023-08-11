Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C5778891
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjHKHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjHKHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:50:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8A30C0;
        Fri, 11 Aug 2023 00:50:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37B7o8ik046448;
        Fri, 11 Aug 2023 02:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691740208;
        bh=G9OWHXsY19lEsHCXBg4q5dQSET0RUIrirgxjNztR6zo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r0IUwQ7SyVQc39ZJ6k2ogGmvZ8/jqnrTO3EvuN7TGO65KjgI2Go1vhvYNDffHTGi7
         7JD/47W8JpEB46FY9PoZkbuAO0RyOWI1IwWAsRXLvJ4rhkvNuzLPu6WqMiu7mxmznd
         yO6YrjxyVJycnMQNpviV5ejvkcO7vPGagdAphRWA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37B7o8Nd128937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 02:50:08 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 02:50:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 02:50:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37B7o6Gu003878;
        Fri, 11 Aug 2023 02:50:07 -0500
Date:   Fri, 11 Aug 2023 13:20:06 +0530
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
Subject: Re: [PATCH V4 2/2] dt-bindings: cpufreq: Convert ti-cpufreq to json
 schema
Message-ID: <20230811075006.wlx5qq2tkz5zn7ok@dhruva>
References: <20230811031458.957624-1-nm@ti.com>
 <20230811031458.957624-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811031458.957624-3-nm@ti.com>
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

On Aug 10, 2023 at 22:14:58 -0500, Nishanth Menon wrote:
> Move the ti-cpufreq binding over to opp and convert the free text
> binding to json-schema.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V3:
> * Rewrote the description of the binding to something more relevant to
>   current style of documentation.
> * Due to the rewrite in description, I have dropped Dhruva's
>   Reviewed-by.

OK

> 
> V3: https://lore.kernel.org/all/20230809023045.1870410-3-nm@ti.com/
> V2: https://lore.kernel.org/all/20230801233341.1416552-3-nm@ti.com
> V1: https://lore.kernel.org/all/20230724153911.1376830-6-nm@ti.com/
> 
>  .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
>  .../opp/operating-points-v2-ti-cpu.yaml       |  92 ++++++++++++
>  2 files changed, 92 insertions(+), 132 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>  create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> 
[...]
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> new file mode 100644
> index 000000000000..02d1d2c17129
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/operating-points-v2-ti-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI CPU OPP (Operating Performance Points)
> +
> +description:
> +  TI SoCs, like those in the AM335x, AM437x, AM57xx, AM62x, and DRA7xx
> +  families, the CPU frequencies subset and the voltage value of each
> +  OPP vary based on the silicon variant used. The data sheet sections
> +  corresponding to "Operating Performance Points" describe the frequency
> +  and voltage values based on device type and speed bin information
> +  blown in corresponding eFuse bits as referred to by the Technical
> +  Reference Manual.
> +
> +  This document extends the operating-points-v2 binding by providing
> +  the hardware description for the scheme mentioned above.
> +
[...]


Thanks for addressing my comments,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
