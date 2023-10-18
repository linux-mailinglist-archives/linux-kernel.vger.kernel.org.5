Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2130D7CDD38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbjJRN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjJRN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:27:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D95A3;
        Wed, 18 Oct 2023 06:27:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902D3C433C8;
        Wed, 18 Oct 2023 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697635666;
        bh=jCgth0ZM5NS8POYLQWWncAMyPeJN/zdTVz+jC6/ir9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgi7WPeIR22Maw7vQXg4kBgzinMLtQgFbpnFy9pUgqlKbc4AtGgTaOEBdVkMrWKCz
         ptQNibWB+rUMv/fArQrHll9RBq9B+8lWECJTao2WD01tRUvFWQ5Y4toqTEAntZVBIc
         bWUQRuYQgzQK4JKeyxxQqHPfjuKodQC/lS5z+kow=
Date:   Wed, 18 Oct 2023 15:27:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas Litunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
Message-ID: <2023101844-sadness-payee-0923@gregkh>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
 <2023101724-diagram-legwork-0e53@gregkh>
 <ZS5FlsCPETnr8T5D@dorcaslitunya-virtual-machine>
 <2023101712-grudge-overtime-1f43@gregkh>
 <ZS5JexVUSKZUuOd4@dorcaslitunya-virtual-machine>
 <ZS7WvaM65awtILqk@dorcaslitunya-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS7WvaM65awtILqk@dorcaslitunya-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:47:25PM +0300, Dorcas Litunya wrote:
> On Tue, Oct 17, 2023 at 11:44:43AM +0300, Dorcas Litunya wrote:
> > On Tue, Oct 17, 2023 at 10:34:43AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 17, 2023 at 11:28:06AM +0300, Dorcas Litunya wrote:
> > > > On Tue, Oct 17, 2023 at 09:50:50AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> > > > > > Rename function displayControlAdjust_SM750E to
> > > > > > display_control_adjust_SM750E. This follows snakecase naming convention
> > > > > > and ensures a consistent naming style throughout the file. Issue found by
> > > > > > checkpatch.
> > > > > > 
> > > > > > Mutes the following error:
> > > > > > CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>
> > > > > > 
> > > > > > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > > > > index e00a6cb31947..8708995f676c 100644
> > > > > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > > > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > > > > @@ -14,8 +14,8 @@
> > > > > >   * in bit 29:27 of Display Control register.
> > > > > >   */
> > > > > >  static unsigned long
> > > > > > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > > > > > -			     unsigned long dispControl)
> > > > > > +display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
> > > > > > +			       unsigned long dispControl)
> > > > > >  {
> > > > > >  	unsigned long x, y;
> > > > > >  
> > > > > > @@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
> > > > > >  			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
> > > > > >  
> > > > > >  		if (sm750_get_chip_type() == SM750LE) {
> > > > > > -			displayControlAdjust_SM750LE(pModeParam, tmp);
> > > > > > +			display_control_adjust_SM750LE(pModeParam, tmp);
> > > > > 
> > > > > Why is this function returning a value if it is just being ignored?
> > > > > 
> > > > > It's not the issue here in the patch, but for future changes.
> > > > >
> > > > Hi Greg,
> > > > 
> > > > I will do the correction in the next patchset to correct both functions
> > > > return value as this patchset was not focused on that. Does this mean
> > > > that this patchset has been accepted? Or should I submit another
> > > > patchset that includes the two changes suggested on function return
> > > > values?
> > > 
> > > You'll get an email from my system when it is accepted, wait a day or so
> > > before worrying about that.  And then send new patches on top of them
> > > then.
> > > 
> > Thanks for the clarification Greg. I will wait for the confirmation
> > email from your system then send the new patches shortly afterwards.
> > 
> > thanks,
> > Dorcas
> > > thanks,
> > > 
> > > greg k-h
> Hello,
>  I have realised there was an error in the commit message subject and body for this patch. I had put "Staging: sm750fb: Rename displayControlAdjust_SM750E" instead of "Staging: sm750fb: Rename displayControlAdjust_SM750LE".I had forgotten the L in SM750LE. I have modified the commit message using git commit --amend to correct the mistake. I have seen the patch has been accepted, however, I am not sure whether the change in the commit message will reflect once the patch is merged. Please guide on what to do next. I am really sorry for the inconvenience.

There is no connection between the change you made on your machine, and
the ones on mine which get pushed to kernel.org.  So if you need a
change, you need to send a new patch.

For a typo fix like this, don't worry about it, it's already in my tree
and is not worth dropping it, so it's all ok.

thanks,

greg k-h
