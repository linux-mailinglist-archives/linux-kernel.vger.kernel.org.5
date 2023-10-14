Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4BA7C9347
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjJNHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:38:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30843B3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:38:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-504a7f9204eso3564345e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269107; x=1697873907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IW8rze1/YjaqUMjBuePhE7bES5VSq0kZGVhjWXwOWg=;
        b=uUUKgB8KsAFXIcw0IQ/AyGE31OrVsjvu49rC9/P4XzePKO6HauDo3AER22BGEZXc+A
         UaAJcrYpk9w5u6Sqhq2zWAZaDx8M7ov217Qe9PHscLmQfz3By5A36L6GyvYBv776REP9
         gafIPlp20qDnJ9XfuqGsbzxxv2Dr312eihF7AkSgFIg1V42c48ySdaZrsgb/gYKtp93q
         QCGIXsCNsMCSVzezlaAFMcG/Jh/GEapBrRV26aPBCtCNOhdiat5j0DDOrGVU/M3x+Z8L
         9uLKyW4nUSENRrMOAfYL1WSRjNbyIHF9zylBl+QcVCQ3Euq7qiWLb7y4CWwvDAaebOJD
         eqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269107; x=1697873907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IW8rze1/YjaqUMjBuePhE7bES5VSq0kZGVhjWXwOWg=;
        b=Aomh4zj7Xq+P6qkA0zTatXNJIJ6Hcw8xvV9MyZfsK/QdfpHKO/tsKXtQxIfV9MJoWh
         ZNslmRwl9Ec1siWmoqVFKmHB0awi27ccYegayj6C/sKzlflZMIJ/eTIGUYGu0OE6oFS2
         fA0DoBeWQn4hef0dsAF9aoCeZlY39ujKqJDNM7ZTrmN7M4wPQiTttjHpb2Bm7xuUm7f0
         Gz+ImSsFPh7Jb3fibvj1EDUMxwxn9zXnky9llDITlQv2U06ONkcy+FAn99rXEFDwdvx2
         QdCSudVDzQCE7bZnfa7pioRjaPRRwuuEYyPnfVJHRmXkFoVcTjHJDCdUWzOzIyVoaCPC
         Ys8Q==
X-Gm-Message-State: AOJu0Yx6AVZClCAqvWzlXruucx2n2GL4GpaS0ar2oEaJME1jzVdYK/Sc
        YEeSdQjU8OAJslXn0hc+SenrGDaInbL7oClkOnE=
X-Google-Smtp-Source: AGHT+IEwy0mTowcwVn+E09x52F7nrltv7XkrXRZJXoKbC5VJ4QM5KNmK+GyTJYRivZMLkI2F/Mx9EA==
X-Received: by 2002:a05:6512:3ba0:b0:507:9d70:b297 with SMTP id g32-20020a0565123ba000b005079d70b297mr3455700lfv.60.1697269107071;
        Sat, 14 Oct 2023 00:38:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v7-20020adfedc7000000b003197efd1e7bsm22225990wro.114.2023.10.14.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:38:26 -0700 (PDT)
Date:   Sat, 14 Oct 2023 10:38:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: gdm724x: Match alignment with open parenthesis
Message-ID: <52732a88-7f40-4ce4-b75b-dded9827c1f0@kadam.mountain>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <ff627fcbc9e450c2e8f4aa5810b94e56151efa2a.1697184167.git.soumya.negi97@gmail.com>
 <a0a7274f-eba6-4f72-9569-ec4c4fff3a1a@kadam.mountain>
 <20231013211326.GB25352@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013211326.GB25352@Negi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:13:26PM -0700, Soumya Negi wrote:
> On Fri, Oct 13, 2023 at 11:57:40AM +0300, Dan Carpenter wrote:
> > On Fri, Oct 13, 2023 at 01:26:34AM -0700, Soumya Negi wrote:
> > > Fix CHECK: Alignment should match open parenthesis
> > > Issue found by checkpatch.pl
> > > 
> > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > ---
> > >  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> > > index 32b2e817ff04..4e5cac76db58 100644
> > > --- a/drivers/staging/gdm724x/gdm_tty.c
> > > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > > @@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
> > >  	int ret;
> > >  
> > >  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> > > -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> > > -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> > > +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> > > +					      TTY_DRIVER_DYNAMIC_DEV);
> > 
> > I prefered the original code.  It was more readable.
> > 
> > regards,
> > dan carpenter
> Hi Dan,
> 
> Noted. I'm curious what happens when some of the patches in a patchset
> are acceptable and some are not. Is everything disregarded by
> maintainers or are the good patches cherry-picked from the set?

Most of the time, you should just resend the series.  Sometimes a
maintainer will take the first few patches and then when they hit one
that can't be merged they'll stop.  So you should try to organize your
patchsets from fixes first, then cleanups and then least controversial
to most controversial.  Except people might be annoyed if it looks like
you're hiding a really controversial one at the end of a long series.

regards,
dan carpenter

