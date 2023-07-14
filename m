Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D07543E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbjGNUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:45:07 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD621BE3;
        Fri, 14 Jul 2023 13:45:06 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-345e55a62d8so10027865ab.3;
        Fri, 14 Jul 2023 13:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689367505; x=1691959505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjp2goDmU3eZUaBvWIsYt7Ff9ugaAud6phFHMfCuKPk=;
        b=kgvMAnp/Fns4BOXaxBRsxO7JlEqg5nNnYLOR1wwzf/31IrW7K2g1bxhwFkzRw4xoj9
         G1Lpwkqvjn4hRtOufqbsF8ZE+fnbsQVvSmLpiUp3G2IP7kQG7ohYR2C+9YEuWMXfl80q
         q6aHBt/YO/Qz/m/OfgikXEvOLvsn1Gn0oXya0cEk99WYa+vkQpsmhH2tRBzoR8r1+Bbr
         7Ir8lbdXD7dwf57dmjNvW4Wyr8qwy0eKkb0wDYZx2Wfsxuq3WQ6Rqti0kUwCHUfknqe0
         jO7x5hADQvqusdtq2JMAWazsmQD7MboEJl2nPLXyh/si+55G1VxVAo6yrMSQV2aNdxyw
         pyAg==
X-Gm-Message-State: ABy/qLaw12mOXyLhp451N1uA1zPUo4gMfn+o36KZXnHQQlWEr6iNRqG7
        +NV/upAYo9yl5LcMS/Uh4Q==
X-Google-Smtp-Source: APBJJlHYIZYxjmYxxwO8SeGpPnHJlVlcG1xS21FJsirLDGT6wdMnGUi4wUo4SySMRd5VSiQAB3oyzg==
X-Received: by 2002:a92:da8f:0:b0:345:c72d:33a5 with SMTP id u15-20020a92da8f000000b00345c72d33a5mr5385994iln.19.1689367505374;
        Fri, 14 Jul 2023 13:45:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g11-20020a0566380bcb00b0042b48e5da4bsm2729732jad.134.2023.07.14.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 13:45:04 -0700 (PDT)
Received: (nullmailer pid 189489 invoked by uid 1000);
        Fri, 14 Jul 2023 20:44:50 -0000
Date:   Fri, 14 Jul 2023 14:44:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, kernel@sberdevices.ru,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>, oxffffaa@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH v3 2/3] dt-bindings: nand: meson: make ECC properties
 dependent
Message-ID: <168936748954.189426.381778716587465848.robh@kernel.org>
References: <20230711122129.2635558-1-AVKrasnov@sberdevices.ru>
 <20230711122129.2635558-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711122129.2635558-3-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jul 2023 15:21:28 +0300, Arseniy Krasnov wrote:
> ECC properties 'nand-ecc-strength' and 'nand-ecc-step-size' depends on
> each other, so they must be both either set or not set. In first case
> ECC core will try to use these values if possible (by checking ECC caps
> provided by driver), in second case ECC core will select most optimal
> values for both properties.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

