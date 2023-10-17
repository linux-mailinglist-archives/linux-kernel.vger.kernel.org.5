Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC47CCB03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjJQSrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:47:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9472F7;
        Tue, 17 Oct 2023 11:47:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c50b7c36so632398e87.3;
        Tue, 17 Oct 2023 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697568450; x=1698173250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmICwmBoI0nNKZqKDeA/2U9n80tXqZ7792F42uyLv0o=;
        b=h/yAWvQVS+SpbUYMTI/CcvRdyrfLRnBB5L0QU1gMaa/+aCbL6f/VUyVRlfE8yC792h
         7jvMHwxvaVsF9Gv5Bln8FQ7RyRCLhlenPeTs9WF+16yl3ZTyWAXVjhE/e5CrYwkhTscl
         04sDCsWfn4m8w2OEWqHtKgRgxWQ49XzH4hrUO9W+XE+CF5R5+lZR1lQBmjVxKClS6QkX
         RElK3Pr5CL1+YKejz2tcQHBRPebWbJFlM0fEV/z8U3DFUMq85eUPng3Ro4Scd0q1AGvO
         sSLGSKGxFVNT6ej4APCa7kcK65OF4GvVqdMjBz6U19eTixzfnOfSXGuWt+xVQkMBC9mo
         QODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568450; x=1698173250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmICwmBoI0nNKZqKDeA/2U9n80tXqZ7792F42uyLv0o=;
        b=u6oUm0N3alqGMe9Fnz+DuFXOikskYsStPeJ6eBQGEybUA/jBRz8g+qWbjhsLxeXUlZ
         ZnRkhKnarOjmwydfcq3DoGNWqKaD+06QydJrMQ5OYfahP3RL7IcSaXGbQSFGt3VNRp41
         MeNYpZBa5Fpbt2qhjuWfPmUMX2AGwuBBTxoWEFzlEoI7NLBAEJAqnV3XWo4ttEgZeijZ
         Lxlnfze0U8rSObaUTHMJaAq3fpChpVSGjbwz9wtKDvF/EDvyfjPoISjG1Lr9BaGP2EEq
         gclaMoWmIf4INZFAlfeFkDjA5Dvbf/UZ7SpKgBmfg100sDfUZoBOsYDfpvpAY8mgosqw
         mEXQ==
X-Gm-Message-State: AOJu0YwLfcgRXXEVBev53Gw7p0FFQBhEvklC3VxCQDlRomGGX2mZxE7q
        B9jfWW9dxGX8q5Bjs1bHYw==
X-Google-Smtp-Source: AGHT+IESZslQNyusElFBWo5mcRJLUnBIRNn71W/9mZybzHHY5GQR5etWw70lNAmSc1d5t4t4sq4ExQ==
X-Received: by 2002:ac2:4206:0:b0:507:a16d:6699 with SMTP id y6-20020ac24206000000b00507a16d6699mr2208709lfh.13.1697568449638;
        Tue, 17 Oct 2023 11:47:29 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.158.206])
        by smtp.gmail.com with ESMTPSA id ee16-20020a056402291000b0053e8f1f79afsm1635197edb.30.2023.10.17.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:47:29 -0700 (PDT)
Date:   Tue, 17 Oct 2023 21:47:25 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
Message-ID: <ZS7WvaM65awtILqk@dorcaslitunya-virtual-machine>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
 <2023101724-diagram-legwork-0e53@gregkh>
 <ZS5FlsCPETnr8T5D@dorcaslitunya-virtual-machine>
 <2023101712-grudge-overtime-1f43@gregkh>
 <ZS5JexVUSKZUuOd4@dorcaslitunya-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5JexVUSKZUuOd4@dorcaslitunya-virtual-machine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:44:43AM +0300, Dorcas Litunya wrote:
> On Tue, Oct 17, 2023 at 10:34:43AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 17, 2023 at 11:28:06AM +0300, Dorcas Litunya wrote:
> > > On Tue, Oct 17, 2023 at 09:50:50AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> > > > > Rename function displayControlAdjust_SM750E to
> > > > > display_control_adjust_SM750E. This follows snakecase naming convention
> > > > > and ensures a consistent naming style throughout the file. Issue found by
> > > > > checkpatch.
> > > > > 
> > > > > Mutes the following error:
> > > > > CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>
> > > > > 
> > > > > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > > > > ---
> > > > >  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > > > index e00a6cb31947..8708995f676c 100644
> > > > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > > > @@ -14,8 +14,8 @@
> > > > >   * in bit 29:27 of Display Control register.
> > > > >   */
> > > > >  static unsigned long
> > > > > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > > > > -			     unsigned long dispControl)
> > > > > +display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
> > > > > +			       unsigned long dispControl)
> > > > >  {
> > > > >  	unsigned long x, y;
> > > > >  
> > > > > @@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
> > > > >  			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
> > > > >  
> > > > >  		if (sm750_get_chip_type() == SM750LE) {
> > > > > -			displayControlAdjust_SM750LE(pModeParam, tmp);
> > > > > +			display_control_adjust_SM750LE(pModeParam, tmp);
> > > > 
> > > > Why is this function returning a value if it is just being ignored?
> > > > 
> > > > It's not the issue here in the patch, but for future changes.
> > > >
> > > Hi Greg,
> > > 
> > > I will do the correction in the next patchset to correct both functions
> > > return value as this patchset was not focused on that. Does this mean
> > > that this patchset has been accepted? Or should I submit another
> > > patchset that includes the two changes suggested on function return
> > > values?
> > 
> > You'll get an email from my system when it is accepted, wait a day or so
> > before worrying about that.  And then send new patches on top of them
> > then.
> > 
> Thanks for the clarification Greg. I will wait for the confirmation
> email from your system then send the new patches shortly afterwards.
> 
> thanks,
> Dorcas
> > thanks,
> > 
> > greg k-h
Hello,
 I have realised there was an error in the commit message subject and body for this patch. I had put "Staging: sm750fb: Rename displayControlAdjust_SM750E" instead of "Staging: sm750fb: Rename displayControlAdjust_SM750LE".I had forgotten the L in SM750LE. I have modified the commit message using git commit --amend to correct the mistake. I have seen the patch has been accepted, however, I am not sure whether the change in the commit message will reflect once the patch is merged. Please guide on what to do next. I am really sorry for the inconvenience.

 Best,
 Dorcas
