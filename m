Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E4753F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjGNQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjGNQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:10:11 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D563585;
        Fri, 14 Jul 2023 09:10:10 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-78625caa702so81878639f.1;
        Fri, 14 Jul 2023 09:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351010; x=1691943010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xZLrToRuYH5s+qILxxveTe7lxP6JYA2zQOdOHNzTzE=;
        b=Md1SAF5FwbtX0/48A0qyK0H8/PKj2lGyBqJeoo91/DZ+SUstknPcGxIRYlrIgoiuj4
         m16zwSrd4HrW25Mx8FNqK90UHBvUhUkPz35K7TmI/WB0g6y+wXdqA4ypuUimoaRFUzBz
         hn9u0p6iI94Eb7/bbjlok2/lwJie25/CaWXWE52rMZ3AoLIouz65vwqXxuiRdt+BODrg
         GI5cqgJUZNmLVOtcjTHapmaQZAu5XvzbVBCo9FGt5Yy0RHgF5EKeA0h6kc/wO6cpM1aV
         q2iL3MudlwzbTlcwPH1ZrQB8kkhy9Gf9J3nGn+C95LLAHHN/3KqLu91CYyMGEyuDvKq7
         55Nw==
X-Gm-Message-State: ABy/qLZ3MaEjpaNbCOdoP5IS8XjlxuxuUb4zgFqPnqEf6cauSQp7KRKD
        +w7U31WZIzll5fSSh6isOw==
X-Google-Smtp-Source: APBJJlE4lqiGT41vGhhD+F+H2ohvXCqZtxqLf3IR+mFBE+tp8lKrKP7cDsLcs5aBVLsQ/yQnIPnMfA==
X-Received: by 2002:a6b:d616:0:b0:783:3957:9b46 with SMTP id w22-20020a6bd616000000b0078339579b46mr4229419ioa.13.1689351009697;
        Fri, 14 Jul 2023 09:10:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a02cf04000000b0042b6cb44429sm2645937jar.46.2023.07.14.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:10:09 -0700 (PDT)
Received: (nullmailer pid 3934677 invoked by uid 1000);
        Fri, 14 Jul 2023 16:10:07 -0000
Date:   Fri, 14 Jul 2023 10:10:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
Message-ID: <168935100680.3934619.1806892417878701791.robh@kernel.org>
References: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 12 Jul 2023 09:45:53 +0200, Krzysztof Kozlowski wrote:
> Allow the GPIO controller subnode to define GPIO names.  Already used in
> at least on DTS:
> 
>   bitmain/bm1880-sophon-edge.dtb: gpio@50027000: gpio-controller@0: 'gpio-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

