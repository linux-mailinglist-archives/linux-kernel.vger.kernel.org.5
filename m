Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7A7CCBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjJQTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbjJQTMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:12:41 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BAB0;
        Tue, 17 Oct 2023 12:12:39 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6c4bad60a1aso3656654a34.2;
        Tue, 17 Oct 2023 12:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569959; x=1698174759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKOdpoZLrfC7mZi7adYpYhK/nK8naai8II+Wc2lfLxY=;
        b=VH1fWjwecDmcLNZggU66HmnglpzwHfNtLJEN/PE4vQzDy9eKw+q0Q7I8XXybbRC6CU
         PynCNYod0cYwmUEiEfpHCQwdMsMx6I7gl/rq9u00lwYama9ZEnurxRbNxWqxtV9fL/lx
         +1xA2D+KP82NzkPYWgVLmZaDjYfe7/k0x32vAPJYs4RS/7VR5Y0NG0NsI6RlP2Kcy/MX
         UrJ7VA3X+HxQ/WRCc1EVEOlbA5xBej4Y1QxLuCPa5X5GDCPEPl8xTLWsvHJzpTy2hTT1
         i3b/rCWdDJTMt4wBQ+h1lDz1qLk8kosHW1rmAvcfbJR3+4ONn3p4BJqf+JdihfLPYHc9
         EC/g==
X-Gm-Message-State: AOJu0YzrWEBG8sZWVzpU2LPTXKlQ68NgwYWSGhfq45rB0auwqCWK505t
        5yPr4mDS5iPR9qhhNCZg8LO8tliKMQ==
X-Google-Smtp-Source: AGHT+IGkXqhJ5ElPxLv4x+02C3cqbHcjm/YAs7LK6bTEQxHSpBtRkAaBTPSRRFt1R25w+BMNr/s/zA==
X-Received: by 2002:a05:6830:1d62:b0:6bc:8afe:8a15 with SMTP id l2-20020a0568301d6200b006bc8afe8a15mr2927536oti.38.1697569958861;
        Tue, 17 Oct 2023 12:12:38 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q20-20020a05683031b400b006b8c277be12sm359714ots.8.2023.10.17.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:12:38 -0700 (PDT)
Received: (nullmailer pid 2529777 invoked by uid 1000);
        Tue, 17 Oct 2023 19:12:37 -0000
Date:   Tue, 17 Oct 2023 14:12:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: fsa4480: Add data-lanes property
 to endpoint
Message-ID: <20231017191237.GA2527374-robh@kernel.org>
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
 <20231013-fsa4480-swap-v1-1-b877f62046cc@fairphone.com>
 <20231016142256.GA2754674-robh@kernel.org>
 <323ff7db-0963-4e63-94e9-551540dd6490@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <323ff7db-0963-4e63-94e9-551540dd6490@linaro.org>
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

On Mon, Oct 16, 2023 at 04:32:55PM +0200, Neil Armstrong wrote:
> On 16/10/2023 16:22, Rob Herring wrote:
> > On Fri, Oct 13, 2023 at 01:38:05PM +0200, Luca Weiss wrote:
> > > Allow specifying data-lanes to reverse the SBU muxing orientation where
> > > necessary by the hardware design.
> > 
> > What situation in the hardware design makes this necessary. Please
> > describe the problem.
> > 
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >   .../devicetree/bindings/usb/fcs,fsa4480.yaml       | 29 +++++++++++++++++++++-
> > >   1 file changed, 28 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> > > index f6e7a5c1ff0b..86f6d633c2fb 100644
> > > --- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> > > @@ -32,10 +32,37 @@ properties:
> > >       type: boolean
> > >     port:
> > > -    $ref: /schemas/graph.yaml#/properties/port
> > > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > >       description:
> > >         A port node to link the FSA4480 to a TypeC controller for the purpose of
> > >         handling altmode muxing and orientation switching.
> > > +    unevaluatedProperties: false
> > > +
> > > +    properties:
> > > +      endpoint:
> > > +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +        unevaluatedProperties: false
> > > +
> > > +        properties:
> > > +          data-lanes:
> > > +            $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +            description:
> > > +              Specifies how the AUX+/- lines are connected to SBU1/2.
> > 
> > Doesn't this depend on the connector orientation? Or it is both that and
> > the lines can be swapped on the PCB?
> > 
> > Seems like an abuse of data-lanes which already has a definition which
> > is not about swapping + and - differential lanes.
> 
> The FSA acts as a mux between DP AUX, Audio lanes on one side and
> the USB-C SBU lanes on the other side.
> _______          ______
>       |          |     |
>       |-- HP   --|     |
>       |-- MIC  --|     |or
> SoC   |          | MUX |-- SBU1 --->  To the USB-C
> Codec |-- AUX+ --|     |-- SBU2 --->  connected
>       |-- AUX- --|     |
> ______|          |____ |
> 
> The SBU1 & SBU2 are connected to the USB-C connector, and the actual orientation
> to the connected devices/cable/whatever is determined by the TPCM and the MUX in
> the FSA4480 with be dynamically changed according to the CC1/CC2 detection and PD alt mode.
> 
> But on the other side the orientation of the AUX+/AUX- connected to the SoC
> is not tied to the USB-C orientation but how it's routed on the PCB.
> 
> This describes how the AUX+/AUX- are physically routed to the FSA4480 chip.

I'd hate for this ASCII art to go to waste. Please add this detail to 
the commit message.

Rob

