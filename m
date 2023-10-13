Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D37C87B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJMOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:18:21 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB87CBD;
        Fri, 13 Oct 2023 07:18:20 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57b811a6ce8so1082944eaf.3;
        Fri, 13 Oct 2023 07:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206700; x=1697811500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPd5fv0hVWwxKT/C0R4CUUe47AKhFbW/BHGeFdYUt7c=;
        b=Z3uzYBkRU0Monn0GM8NJl6OK8ihPq7qW6gzzs2QVUzQZ7BydIDdJwTAhvv3AF9dDLJ
         kviVIgUTioY3ENsS7i8hu3Tgtn0vHgUck6aL35fzMWg1L/RbilwbzDR63TXaZzkQPcV8
         Jc0d5lSKWjVjPLa0cAGzdsQAguF9UHh/hHtbniKA5JcrvZUedrJXEZhZ32xkeXaICnAC
         ViEBRuy3QuPUB+Rz4RPOa+wMeHDK+gdupTw2RX+MvCoHgn1T/sRJdcxgYxrTCyGZdzvf
         qYcABHOAqcAQBg7A0Qz/9oo7AVtPEhEnJe2tDZQbOoL4jJKKlYbH3dgnFjzr7lJpOfJY
         t2og==
X-Gm-Message-State: AOJu0YzXLFeWAvIRLgOdvWnfAmhU5QQM/pLJ+e0h6zRnn6lKeTyMFUHB
        cBQfV+ShxgE4N/5kLOBYjQ==
X-Google-Smtp-Source: AGHT+IHExzxMpDSPXY/3DM/M56e2wZSovyiqU/wvsmcDW7iMiUTUUTINlZTZfeKsGga3ppvYyqqV0w==
X-Received: by 2002:a05:6871:5288:b0:1e9:ccec:645a with SMTP id hu8-20020a056871528800b001e9ccec645amr3696691oac.44.1697206699939;
        Fri, 13 Oct 2023 07:18:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy40-20020a056870c7a800b001e1754b9fc1sm653219oab.24.2023.10.13.07.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:18:19 -0700 (PDT)
Received: (nullmailer pid 3802821 invoked by uid 1000);
        Fri, 13 Oct 2023 14:18:17 -0000
Date:   Fri, 13 Oct 2023 09:18:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
Message-ID: <20231013141817.GB3793553-robh@kernel.org>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
 <d971d7c1-c6b5-44a4-81cf-4f634e760e87@lunn.ch>
 <CACRpkdYocdsrsydHwe_FF--6g-Y_YwxHXF6GUTe3wRY0suSCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYocdsrsydHwe_FF--6g-Y_YwxHXF6GUTe3wRY0suSCCg@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:04:10PM +0200, Linus Walleij wrote:
> Hi Andrew,
> 
> thanks for reviewing!
> 
> On Fri, Oct 13, 2023 at 2:43 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - marvell,mv88e6060
> >
> > The 6060 is a separate driver. Its not part of mv88e6xxx. So it should
> > have a binding document of its own.
> 
> It really doesn't matter to the DT bindings.
> It is not the job of DT to reflect the state of Linux.
> 
> In another operating system they might all be the same driver.
> Or all four variants have their own driver.
> 
> If the hardware is distinctly different so a lot of the properties
> are unique then it may be warranted with a separate DT
> binding, for the sake of keeping bindings simpler and
> coherent.

Exactly.

> 
> > > +  '#interrupt-cells':
> > > +    description: The internal interrupt controller only supports triggering
> > > +      on IRQ_TYPE_LEVEL_HIGH
> > > +      # FIXME: what is this? this should be one cell should it not?
> > > +      # the Linux mv88e6xxx driver does not implement .irq_set_type in its irq_chip
> > > +      # so at least in that implementation the type is flat out ignored.
> > > +    const: 2
> >
> > This interrupt controller is for the embedded PHYs. Its is hard wired
> > active high.
> 
> Hmm.... I need feedback from the DT people here. It does have a
> polarity, but the polarity cannot be changed. So shall we encode this
> always the same polarity in the flags cell or skip it altogether?
> 
> I'm uncertain. The currens scheme does reflect a reality.

Either way is fine. If users are already doing 2 cells, then I'd 
probably just keep that and state that the flags cell is ignored/unused.

Rob
