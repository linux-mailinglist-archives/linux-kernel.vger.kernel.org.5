Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AEE7B01AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjI0KUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0KUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:20:17 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B982A4218
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:20:14 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1978106:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 27 Sep 2023 18:19:49 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 27 Sep
 2023 18:19:48 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 27 Sep 2023 18:19:48 +0800
Date:   Wed, 27 Sep 2023 18:19:48 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <20230927101948.GA27975@linuxcarl2.richtek.com>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
 <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
 <20230927094637.GA25905@linuxcarl2.richtek.com>
 <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:59:31AM +0200, Mark Brown wrote:
> On Wed, Sep 27, 2023 at 05:46:37PM +0800, ChiYuan Huang wrote:
> > On Wed, Sep 27, 2023 at 11:13:22AM +0200, Mark Brown wrote:
> 
> > > Is this something that's going to be changing dynamically at runtime or
> > > should this be a device property that's set either by firmware or when
> > > we're doing the TDM setup?  This sounds like something I'd expect to be
> > > fixed by the board design.
> 
> > I may think one case if ASoC platform support multiple data source outputs
> > that share the same bck/lcrk on different data pin. If it can be dynamically
> > adjusted for the scenarios, this will keep the flexibility for the differet
> > platform design.
> 
> Sure, but is that actually a practical design - or if someone is doing
> this shouldn't it be joined up with the TDM configuration since with
> just the control it'd only be possible to switch the pins but not change
> the TDM layout?  I'm not sure that this control works as a standalone
> thing.

I think if two data source input for different scenarios, then the data source
switch will become practical. For the standalone usage, keep a device property
to decide this may be enough. But consider the future application, to keep this
in general mixer control is still usable to meet the complex design.
