Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62901788841
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbjHYNRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245015AbjHYNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:17:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23A410FE;
        Fri, 25 Aug 2023 06:17:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bed101b70so110621566b.3;
        Fri, 25 Aug 2023 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692969438; x=1693574238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKg1xNyj5cqg89HgKCFhTm6AC7PKqfAE4maU2AzHZSc=;
        b=ezgAX/bNtMDbH7vc/9Ke7Pm7RVCGBbr6vviIG5U3AohS50oZ562yeha2hYG/NUQCyh
         0OPSYWHaQkUY9/Y2kXqhUpKWDNTKZs0Z3yZsdnQN1h5O5IWyMxmCsQOTQerxvJQNLsUo
         9V5jIe7DHiIIPWw8maJ1vM6kQZ01O6Kw55J+UPIKMiPv4xVUsNrbgETbJVMz556mE8wq
         ju4YiAUslTbHW+OYMmf3kt44nxS5DhWW0aRgFmlqeuIbG3korcIJb62ic5hUks9u2hYT
         XdJGlbcB855l5gBbJVBrpKHty23dg8tV1SHpzGaqYSk7d7FRn8NdsTZfnttmBUGn0lQ2
         fuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969438; x=1693574238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKg1xNyj5cqg89HgKCFhTm6AC7PKqfAE4maU2AzHZSc=;
        b=k1BfDdZnEpoCzsCQCgbmLZvwMad1DbIAWopSt0CD90LA1hIO2lFRh+7LOTlXcyc92q
         vze9eoiaMGtzPTGjQSP5hGoI0mH1siNMOgHT0QWywCjKhoEs7lWAsSi6vrkEzN9gWwxB
         mJCrdxP0UwfIlU2JBict5zDFmAPXWubI9NDIcLQQt7m9ujWiBbYpNK3sCBF89E4CdFM4
         tL171cDAEtUFc4heQil0/OCf7nQb7LLbhLUomG+XaYAOB1C7s8TZDFaYV0gsll+BlFWk
         fDPUl8wcdr8oWSuMr6yfS/XnJqfyF+IA1HGKbQbdHyIIst4BoDn8twnn14XImrfqdvHH
         oFxw==
X-Gm-Message-State: AOJu0Yx4eWCpw5T1bZlA3XEWw0XCZjAY4vnoU28oSG4dyCrWh4CtKj/X
        d7LrW1K47woZZs/YJPxc3Fw=
X-Google-Smtp-Source: AGHT+IG3lIBxk0PJGn54zZk+fATrW+uM85zcUjxCRKp0LEy/DOqNmgmAtbh4Q2ezY1U6X2E4fdD81A==
X-Received: by 2002:a17:906:1099:b0:9a2:143e:a061 with SMTP id u25-20020a170906109900b009a2143ea061mr3560241eju.28.1692969437232;
        Fri, 25 Aug 2023 06:17:17 -0700 (PDT)
Received: from fedora ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b0099b42c90830sm961345ejm.36.2023.08.25.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:17:16 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:17:14 +0200
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCHv5 1/4] dt-bindings: wiegand: add Wiegand controller
 common properties
Message-ID: <ZOip2hz+0gK7FpLp@fedora>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-2-m.zatovic1@gmail.com>
 <20230824133701.GA649032-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824133701.GA649032-robh@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:37:01AM -0500, Rob Herring wrote:
> On Thu, Aug 24, 2023 at 01:10:12PM +0200, Martin Zaťovič wrote:
> > Wiegand bus is defined by a Wiegand controller node. This node
> > can contain one or more device nodes for devices attached to
> > the controller(it is advised to only connect one device as Wiegand
> > is a point-to-point bus).
> 
> How would multiple devices work? Seems like you'd need some sort of mux 
> which would be another node. If there's not really any need, then I'd 
> just say it's only a single device. Either way the binding needs to 
> define this.
> 
> > 
> > Wiegand controller needs to specify several attributes such as
> > the pulse length in order to function properly. These attributes
> > are documented here.
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> > ---
> >  .../bindings/wiegand/wiegand-controller.yaml  | 39 +++++++++++++++++++
> >  MAINTAINERS                                   |  5 +++
> >  2 files changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> > new file mode 100644
> > index 000000000000..8f36287e4fed
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Wiegand Generic Controller Common Properties
> > +
> > +maintainers:
> > +  - Martin Zaťovič <m.zatovic1@gmail.com>
> > +
> > +description:
> > +  Wiegand busses can be described with a node for the Wiegand controller device
> > +  and a set of child nodes for each SPI slave on the bus.
> 
> Some more detail on what Wiegand is would be useful. Link to spec? What 
> it is used for?

There is no official Wiegand datasheet out there. I can include the summary of
some proprietary documents about Wiegand, like the commit message of the second
commit in the series.

> 
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^wiegand(@.*|-[0-9a-f])?$"
> 
> The '-[0-9a-f]' suffix should be decimal rather than hex.
> 
> > +
> > +  pulse-len-us:
> > +    description:
> > +      Length of the low pulse in microseconds.
> > +
> > +  interval-len-us:
> > +    description:
> > +      Length of a whole bit (both the pulse and the high phase) in microseconds.
> > +
> > +  frame-gap-us:
> > +    description:
> > +      Length of the last bit of a frame (both the pulse and the high phase) in
> > +      microseconds.
> 
> If you have multiple devices, you need to define the child node format. 
> Specifically, you need addresses for multiple devices. So you need to 
> define the unit-address format, #address-cells and #size-cells values, 
> and any constraints on 'reg' such as max address and/or number of entries.

I see.. the bus should really only allow one device to be connected.
That means, there is no need to define anything else in this file, right?
I will explicitely mention it in the Description and I will add the

unevaluatedPropertied:
  type: object

to the wiegand-gpio.yaml file so that adding a child node is allowed.

> 
> Rob

With regards,
Martin Zaťovič
