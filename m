Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94AB7CDD27
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjJRNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjJRNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:25:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63796112;
        Wed, 18 Oct 2023 06:25:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C944C433C8;
        Wed, 18 Oct 2023 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697635507;
        bh=V5vV9mOcW/WM58qdgODI7jhGfII2OqW8maCTrvEpT78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXpnBUfdo4YSW8EebR0dBdWP897om+17z8TLdTsIvE85A2YkJgrmJKX5oxVeyj2th
         Vn3lEdRfnHXpnpo4lnM7emSVpJ3OoQqo1uhxyaLLCsYZyjsuZOkic2iNK7Mh22t0aO
         RXb4u9P8FyD8//Upmwr+MTYwkllNRLj2dmQCv0WY=
Date:   Wed, 18 Oct 2023 15:25:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas Litunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <2023101830-janitor-trapezoid-bb48@gregkh>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
 <2023101846-synopses-paralyses-d1ee@gregkh>
 <ZS+moqE585lPBN3m@dorcaslitunya-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+moqE585lPBN3m@dorcaslitunya-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:34:26PM +0300, Dorcas Litunya wrote:
> On Wed, Oct 18, 2023 at 11:26:33AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 12:07:38PM +0300, Dorcas AnonoLitunya wrote:
> > > Modifies the return type of program_mode_registers()
> > > to void from int as the return value is being ignored in
> > > all subsequent function calls.
> > > 
> > > This improves code readability and maintainability.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > index 83ace6cc9583..e15039238232 100644
> > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
> > >  }
> > >  
> > >  /* only timing related registers will be  programed */
> > > -static int program_mode_registers(struct mode_parameter *mode_param,
> > > -				  struct pll_value *pll)
> > > +static void program_mode_registers(struct mode_parameter *mode_param,
> > > +				   struct pll_value *pll)
> > >  {
> > >  	int ret = 0;
> > >  	int cnt = 0;
> > > @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
> > >  	} else {
> > >  		ret = -1;
> > 
> > Why are you still setting the 'ret' variable if you are not doing
> > anything with it anymore?
> > 
> > >  	}
> > > -	return ret;
> > 
> > Are you sure that the caller shouldn't be checking for errors instead of
> > dropping the return value?  If so, document that in the changelog too.
> >
> Seems like the caller doesn't use the function to check for errors as in
> the code below:
> 
> int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
> {
>         struct pll_value pll;
> 
>         pll.input_freq = DEFAULT_INPUT_CLOCK;
>         pll.clock_type = clock;
> 
>         sm750_calc_pll_value(parm->pixel_clock, &pll);
>         if (sm750_get_chip_type() == SM750LE) {
>                 /* set graphic mode via IO method */
>                 outb_p(0x88, 0x3d4);
>                 outb_p(0x06, 0x3d5);
>         }
>         program_mode_registers(parm, &pll);
>         return 0;
> 
> It will still return 0 regardless of whether there is an error or not.
> Since I am not sure how the two functions relate to one another, is
> there need to check error in the caller function?

That is correct, it is not checking for errors, but shouldn't it?  If
the function can fail, then it should have proper error handling so
return the correct error (hint -1 is not a valid error), and then
propagate it up the call chain correctly as well.

For doing this type of work, either the function can not fail so there
can not be an error return value, or it can, and then the error should
be propagated correctly.  Sorry for not spelling that out earlier.

thanks,

greg k-h
