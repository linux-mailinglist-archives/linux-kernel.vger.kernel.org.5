Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB79F7543EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbjGNUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:45:43 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572EE74;
        Fri, 14 Jul 2023 13:45:42 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-78358268d1bso94257339f.3;
        Fri, 14 Jul 2023 13:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689367541; x=1691959541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y3ra0r3hkaBwd8vx0dfHK0XFY3aSMiR7tGnV2YHC7U=;
        b=MCcGfKGHhIwGi33ubPCi/JGUNERe/DiM6drJFWrDFZBW/mwAqk+G1Z73uWByjiBuj6
         Yn1THWqd8q0HdqD8kze9sW1/CU0rw5b7cYwHcgYfrrujuU7vMdfvko7Ya70hRui3YtPz
         b23lUjxbew8VBpoJbgR6j8bLqChzthUUhdU5eAFvgneNwrYhgDG5fdZVF4YcpqEuL3Qb
         LLlDGPEcMHRM+v2sozdNsUmtjjrqtPylJ4vU/mLCJsZeTa2Kr1uqnFJ7ZxuK0OM70ZZn
         3wrIq8oKgpe3+6sZRqg1D5DpwUbHT7Ohjt92nlRq8NdGLtArG4SDv9ePiEgj6/VgebzA
         LSOg==
X-Gm-Message-State: ABy/qLae2DA5sxeBxoYKJwyzXoLl8KBmKxCDKmT73OpLEWPOTGlgn2Ut
        2oVVXWhMLlq5EYkB5nLRSg==
X-Google-Smtp-Source: APBJJlH1Da/kb2t5sY+oGkdk6N3MmDw6HcAHu+e6hf9UrMvHrAMm8reBosfrr4DwbQuqA3fVE7OYmw==
X-Received: by 2002:a5e:a803:0:b0:783:3899:e1d0 with SMTP id c3-20020a5ea803000000b007833899e1d0mr6278307ioa.6.1689367541712;
        Fri, 14 Jul 2023 13:45:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e15-20020a02a50f000000b0042b69cca627sm2649569jam.137.2023.07.14.13.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 13:45:41 -0700 (PDT)
Received: (nullmailer pid 190560 invoked by uid 1000);
        Fri, 14 Jul 2023 20:45:27 -0000
Date:   Fri, 14 Jul 2023 14:45:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eliav Farber <farbere@amazon.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon: moortec,mr75203: fix multipleOf for
 coefficients
Message-ID: <168936752590.190481.1796694442557063883.robh@kernel.org>
References: <20230712081124.110345-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712081124.110345-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 12 Jul 2023 10:11:24 +0200, Krzysztof Kozlowski wrote:
> Few coefficients use default values multiple of 100, not 1000 (in the
> example DTS and in the Linux driver):
> 
>   moortec,mr75203.example.dtb: pvt@e0680000: moortec,ts-coeff-g:0:0: 61400 is not a multiple of 1000
> 
> Fixes: bf1fdafdbc61 ("dt-bindings: hwmon: (mr75203) add coefficient properties for the thermal equation")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml          | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!

