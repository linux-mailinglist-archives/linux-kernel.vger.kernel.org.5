Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0563A7BFFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjJJO6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjJJO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:58:07 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1199;
        Tue, 10 Oct 2023 07:58:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2DBAA120008;
        Tue, 10 Oct 2023 17:57:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2DBAA120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696949878;
        bh=WKjfedJyvBDkzLdG/sTO4e60qiEDTGG07ZQdbl0pGik=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=M9+zGAzAs6NiaUoSUbh7JWgTVinHLEqlbdhQTvz18rUUMNKqgSCKHgU1LrDPKrciu
         TyEKeA2xTRifnNuKhW/ESkdlqTsB72V0/XhFLp1VSVguwdXWX1DkuB13454b8JDx1w
         DN2b2pa10ugsXc+lFoETFz/xbSAwaMkna+gYHLvRpd6EPav+Y50qbFFippWYhwdNYd
         ZFpSTOQmHYR1ozNNtrbgDHcMs/mNmvjM9q3fI8JkKh+VdjypGzfWGzvFIy66feF5/C
         EVoAu++ZsEqDlZXbP/TVtZfkOSju4iKlvm+FzXabb7dZNI0ytfdZ6nIeFpwCJlFI1p
         AFjruUWllS4ag==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 10 Oct 2023 17:57:57 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 10 Oct
 2023 17:57:57 +0300
Date:   Tue, 10 Oct 2023 17:57:56 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Rob Herring <robh@kernel.org>
CC:     <lee@kernel.org>, <pavel@ucw.cz>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v1 04/11] dt-bindings: leds: aw200xx: introduce optional
 hwen-gpio property
Message-ID: <20231010145756.7kvzcwjqiiq6dz4j@CAB-WSD-L081021>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-5-ddrokosov@salutedevices.com>
 <20231010141332.GA756597-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010141332.GA756597-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180514 [Oct 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/10 12:47:00 #22143134
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thank you for the review! Please find my comments below.

On Tue, Oct 10, 2023 at 09:13:32AM -0500, Rob Herring wrote:
> On Fri, Oct 06, 2023 at 07:04:30PM +0300, Dmitry Rokosov wrote:
> > Property 'awinic,hwen-gpio' is optional, it can be used by the board
> > developer to connect AW200XX LED controller with appropriate poweron
> > GPIO pad.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > index 73b81f7a7258..e3ad11fc7a84 100644
> > --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > @@ -41,6 +41,9 @@ properties:
> >      description:
> >        Leds matrix size
> >  
> > +  awinic,hwen-gpio:
> > +    maxItems: 1
> 
> We have standard 'enable-gpios' or 'powerdown-gpios'. Those don't work 
> here?
> 
> Note that *-gpio is deprecated in favor of *-gpios.

Yes, you are absolutely correct. Andy has already addressed this issue
in the driver patchset. I will revise the driver to utilize the current
GPIO API.

> > +
> >  patternProperties:
> >    "^led@[0-9a-f]+$":
> >      type: object
> > @@ -90,12 +93,15 @@ additionalProperties: false
> >  
> >  examples:
> >    - |
> > +    #include <dt-bindings/gpio/gpio.h>
> >      #include <dt-bindings/leds/common.h>
> >  
> >      i2c {
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >  
> > +        awinic,hwen-gpio = <&gpio 3 GPIO_ACTIVE_HIGH>;
> > +
> >          led-controller@3a {
> >              compatible = "awinic,aw20036";
> >              reg = <0x3a>;
> > -- 
> > 2.36.0
> > 

-- 
Thank you,
Dmitry
