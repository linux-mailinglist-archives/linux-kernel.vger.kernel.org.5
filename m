Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F407C8935
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjJMP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjJMP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:56:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA37BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:56:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40776b1ff73so2395265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697212572; x=1697817372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeV8mwVr2qqt0AVCLeJMQI/U6jyncSF2xLGT0JjXz0w=;
        b=FxWwk9Z0FpE7p5jN4moR/+DRbYUVegMYPJ72smoVyz2Ano5UdwvT0fQ7hg8HFCL2YS
         p11T/dx+D5XtreuOV9c2R6kLnOoJMC4NLpaobY+/gjfokJwCkTQUrxUOZ38yhqCojsCY
         atGHqyj5iEokuZ3P+rJkrrw+awQB8ts9mx/rk1Zow/i0LaKl7JWJ27JwLQWDKm9AHb4m
         cJgJVQA3KfRJLi2/cSrc9HRzGnz4u5+nyW5DgB0mNB8m4MTTl5DsMz/Yz0HlEJK7yAy/
         lYFandeMPYTwnoFCouH1r0fbEH3SYBYQoNYdbRDQTtyG58JlEI1HQZNmw2Tj8kIPXHFe
         AfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212572; x=1697817372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeV8mwVr2qqt0AVCLeJMQI/U6jyncSF2xLGT0JjXz0w=;
        b=U3yViR2lHXGxLa0uOyoOPcWTYHlE6wY0fU1hUxpDRPkThmjklf5NdZMlDzgjozgDP0
         V1MTWuzjhsAzvvjsIVof2NefWIAz21GKRSkM3q76GqsJ/EzSHqftyWefMncG4Vm5gwkE
         9n3HAkRMLSKx/u3TsRX1scAzBDLqF/wy/gk9/R/sgQTZ06/XCJ9fUb6ypgq9eVot0Mck
         wb4FLabatNoUkih+kg1BPE6RKGyuje1Eq4mGiYx/SeAVwzl2VJ/ueryyJY7CMgcYW8p1
         8C17oS6QA2QTIvzpepRNmf7nC0e2flw5KMN7kzGDovklAjlhp4zTkas934ubaCLfJJ3x
         xfdQ==
X-Gm-Message-State: AOJu0YyTfx16waIeDfem+cwopfTKHs/3o86JEpduKIGPYIQASzXHBwRO
        Q1sGyaxD0TVtZbRfGeKtTC2sZQ==
X-Google-Smtp-Source: AGHT+IGxYfzD8CnnGBJcwffwT+sLmo1TXKCJR1s8yImxg5JTv+J2FYJjyguZrzqOBGPE6zRTrmNnoA==
X-Received: by 2002:a1c:6a0c:0:b0:404:757e:c5ba with SMTP id f12-20020a1c6a0c000000b00404757ec5bamr22625270wmc.26.1697212572018;
        Fri, 13 Oct 2023 08:56:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003fe1fe56202sm518136wmq.33.2023.10.13.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:56:11 -0700 (PDT)
Date:   Fri, 13 Oct 2023 18:56:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dorcas Litunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH]Staging: sm750fb:Add snakecase naming style
Message-ID: <780713a6-5f93-4393-a46d-36904e7fbd11@kadam.mountain>
References: <20231013104220.7527-1-anonolitunya@gmail.com>
 <efcb4734-0349-493e-be93-b95381eb6c78@kadam.mountain>
 <ZSkq7E+Tp1X/qiER@dorcaslitunya-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkq7E+Tp1X/qiER@dorcaslitunya-virtual-machine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:33:00PM +0300, Dorcas Litunya wrote:
> On Fri, Oct 13, 2023 at 01:48:08PM +0300, Dan Carpenter wrote:
> > On Fri, Oct 13, 2023 at 01:42:15PM +0300, Dorcas AnonoLitunya wrote:
> > > From: Dorcas Anono Litunya <anonolitunya@gmail.com>
> > > 
> > > Change camelCase variables in file to snake_case for consistent naming
> > > practices. Issue found by checkpatch.
> > > 
> > > Signed-off-by: Dorcas Anono Litunya <anonolitunya@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_mode.c | 86 +++++++++++++--------------
> > >  drivers/staging/sm750fb/ddk750_mode.h |  2 +-
> > >  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
> > >  3 files changed, 45 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > index e00a6cb31947..f08dcab29172 100644
> > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > @@ -14,13 +14,13 @@
> > >   * in bit 29:27 of Display Control register.
> > >   */
> > >  static unsigned long
> > > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > > -			     unsigned long dispControl)
> > > +display_control_adjust_SM750LE(struct mode_parameter *p_mode_param,
> > 
> > The p stands for pointer.  We don't like that naming style.  Just call
> > it mode_param.
> > 
> > Thes are the renamed things.
> > 
> > displayControlAdjust_SM750LE => display_control_adjust_SM750LE
> > pModeParam => p_mode_param
> > dispControl => disp_control
> > programModeRegisters => program_mode_registers
> > ddk750_setModeTiming => ddk750_set_mode_timing
> > 
> > I feel like this would be better broken up probably into one variable
> > per patch.  It's jumping around between files.  These variables are not
> > closely related.
> Thanks for the feedback Dan. I will revise to do one variable per patch.
> 
> However,I have an inquiry the main reason its jumping between files is because one of the
> functions I am modifying(the ddk_set_mode_timing) is imported and used
> in other files. In this case, should I do one patch per variable per
> file?

No that would break the build...

It's just that I felt that in this case it's especially useful to
break it apart because some of them affect multiple files and some of
the variables are local to a given function.  (You should still adjust
the header file to match even though the compiler doesn't care).

regards,
dan carpenter

