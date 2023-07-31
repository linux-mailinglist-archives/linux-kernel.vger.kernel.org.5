Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95517695B9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjGaMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGaMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:11:33 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF81724;
        Mon, 31 Jul 2023 05:11:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A7A9CFB03;
        Mon, 31 Jul 2023 14:11:16 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s8Fn4PzHcjuu; Mon, 31 Jul 2023 14:11:15 +0200 (CEST)
Date:   Mon, 31 Jul 2023 14:11:13 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     David Heidelberg <david@ixit.cz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: sound: gtm601: convert to YAML
Message-ID: <ZMek4XHZQ/HVahKV@qwark.sigxcpu.org>
References: <20230730191742.117013-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730191742.117013-1-david@ixit.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 30, 2023 at 10:17:42PM +0300, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v4:
>  - added missing required property
> v3:
>  - incorporated feedback from Krzysztof
> v2:
>  - add #sound-dai-cells
>  - put kernel@puri.sm into maintainers
> 
>  .../devicetree/bindings/sound/gtm601.txt      | 19 ---------
>  .../bindings/sound/option,gtm601.yaml         | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/option,gtm601.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
> deleted file mode 100644
> index efa32a486c4a..000000000000
> --- a/Documentation/devicetree/bindings/sound/gtm601.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -GTM601 UMTS modem audio interface CODEC
> -
> -This device has no configuration interface. The sample rate and channels are
> -based on the compatible string
> -	"option,gtm601" = 8kHz mono
> -	"broadmobi,bm818" = 48KHz stereo
> -
> -Required properties:
> -
> -  - compatible : one of
> -	"option,gtm601"
> -	"broadmobi,bm818"
> -
> -
> -Example:
> -
> -codec: gtm601_codec {
> -	compatible = "option,gtm601";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/option,gtm601.yaml b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> new file mode 100644
> index 000000000000..69c2ccc79dc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/option,gtm601.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GTM601 UMTS modem audio interface CODEC
> +
> +maintainers:
> +  - kernel@puri.sm
> +
> +description: >
> +  This device has no configuration interface. The sample rate and channels are
> +  based on the compatible string
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:  # 48 kHz stereo
> +          - const: broadmobi,bm818
> +          - const: option,gtm601
> +      - const: option,gtm601  # 8 kHz mono

This looks good to me. I just wonder if it makes sense to use a description
instead of comments to make the sampling rate/channel requirements a bit
more obvious:

      - description: Broadmobi BM818 (48kHz stereo)
        items:
           - const: broadmobi,bm818
           - const: option,gtm601
      - description:  Option GTM601 audio code (8kHz mono) 
        const: option,gtm601

Cheers,
 -- Guido

> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    codec {
> +        compatible = "option,gtm601";
> +        #sound-dai-cells = <0>;
> +    };
> -- 
> 2.40.1
> 
