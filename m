Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1767B7863
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjJDHId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjJDHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:08:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A90AF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:08:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c5faa2af60so1865395ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696403308; x=1697008108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+HNamXx8KNnqMjBVvxVHxCmQqxpGZi0a4VnllDCQ5M=;
        b=YMS/pQ8YiQW2H6sfa8AqDaJeM49qhkGJDBu5WBt0msFhJICyYHyhd3r34/vTyAMCoS
         UdRk8FyD0RTlMhbNIgblRJ21YJ1RcGW/yJdNpsk+LrXLr65Y2n2CVVUcMdn+ZkB7I30L
         nH3r9M0ki6B6RHvB+89oh9w1QQOK6AJ34RQl5D2IXozEDhei0Vn39EZNnBwGuANSMI4k
         nn2wUpD0J7BR+OtpptFky4H77wewma6OfckIgwVTH4uYBxI1bmP92cf+ve9SUl0Hqx4J
         SGWDAH3kElyJosLL/vP+u+rYCn4YW0Cq3VaPNewSFHdejy1gyr6oWOT4fjPVhIYayYlo
         AJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696403308; x=1697008108;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+HNamXx8KNnqMjBVvxVHxCmQqxpGZi0a4VnllDCQ5M=;
        b=cm5KPOGFrmzrExNq3Ycpg34dMJsLidxrJ4tTlMtWPxTgqwPP3TB0AHZ0Tb6eTu4EIJ
         2OV1TbFR5j9ItMUwM+f8tf/68mvaimrVT9lXnKrMnEI/n0aQ7qoNsox8dRWGe5ZWRM7y
         obFV0aY0LVq8CMMsO3sBk2JmCd5+8GURvWh/lo9tkJrS1nItsDVJiNwoBj+w5LzYeclG
         hNYjn+FFuJdaLW9fK7fcWGgIA1jtmj3LRexYNihZEGuuD3uu99eJVNFxS6FXRhFHQlkd
         pvbPEZSiV3ZVw695y6tghvrGi16B/buKVi7Omps/nUMN1FCts6gp6V1i/zOTCjfVByMm
         p5jg==
X-Gm-Message-State: AOJu0YzAums09jJTPizu5Ptz3bfJmUmVCsQ+RYBXip/Vu1Z1y8PWGPZ/
        yvE9T3rkXEjWklkgw+nlx5GIZQ==
X-Google-Smtp-Source: AGHT+IG9Sl5KymtbHuRT8tP6Uk0OFio8plzOQlpu4XZA2P8W7Fbb/mUXcRCply6qxt878PPQR8VPJQ==
X-Received: by 2002:a17:902:dac8:b0:1bf:1a9e:85f7 with SMTP id q8-20020a170902dac800b001bf1a9e85f7mr1785477plx.1.1696403308115;
        Wed, 04 Oct 2023 00:08:28 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:81c4:ac5:bfc9:67a3])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001c3f7fd1ef7sm2873333pld.12.2023.10.04.00.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:08:27 -0700 (PDT)
Date:   Wed, 4 Oct 2023 16:08:23 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl based
 gpio
Message-ID: <ZR0PZ+RHzfbrlbnI@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-5-takahiro.akashi@linaro.org>
 <CACRpkdZgmwhGYH43iAq=cERaGO9a-mVHXG8sQ2htPw0DcrnuNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZgmwhGYH43iAq=cERaGO9a-mVHXG8sQ2htPw0DcrnuNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:16:49PM +0200, Linus Walleij wrote:
> Hi Takahiro,
> 
> first, thanks for working on this important and crucial driver!
> 
> I'll try to clarify and also explain something of what the others
> are saying (unless I misunderstand them...)

Ah, thank you.

> On Mon, Oct 2, 2023 at 4:17???AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> 
> > A dt binding for SCMI pinctrl based gpio driver is defined in this
> > commit. It basically conforms to generic pinctrl-gpio mapping framework.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> I think like Christian says that SCMI maybe has nothing to do
> with this binding? It is just one possible use case (though we don't know
> of any others.) The resource it is using is generic functionality that exist
> in any pin controller that provides ways to drive lines high and low
> etc.
> 
> Would it be named a generic pin control-based GPIO?

If you like :)
As I said, I was not confident that the driver be applicable
to other pinctrl-gpio cases.

> (...)
> > +++ b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> (...)
> > +$id: http://devicetree.org/schemas/gpio/arm,scmi-gpio.yaml#
> 
> So no ARM, no scmi, just pin-control-gpio.yaml, be bold!

I'm not so ambitious.

> (I like this long unabbreviated name)
> 
> > +title: SCMI pinctrl based generic GPIO controller
> 
> Pin control-based generic GPIO controller
> 
> Add
> 
> description:
>   The pin control-based GPIO will facilitate a pin controllers ability
>   to drive electric lines high/low and other generic properties of a
>   pin controller to perform general-purpose one-bit binary I/O.
> 
> (At least I think this is the idea, I hope I understand correctly.)

Okay.

> > +properties:
> > +  $nodename:
> > +    pattern: "^scmi_gpio(@[0-9a-f]+)$"
> 
> These nodes are always just named gpio@...
> the resource marker is "this is a GPIO" that's all it means.

By following other gpio drivers' bindings, I will drop this rule.

> > +  compatible:
> > +    const: arm,scmi-gpio-generic
> 
> const: pin-control-gpio
> 
> Other than that I am aboard with the solution!

Hope that the driver works on real hardware :)

-Takahiro Akashi

> Yours,
> Linus Walleij
