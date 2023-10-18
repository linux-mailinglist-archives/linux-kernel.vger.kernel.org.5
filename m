Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B887CE149
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjJRPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjJRPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:34:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A9111;
        Wed, 18 Oct 2023 08:34:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so1074360466b.3;
        Wed, 18 Oct 2023 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697643278; x=1698248078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub5Yg0CJelx4oGv8fp3eRsfPV6T6acMrYQkLBrGUmtg=;
        b=INtkq7RYb85JDOX/JA+KFdfCBZbwqjvSFIxcYzjo7zsHsSNiyN80WAx9uRx9ZGYaNf
         dysSEMJUj5btLi1fu/eUTpbmJhJi6ty4n2vCl9ej91I3TvWHDXioG0UaDZQE5F9L9Qxs
         tLXSRIiYWqHyoPIktlAlEtUUiGz/fE/YchYu8T+DsXIrHHHz7GxF2IA3qTKRuv3oxmXe
         WnFdZo9EqD/uigQiGH+NQ32EkV3nYd0FmJfJUNGTMRlo4yAOoQX/2u1wPnXkvq/hPoet
         07mPAgE6d+hFlyFd8aHF2kNAulH2K9iTJKR+twzfbYyvTls+JaD24dcW6ls9Lh3b/iq2
         yZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697643278; x=1698248078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub5Yg0CJelx4oGv8fp3eRsfPV6T6acMrYQkLBrGUmtg=;
        b=EDObk2PcodKFKs+dq4FfuxFsI+mn3a17u/rNjfPSHKp5yr4R3l539gsxmdwTeLL2aG
         0vpieIfXqUtDRkNdXs+nGz3P0ItHIoFt9KWNX1HJM4Dv5PapBwy3liRo0kCGSnkj4+PJ
         mhLyFLv77h89G49Cuu69tl4AIFaKf+5ZaGCryIfb8j27BmUY1tMCvwnGr5DIK6nyM6Br
         GthbNgdBeFXd0956Yxi1ZuMRyAfDtjv4GFFaJ/ZAc/mK1voe07BtMwumuuKemj85jKB8
         /4E9wjDmn6yepUXuFxlUzhLYqNzIJvllBleou695HTFwshOF/45HeNpzdXbi5DQ4PMDA
         D3EA==
X-Gm-Message-State: AOJu0YzusoH6NuqmQT4MMGh8i+5BPDpZwhHvZvAp19M5thr5KvRUDyxI
        f0Utw7gOcpdLgCFCc+tZlO7R0x9dfjbwO80=
X-Google-Smtp-Source: AGHT+IFuXpYMxlADLEsXxy5I5GqphwtTebkI3aaksBzLRVwqwh4y5mNKLrJxrinpzTR4oIfD9PVrvw==
X-Received: by 2002:a17:907:78b:b0:9be:7de2:927c with SMTP id xd11-20020a170907078b00b009be7de2927cmr4110575ejb.70.1697643278205;
        Wed, 18 Oct 2023 08:34:38 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.156.111])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170906b88600b009b8dbdd5203sm1880717ejb.107.2023.10.18.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:34:37 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:24:55 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <ZS/cp8IZyCjujmDQ@dorcaslitunya-virtual-machine>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
 <2023101846-synopses-paralyses-d1ee@gregkh>
 <ZS+moqE585lPBN3m@dorcaslitunya-virtual-machine>
 <2023101830-janitor-trapezoid-bb48@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101830-janitor-trapezoid-bb48@gregkh>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:25:05PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 12:34:26PM +0300, Dorcas Litunya wrote:
> > On Wed, Oct 18, 2023 at 11:26:33AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 18, 2023 at 12:07:38PM +0300, Dorcas AnonoLitunya wrote:
> > > > Modifies the return type of program_mode_registers()
> > > > to void from int as the return value is being ignored in
> > > > all subsequent function calls.
> > > > 
> > > > This improves code readability and maintainability.
> > > > 
> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > > > ---
> > > >  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > > index 83ace6cc9583..e15039238232 100644
> > > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > > @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
> > > >  }
> > > >  
> > > >  /* only timing related registers will be  programed */
> > > > -static int program_mode_registers(struct mode_parameter *mode_param,
> > > > -				  struct pll_value *pll)
> > > > +static void program_mode_registers(struct mode_parameter *mode_param,
> > > > +				   struct pll_value *pll)
> > > >  {
> > > >  	int ret = 0;
> > > >  	int cnt = 0;
> > > > @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
> > > >  	} else {
> > > >  		ret = -1;
> > > 
> > > Why are you still setting the 'ret' variable if you are not doing
> > > anything with it anymore?
> > > 
> > > >  	}
> > > > -	return ret;
> > > 
> > > Are you sure that the caller shouldn't be checking for errors instead of
> > > dropping the return value?  If so, document that in the changelog too.
> > >
> > Seems like the caller doesn't use the function to check for errors as in
> > the code below:
> > 
> > int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
> > {
> >         struct pll_value pll;
> > 
> >         pll.input_freq = DEFAULT_INPUT_CLOCK;
> >         pll.clock_type = clock;
> > 
> >         sm750_calc_pll_value(parm->pixel_clock, &pll);
> >         if (sm750_get_chip_type() == SM750LE) {
> >                 /* set graphic mode via IO method */
> >                 outb_p(0x88, 0x3d4);
> >                 outb_p(0x06, 0x3d5);
> >         }
> >         program_mode_registers(parm, &pll);
> >         return 0;
> > 
> > It will still return 0 regardless of whether there is an error or not.
> > Since I am not sure how the two functions relate to one another, is
> > there need to check error in the caller function?
> 
> That is correct, it is not checking for errors, but shouldn't it?  If
> the function can fail, then it should have proper error handling so
> return the correct error (hint -1 is not a valid error), and then
> propagate it up the call chain correctly as well.
> 
> For doing this type of work, either the function can not fail so there
> can not be an error return value, or it can, and then the error should
> be propagated correctly.  Sorry for not spelling that out earlier.
> 
> thanks,
> 
> greg k-h
Makes sense. I am not sure whether there exists a function that cannot
fail. But for this patch I will start by assuming that it cannot fail and
remove the error return variable altogether. Then after submission of the patch, I
will look at whether the function can fail and see how to propagate the
error. I think this should work?

thanks,
Dorcas

