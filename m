Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932CA7CCFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQWWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:22:35 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6395
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:22:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C49E240005;
        Tue, 17 Oct 2023 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697581351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RYhFnz8eyfMROGBEry38EvxL6FIh7wOsJOmeYjg9T44=;
        b=C9NeFpwfRDPAgZ3ve02+rfgt6FDHnz6jvyoqPt/uan+r85WkXy9M/Slu1ze6a713seBJpJ
        0u+/J/Z+PgL6grtOaC2zP7wgr6JSH1n8ftacz1T1BniTVd4AntP0sgNXSgfPJ+Lj46hPfv
        eTQIRLu1t2N6JBJqeltIwBmIL4jxWlRAP+B82eAqyRSLCKmKPV7RIVWd3n7/Cvxyvxqelp
        0KY7v8P2IEEqidS2cHrMAtblgG200vSiQTQteMiR8JV+nTxdmqRXJrz9NwcmGkapqXnJt4
        MUwXlLJ0laJWaYaEfm3R2MeH6oCAjpnC7XYzWisuoF1BeTn+4hKnAOWXILpHHg==
Date:   Wed, 18 Oct 2023 00:22:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/5] i3c: master: svc: enable hotjoin default
Message-ID: <20231017222230636965c5@mail.local>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-2-Frank.Li@nxp.com>
 <20231017160457.4f0c2490@xps-13>
 <ZS6fbVtbuBH32aRU@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6fbVtbuBH32aRU@lizhi-Precision-Tower-5810>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 17/10/2023 10:51:25-0400, Frank Li wrote:
> On Tue, Oct 17, 2023 at 04:04:57PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> > 
> > Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:28 -0400:
> > 
> > > Hotjoin require clock running and enable SLVSTART irq.
> > > Add module parameter 'hotjoin' to disable hotjoin and enable runtime_pm to
> > > save power.
> > 
> > I am really not a big fan of the use of modules parameters. Maybe it
> > makes sense here. Alex, a better idea?
> 
> Maybe we can create sys entry to enable/disable hotjoin. I think i3c
> should default support hotjoin, but it exist user case that needn't hj and
> want more aggressive power saving.
> 
> If create /sys/ entry, it need change driver/i3c/master.c.
> 

If this can be changed dynamically, I guess ideally, we should be able
to set it independently per controller so it could be disabled on a bus
but kept enabled on others.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
