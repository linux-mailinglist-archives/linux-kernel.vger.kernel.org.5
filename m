Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B27BF22C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377308AbjJJFZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjJJFZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:25:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F9CA7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 22:25:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690f8e63777so1405000b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696915537; x=1697520337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snvQeStdhijDETWeVBYS3dl/07bqPJilz83FkwuW3kY=;
        b=adErcRurMoece39OYEqov3ZG47YzW29wlA7uPHkVQ4fk8s4Ocr9gfg0jGKKLMSWhG/
         vGnKeZ17f9irbIAEHGMbzjYbpmyy/4/hmCqHjNt+EMNBmwQQ0EBT9n3LrxK9aQiJ55Ir
         14hvhSxGJsRxavspQ2/3Ut++jyPH7NQjvKPweYg4JrT33VpBYkWlFcPraQFI80KhW/61
         X/EzyyeqCfJLPK4mDOnQYQfF1jessxY7fHWDFG+eNYE/v1xPoVDgNoQ418ZDVI/PGu00
         gcuC5+v8kj7FOiwM1GDKCjnVrXFqurObb6JU2yCFVdRDYWaYsGKzlD8/opgJKwpwclIv
         9ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696915537; x=1697520337;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snvQeStdhijDETWeVBYS3dl/07bqPJilz83FkwuW3kY=;
        b=UuQLX017709k2qnNL4jDPzS+GKaEaJcR/9m5+Ht3oF9iVk39tqi80QdCA4pJZ4biNL
         lxQxC7wBOmQdq+0FvCMXqLOhcTKz0QwL/r1NvkRIES9m+auL1SQnyofQ+ryte74D/ERW
         UapDHyhxTIr22szD/qA12Da2Z/KqDlWppT6usH04SZbYJ12mq3aqdNznsXs1vLUpzQnb
         E4crRnnG7kiUfP8bIF1waNw8nzcXt6j79hqZ0JBLsTrTZbF5Bjtmq4UYv2qETx9YDk+l
         YHlzf17jO2MAxJ62p5w2CTiz19H1gOuj0ztiqGjNKAjEso3H/kZf5ZPSfjPtWRopEOUo
         WHYg==
X-Gm-Message-State: AOJu0YxededP1ZiAuKeK4BEGV+toBrXVVpxw/27003wAZ3fDs/7qRIOM
        7vvZkXlZEIO9JruYvWkxwxW1kw==
X-Google-Smtp-Source: AGHT+IFI3I5vmphBv6NyErQg0zr3iIvSzwXWLQ5UEUtwuY2oSGr6Dh1hSlyHRK3PsH3Mwgh40cOI5A==
X-Received: by 2002:a05:6a00:d46:b0:68e:369b:a123 with SMTP id n6-20020a056a000d4600b0068e369ba123mr18720831pfv.1.1696915537115;
        Mon, 09 Oct 2023 22:25:37 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:d26f:f61a:9867:e809])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78c13000000b0069309cbc220sm7282740pfd.121.2023.10.09.22.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:25:36 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:25:32 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZSTgTC4cFFpofYAk@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:49:33AM +0200, Linus Walleij wrote:
> On Fri, Oct 6, 2023 at 3:23???PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Oct 05, 2023 at 11:58:43AM +0900, AKASHI Takahiro wrote:
> 
> > > A dt binding for pin controller based generic gpio driver is defined in
> > > this commit. One usable device is Arm's SCMI.
> >
> > You don't need a "generic" binding to have a generic driver. Keep the
> > binding specific and then decide in the OS to whether to use a generic
> > or specific driver. That decision could change over time, but the
> > binding can't. For example, see simple-panel.
> 
> What you say is true for simple-panel (a word like "simple" should
> always cause red flags).
> 
> This case is more like mfd/syscon.yaml, where the singular
> compatible = "syscon"; is in widespread use:
> 
> $ git grep 'compatible = \"syscon\";' |wc -l
> 50
> 
> I would accept adding a tuple compatible if you insist, so:
> 
> compatible = "foo-silicon", "pin-contro-gpio";
> 
> One case will be something like:
> 
> compatible = "optee-scmi-pin-control", "pin-control-gpio";
> 
> In this case I happen to know that we have the problem of
> this being standardization work ahead of implementation on
> actual hardware, and that is driven by the will known firmware
> ambition to be completely abstract. It is supposed to sit on
> top of pin control, or as part of pin control. Which leads me to
> this thing (which I didn't think of before...)
> 
> > +    gpio0: gpio@0 {
> > +        compatible = "pin-control-gpio";
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
> > +                      <&scmi_pinctrl 5 0 0>;
> > +        gpio-ranges-group-names = "",
> > +                                  "pinmux_gpio";
> > +    };
> 
> Maybe we should require that the pin-control-gpio node actually
> be *inside* the pin control node, in this case whatever the label
> &scmi_pinctrl is pointing to?

null (or '_' as dummy) if the dt schema allows such a value as
a trivial case?

> We can probably mandate that this has to be inside a pin controller
> since it is a first.

Yeah, my U-Boot implementation tentatively supports both (inside and
outside pin controller). But it is not a user's choice, but we should
decide which way to go.

Thanks,
-Takahiro Akashi

> Yours,
> Linus Walleij
