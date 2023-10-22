Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87417D261F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJVVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:42:24 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71BE5;
        Sun, 22 Oct 2023 14:42:22 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2e22a4004so2026478b6e.3;
        Sun, 22 Oct 2023 14:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698010942; x=1698615742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD6hNKWqp4dlOId5gsO4sOaKWKbRB4aMfCpeXMgYAks=;
        b=H2qBXVE5yjMOnOmTFUzTMf951wDgBlySfakhbSgFpZxkJ2R1L7TOpB1UAguFKVFaCT
         GFGj/zJMrbSdu2LpmevAW6F9jFlLgA+DloBhNAD+5YYcSNjSbPg1D3rxsKsKuk8uhajD
         owCLNae/IWBZ/nKN6+/eBnG7PG/jqpeS7yZCY4oxPCx0mlpHMQZv4WphqQeFI6zvD6mV
         2cMXk5bh/j2NS63idkHek+bxGmdqI4+At9vQP8gZpHk2oWZnPoYatmRQ7Q0Xei7TwhGp
         103u/TnQNNwU2vV0Qy+lwQxt2J/qexT2Slz0vs7sodG8lkbhkWqumXGq8M/odyzx3jiu
         DVQw==
X-Gm-Message-State: AOJu0Yx1HNM1wkCNg4kkg8QkBxPTPSYLidCMScTUa4tAxWwRwMVTu3oP
        BrKqEs4VqiS4Jsro5hHDYA==
X-Google-Smtp-Source: AGHT+IHtnYoRv+W2kAG7aMLEsfhEq8v6lHvAvr7C6bOY3fLoAYpynDcTsoQtDY8VI4Ae+1twkAxDgA==
X-Received: by 2002:a05:6808:222a:b0:3ae:5442:ed11 with SMTP id bd42-20020a056808222a00b003ae5442ed11mr11305393oib.54.1698010941722;
        Sun, 22 Oct 2023 14:42:21 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c1:8e5d:a109:ceb8:bec4:d970])
        by smtp.gmail.com with ESMTPSA id u15-20020a056808150f00b003ae5cb55513sm1229441oiw.38.2023.10.22.14.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:42:21 -0700 (PDT)
Received: (nullmailer pid 721245 invoked by uid 1000);
        Sun, 22 Oct 2023 21:42:19 -0000
Date:   Sun, 22 Oct 2023 16:42:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Conor Dooley <conor@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20231022214219.GA706888-robh@kernel.org>
References: <20231020150022.48725-1-sebastian.reichel@collabora.com>
 <20231020150022.48725-2-sebastian.reichel@collabora.com>
 <20231020-shudder-tackle-cc98a82f1cd0@spud>
 <20231020160329.uqgjjr6ubfrcqjkj@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020160329.uqgjjr6ubfrcqjkj@mercury.elektranox.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:03:29PM +0200, Sebastian Reichel wrote:
> Hi Conor,
> 
> On Fri, Oct 20, 2023 at 04:36:19PM +0100, Conor Dooley wrote:
> > On Fri, Oct 20, 2023 at 04:11:40PM +0200, Sebastian Reichel wrote:
> > > [...]
> > > +allOf:
> > > +  - $ref: snps,dwc3.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: rockchip,rk3328-dwc3
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 3
> > > +          maxItems: 4
> > > +        clock-names:
> > > +          minItems: 3
> > > +          items:
> > > +            - const: ref_clk
> > > +            - const: suspend_clk
> > > +            - const: bus_clk
> > > +            - const: grf_clk
> > 
> > minItems for clocks and clock-names is already 3, is it not?
> 
> Yes, but the following 'maxItems: 4' implicitly sets it to 4,
> so I had to set it again. The same is true for clock-names -
> providings new 'items:' effectively drops the "minItems: 3"
> from the generic section.

Are you sure? We don't add anything implicit in the if/then schemas. 
Could be a tool issue though.

Rob
