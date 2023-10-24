Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC617D5AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbjJXSwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjJXSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:52:20 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5EA6;
        Tue, 24 Oct 2023 11:52:14 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 27AB4120046;
        Tue, 24 Oct 2023 21:52:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 27AB4120046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698173532;
        bh=ZfnwsoCFNLWxYlhF3Ype4MK6VdYqony+g3yIue3PzsQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=A1njmlfTnNiQFmP0AhqW2IbeOLkX1fhd8vSFmE+snlE6wgCPFcyXc3T+8TxjNMzAx
         w6D6Elr7sohany6Ydo3sJCswxk0Sai1Wx9Tk9T23j3v+bga7OhCNvYTIDW3yaOtrMb
         KG8utSnwMhP834AVnHQU67WJdJjcjWouj2dfnHa0ceCo448EbtshzKcgCMFMukXe7d
         TPqu2h+gLkCYpFfmti6HsACB6EWqyHlsF1z0eUII1P+opWfR1AJ1m0miCt21KF/lk8
         F/2E4dMPh5qaT6ZRd+j2H+gTIODXbs0bxaUADilhp9qUY1uEUMgUv4JOgMVxqK5IFF
         F1eHn41HJdXIw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 24 Oct 2023 21:52:12 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 24 Oct
 2023 21:52:11 +0300
Date:   Tue, 24 Oct 2023 21:52:11 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Rob Herring <robh@kernel.org>
CC:     <lee@kernel.org>, <pavel@ucw.cz>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: Re: [DMARC error] Re: [PATCH v2 03/11] dt-bindings: leds: aw200xx:
 introduce optional hwen-gpios property
Message-ID: <20231024185211.x753eonmq5flwqa3@CAB-WSD-L081021>
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
 <20231018182943.18700-4-ddrokosov@salutedevices.com>
 <20231024183014.GA243505-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231024183014.GA243505-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180848 [Oct 24 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/24 17:39:00 #22277133
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 01:30:14PM -0500, Rob Herring wrote:
> On Wed, Oct 18, 2023 at 09:29:35PM +0300, Dmitry Rokosov wrote:
> > Property 'hwen-gpios' is optional, it can be used by the board
> > developer to connect AW200XX LED controller with appropriate poweron
> > GPIO pad.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > index feb5febaf361..255eb0563737 100644
> > --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> > @@ -41,6 +41,9 @@ properties:
> >      description:
> >        Leds matrix size
> >  
> > +  hwen-gpios:
> > +    maxItems: 1
> 
> The standard enable-gpios or powerdown-gpios don't work for you?

HWEN is the name from the official datasheet. I thought it's always
better to use a naming convention that is similar to the notations used
in the datasheet.

-- 
Thank you,
Dmitry
