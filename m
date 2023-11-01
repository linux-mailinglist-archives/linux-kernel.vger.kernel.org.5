Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4C7DE592
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjKARof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjKARod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:44:33 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545110F;
        Wed,  1 Nov 2023 10:44:26 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id EAC1A120020;
        Wed,  1 Nov 2023 20:44:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EAC1A120020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698860663;
        bh=IFMjb5EThxVctmhDxs8Q+Vp71Ug13ebnpxJJFqjaR1Y=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=ED7K3VOKIYmV02lfi4q4r3obn44pKQEie/SSZ/VkH8lCv37v3BcVp7fO4fWKOQ1h1
         jkhXZBqyxpz4RBdRH3iBZ+zdOA3pu7LcKYeQkjosVEkK8viMCPvtxT244TFboJoYZs
         bWlPrrxWVWcv8ENMuCLTPNhnazNLnkrOZXMSWcjzDn7sbF+Ikjghv6Z0+AaYXGXRxl
         eJJRVQeYl0G14xcy4Qf0DiymqcwQrH7hIlGbF83KfYU6LO/ZgFTUaqiMOwXUJ7CmnY
         fZsoKL/RfotwRlyk6NZVW1t0QGkLqtsZpbM9Zj/krolyux5I4apxa6apajnLktYDQR
         C1B90Xa0wveTg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 20:44:22 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 1 Nov
 2023 20:44:22 +0300
Date:   Wed, 1 Nov 2023 20:44:22 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh@kernel.org>, <linux-leds@vger.kernel.org>,
        <lee@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <andy.shevchenko@gmail.com>,
        <conor+dt@kernel.org>, <pavel@ucw.cz>,
        <krzysztof.kozlowski+dt@linaro.org>, <rockosov@gmail.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] dt-bindings: leds: aw200xx: fix led pattern and
 add reg constraints
Message-ID: <20231101174422.zs5er6tqethm46ur@CAB-WSD-L081021>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-12-ddrokosov@salutedevices.com>
 <169885374980.409399.3653628333009308100.robh@kernel.org>
 <20231101-bolster-anaerobic-244cd1a8c205@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231101-bolster-anaerobic-244cd1a8c205@spud>
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
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/01 16:22:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/01 16:22:00
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

Hello Conor,

On Wed, Nov 01, 2023 at 04:17:14PM +0000, Conor Dooley wrote:
> On Wed, Nov 01, 2023 at 11:04:16AM -0500, Rob Herring wrote:
> > 
> > On Wed, 01 Nov 2023 17:24:45 +0300, Dmitry Rokosov wrote:
> > > AW200XX controllers have the capability to declare more than 0xf LEDs,
> > > therefore, it is necessary to accept LED names using an appropriate
> > > regex pattern.
> > > 
> > > The register offsets can be adjusted within the specified range, with
> > > the maximum value corresponding to the highest number of LEDs that can
> > > be connected to the controller.
> > > 
> > > Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > ---
> > >  .../bindings/leds/awinic,aw200xx.yaml         | 64 +++++++++++++++++--
> > >  1 file changed, 58 insertions(+), 6 deletions(-)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@0: Unevaluated properties are not allowed ('reg' was unexpected)
> > 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@1: Unevaluated properties are not allowed ('reg' was unexpected)
> > 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@2: Unevaluated properties are not allowed ('reg' was unexpected)
> > 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
> 
> Looks like you need to drop the second part of this hunk from the patch.
> @@ -45,17 +45,12 @@ properties:
>      maxItems: 1
>  
>  patternProperties:
> -  "^led@[0-9a-f]$":
> +  "^led@[0-9a-f]+$":
>      type: object
>      $ref: common.yaml#
>      unevaluatedProperties: false
>  
>      properties:
> -      reg:
> -        description:
> -          LED number
> -        maxItems: 1
> -
>        led-max-microamp:
>          default: 9780
>          description: |
> 
> Each LED still only has one reg entry, right?

You're right... the maxItems for 'reg' is still needed. I'll back it in
the next version.
But I don't understand, why my dt_binding_check run doesn't show me this
problem... I don't specify DT_CHECKER_FLAGS, maybe this is a root cause.

-- 
Thank you,
Dmitry
