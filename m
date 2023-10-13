Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5097C8965
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJMQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJMQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:00:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30293DA;
        Fri, 13 Oct 2023 09:00:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so2125652f8f.1;
        Fri, 13 Oct 2023 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697212830; x=1697817630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfHYWVeXZkEiH4m2tnI9YIZClF3r0QNLYgJ4gF7eXfw=;
        b=Yq+AFrj3I5yVJKkE1z4T+SeuVnlBGvp1vcc4DeispRSIi22CNiOOk8ObJVf2E2zrCe
         E2WhQop1XZu9G4w+Y9zp3E7Xkw4omu2cJ87ZFRvH2DJVRPX5s3tqf9ARfJ9PQHMwq+jP
         19ebT4OaZI2hTFOA+MjIz5TayqmyMWne7VHmB17A3xFEA9ytseO7lxjg3jFPtXEdka62
         b0v4Oh5u0mnIRaNE3qFJ6YP2tW6xjEF7fKdQ+F5aCPyu2pBOSrK+M67fji2aufas9LJN
         xGUYigfVyr8NwIhCxdAvF7Wd15sj6utBSRPnRFeBb7n66snsvX8C9ELwx3myOnZH7XN+
         9B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212830; x=1697817630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfHYWVeXZkEiH4m2tnI9YIZClF3r0QNLYgJ4gF7eXfw=;
        b=bPzw931cKS8OQH21dhELB/3bPjP6CsjNNHsO++T/s7bBoF7achqDs6fjBbM+XQQBpQ
         cOQI3CZN1RF5Jt9lOIiP3iJgJkWypYIYDdwtDKrBlCXwyOt/IwXSPGULvaZszCEHg/PP
         h2Q3+igPsB+UnMfenrYRE8sANtRjBvF76NPUj5cdF1T5GiYJvOk0DP6gAX6T/pXy+wBa
         NkHsd01PQLs0ou/zLhTz5PmBIGkWoQKSkdgUyfg2caykbzzGvc50Pc+7MPYa4oOGEWYR
         L2c2IX5gHt7X+Of8Bau9Y/jd0vgOPnk+gpY7KsmlOi8EgRhFKhLo/2D6WF4rBQRKGyTv
         kUAg==
X-Gm-Message-State: AOJu0YxVVECSbMlzEUykl8pF5DoVx/4Ci5gZwsuRIGqVtzDtMvlABKzG
        6wGJlIOYG2BJr8aI0NuQKA==
X-Google-Smtp-Source: AGHT+IE9zHwK80IGz+wxOh5k8G7VLdRI3RWJZuSCCA/9uDwewxsetoyv6NSUV20Yjmp/N3IitbftZA==
X-Received: by 2002:a5d:4586:0:b0:321:5e2f:37e1 with SMTP id p6-20020a5d4586000000b003215e2f37e1mr23336167wrq.19.1697212830200;
        Fri, 13 Oct 2023 09:00:30 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.2.146])
        by smtp.gmail.com with ESMTPSA id iv10-20020a05600c548a00b0040472ad9a3dsm516532wmb.14.2023.10.13.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:00:29 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:46:04 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH]Staging: sm750fb:Add snakecase naming style
Message-ID: <ZSkt/B+hyDmOoocF@dorcaslitunya-virtual-machine>
References: <20231013104220.7527-1-anonolitunya@gmail.com>
 <efcb4734-0349-493e-be93-b95381eb6c78@kadam.mountain>
 <ZSkq7E+Tp1X/qiER@dorcaslitunya-virtual-machine>
 <780713a6-5f93-4393-a46d-36904e7fbd11@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <780713a6-5f93-4393-a46d-36904e7fbd11@kadam.mountain>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:56:08PM +0300, Dan Carpenter wrote:
> On Fri, Oct 13, 2023 at 02:33:00PM +0300, Dorcas Litunya wrote:
> > On Fri, Oct 13, 2023 at 01:48:08PM +0300, Dan Carpenter wrote:
> > > On Fri, Oct 13, 2023 at 01:42:15PM +0300, Dorcas AnonoLitunya wrote:
> > > > From: Dorcas Anono Litunya <anonolitunya@gmail.com>
> > > > 
> > > > Change camelCase variables in file to snake_case for consistent naming
> > > > practices. Issue found by checkpatch.
> > > > 
> > > > Signed-off-by: Dorcas Anono Litunya <anonolitunya@gmail.com>
> > > > ---
> > > >  drivers/staging/sm750fb/ddk750_mode.c | 86 +++++++++++++--------------
> > > >  drivers/staging/sm750fb/ddk750_mode.h |  2 +-
> > > >  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
> > > >  3 files changed, 45 insertions(+), 45 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > > index e00a6cb31947..f08dcab29172 100644
> > > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > > @@ -14,13 +14,13 @@
> > > >   * in bit 29:27 of Display Control register.
> > > >   */
> > > >  static unsigned long
> > > > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > > > -			     unsigned long dispControl)
> > > > +display_control_adjust_SM750LE(struct mode_parameter *p_mode_param,
> > > 
> > > The p stands for pointer.  We don't like that naming style.  Just call
> > > it mode_param.
> > > 
> > > Thes are the renamed things.
> > > 
> > > displayControlAdjust_SM750LE => display_control_adjust_SM750LE
> > > pModeParam => p_mode_param
> > > dispControl => disp_control
> > > programModeRegisters => program_mode_registers
> > > ddk750_setModeTiming => ddk750_set_mode_timing
> > > 
> > > I feel like this would be better broken up probably into one variable
> > > per patch.  It's jumping around between files.  These variables are not
> > > closely related.
> > Thanks for the feedback Dan. I will revise to do one variable per patch.
> > 
> > However,I have an inquiry the main reason its jumping between files is because one of the
> > functions I am modifying(the ddk_set_mode_timing) is imported and used
> > in other files. In this case, should I do one patch per variable per
> > file?
> 
> No that would break the build...
> 
> It's just that I felt that in this case it's especially useful to
> break it apart because some of them affect multiple files and some of
> the variables are local to a given function.  (You should still adjust
> the header file to match even though the compiler doesn't care).

Makes more sense. I will work on that. Thanks!
> regards,
> dan carpenter
> 
