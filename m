Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E17C854A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjJMMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjJMMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:05:45 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48FDA;
        Fri, 13 Oct 2023 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=JVNjKA5BDxHIuNoLtOyLa0d8PBvTaC7XyqHCbnt00h0=; b=C9
        HT0EZtdZTTScE2v3IV7j2X36h2efmC5H3E6jYaFi4GMyhNJsRNTWKErZXFLPp+3JRhgc/JgIrGEXu
        OA3001XO64hvR99tJBz1CoZKBkx5xMobrF7Le1xEwXXZ3Q+RECtFyZr1rUbrpfC4ln9grnpq1M3pk
        1IGTLNwTDvDhvaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrGv4-0025Mw-JH; Fri, 13 Oct 2023 14:05:30 +0200
Date:   Fri, 13 Oct 2023 14:05:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <e2b7f4fb-b2f9-4457-b5ae-4cf6acceb10d@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
 <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
 <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:01:06PM -0700, Justin Stitt wrote:
> On Thu, Oct 12, 2023 at 2:59 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
> > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > [1] and as such we should prefer more robust and less ambiguous string
> > > interfaces.
> >
> > Hi Justin
> >
> > You just sent two patches with the same Subject. That got me confused
> > for a while, is it a resend? A new version?
> 
> Yep, just saw this.
> 
> I'm working (top to bottom) on a list of strncpy hits. I have an automated tool
> fetch the prefix and update the subject line accordingly. They are two separate
> patches but ended up with the same exact subject line due to oversight and
> over-automation.
> 
> Looking for guidance:
> Should I combine them into one patch?

No, it is fine. Just try to avoid it in the future.

    Andrew
