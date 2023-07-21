Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10DB75BEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGUG2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGUG2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:28:14 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2CBD271D;
        Thu, 20 Jul 2023 23:27:51 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(2903881:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 21 Jul 2023 14:27:35 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 21 Jul
 2023 14:27:35 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 21 Jul 2023 14:27:35 +0800
Date:   Fri, 21 Jul 2023 14:27:35 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230721062735.GA9068@linuxcarl2.richtek.com>
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
 <44b50616-a6ee-76e4-21b8-3e39b1a2ccd1@linaro.org>
 <20230720080728.GA10433@linuxcarl2.richtek.com>
 <fd37e408-34d2-8fd3-31b7-b3a07dfb9817@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd37e408-34d2-8fd3-31b7-b3a07dfb9817@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Krzysztof:

> > ...
> > 
> >>> +
> >>> +          regulator-mode:
> >>> +            enum: [0, 1]
> >>> +            description:
> >>> +              describe buck initial operating mode in suspend state.
> >>
> >> There is no such property on this level. Aren't you mixing initial one?
> > 
> > It's the initial mode in suspend-mem state, should I modify that like this ?
> >         patternProperties:
> >           "^regulator-state-(standby|mem|disk)$":
> > 	    type: object
> > 	    $ref: regulator.yaml#
> > 	    properties:
> > 	      regulator-mode:
> > 	        enum: [0, 1]
> > 		description:
> >                   describe byck initial operating mode in suspend state.
> 
> Please check how other bindings do it.
>

If I modify that like this, will it be correct ?


...
          regulator-state-mem:
	    type: object
	    $ref: regulator.yaml#
	    properties:
	      regulator-mode:
	      description:
	        describe buck initial operating mode in suspend state.
		0 - Auto mode
		1 - FCCM

Best regards,
Alina
