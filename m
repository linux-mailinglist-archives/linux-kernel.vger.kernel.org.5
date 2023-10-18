Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5A7CD46B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjJRGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344634AbjJRGX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:23:58 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B072718;
        Tue, 17 Oct 2023 23:21:59 -0700 (PDT)
Received: from p200300ccff145f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:5f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qszw7-00580I-U3; Wed, 18 Oct 2023 08:21:44 +0200
Date:   Wed, 18 Oct 2023 08:21:42 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
Message-ID: <20231018082142.5b7d3ad5@aktux>
In-Reply-To: <20231018052345.GK34982@atomide.com>
References: <20230705190324.355282-1-andreas@kemnade.info>
        <20230705190324.355282-2-andreas@kemnade.info>
        <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
        <20230920063353.GQ5285@atomide.com>
        <dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
        <20230921121626.GT5285@atomide.com>
        <20231006102348.GK34982@atomide.com>
        <20231006213003.0fbac87a@aktux>
        <20231007062518.GM34982@atomide.com>
        <20231015234815.637f5c14@aktux>
        <20231018052345.GK34982@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 08:23:45 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [231015 21:48]:
> > On Sat, 7 Oct 2023 09:25:18 +0300
> > Tony Lindgren <tony@atomide.com> wrote:  
> > > If so then the following might be a fix, not familiar with runtime PM
> > > done by ASoC though and not sure if some kind of locking would be
> > > needed here.
> > >   
> > just checked: that one fixes the regression. runtime suspends again.  
> 
> OK good to hear. So is there some fixes tag for this one or where did this
> start happening? I'm not quite following how the dropping of platform data
> could have affected this, maybe it just hid the problem because of
> returning early?
> 
yes I think so. From a perspective of OMAP[45] mith McBSP in master mode,
applying  "clk: ti: Fix missing omap4 mcbsp functional clock and aliases"
on top of "ASoC: ti: omap-mcbsp: Ignore errors for getting  fck_src"
is a regression. For everyone else not. So 
"clk: ti: Fix missing omap4 mcbsp functional clock and aliases"
did uncover a hidden problem, but of course it is the right step
forward.

Regards
Andreas
