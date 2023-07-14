Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14B753388
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjGNHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGNHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:50:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0B30E0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:50:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so14759915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689321004; x=1691913004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ugr1nKWo0tHUl4i565GOZQnCj/QVDFoqHM8cjNP8oLQ=;
        b=Ol7SNUGf0nyq4TmloK/Y5A3bNqYAzcHTc6BNnYkNndswp+w0xHRJ6IhvOOfIaNXNUo
         aReZsNf106ztb87etspgpuz3Z7rl72nirHfrApIbMp2gV1FtvQF1FQRU2Ht19Sz28y/g
         XG5kyuzrfqeXWY62QI57jveGTRSyaTRXRv6/ko/h0E5dGEYwf75qkeYi1bq3q0CkRqMv
         wmclO7ajAdoBIJG7/cyJuMktcMLdQcjl5T4va3zN7ToasN1GopJPvKBt771qYBw7nBNW
         fkjE1b3t6LRzN1zLyYAyojHGedzKlo760DmHqgstLPWeK2a6tc3rywziof7m9kkdGDWF
         BkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321004; x=1691913004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugr1nKWo0tHUl4i565GOZQnCj/QVDFoqHM8cjNP8oLQ=;
        b=jQt1Wdn4ef4mk2DqWpyf2jON4dBYzoziQfB0f+K0LUVf3uTEpxPeXKmF2MgUQtrzgK
         POjHzjPsixEhpkszLRkEGCbYh3Pjj6C+bjilWDLbxhf1LmLE2LvBeLN0GgWlzwO5tD9x
         aBGUiT5aq485zdOJJPMLovtWfOKok42FSO07i5tzGISz9kTkziAkodHWr6gSUxt8IcAF
         la9Ym9tOrpddXTBsauujShIJ1/QFFdDZFPsULuO1tbSPiTASTujPcUT0SXoxuo/qqbQo
         O0NItNuFgOaEsmkS5Q3MPY0ln13rm9wSZPJYS6Xs2E3RI40T2ICPFRBQAeP4r2210IxV
         KwsQ==
X-Gm-Message-State: ABy/qLbIh3DKfeezWlOgYWdHHBdSFivEgCnKAt9t7R973MiwyQvkloxO
        FVoeOOJ6K+gHQrLZYmAvLHSp8g==
X-Google-Smtp-Source: APBJJlH+84rp2p3GFR4kUoeLJFeu4BMqNMFFRD/PLdDKyjHBuhSO9ixuy4JX54IRwxvQp0IrtKTWwg==
X-Received: by 2002:a1c:730c:0:b0:3fb:b890:128b with SMTP id d12-20020a1c730c000000b003fbb890128bmr3299001wmb.27.1689321004638;
        Fri, 14 Jul 2023 00:50:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u13-20020a7bcb0d000000b003fbd597bccesm762282wmj.41.2023.07.14.00.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:50:04 -0700 (PDT)
Message-ID: <7aa255e8-1cf1-03c6-02c8-de7c737a5683@linaro.org>
Date:   Fri, 14 Jul 2023 09:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-2-yuji2.ishikawa@toshiba.co.jp>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714015059.18775-2-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 03:50, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> Changelog v2:

Thank you for your patch. There is something to discuss/improve.

> - no change
> 
> Changelog v3:
> - no change
> 
> Changelog v4:
> - fix style problems at the v3 patch
> - remove "index" member
> - update example
> 
> Changelog v5:
> - no change
> 
> Changelog v6:
> - add register definition of BUS-IF and MPU
> 
> Changelog v7:
> - remove trailing "bindings" from commit header message
> - remove trailing "Device Tree Bindings" from title
> - fix text wrapping of description
> - change compatible to visconti5-viif

Then the filename should be updated to match it:
toshiba,visconti5-viif.yaml


> - explicitly define allowed properties for port::endpoint
> 
>  .../bindings/media/toshiba,visconti-viif.yaml | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 

...

> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description: Input port, single endpoint describing the CSI-2 transmitter.
> +
> +    properties:
> +      endpoint:
> +        $ref: video-interfaces.yaml#
> +        additionalProperties: false

This should be rather:
unevaluatedProperties: false
> +
> +        required: ["bus-type", "clock-noncontinuous", "link-frequencies", "remote-endpoint"]

That's not the syntax we try to keep in the bindings. See
renesas,rzg2l-csi2.yaml.

> +
> +        properties:
> +          data-lanes:
> +            description: VIIF supports 2 or 4 data lanes
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            minItems: 1
> +            maxItems: 4
> +            items:
> +              minimum: 1
> +              maximum: 4
> +
> +          clock-lanes:
> +            description: VIIF supports 1 clock lane
> +            const: 0

Are you sure it must be on position 0?

> +
> +          bus-type: true
> +          clock-noncontinuous: true
> +          link-frequencies: true
> +          remote-endpoint: true

Drop all of these "xxx: true", should not be needed after converting to
unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        viif@1c000000 {

isp@
(or video or something else matching this type of the device, but this
should be a generic name)

> +            compatible = "toshiba,visconti5-viif";
> +            reg = <0 0x1c000000 0 0x6000>,
> +                  <0 0x1c008000 0 0x400>,
> +                  <0 0x1c00E000 0 0x1000>,
> +                  <0 0x2417A000 0 0x1000>;

Lowercase hex, please.

Best regards,
Krzysztof

