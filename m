Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1A762AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGZFmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGZFmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:42:08 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 22:42:02 PDT
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9726A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:42:02 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 71C162F9F328
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:35:13 +0200 (CEST)
Received: from s979.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 625012E27956;
        Wed, 26 Jul 2023 07:35:13 +0200 (CEST)
Received: from s476.loopia.se (unknown [172.22.191.5])
        by s979.loopia.se (Postfix) with ESMTP id 5FF6810BC349;
        Wed, 26 Jul 2023 07:35:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from s934.loopia.se ([172.22.191.5])
        by s476.loopia.se (s476.loopia.se [172.22.190.16]) (amavisd-new, port 10024)
        with UTF8LMTP id 8oQDPUiBmNm1; Wed, 26 Jul 2023 07:35:13 +0200 (CEST)
X-Loopia-Auth: webmail
X-Loopia-User: richard@bit42.se
Received: from webmail.loopia.se (unknown [172.22.212.9])
        (Authenticated sender: richard@bit42.se)
        by s934.loopia.se (Postfix) with ESMTPA id E37267CEA72;
        Wed, 26 Jul 2023 07:35:12 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 26 Jul 2023 07:35:12 +0200
From:   richard@bit42.se
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, niklas.soderlund+renesas@ragnatech.se
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
In-Reply-To: <20230410082051.2948510-1-richard@bit42.se>
References: <20230410082051.2948510-1-richard@bit42.se>
User-Agent: Loopia Webmail/1.6.1
Message-ID: <e248cd32ba0fe9388a72a732ad252eaa@bit42.se>
X-Sender: richard@bit42.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-10 10:20, Richard Alpe wrote:
> Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.
> 
> Signed-off-by: Richard Alpe <richard@bit42.se>
> ---
> v3: Introduce this patch.
> v4: Updates according to feedback from Krzysztof.
> v5: Fix yamllint warning (file name $id matching).
> 
>  .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml 
> b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
> new file mode 100644
> index 000000000000..df826b40d8ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP QorIQ eFuse support
> +
> +maintainers:
> +  - Richard Alpe <richard@bit42.se>
> +
> +description:
> +  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    const: fsl,t1023-sfp
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    efuse@e8000 {
> +        compatible = "fsl,t1023-sfp";
> +        reg = <0xe8000 0x1000>;
> +    };
> +...

Gentle ping on this
