Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F67A551B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjIRVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:33:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507348E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:33:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B348C433C8;
        Mon, 18 Sep 2023 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695072826;
        bh=HJnD3hDCAKtTDtsEuzBCabBIEMAOgegcnbNytmQ7rTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/lXBeKiRldFnvNecwB87VK4iPzybzfdxFTpW7N7DEWOG0ePMwhWA1QBHQj7CZmOE
         rwJzCyjXxuHxmWV776xSnXJnCwS1Y0dtd49ta/JFo05fQvVVmUH9rfpcqiiHynzYD0
         flE5SBBnlLaWbqmFb7RF8ps2D0Ihih5XNYo3kHtAHgWRfOaX8wu1HaIhcdh0iLlGUY
         KabrMyZUZcxyjJ9ucBFNbR4CiTALYZUcRIrBfnguxGFT2r2Y8y5skAJRpyLr+U9nqZ
         Vqe8hmZXeZDTvMroRHiK3s4IbOQCqckidhK+CPVHdLxFVrKwD6eqW0HmNH4e3LiZ6Z
         RVzOdVIeBJsIQ==
Received: (nullmailer pid 1791762 invoked by uid 1000);
        Mon, 18 Sep 2023 21:33:28 -0000
Date:   Mon, 18 Sep 2023 16:33:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kwanghoon Son <k.son@samsung.com>
Cc:     p.zabel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jszhang@kernel.org, guoren@kernel.org,
        wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset control
Message-ID: <20230918213328.GA1771303-robh@kernel.org>
References: <20230918045125.4000083-1-k.son@samsung.com>
 <CGME20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50@epcas1p1.samsung.com>
 <20230918045125.4000083-2-k.son@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918045125.4000083-2-k.son@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:51:23AM +0000, Kwanghoon Son wrote:
> Add documentation to describe th1520 reset device
> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml    | 44 +++++++++++++++++++
>  .../dt-bindings/reset/thead,th1520-reset.h    |  9 ++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
>  create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> new file mode 100644
> index 000000000000..49ea8c6a331f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/thead,th1520-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD th1520 SoC Reset Controller
> +
> +maintainers:
> +  - Kwanghoon Son <k.son@samsung.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: thead,th1520-reset
> +      - const: syscon

Why do you need "syscon"? Are there other functions? If so, please 
describe them in top-level "description". If not, drop "syscon" and use 
device_node_to_regmap() instead of syscon_node_to_regmap().

Rob
