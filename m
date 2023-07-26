Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4651763D67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGZROo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGZROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18983DD;
        Wed, 26 Jul 2023 10:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D92361C06;
        Wed, 26 Jul 2023 17:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1248C433C8;
        Wed, 26 Jul 2023 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690391679;
        bh=KlCWL6wIpa2sJJwcCSLx2GVLerKIi63SyCWQhyTv87U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsQ/io2LYkd2J/5ifsTQ55OFK/oGcpB/vHHe19JUIgBhLiQHVZeO7Bow/RZL8XqjK
         YxNLOz8eOWyOgGUEpDq7Jmzr7Q0LdLtG88erf7Hr+5YVgmivl16K6QNaXA1Xn8ojFd
         X8Vcr5wWg4RELHPD5XbzkVVNp7huudmRI8IFA0hWYegmDl/rbMIIdkteZhpAHhCZ21
         J1/QJcvTYOK0P8+hOnUHTi2FDE10aexiI5d3VYe89rLW5FprN3qWHR6wf2d2whYOza
         qLpdXqUlN8iMepLZnd5xDeGBI0sryu7h8k45PktrDnPieHcrk/TOsdSgIogMt3CXBI
         WYESkZDmeNKEQ==
Received: (nullmailer pid 1638608 invoked by uid 1000);
        Wed, 26 Jul 2023 17:14:36 -0000
Date:   Wed, 26 Jul 2023 11:14:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] dt-bindings: cpufreq: Convert ti-cpufreq.txt to yaml
 binding
Message-ID: <20230726171436.GA1609063-robh@kernel.org>
References: <20230724153911.1376830-1-nm@ti.com>
 <20230724153911.1376830-6-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724153911.1376830-6-nm@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:39:11AM -0500, Nishanth Menon wrote:
> Move the ti-cpufreq binding over to opp and convert to yaml
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
>  .../bindings/opp/opp-v2-ti-cpu.yaml           |  88 ++++++++++++
>  2 files changed, 88 insertions(+), 132 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml


> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml
> new file mode 100644
> index 000000000000..758f6da619a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml

Filename matching the compatible.

> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/opp-v2-ti-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI CPU OPP
> +
> +description: |

Don't need '|'.

> +  Certain TI SoCs, like those in the am335x, am437x, am57xx, am62x and dra7xx
> +  families support different OPPs depending on the silicon variant in use.
> +  The ti-cpufreq driver can use revision and an efuse value from the SoC to
> +  provide the OPP framework with supported hardware information. This is
> +  used to determine which OPPs from the operating-points-v2 table get enabled
> +  when it is parsed by the OPP framework.
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +allOf:
> +  - $ref: opp-v2-base.yaml#
> +
> +properties:
> +  compatible:
> +    const: operating-points-v2-ti-cpu
> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      points to syscon node representing the control module
> +      register space of the SoC.
> +
> +  opp-shared: true
> +
> +patternProperties:
> +  '^opp(-?[0-9]+)*$':
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      clock-latency-ns: true
> +      opp-hz: true
> +      opp-microvolt: true
> +      opp-supported-hw: true
> +      opp-suspend: true
> +      turbo-mode: true
> +
> +    required:
> +      - opp-hz
> +      - opp-supported-hw
> +
> +required:
> +  - compatible
> +  - syscon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpu0_opp_table: opp-table {

Drop unused labels

> +        compatible = "operating-points-v2-ti-cpu";
> +        syscon = <&scm_conf>;
> +
> +        opp-300000000 {
> +            opp-hz = /bits/ 64 <300000000>;
> +            opp-microvolt = <1100000 1078000 1122000>;
> +            opp-supported-hw = <0x06 0x0020>;
> +            opp-suspend;
> +        };
> +
> +        opp-500000000 {
> +            opp-hz = /bits/ 64 <500000000>;
> +            opp-microvolt = <1100000 1078000 1122000>;
> +            opp-supported-hw = <0x01 0xFFFF>;
> +        };
> +
> +        opp-600000000 {
> +            opp-hz = /bits/ 64 <600000000>;
> +            opp-microvolt = <1100000 1078000 1122000>;
> +            opp-supported-hw = <0x06 0x0040>;
> +        };
> +
> +        opp-1000000000 {
> +            opp-hz = /bits/ 64 <1000000000>;
> +            opp-microvolt = <1325000 1298500 1351500>;
> +            opp-supported-hw = <0x04 0x0200>;
> +        };
> +    };
> -- 
> 2.40.0
> 
