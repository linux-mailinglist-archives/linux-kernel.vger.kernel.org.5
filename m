Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EE7B82AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbjJDOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjJDOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:50:55 -0400
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5230DB8;
        Wed,  4 Oct 2023 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
        t=1696429806; bh=TedzwPwzm/uvapENYRqWPjouS2zTRkOVHGvUyrv0Vbg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=rpv5KxdgDOusiTO9ZZC61winbmtp7SfZHExdR2ZIYw9LCALQbncIIkuHmpH/5sg/I
         1TnE238b7YHEyy1YvC/GqBrZmOaafysjte8Cu1hVsWgSgB/VOkJotvsfjx2zOUjdIe
         NstFlxLnKmF3GoJGXXUCeXN9lTgX50Au+YqODEo4=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  4 Oct 2023 16:30:05 +0200 (CEST)
X-EA-Auth: FZCFa3GRQPbutha7o0M0ykDKPqM2F0qO6GzRNQf8jrVWg2fNZYwzAaVwjbw+R+Ys40IIDryL2fxYpvG/N0MKlGn1EYhErdyE2yIID/PZCJM=
Date:   Wed, 4 Oct 2023 16:29:06 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: remove unneeded
 stmmac_poll_controller
Message-ID: <ZR12sux0vN5YXIYk@pilgrim>
References: <20230906091330.6817-1-repk@triplefau.lt>
 <626de62327fa25706ab1aaab32d7ba3a93ab26e4.camel@redhat.com>
 <ZRKozLps8dmDmQgc@pilgrim>
 <20231002133759.133d8a97@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002133759.133d8a97@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:37:59PM -0700, Jakub Kicinski wrote:
> On Tue, 26 Sep 2023 11:47:56 +0200 Remi Pommarel wrote:
> > > I'm sorry for the incremental feedback, but we also need a suitable
> > > Fixes tag, thanks!  
> > 
> > I didn't include Fixes tag because it would go back up to the initial
> > driver support commit [0]. I can't be sure that this commit includes
> > necessary NAPI implementation to be able to get rid of
> > .ndo_poll_controller callback back then. And I am not able to test it on
> > older version than 5.15.x hence I only included the 5.15.x Cc tag
> > version prerequisite.
> > 
> > But I surely can add a Fixed tag if it is ok for it to be [0].
> > 
> > Also sorry for the long replying delay.
> > 
> > [0] commit 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")
> 
> AFAIU the Fixes tag only indicates where the bug was present,
> no guarantees on whether the fix can be backported as far back.
> IOW I think [0] as Fixes tag will be perfectly correct, please
> repost with it included?

Ok that makes sense, thanks. Will resend with Fixes tag.

-- 
Remi


