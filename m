Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0D7AA9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIVHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIVHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:02:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5F192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:02:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so228041466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695366119; x=1695970919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jMuggZZvKYcFUdy/dK+81rshpboXDd4s3uqzGI3A5Y=;
        b=K5rxQq5ot5FxzBgxgpFlZHjgXFbXo4MEKdyvaJJ1BlTG77yJ0Uzdo/PJadBIRP9xgF
         KxIbg91/4ISsMI4PSClorRXx78SbHHQAVDSVIT0dkAoYSUfyRVc9B4t/VqItJuosrrc7
         SxU09qWm73WFE9mh58y9te4l4uu3E37hCcyhGN/wIEO6GAD2eyH0LfNnbkh1QuO0k99G
         QV9ccgkb2DuS3o3cO9uMq8kl2uc3a7OhLKEe01cRe38yh+kbHYAJrOvRAKrxcnzFo8WT
         /RkW0YxPdj2AVXPcgPA4vgypJLeMyRSyUaf42WInxud7QgxGB0Xgnpaxxq4GB0Q6dj+c
         FaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695366119; x=1695970919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jMuggZZvKYcFUdy/dK+81rshpboXDd4s3uqzGI3A5Y=;
        b=FXvQZhLRavf7FHXviY3ph3EZPqPP+urgT8cqOiZMmjeJQnKSwjOUzCTb+g+/rJH2Q0
         93x0SpULFUFjE2DvfV9403mM16m7cDzY85H8lnBu+TkiXMpVesQBi5mEj0sWqtg6RAFQ
         7jWa/ZUJy5W3Tq2pZmfqPlvP2GDims/IgJ3HPe0lJK0Mjf8PxnKyPORdcCUbdrX+uJA1
         ZuXaR9tpke/zUwXS2dCAIiMRGsTB1JxBdzDPRUTGzYOxkedJszckDglKiJWIzANrTX/x
         Jh9SRk9MMMXlvBqeAtm+9/luBQdfrFFSzHophyV0UpOtM6oVLOObFFSffgmMAYqwVWoI
         /Wjw==
X-Gm-Message-State: AOJu0Yxd20j+uaIZHzQnWTp29vu4ZH+7MnXayW3dhgPevW3iBoHjB0fP
        69asMZ4v1D4GHqpDd66aEzG4ZA==
X-Google-Smtp-Source: AGHT+IG0i7UDbq0G1Fggapv+viejE9QTHLY0IXIcvKnvjvzePXoImlcw3a294mo0jaA03y9ttLUk9Q==
X-Received: by 2002:a17:906:519c:b0:9ae:5be8:ff90 with SMTP id y28-20020a170906519c00b009ae5be8ff90mr3193946ejk.68.1695366119042;
        Fri, 22 Sep 2023 00:01:59 -0700 (PDT)
Received: from [10.41.192.245] ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b0099bd046170fsm2220195ejr.104.2023.09.22.00.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:01:58 -0700 (PDT)
Message-ID: <da77e965-2893-097a-b438-85787c43dcb0@linaro.org>
Date:   Fri, 22 Sep 2023 09:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
Content-Language: en-US
To:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 20:45, Simon Glass wrote:
> Binman[1] is a tool for creating firmware images. It allows you to
> combine various binaries and place them in an output file.
> 
> Binman uses a DT schema to describe an image, in enough detail that
> it can be automatically built from component parts, disassembled,
> replaced, listed, etc.
> 
> Images are typically stored in flash, which is why this binding is
> targeted at mtd. Previous discussion is at [2] [3].
> 
> [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> [3] https://www.spinics.net/lists/devicetree/msg626149.html
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
>  .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  4 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> new file mode 100644
> index 00000000000000..c792d5a37b700a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman firmware layout
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +description: |
> +  The binman node provides a layout for firmware, used when packaging firmware
> +  from multiple projects. For now it just supports a very simple set of
> +  features, as a starting point for discussion.
> +
> +  Documentation for Binman is available at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
> +
> +  with the current image-description format at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
> +
> +properties:
> +  compatible:
> +    const: u-boot,binman
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      binman {
> +        compatible = "u-boot,binman";
> +
> +        u-boot {

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.


> +          size = <0xa0000>;
> +        };
> +
> +        atf-bl31 {
> +          offset = <0x100000>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> new file mode 100644
> index 00000000000000..8003eb4f1a994f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman/entry.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman entry
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +description: |
> +  The entry node specifies a single entry in the firmware.
> +
> +  Entries have a specific type, such as "u-boot" or "atf-bl31". If the type
> +  is missing, the name is used as the type.
> +
> +  Note: This definition is intended to be hierarchical, so that entries can
> +  appear in other entries. Schema for that is TBD.
> +
> +properties:
> +  $nodename:
> +    pattern: "^[-a-z]+(-[0-9]+)?$"

Why do you need this?

> +
> +  type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Provides the offset of this entry from the start of its parent section.
> +      If this is omitted, Binman will determine this by packing the enclosing
> +      section according to alignment rules, etc.
> +
> +  size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Provides the size of this entry in bytes. If this is omitted, Binman will
> +      use the content size, along with any alignment information, to determine
> +      the size of the entry.
> +


Best regards,
Krzysztof

