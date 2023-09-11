Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759C79B09A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbjIKVMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242512AbjIKPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:44:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B27218D;
        Mon, 11 Sep 2023 08:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208B9C433C8;
        Mon, 11 Sep 2023 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694447091;
        bh=UypZKzekW0Fnyf/smilvBj2pL+glSdtZ2s73jeqIa1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeFuPBsx5eG593nKlIqcbZckZNxJOEEWxbPFIgnX1pqMeBsyDlT0J4/elUxqs8uGw
         319DNMooXPc1YxiFXes6YWrgimtBwvCdbQDSWraDVqjIduYr+yItGP2o/Bk6LCtUBG
         9c7wAGtZBSZ7lS3tYpdRGX1XV6EW8hKIyadGhk+8XrqQX/qJA3i3pB3MbDCN+pLjkN
         ANBdfpsd6v+pbUezujnXqEKfaWEBk07zeD8PCfFa+IZJe3x8ZGlrC8wnyckx7HH3vT
         XSu3biW8py3ETqCF6rMlRW764U5RTVQDmHb0ajfh7qG2B/2kb5JHmmxx/lczXeeMDy
         OoW5AY0nLzs8Q==
Received: (nullmailer pid 1295173 invoked by uid 1000);
        Mon, 11 Sep 2023 15:44:48 -0000
Date:   Mon, 11 Sep 2023 10:44:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com
Subject: Re: [PATCH 8/9] dt-bindings: reserved-memory: MediaTek: Add reserved
 memory for SVP
Message-ID: <20230911154448.GA1279317-robh@kernel.org>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
 <20230911023038.30649-9-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911023038.30649-9-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:30:37AM +0800, Yong Wu wrote:
> This adds the binding for describing a CMA memory for MediaTek SVP(Secure
> Video Path).

CMA is a Linux thing. How is this related to CMA?

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,secure_cma_chunkmem.yaml         | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,secure_cma_chunkmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,secure_cma_chunkmem.yaml b/Documentation/devicetree/bindings/reserved-memory/mediatek,secure_cma_chunkmem.yaml
> new file mode 100644
> index 000000000000..cc10e00d35c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,secure_cma_chunkmem.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/mediatek,secure_cma_chunkmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Secure Video Path Reserved Memory

What makes this specific to Mediatek? Secure video path is fairly 
common, right?

> +
> +description:
> +  This binding describes the reserved memory for secure video path.
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    const: mediatek,secure_cma_chunkmem
> +
> +required:
> +  - compatible
> +  - reg
> +  - reusable
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        reserved-memory@80000000 {
> +            compatible = "mediatek,secure_cma_chunkmem";
> +            reusable;
> +            reg = <0x80000000 0x18000000>;
> +        };
> +    };
> -- 
> 2.25.1
> 
