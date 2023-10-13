Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27257C8912
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjJMPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjJMPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:47:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D904BB;
        Fri, 13 Oct 2023 08:47:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405524e6768so22954355e9.2;
        Fri, 13 Oct 2023 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697212045; x=1697816845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2myRePQeeuTuk2eA5QtfCramI6KhbCaOjS+i8SpwN1M=;
        b=F4gHhYHshkEcK6OvM+lt8hzv+fQXSeFSArFF6AgT7pNc5AvxU/BMxvYAutbxnIeZAP
         aJO4oq+7LYeBcXWceF+wMUarHgBgPPVrCr5B755IBIsDOX8SV/oOlBX5iHDU/3/B8L87
         c2nJurs+TiGa5Vlkprqu2x8BejPf9/5L6bDjdWcwYX2oCTKAyRJi58+zKrpi1ytI6nxL
         d59Af885xgfm48lqjxe/akF4Ha4eXNuoi784b/e/5zJoLVclpfGn+EQHFx3AJUiBCfsH
         vlcAn8Sr1LThqWcNnm/LhI9lDvKmm0CwEouDC0lcAcfw8j5OZS/3bD+ox5ek3IcBUZV2
         46zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212045; x=1697816845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2myRePQeeuTuk2eA5QtfCramI6KhbCaOjS+i8SpwN1M=;
        b=G0Rx5RtDOO4w9onZcgqZgpHK+2PgVba6VRFkChr7i0IVaLm8C+mpnODJgVUMlSeI6W
         tnh2x/wqobyIM1Oy4EYIy4pHzFm1s/qKLZe86LIetQcuIXPS/sFEEE1rOSECf+Ckwn/D
         ZH0iw/cz6TBcQ1To+mWPjZz1VH4ubEHpBWRtI+Wnpdr/W5PS+MWF7HsT0RgzWBTRaG7w
         8/qh+DwxhhQDAG0wT/1oK13LVY+X3SN7PORUpDi2xccq0gmkZSiDy+zZT1ureK57mbPR
         0C6L8+GM8lPUe74XiYn2yP3znOBdDF80p8bHw0sj8hHvZvf3G90qvy+p/0NXGzTpF8/K
         0XDw==
X-Gm-Message-State: AOJu0Yy10rxKy4yeirlmdsoEC9u8kBYrrXy7MDTg+u528gGlbUfJqJHU
        iTxIyzpaOiZUReiSq3hqZg==
X-Google-Smtp-Source: AGHT+IHVPlrWh5nASz+RRHnYgLg3aaWH5K6BC+qkxPvceyjzWEkFtppG7oj2xgn8qnh4ZqjuEZcrHQ==
X-Received: by 2002:a05:600c:230d:b0:401:dc7c:2494 with SMTP id 13-20020a05600c230d00b00401dc7c2494mr25645224wmo.27.1697212044179;
        Fri, 13 Oct 2023 08:47:24 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.2.146])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c199000b00403b63e87f2sm469748wmq.32.2023.10.13.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:47:23 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:33:00 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH]Staging: sm750fb:Add snakecase naming style
Message-ID: <ZSkq7E+Tp1X/qiER@dorcaslitunya-virtual-machine>
References: <20231013104220.7527-1-anonolitunya@gmail.com>
 <efcb4734-0349-493e-be93-b95381eb6c78@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efcb4734-0349-493e-be93-b95381eb6c78@kadam.mountain>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:48:08PM +0300, Dan Carpenter wrote:
> On Fri, Oct 13, 2023 at 01:42:15PM +0300, Dorcas AnonoLitunya wrote:
> > From: Dorcas Anono Litunya <anonolitunya@gmail.com>
> > 
> > Change camelCase variables in file to snake_case for consistent naming
> > practices. Issue found by checkpatch.
> > 
> > Signed-off-by: Dorcas Anono Litunya <anonolitunya@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 86 +++++++++++++--------------
> >  drivers/staging/sm750fb/ddk750_mode.h |  2 +-
> >  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
> >  3 files changed, 45 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index e00a6cb31947..f08dcab29172 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -14,13 +14,13 @@
> >   * in bit 29:27 of Display Control register.
> >   */
> >  static unsigned long
> > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > -			     unsigned long dispControl)
> > +display_control_adjust_SM750LE(struct mode_parameter *p_mode_param,
> 
> The p stands for pointer.  We don't like that naming style.  Just call
> it mode_param.
> 
> Thes are the renamed things.
> 
> displayControlAdjust_SM750LE => display_control_adjust_SM750LE
> pModeParam => p_mode_param
> dispControl => disp_control
> programModeRegisters => program_mode_registers
> ddk750_setModeTiming => ddk750_set_mode_timing
> 
> I feel like this would be better broken up probably into one variable
> per patch.  It's jumping around between files.  These variables are not
> closely related.
Thanks for the feedback Dan. I will revise to do one variable per patch.

However,I have an inquiry the main reason its jumping between files is because one of the
functions I am modifying(the ddk_set_mode_timing) is imported and used
in other files. In this case, should I do one patch per variable per
file?

Dorcas

> 
> regards,
> dan carpenter
> 
