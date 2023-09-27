Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032E7B06BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjI0O21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0O20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:28:26 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB7F9;
        Wed, 27 Sep 2023 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=fY3tgArrYfp7UiQOV9ma8Q9n1cP+zTVSpeExNbzVza4=; b=yWJWqqYe2XRy/t2Old5oNg2JYA
        o3Qs9hrf5uhctU2jXuNEp3ML6UWPC81tXcCdm8pNcXfVq5oaLVVM4OMUKNtJCPpSXII8vrF1ri7dS
        lo2P68h3PhtoRkwxAcEMUG53r+NRbiL0nTvpdUVjue1ASo0GoRyXlnUb3AnuhnT3Uaus=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34286 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qlVWV-0007Eq-Bw; Wed, 27 Sep 2023 10:28:19 -0400
Date:   Wed, 27 Sep 2023 10:28:18 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <20230927102818.27b0beff6006392e91380ecd@hugovil.com>
In-Reply-To: <CAL_JsqLpJuxJ1ZbMkwXPrzUAK3Xhfr4zFgSYvmFufyDRF1QjpQ@mail.gmail.com>
References: <20230920152015.1376838-1-hugo@hugovil.com>
        <20230920152015.1376838-4-hugo@hugovil.com>
        <20230921162424.GA435508-robh@kernel.org>
        <20230921123237.b3c50eb12746724a4fd62237@hugovil.com>
        <CAL_JsqLpJuxJ1ZbMkwXPrzUAK3Xhfr4zFgSYvmFufyDRF1QjpQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to
 irda-mode-ports property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 14:52:06 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, Sep 21, 2023 at 11:32 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > On Thu, 21 Sep 2023 11:24:24 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Wed, Sep 20, 2023 at 11:20:14AM -0400, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >
> > > > The NXP-specific "irda-mode-ports" property lacks a proper vendor
> > > > prefix. Add "nxp," prefix to comply with DT best practises.
> > >
> > > The opposite direction would be worth carrying in the driver, but I
> > > don't think adding a vendor prefix is. I would just leave this as-is.
> > >
> > > Rob
> >
> > Hi Rob,
> > I am not following you, can you clarify?
> 
> Just keep the property as-is and don't add a 'nxp,' prefixed version.
> It's not worth carrying the fallback in the driver.
> 
> If you were dropping a vendor prefix from a property, then that's
> worth it because there might be other users added.
> 
> Rob

Hi Rob,
ok, then I will drop this patch as well as the other titled
'serial: sc16is7xx: recognize "nxp,irda-mode-ports" DT property' for
V2.

Hugo.
