Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50997CB49E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjJPUaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:29:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A3B4;
        Mon, 16 Oct 2023 13:29:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so50208375e9.2;
        Mon, 16 Oct 2023 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697488192; x=1698092992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwRWv8WzXK7ulsIjQYcQ2H5E6aNrsXzP3LLjUnpeYMY=;
        b=NQhMGZS6o4Udb2K191Ec7f07mkjb8kx+nNQpkRZ6EpU+5/mLnp34QIpKEhUHRDzsY1
         uD+jOalrAxKxPM88pA4d4iWrmgf5XOf3KPC42YSPhBK0UyGpl48kS8BNIXK1SOAzoT/N
         Xt7Z7zePsO3+GsHsIk8PFle1OrmL3Ac4d50sFfZYgNtS7YVRZHiU2gON0uP4hxB/1/LK
         9VkGKhHvPevE7eJ0IOoAA85QaM+YQEz7YE9nenbM/tVPG4IOAtB//BxgKj9cnHbOzufA
         1JWI18DBE+1ykQ356UFzpLPrbUoU54yhy/f3ztl0oBjAJi1ELaLT7xonydEx1I5LQDku
         PwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488192; x=1698092992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwRWv8WzXK7ulsIjQYcQ2H5E6aNrsXzP3LLjUnpeYMY=;
        b=ghIEC6I+2wJ/fYvnOCJdmWkxs5g9bMV7Wzxlhgv8220zUxhco9rPQjCGKzR1HqxGU7
         mMZKpWTRloxXlz81+WoNnP2ta0VcUJf5IbRL0tWh4QT0Knwam0EeGaGoFHr112HWGPxF
         XRqEEeX9ArBMxIYD7pZ+j4Xzf9/0ofKTi6eqyfESkE05nYgX0Gq6v7T7ztLafTAu7lry
         +6rIhD/Kiiah8nlYMijEzy8PnZbg1V/J4UWQAZ3BcJwrTlkk6GRbcQlIUckberLjalZg
         nVAz4Y9lLOZmffLhqsZgGZSyVf+4HF+6cCCoQYlH43J7Jw1cgiPpnAIjovxdVrzuPb1J
         6Ijg==
X-Gm-Message-State: AOJu0Yw68WQ/gx2IlgDNCKwETA4NdbZgeABjPHeHkNU0e8Isu8pQI9ND
        JCHUptFVpjs9Q/EAIq1l7g==
X-Google-Smtp-Source: AGHT+IGHR6pm/ebcyjCzv/iEasWkYG4F4GvkqOo2vIn6DGhR2AerZFfF4bL0VTU13lVA7nWMfdiv1w==
X-Received: by 2002:a5d:6885:0:b0:32d:a022:8559 with SMTP id h5-20020a5d6885000000b0032da0228559mr397043wru.47.1697488191736;
        Mon, 16 Oct 2023 13:29:51 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id i5-20020adffc05000000b0032dab20e773sm73834wrr.69.2023.10.16.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:29:51 -0700 (PDT)
Date:   Mon, 16 Oct 2023 23:29:47 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Staging: sm750fb: Rename displayControlAdjust_SM750E
Message-ID: <ZS2dO4oirsQlM+TU@dorcaslitunya-virtual-machine>
References: <cover.1697400022.git.anonolitunya@gmail.com>
 <16a9ad33ef67993482da0d350d7239aee3f0dd22.1697400022.git.anonolitunya@gmail.com>
 <d4fb378f-7446-cf16-2d14-3623e313d6ac@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fb378f-7446-cf16-2d14-3623e313d6ac@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 10:22:29PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 15 Oct 2023, Dorcas AnonoLitunya wrote:
> 
> > Rename function displayControlAdjust_SM750E to
> > display_control_adjust_SM750E.This follows snakecase naming convention
> > and ensures consistent naming style throughout the file.Issue by
> > checkpatch.
> 
> The period at the end of a sentence should have a space after it.
> 
> ensures -> ensures a
> 
> Issue -> Issue found
> 
This is corrected. Thanks Julia!

> julia
> 
> >
> > Mutes the following error:
> > CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>
> >
> > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index e00a6cb31947..8708995f676c 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -14,8 +14,8 @@
> >   * in bit 29:27 of Display Control register.
> >   */
> >  static unsigned long
> > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > -			     unsigned long dispControl)
> > +display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
> > +			       unsigned long dispControl)
> >  {
> >  	unsigned long x, y;
> >
> > @@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
> >  			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
> >
> >  		if (sm750_get_chip_type() == SM750LE) {
> > -			displayControlAdjust_SM750LE(pModeParam, tmp);
> > +			display_control_adjust_SM750LE(pModeParam, tmp);
> >  		} else {
> >  			reg = peek32(CRT_DISPLAY_CTRL) &
> >  				~(DISPLAY_CTRL_VSYNC_PHASE |
> > --
> > 2.42.0.345.gaab89be2eb
> >
> >
> >
