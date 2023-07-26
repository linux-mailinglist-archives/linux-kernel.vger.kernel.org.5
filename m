Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C55762AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGZFYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGZFY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:24:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D102738;
        Tue, 25 Jul 2023 22:24:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4039f0d140eso52439951cf.1;
        Tue, 25 Jul 2023 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690349049; x=1690953849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3/b1svPfCxY8b6G9lEyU8Vyl9EjVxmK0dR5evJYDXY=;
        b=aB1sv1Vcv2FwxJtiYTHGCoIIi88GwTS66jdIzuf+pfGZT05cEaRiJExm4i1VD65gCV
         nh4fK1PLHcOBCHjtQHDbmd7/fy3JoC40/hxCztcVNBRndlGn9a/mxkt4liOmO9UhMr89
         8soF7uIYau//ZHVJPF+G4Dx3Omm5VhTKhRtmN3LubCb5i7mLDzFiqUbxXxcEAwhgnGEU
         uLFgn92U4yxSF5Slj1Gjz/NX91NABbMGpj3CLcC3OT35xqZBoWT7k7v1+k6lNFtw/qhZ
         FEZzBGoBQLNXObnBc9jbT3wXecS8j19/vxJ8sGqx9AluyVIh/utdw9FrhWIrcuPa+vf7
         iXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690349049; x=1690953849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3/b1svPfCxY8b6G9lEyU8Vyl9EjVxmK0dR5evJYDXY=;
        b=NvRLCWrqQ8wUZ2pn22jFjpke6RDCKlHgWjNytYo/KxlOZ4s8n4iX/zdPvezWnjGxQl
         Cpa7WN+TPkDt+0567r7emBoLlX9ddd9jnKDPzKtwMR+OdCnjq/p41oqm/vvfGTf+h88c
         Zj52idnl2yMZk1Dswp888W6ji9ucWVVJBqDp6Deib3DYywMP2+nHS/iRdIRIi+kFln4P
         q7VNu55ggXsH/8g5B29euLRMmYeauZdoNFkALlTQcGFAlqKisAuxVy9AzGYUkrbf1Vl1
         pQh3uIRo/Cs78fh1TXClFYVFJzhtYG8tKnZp8GGx0f5reFesCBOPDtxS/X6xljUusToa
         s9Uw==
X-Gm-Message-State: ABy/qLaCzIJXKg42dXWEZVTjI7HKQgwvcbJgA5uOOFhWyp4jp7YteO7P
        gdLBhn+frW2D7wxPZCbzns8=
X-Google-Smtp-Source: APBJJlFTe4YFpj3Yse6kBJERqW23H9uklSXmOf1tarq8nZxZDxdMDymRawqMCOiHPMDk402U/J9Fag==
X-Received: by 2002:a05:620a:3901:b0:767:785:2b48 with SMTP id qr1-20020a05620a390100b0076707852b48mr1281399qkn.16.1690349048914;
        Tue, 25 Jul 2023 22:24:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ade8c00b00263ba6a248bsm452950pjv.1.2023.07.25.22.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:24:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 22:24:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     werneazc@gmail.com
Cc:     jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add description for new hwmon
 sensor hs3001
Message-ID: <b15222f3-8e03-405a-8e22-4642e67dbb69@roeck-us.net>
References: <0f32155b-bcc1-4d9e-bba9-058d63194abc@roeck-us.net>
 <20230726051635.9778-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726051635.9778-1-andre.werner@systec-electronic.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:16:34AM +0200, werneazc@gmail.com wrote:
> From: Andre Werner <andre.werner@systec-electronic.com>
> 
> Add binding for Renesas HS3001 Temperature and Relative Humidity Sensor.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v1: Using separate dt-binding hs300x.yaml
> v2: Reviewer recommends documentation of driver dt-binding in
> trivial-devices.yaml because the driver has no special properties
> to describe.
> v3: Simplify description of sensors compatible
> v4: Change patch description
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

This is now a bit messed up.

Never mind, fixed and applied.

Guenter

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ba2bfb547909..96eb59e56eb7 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -315,6 +315,8 @@ properties:
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
>            - pulsedlight,lidar-lite-v2
> +            # Renesas HS3001 Temperature and Relative Humidity Sensors
> +          - renesas,hs3001
>              # Renesas ISL29501 time-of-flight sensor
>            - renesas,isl29501
>              # Rohm DH2228FV
