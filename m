Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F97BC618
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjJGIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjJGIfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:35:11 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1C83;
        Sat,  7 Oct 2023 01:35:10 -0700 (PDT)
Received: from p5dc58360.dip0.t-ipconnect.de ([93.197.131.96] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qp2m5-004c4z-Ex; Sat, 07 Oct 2023 10:35:01 +0200
Date:   Sat, 7 Oct 2023 10:34:59 +0200
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
Message-ID: <20231007103459.29998aa8@aktux>
In-Reply-To: <20231007074159.GX34982@atomide.com>
References: <20230705190324.355282-1-andreas@kemnade.info>
        <20230705190324.355282-2-andreas@kemnade.info>
        <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
        <20230920063353.GQ5285@atomide.com>
        <dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
        <20230921121626.GT5285@atomide.com>
        <20231006102348.GK34982@atomide.com>
        <20231006213003.0fbac87a@aktux>
        <20231007062518.GM34982@atomide.com>
        <20231007091156.588d7ba1@aktux>
        <20231007074159.GX34982@atomide.com>
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

On Sat, 7 Oct 2023 10:41:59 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [231007 07:12]:
> > Well, it is a regression caused by your fix. Without it (and not reverting
> > the already applied ignore patch), runtime is properly suspended. Don't know
> > why yet.  
> 
> We return early from omap2_mcbsp_set_clks_src() with IS_ERR(fck_src) and
> the runtime PM functions never get called?
> 
no, we do not. This patch we are talking about to do it in a better way made
its way into mainline v6.6-rc1. The other pieces of sound support did not,
they need rework.

Regards,
Andreas
