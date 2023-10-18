Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55967CD83F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjJRJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjJRJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:34:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D8106;
        Wed, 18 Oct 2023 02:34:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso10330325e9.0;
        Wed, 18 Oct 2023 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621671; x=1698226471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sd04U5ztHM5BN91zVsx9G6ZDnJ4iPY9R76fpuMvI0tU=;
        b=XbEcmMEIG/xzTmpJfdoxYpcGYmLJj50T9Fmz95KTNgrY+l4uACG8sQee7rX8XxHURk
         GWGz5K3XCmgP5fXFYd5F9CGmVNuaAuQFNMfr3oFKLAbGb+sRS4+vnmPP9Wn56pGqtPHn
         4jrOPWVA2/dCB4wym1eM1/OKXLpIJWjRRPS+dm6qVHATWDJJ3CfO0NtSarRnnmEXes6Q
         HkX8iVp7q4PJdlUnTEVfmBwjsl4JWvoY6M/pur6gk458BDCJ1aUNeL/pVthD7snCGCnx
         V3j7h5WyQHOu/VhNa42Pqbv5IiG1UTtHx+a/T2XKgj9KsEuvE3951137cg4POUmcInNl
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621671; x=1698226471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd04U5ztHM5BN91zVsx9G6ZDnJ4iPY9R76fpuMvI0tU=;
        b=kyltxCrxwuHjKNVGt2HfzW9vGliD0RmQjDpJ2vWdBAfyBj91BCJDTPPth+5rc7EmXW
         KtwPgwounFWxeWptzV9myBtUD3MJKK+qWoZfmKqJwolHMnCvGxoLiSwIRuliQTMzHT9T
         r7hS/0iYqUm06v8QCkX6D6JKgH3uXqCyOF6KqfbuZLmt3jDIOo3kfgMRGtUcA9dzRFkI
         +qosh2NXUdd0Hbgn8KXQ02t8JQehhsa0K5IITRrrkAGt4ctAFjZmrJg0ZZHudTQ4fpXb
         EPTDumrUgrVFaSiKey6M1EJ812b6CzS+ZrePGV1fI6fKLFaDZiyWYQ7ht/COOS8EQCbO
         SCUA==
X-Gm-Message-State: AOJu0YzIAAGi3tYZtH5tMxo5MMA1XvoqcyqvCNnGVzZ5N+qPTe90JnIg
        x6hJncoZGe+af/XyjY6Z1A==
X-Google-Smtp-Source: AGHT+IHmDIpRPzXCLPQAZ3IxJiiTrLvL6xTrGXiKrnqsbiCJwNUaHu+nlvHbGSpKR4lJJDeUTV+Qjg==
X-Received: by 2002:a05:600c:5487:b0:408:3ab3:a050 with SMTP id iv7-20020a05600c548700b004083ab3a050mr1172995wmb.16.1697621670844;
        Wed, 18 Oct 2023 02:34:30 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.0.227])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d66c1000000b0032dbf99bf4fsm1680829wrw.89.2023.10.18.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:34:30 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:34:26 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <ZS+moqE585lPBN3m@dorcaslitunya-virtual-machine>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
 <2023101846-synopses-paralyses-d1ee@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101846-synopses-paralyses-d1ee@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:26:33AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 12:07:38PM +0300, Dorcas AnonoLitunya wrote:
> > Modifies the return type of program_mode_registers()
> > to void from int as the return value is being ignored in
> > all subsequent function calls.
> > 
> > This improves code readability and maintainability.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index 83ace6cc9583..e15039238232 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
> >  }
> >  
> >  /* only timing related registers will be  programed */
> > -static int program_mode_registers(struct mode_parameter *mode_param,
> > -				  struct pll_value *pll)
> > +static void program_mode_registers(struct mode_parameter *mode_param,
> > +				   struct pll_value *pll)
> >  {
> >  	int ret = 0;
> >  	int cnt = 0;
> > @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
> >  	} else {
> >  		ret = -1;
> 
> Why are you still setting the 'ret' variable if you are not doing
> anything with it anymore?
> 
> >  	}
> > -	return ret;
> 
> Are you sure that the caller shouldn't be checking for errors instead of
> dropping the return value?  If so, document that in the changelog too.
>
Seems like the caller doesn't use the function to check for errors as in
the code below:

int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
{
        struct pll_value pll;

        pll.input_freq = DEFAULT_INPUT_CLOCK;
        pll.clock_type = clock;

        sm750_calc_pll_value(parm->pixel_clock, &pll);
        if (sm750_get_chip_type() == SM750LE) {
                /* set graphic mode via IO method */
                outb_p(0x88, 0x3d4);
                outb_p(0x06, 0x3d5);
        }
        program_mode_registers(parm, &pll);
        return 0;

It will still return 0 regardless of whether there is an error or not.
Since I am not sure how the two functions relate to one another, is
there need to check error in the caller function?

thanks,
Dorcas
> thanks,
> 
> greg k-h
