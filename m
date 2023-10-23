Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C07D3E08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJWRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJWRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:41:08 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6710CF;
        Mon, 23 Oct 2023 10:41:03 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2b1af09c5so2087457b6e.0;
        Mon, 23 Oct 2023 10:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082862; x=1698687662;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmqnrhI90Z1XEYPu0vBhhTnhUoWJuxsH4Kz9QXi9qtg=;
        b=UTjxkGvtLud72/hOwlcXscEp+CUeIS/k6aT859xrmwj4WMAcMyuLyNwnry6sLzQI6K
         RI4vtcakXeg6PziXIPpYcL7hi1XCPiXK3OF93+wJp4MMEwG4+n6JsC9IrarLVExwR5CF
         ilLpb03MhD6i1XhxZcMmJ7qjJFVEb7zFZ+dRlHDJDNOQq112t6p46gONAuzYLXP1XTix
         vg4zoqnVksc3oXarq/tX5aJYGUbCoOKUwNkAgxVZV2SYRuuWRXt+2VqzmYI5L+MaVSEy
         nduMJdy2Prq2KIG88jLG5DXJwwXV+oKoNi/S7gxonxBcEjzNvwe0tt8rc64/KiVV7tmt
         eJNg==
X-Gm-Message-State: AOJu0YzqrcSn731oQnJsiuj5zeoDxN0/QxZIb/ovLhZibDuzFJg9Dr3k
        OOcjUs34543nXZfj8PDq5Q==
X-Google-Smtp-Source: AGHT+IHV9ojFzaeIhztF8lWZjX/vfptW0p5inXTEfvWm3/N7Fj8s4KWJ5FOFJN8T6j84XIOkU8V+vw==
X-Received: by 2002:a05:6808:bc1:b0:3a9:cfb5:462a with SMTP id o1-20020a0568080bc100b003a9cfb5462amr10051960oik.36.1698082862515;
        Mon, 23 Oct 2023 10:41:02 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6e0:8169:8cd7:6070:de02:c079])
        by smtp.gmail.com with ESMTPSA id r5-20020a0568080aa500b003ae540759a0sm1560522oij.40.2023.10.23.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:41:01 -0700 (PDT)
Received: (nullmailer pid 864626 invoked by uid 1000);
        Mon, 23 Oct 2023 17:40:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
 <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
Message-Id: <169808265708.861114.9088023510447543664.robh@kernel.org>
Subject: Re: [PATCH net-next v5 1/7] dt-bindings: net: dsa: Require ports
 or ethernet-ports
Date:   Mon, 23 Oct 2023 12:40:49 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 09:18:52 +0200, Linus Walleij wrote:
> Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> a DSA switch node need to have a ports or ethernet-ports
> subnode, and that is actually required, so add requirements
> using oneOf.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wrong indentation: expected 8 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/dsa.yaml: $defs: 'oneOf' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found in $defs key.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/dsa.yaml: $defs:oneOf: [{'required': ['ports']}, {'required': ['ethernet-ports']}] is not of type 'object'
	hint: $defs entries must contain schemas
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

