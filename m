Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805017D0231
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjJSTG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJSTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:06:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF4F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:06:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692c02adeefso57092b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697742380; x=1698347180; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWJpu48XDgOzWODf3Ip57EpXlsaglYJphkrHkfSodW0=;
        b=QqAzEHyPspvlUOPkbuuIy8UJBJoEtJJC1m1O9V2PGW+nUiDFtRgjE8uRT5fglm40Q5
         LW7697TLdwUB7p0ktzRPMPKUa4fJ49wn3sBKfVTh2IrDs3jQCp5qVNmD1tE02JJ+0Spf
         O2t8zwfExAm45vr7pGu9vLP8kGnRujpmgjqz0w+pz6c313QBp7ciTQ8+EOI8+bGJpdXy
         1DxFnoFPLYdw67GJAlUEqNL1gT6ItgqMFdwJZL7g4lR+02PkIfwa5pRenNfipIDCajq4
         Kq1V3oZOoiTcl1QiJRyrQ/nsZPCpKD2eKEfA8jxMBd6LOF8aSEzb80DEO3eqfFW2ZO+n
         9OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697742380; x=1698347180;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWJpu48XDgOzWODf3Ip57EpXlsaglYJphkrHkfSodW0=;
        b=tRBF3Bnwz0v40+d1l7LDnMehnAKys1Uld/rpUDJP10cre3+fQS6x0lChod7pT5yDjg
         GIkheYLN3tb8CM3VSSSAU/13KrHxIE7Hd9r7qLUynq7yNEqJfX2KbmFQGbar921sBxJe
         pX2eXbi6quqyBNH8UONdu/jepISljow8M9mMGZejQp4rAlYK4pPsbgAqRBrT03zm3Ii2
         4xBDFucTp++fkJ7mxYI7d9k6SIhXJWNW/TTxhwiHu+6XyPUzo3q0HQBwOGIp2cLBNTJu
         CNzkmLH6neejrc8MzZMwGhBaELhD115sq/C8W2CdIpRAvEo43izTA1lzjJgo1zqeU2q1
         7qcQ==
X-Gm-Message-State: AOJu0YwUJhG4m2hQEeggFa3awF80o6C5Gf4m8sPwgeU9alvqGMx8TL+r
        ovpijdM4AZeJ7L7i4ybyEfUox1r+rfPH+g==
X-Google-Smtp-Source: AGHT+IHmT5wyc2UxYytBTeiu8da70APrWxnUEwtgWi0O8N35e6RkncPLic7Sry7GP7BjZMhVR2nX3A==
X-Received: by 2002:a05:6a00:1895:b0:6be:2bfa:6290 with SMTP id x21-20020a056a00189500b006be2bfa6290mr3054593pfh.8.1697742379976;
        Thu, 19 Oct 2023 12:06:19 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006be22fde07dsm133346pfj.106.2023.10.19.12.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:06:19 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:06:18 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <20231019190618.GA29750@Negi>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
 <2023101823-unhidden-draw-d68c@gregkh>
 <20231018193855.GA32553@Negi>
 <2023101925-kudos-playful-7c5a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101925-kudos-playful-7c5a@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:34:01PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 12:38:56PM -0700, Soumya Negi wrote:
> > Hi Greg,
> > 
> > On Wed, Oct 18, 2023 at 03:26:07PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 17, 2023 at 09:36:32PM -0700, Soumya Negi wrote:
> > > > vme.c uses printk() to log messages. To improve and standardize message
> > > > formatting, use logging mechanisms pr_err()/pr_warn() and
> > > > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > > > messages during replacement.
> > > > 
> > > > Issue found by checkpatch.pl
> > > > 
> > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > ---
> > > >  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
> > > >  1 file changed, 94 insertions(+), 81 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > > index 6519a7c994a0..e8c2c1e77b7d 100644
> > > > --- a/drivers/staging/vme_user/vme.c
> > > > +++ b/drivers/staging/vme_user/vme.c
> > > > @@ -9,6 +9,8 @@
> > > >   * Copyright 2004 Motorola Inc.
> > > >   */
> > > >  
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > 
> > > No, this is a driver, as others have pointed out, always use dev_*()
> > > calls instead.
> > 
> > Some of the pr_ fns can be dev_, but I don't think all can.
> > e.g. device NULL-check error messages
> 
> I would argue that those are pointless and can be removed and also the
> check is probably not needed either.

Got it. The pr_() in find_bridge() can't be converted to dev_ so I'll remove 
the message entirely in another patch.

I understand that the device-NULL checks should be done on the caller's side. 
Since empty devices would mean something went wrong, would it be better to
put in an assertion(..WARN_ON) when removing the check? 

> > Also, there are portions of the driver where we have no access to
> > any 'struct device' to feed into dev_.
> 
> Then you can fix that :)

Will do this. 

Regards,
Soumya

> thanks,
> 
> greg k-h
