Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F263475E9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGXCYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGXCYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:24:15 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F6F918B;
        Sun, 23 Jul 2023 19:24:00 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1318274:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 24 Jul 2023 10:23:42 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 24 Jul
 2023 10:23:42 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 24 Jul 2023 10:23:42 +0800
Date:   Mon, 24 Jul 2023 10:23:42 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230724022342.GA17679@linuxcarl2.richtek.com>
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
 <44b50616-a6ee-76e4-21b8-3e39b1a2ccd1@linaro.org>
 <20230720080728.GA10433@linuxcarl2.richtek.com>
 <fd37e408-34d2-8fd3-31b7-b3a07dfb9817@linaro.org>
 <20230721062735.GA9068@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230721062735.GA9068@linuxcarl2.richtek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Krzysztof:

> > > ...
> > > 
> > >>> +
> > >>> +          regulator-mode:
> > >>> +            enum: [0, 1]
> > >>> +            description:
> > >>> +              describe buck initial operating mode in suspend state.
> > >>
> > >> There is no such property on this level. Aren't you mixing initial one?
> > > 
> > > It's the initial mode in suspend-mem state, should I modify that like this ?
> > >         patternProperties:
> > >           "^regulator-state-(standby|mem|disk)$":
> > > 	    type: object
> > > 	    $ref: regulator.yaml#
> > > 	    properties:
> > > 	      regulator-mode:
> > > 	        enum: [0, 1]
> > > 		description:
> > >                   describe byck initial operating mode in suspend state.
> > 
> > Please check how other bindings do it.
> >
> 
> If I modify that like this, will it be correct ?
> 
> 
> ...
>           regulator-state-mem:
> 	    type: object
> 	    $ref: regulator.yaml#
> 	    properties:
> 	      regulator-mode:
> 	      description:
> 	        describe buck initial operating mode in suspend state.
> 		0 - Auto mode
> 		1 - FCCM
>

Sorry, I think I didn't explain well why to add "regulator-mode".
I just want to add description for this property, for people can get its meaning when they see the yaml.
If it's optional and it's already a general property in regulator.yaml.
May I remove it from my yaml ?

Best regards,
Alina
