Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF67C50B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjJKLBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjJKLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:01:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19B94;
        Wed, 11 Oct 2023 04:01:32 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (185-9-11-240.cust.suomicom.net [185.9.11.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S58w70C2dz49Pwn;
        Wed, 11 Oct 2023 14:01:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1697022089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//xw1oKncXx8ruRws2n7MrScj5Aevzl+XjGbNm2925Q=;
        b=NtAEihIKHoUL8qFZa7TrWhLIUZzrkAYMwOdCri29SqMZWQvl+X8pua6n6HyvBR8n6aHlRY
        PvLa8KpOSfNKuGGmnc9Dlbbj2Z3UqdkcY72kWciyXBtGZWY3Jlv9xsJAjVdDyxJlCEBPTt
        62LxgkZ176NFt+P6NzgQVY8+IzpuuU3xmpte/yBa+O/Bng0jXxfdWtqj5+orgjOSyPPL31
        513xZzXo+qEs6wyri3I0TJPvueu1+s+2kZxC9NmO/lAGlsjCvwHxFh+ZvGjTXSJIZQihcD
        3sCnZU3QMiWX0azHBlDI0scAZfoU4en/7wuwBFvektF2hG1p1L6XMeklUiugGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1697022089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//xw1oKncXx8ruRws2n7MrScj5Aevzl+XjGbNm2925Q=;
        b=MxTG+Jjbt+pMFRlblr4TyXXbi0zleo6fmwJuwzFW/QlKbwG98fcpwdc26U5D4yP1y0FdlW
        vZpEjuKnGjEd2ZQXlIhU/Qp8aDZeAvRFqwjHs/se4FRdk0cpfJwCOqT1aR/RFBLy5gsPkl
        WQ2Fx1nbbKcz49yjcvXGaudHIHMrtG3ngQen2zcUB/mxfVhbllyYzEu74lttpsze87Qeiy
        T3Fi2Yz4aTiAXS6AsRX9mH0LeSNDzyjscC+rkjueKjYS8xij94fumaTP1FGB2+V+S0sVoE
        WT0uLqEU5yl7ZghdD7hPVfuLRUHNidN4wmt6J0HZ7s8TsQBmkYs0bKDMx/JFWg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1697022089; a=rsa-sha256;
        cv=none;
        b=hDtJ3DvjeklP1GRFzEcKO0SuH35K/RuRR4iBGryQ22RjsIevgVdAXrpTLIlHCNg1My2l/d
        r16zEGuCme1HLpL6vAWO6OLRE+JkfZ61cJkUfjmegw3xA7EdJdOfDMhZN9jWIIZZ7ehBPh
        tDWIYe+Oxa1FImGL7ti/htYEi5C/fd7h9s746v33WkXJDitCLn3BrT5LHR9FE+s8dqVFcf
        NhSwuL0i8YRbRw6dy/J0O2UMWlZ/Ys9fSiRNF59B12zKgnZ/PbzOrhWIEEcoyZ+rCyniWD
        OZuyzoJ+4w/wnkH81OVRdofxO05TERiJDL16lfdiOEj23JRg2sWyAQ0OaCb/uA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 013E3634CA9;
        Wed, 11 Oct 2023 14:01:23 +0300 (EEST)
Date:   Wed, 11 Oct 2023 11:01:23 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, moderated list:
        ARM/FREESCALE IMX / MXC ARM ARCHITECTURE 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH 1/5] media: dt-bindings: media: imx335: Add supply
 bindings
Message-ID: <ZSaAg8aSZAfxEDpM@valkosipuli.retiisi.eu>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-2-kieran.bingham@ideasonboard.com>
 <ZSTp4jXKPVrbo5oU@valkosipuli.retiisi.eu>
 <169694430967.3973464.6599459439831458834@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169694430967.3973464.6599459439831458834@ping.linuxembedded.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Oct 10, 2023 at 02:25:09PM +0100, Kieran Bingham wrote:
> Hi Sakari,
> 
> Quoting Sakari Ailus (2023-10-10 07:06:26)
> > Hi Kieran,
> > 
> > On Tue, Oct 10, 2023 at 01:51:22AM +0100, Kieran Bingham wrote:
> > > Add the bindings for the supply references used on the IMX335.
> > > 
> > > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > > ---
> > >  .../bindings/media/i2c/sony,imx335.yaml          | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
> > > index a167dcdb3a32..1863b5608a5c 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
> > > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
> > > @@ -32,6 +32,15 @@ properties:
> > >      description: Clock frequency from 6 to 27 MHz, 37.125MHz, 74.25MHz
> > >      maxItems: 1
> > >  
> > > +  avdd-supply:
> > > +    description: Analog power supply (2.9V)
> > > +
> > > +  ovdd-supply:
> > > +    description: Interface power supply (1.8V)
> > > +
> > > +  dvdd-supply:
> > > +    description: Digital power supply (1.2V)
> > 
> > I wonder what's the policy in this case --- some of the regulators are
> > often hard-wired and the bindings didn't have them previously either (I
> > wonder why, maybe they were all hard wired in the board??).
> > 
> > Could they be optional? The driver will need to be able to do without these
> > in any case.
> 
> Indeed - many devices do not need to define how they are powered up.
> 
> But Krzysztof stated that supplies should be required by the bindings on
> my recent posting for a VCM driver:
> 
>  - https://lore.kernel.org/all/6e163f4d-061d-3c20-4c2e-44c74d529f10@linaro.org/
> 
> So based on that I have made these 'required'.

I guess it's good to align bindings regarding this, in practice the driver
will need to work without regulators (or with dummies), too.

> 
> Even in my case here, with a camera module that is compatible with the
> Raspberry Pi camera connector - there isn't really 3 supplies. It's just
> a single gpio enable pin to bring this device up for me. Of course
> that's specific to the module not the sensor.

How do you declare that in DT? One of the regulators will be a GPIO one?

-- 
Regards,

Sakari Ailus
