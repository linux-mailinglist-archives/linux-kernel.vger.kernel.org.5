Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A567D5A80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjJXSaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJXSaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:30:23 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865C129;
        Tue, 24 Oct 2023 11:30:17 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ce2d4567caso3243575a34.2;
        Tue, 24 Oct 2023 11:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172216; x=1698777016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnP3eRYhK+qkeq8kCtjms76zvb6GVa1n6rL36FXwPWs=;
        b=jFZ+HDj3+AhAZdb+ahwlxI44X4PQHBOVEu85+ZFngLecXyKfqummnMXBbSRisQZ0k7
         hmwEzrnw/dDpOd2QYv7A0hBxnujw2ze4UvPsciCehjixMKdLorvUZwmN1JAyg3dONkGy
         uQPiCgCkVI1SDv6ZScrne4vgg8hMD8Bf1yFjk6GgX+H7UI7kPLRdYsU5H/6YnIFxdF4V
         7XUtQ3Wdg4b7Dx8bFNQoPiLEdGhaJCe1ginmpp08RyK3zZPHAk3ZMEjMt7KARgbgxCNn
         fvrC+cHPUFJnCtn9JthviF4rcum/MKv+SBOglddM5CC+bYuYKyQdxTrtYz0GEgPq8wCy
         CB3A==
X-Gm-Message-State: AOJu0Yz8PJSpjOceiSFkSu+RX1gpFy3vppm/fx4RK7xIG6CtDvyUSVgT
        xv6Mmkz71aNNWPdHYD4yPg==
X-Google-Smtp-Source: AGHT+IF62KygVK5CdR46X6iPh8K58aYkieAnOXIu/QCrpVTZJoDQpjSnO7sejz/lAfguZYXrsptPgA==
X-Received: by 2002:a05:6830:4492:b0:6bd:b0c9:a89 with SMTP id r18-20020a056830449200b006bdb0c90a89mr16702513otv.2.1698172216197;
        Tue, 24 Oct 2023 11:30:16 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a05683004a600b006c6311b15f6sm1919958otd.38.2023.10.24.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:30:15 -0700 (PDT)
Received: (nullmailer pid 246522 invoked by uid 1000);
        Tue, 24 Oct 2023 18:30:14 -0000
Date:   Tue, 24 Oct 2023 13:30:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andy.shevchenko@gmail.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 03/11] dt-bindings: leds: aw200xx: introduce optional
 hwen-gpios property
Message-ID: <20231024183014.GA243505-robh@kernel.org>
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
 <20231018182943.18700-4-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018182943.18700-4-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:29:35PM +0300, Dmitry Rokosov wrote:
> Property 'hwen-gpios' is optional, it can be used by the board
> developer to connect AW200XX LED controller with appropriate poweron
> GPIO pad.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index feb5febaf361..255eb0563737 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -41,6 +41,9 @@ properties:
>      description:
>        Leds matrix size
>  
> +  hwen-gpios:
> +    maxItems: 1

The standard enable-gpios or powerdown-gpios don't work for you?
