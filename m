Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7EC7DE599
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbjKARsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjKARso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:48:44 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EDA2;
        Wed,  1 Nov 2023 10:48:38 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1101F120020;
        Wed,  1 Nov 2023 20:48:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1101F120020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698860917;
        bh=EddFr7lOGf4NXOMM9jH9Co+otzGhI8EbkMU/xHevNXE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=F07PzInd2aLutm3Xd9pZoDISSjegh06GAkp3cdqDW4Lx5dLB9WXbsgoFpvw7aEB+n
         kZ7/Yi0H+KQpjsyxGCqYJtfIi7mJXC6TRODY3mS2ZeumRl/GhqFWtI3lN9wC0yrQAw
         9bbnGqmGaekNiFh0K5/e+uI3u3FWG2BEExgEq09hnB1n6IPdh5X2BWc8rvxZhTQeuh
         RB3CIJnLtAOBkYvHgN9RkpIXfcTY1CB3OFpWGg08uy+/rlKM+x3nj2HIQuPRt2x6/H
         n2ZJc3YVzF137t7PWQr+Y08s8CKB5D/3nXAg6s3M7wYdaCLqoeALEpj+7GCZvwQq0i
         5ULJWT87MKiLQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 20:48:36 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 1 Nov
 2023 20:48:36 +0300
Date:   Wed, 1 Nov 2023 20:48:36 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] dt-bindings: leds: aw200xx: fix led pattern and
 add reg constraints
Message-ID: <20231101174836.2qlhkgao6pxjjs2e@CAB-WSD-L081021>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-12-ddrokosov@salutedevices.com>
 <20231101-subzero-grimace-52a10da6a445@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231101-subzero-grimace-52a10da6a445@spud>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181058 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 15:56:00 #22380151
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor,

On Wed, Nov 01, 2023 at 03:31:28PM +0000, Conor Dooley wrote:
> On Wed, Nov 01, 2023 at 05:24:45PM +0300, Dmitry Rokosov wrote:
> > AW200XX controllers have the capability to declare more than 0xf LEDs,
> > therefore, it is necessary to accept LED names using an appropriate
> > regex pattern.
> > 
> > The register offsets can be adjusted within the specified range, with
> > the maximum value corresponding to the highest number of LEDs that can
> > be connected to the controller.
> > 
> > Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> You did correctly guess what I was getting at on the previous version.
> Apologies for not replying - I got sick and things probably fell a bit
> through the cracks.

Don't worry! Take care and get well soon!

> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

Should I include this tag in the next version with a fix for the 'reg'
maxItems, or would you review this patch again?

> Cheers,
> Conor.
> 
> > ---
> >  .../bindings/leds/awinic,aw200xx.yaml         | 64 +++++++++++++++++--
> >  1 file changed, 58 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > index 67c1d960db1d..ba4511664fb8 100644
> > --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > @@ -45,17 +45,12 @@ properties:
> >      maxItems: 1
> >  
> >  patternProperties:
> > -  "^led@[0-9a-f]$":
> > +  "^led@[0-9a-f]+$":
> >      type: object
> >      $ref: common.yaml#
> >      unevaluatedProperties: false
> >  
> >      properties:
> > -      reg:
> > -        description:
> > -          LED number
> > -        maxItems: 1
> > -
> >        led-max-microamp:
> >          default: 9780
> >          description: |
> > @@ -69,6 +64,63 @@ patternProperties:
> >            where max-current-switch-number is determinated by led configuration
> >            and depends on how leds are physically connected to the led driver.
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: awinic,aw20036
> > +    then:
> > +      patternProperties:
> > +        "^led@[0-9a-f]+$":
> > +          properties:
> > +            reg:
> > +              items:
> > +                minimum: 0
> > +                maximum: 36
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: awinic,aw20054
> > +    then:
> > +      patternProperties:
> > +        "^led@[0-9a-f]+$":
> > +          properties:
> > +            reg:
> > +              items:
> > +                minimum: 0
> > +                maximum: 54
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: awinic,aw20072
> > +    then:
> > +      patternProperties:
> > +        "^led@[0-9a-f]+$":
> > +          properties:
> > +            reg:
> > +              items:
> > +                minimum: 0
> > +                maximum: 72
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: awinic,aw20108
> > +    then:
> > +      patternProperties:
> > +        "^led@[0-9a-f]+$":
> > +          properties:
> > +            reg:
> > +              items:
> > +                minimum: 0
> > +                maximum: 108
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.36.0
> > 



-- 
Thank you,
Dmitry
