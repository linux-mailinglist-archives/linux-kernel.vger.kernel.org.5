Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2E80A36B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573741AbjLHMhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjLHMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:37:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5141987;
        Fri,  8 Dec 2023 04:37:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so231069766b.1;
        Fri, 08 Dec 2023 04:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702039038; x=1702643838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPQ6igrFJgaAkCCJ/PrY9rvOQPcIfSLQwy5XAAYTFZ4=;
        b=WRVtDSVdr1jEbYjNP8e/T6GfnH5uuRxJmXv9YwgPsiG+AUR9qqGlrYZQOXX8zS7XNk
         iRgQlc+fFnMLmU7rFUuscT9vAxWowry4JUg+e45+pLs0IYpLE/EYc6bHGVMUVH1lIfR/
         B6GjRVkw9bB6O6RIQdngXqkSJrHDE53LSfZqWgJIeNSWJ+hxSYzKIr8BHBRXyUbhmoZ9
         E5/LUQpJOvkrFxB56TWP/Mq2BbvE51na4idJNwSV1dqqBohc6b9kvWiuxFzbpY7hPKsq
         9Kqap/OLNDAV7KF/fS9AfP+tQqTU8rxY3C26iYZwgQCaDB4D3Ljc+SKPquPE33qVyN9h
         /dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039038; x=1702643838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPQ6igrFJgaAkCCJ/PrY9rvOQPcIfSLQwy5XAAYTFZ4=;
        b=VUhpiLTI6vdkBpB3A2A7qBKu/0hQ+6ptcVcX9ptwvYv3rKh2C3cQY7q6rdMqLCKajP
         5UQfpqf8IrQb4ezSziS2wKUoseVFBDoorGHsoehG1zL1loTGOBP36LNdFQZogtaFkx9e
         aWduvvxW2japOEEa+oFutd2V8NQL1QtLt8FbsiiPz5jJ6g/UvjvuNUgH3Vx8+CJgsyNh
         7DfBaSAgOwTKvQ3oiKsmTX2HtCs0bzgOA+x+NlBmUDYQqmfRp2QHxS8lJKDmKvwO2wGh
         m+kCZUaXcYQa21eV2oKALBWVNkDHxsffNs6kmwZmyTXqk33BeL+ZO4hvk3CSGXO+0CGy
         nu+g==
X-Gm-Message-State: AOJu0Yx2LG+R3BMnnhLdhs28gRjRutUVfyecTj/yWPChFG8+vOdkKVbd
        6lF8egy+zLh0O9XK2jTx1D0=
X-Google-Smtp-Source: AGHT+IFifdS6Qk1seBmfoJXsGQi4ktaHsgxpPEGE814Znqh9/iODFHgV0KfjFcbZ42XhVpjwJN7Btw==
X-Received: by 2002:a17:906:718:b0:a18:35e2:de31 with SMTP id y24-20020a170906071800b00a1835e2de31mr1973793ejb.63.1702039037564;
        Fri, 08 Dec 2023 04:37:17 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:905b:7c28:f9e2:a6aa])
        by smtp.gmail.com with ESMTPSA id jl26-20020a17090775da00b00a1d20467a90sm957286ejc.214.2023.12.08.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:37:13 -0800 (PST)
Date:   Fri, 8 Dec 2023 13:37:08 +0100
From:   Stefan Eichenberger <eichest@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, linus.walleij@linaro.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: atmel,maxtouch: add
 poweroff-in-suspend property
Message-ID: <ZXMN9EgWRjtJyybr@eichest-laptop>
References: <20231207111300.80581-1-eichest@gmail.com>
 <20231207111300.80581-2-eichest@gmail.com>
 <b9868bd4-6f14-4628-88ea-56d06027739e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9868bd4-6f14-4628-88ea-56d06027739e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Dec 07, 2023 at 05:59:08PM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2023 12:12, Stefan Eichenberger wrote:
> > diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> > index c40799355ed7..047a5101341c 100644
> > --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> > +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> > @@ -87,6 +87,12 @@ properties:
> >        - 2 # ATMEL_MXT_WAKEUP_GPIO
> >      default: 0
> >  
> > +  atmel,poweroff-in-suspend:
> > +    description: |
> > +      When this property is set, all supplies are turned off when the system is
> > +      going to suspend.
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

Thanks a lot for the feedback. Would the following be okay as a
description?

vdda and vdd are switched off in suspend mode.

Best regards,
Stefan
