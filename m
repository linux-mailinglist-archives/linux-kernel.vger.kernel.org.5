Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813C37919AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjIDO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjIDO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:28:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59899CE5;
        Mon,  4 Sep 2023 07:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D834CE0ED3;
        Mon,  4 Sep 2023 14:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56398C433C7;
        Mon,  4 Sep 2023 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693837718;
        bh=Up07sfErFvj6d+ATkEHYNBDmwHdFvbMBAGVYWlJsRWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wcr5RIvKGmcsqGx7hxbCl+2tlzvjsDIh8LjcB2+BcpPBVo2/RCSrbH7KPlgJw04oM
         9JBD/OA3g89RWKKGo6lNP3gjqgLxlcsWYkrbH/7GiWojDqKVXCzd9ZyTwoDvQ6hRKh
         a/PREKMgMzt8YTmlXyGqesMNThjqiW3ngRnXjH0dL07EXQpe+UuXdeuB8oCEFr0b8+
         Q9m8hwJ05cYczviRgmTuOFK9t1sVzDPy2hr5lVTcAxcM5UqMuNE/wnGvrbebXkslSu
         vQWpKiUjgtfLTyvb7go7fugVVaR54abRRzEpxFmGyajsJmHwgux8ZlusCUhGNTLDHf
         WCZ87NW5zC2BA==
Date:   Mon, 4 Sep 2023 15:28:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: media: remove nokia,n900-ir as
 pwm-ir-tx is compatible
Message-ID: <20230904142833.GE13143@google.com>
References: <cover.1693577725.git.sean@mess.org>
 <25e8f2626d15199a1bf727fee375b5b149004c8e.1693577725.git.sean@mess.org>
 <20230902-gender-sandstone-7da75af72f4f@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230902-gender-sandstone-7da75af72f4f@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2023, Conor Dooley wrote:

> On Fri, Sep 01, 2023 at 03:18:55PM +0100, Sean Young wrote:
> > The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
> > can be removed.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

> > ---
> >  .../bindings/leds/irled/pwm-ir-tx.yaml        |  5 ++++-

Acked-by: Lee Jones <lee@kernel.org>

> >  .../devicetree/bindings/media/nokia,n900-ir   | 20 -------------------
> >  2 files changed, 4 insertions(+), 21 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> > index f2a6fa140f38..7526e3149f72 100644
> > --- a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> > +++ b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> > @@ -15,7 +15,10 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    const: pwm-ir-tx
> > +    oneOf:
> > +      - const: pwm-ir-tx
> > +      - const: nokia,n900-ir
> > +        deprecated: true
> >  
> >    pwms:
> >      maxItems: 1
> > diff --git a/Documentation/devicetree/bindings/media/nokia,n900-ir b/Documentation/devicetree/bindings/media/nokia,n900-ir
> > deleted file mode 100644
> > index 13a18ce37dd1..000000000000
> > --- a/Documentation/devicetree/bindings/media/nokia,n900-ir
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -Device-Tree bindings for LIRC TX driver for Nokia N900(RX51)
> > -
> > -Required properties:
> > -	- compatible: should be "nokia,n900-ir".
> > -	- pwms: specifies PWM used for IR signal transmission.
> > -
> > -Example node:
> > -
> > -	pwm9: dmtimer-pwm@9 {
> > -		compatible = "ti,omap-dmtimer-pwm";
> > -		ti,timers = <&timer9>;
> > -		ti,clock-source = <0x00>; /* timer_sys_ck */
> > -		#pwm-cells = <3>;
> > -	};
> > -
> > -	ir: n900-ir {
> > -		compatible = "nokia,n900-ir";
> > -
> > -		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
> > -	};
> > -- 
> > 2.42.0
> > 



-- 
Lee Jones [李琼斯]
