Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649EB80812D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjLGGvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjLGGuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:50:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53702D1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:50:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA5C433C7;
        Thu,  7 Dec 2023 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701931831;
        bh=vqgmxvtHdH524IT5OoMaM15bH8qpnsIkh6S4xu+XSxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=to17iC5LcWb0i2pmWujxZYbaGuiujJ9OFrtiYvhYHQGvFbnKFIui3x0oCPZg/13Sp
         yX3QhHnj98dbh48AdjNfHaabqXzI9Dli1CP22PFAz2iWd8ZtnWdAcCeUwanmWqyZEp
         V5yv20LWOSvdnz8PoKjOXYo3BWiwIYsJzS7DIF90=
Date:   Thu, 7 Dec 2023 10:33:16 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
Message-ID: <2023120755-dance-request-8293@gregkh>
References: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
 <2023120146-pyramid-salsa-d8cd@gregkh>
 <ZWmhKS+quI3dmOND@moxa-ThinkCentre-M90t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmhKS+quI3dmOND@moxa-ThinkCentre-M90t>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:02:33PM +0800, Crescent CY Hsieh wrote:
> On Fri, Dec 01, 2023 at 08:27:05AM +0000, Greg Kroah-Hartman wrote:
> > On Fri, Dec 01, 2023 at 03:40:55PM +0800, Crescent CY Hsieh wrote:
> > > MOXA PCIe RS422/RS485 boards will not function by default because of the
> > > initial default serial interface of all MOXA PCIe boards is set to
> > > RS232.
> > > 
> > > This patch fixes the problem above by setting the initial default serial
> > > interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> > > 
> > > Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > > ---
> > >  drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
> > >  1 file changed, 57 insertions(+), 1 deletion(-)
> > 
> > Why is this a RESEND?  What happened to the first attempt, did I miss it
> > somewhere?
> 
> This RESEND patch is the first patch of this patch series [1], Jiri
> reviewed the first patch and suggested to split the second patch, so I
> split the second patch and sent it as a new patch.
> 
> However, the first patch seems to be overlooked, so I resend it.
> 
> [1] https://lore.kernel.org/all/20231027062440.7749-1-crescentcy.hsieh@moxa.com/

Looks like 0-day had a problem with it, please fix that up and resend a
new version.

thanks,

greg k-h
