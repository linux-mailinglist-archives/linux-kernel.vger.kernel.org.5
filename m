Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07EC753F62
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjGNP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjGNP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:56:02 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385135A8;
        Fri, 14 Jul 2023 08:55:57 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-78625caa702so81240139f.1;
        Fri, 14 Jul 2023 08:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350156; x=1691942156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNZFP4mW99DwtXznitHmmJIt+x4d+svOUE0Ehy3Kg9c=;
        b=AE9bMdabTXyw5SK9sUTYRXuyMcFtz5sThJTd7w/88yS+58+J1pQJhzA6GqrU0f9zy2
         4qRAhIpa7yhpeFS0whOeR+qsgdyjVOrgTgKcUb564mxeXlCBMcl77HCz9hUNmPSBBcMZ
         KTUqMKLHM1kgPpsWn2QvuWJBU590xWahHW+0+07KhLobFtLtd15RqCsRfAP7CVHBd6Xz
         1qLX90Zvi4MKH11A5QEQ0tDGxSMHitoiV+kz+vFC05pkt4eyW6EGjoCE7yw2u77EDGv5
         54RlhB890ptYqRVW/IjYg5QylO6tiAC5TmNRp09SlcmnadIdVrfQTX3Mu+G9Hk0XcjHh
         BICg==
X-Gm-Message-State: ABy/qLaxDHVPeaBcPLwK7NAi1H6JudwbfYTi3LFBL2Q2gJYh5uostM8p
        Y2qdxZgbdtK6hfs9yPZZgw==
X-Google-Smtp-Source: APBJJlE4L549pt9iOdB31Vv+jb4GGXjOF7BIKHFlzpjgKeW0XdyUUPL86H99oVrbGwrQ07NryN3fzQ==
X-Received: by 2002:a5d:9b0d:0:b0:785:d4f5:2225 with SMTP id y13-20020a5d9b0d000000b00785d4f52225mr5028184ion.19.1689350156613;
        Fri, 14 Jul 2023 08:55:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h17-20020a02c4d1000000b0042b8566a982sm2648207jaj.41.2023.07.14.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:55:55 -0700 (PDT)
Received: (nullmailer pid 3916353 invoked by uid 1000);
        Fri, 14 Jul 2023 15:55:53 -0000
Date:   Fri, 14 Jul 2023 09:55:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] dt-bindings: nand: meson: make ECC properties
 dependent
Message-ID: <20230714155553.GA3913802-robh@kernel.org>
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

On Tue, Jul 11, 2023 at 03:21:28PM +0300, Arseniy Krasnov wrote:
> ECC properties 'nand-ecc-strength' and 'nand-ecc-step-size' depends on
> each other, so they must be both either set or not set. 

Is that true for all drivers or just meson?

> In first case
> ECC core will try to use these values if possible (by checking ECC caps
> provided by driver), in second case ECC core will select most optimal
> values for both properties.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index e81757c9e0ed..4f6e56542a7e 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -58,6 +58,10 @@ patternProperties:
>              meson-gxl-nfc 8, 16, 24, 30, 40, 50, 60
>              meson-axg-nfc 8
>  
> +    dependencies:
> +      nand-ecc-strength: ['nand-ecc-step-size']
> +      nand-ecc-step-size: ['nand-ecc-strength']
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.35.0
> 
