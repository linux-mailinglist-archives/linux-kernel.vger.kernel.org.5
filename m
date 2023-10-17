Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154467CBE05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjJQIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:44:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600EB0;
        Tue, 17 Oct 2023 01:44:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53406799540so9398471a12.1;
        Tue, 17 Oct 2023 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697532288; x=1698137088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmsMFOzw6DDo4sGJW291xAQW+LN+HB2lb3S1lOiqLbM=;
        b=hI6F8h2N1tpTOg0I47qrHXLoz24at9Q8PLwHDvX7G14JiJLSffdXUbBnVe+oIGJ8TR
         HHSCUBL7PnbBY92iSj/RRXw7h2T5X/GGudg1aaqW/c1cv4VGzHII+FLqqPwan3bN05+K
         awZ8i/OZvBwLatMDEC/ebpS9rImvdZPbQ/5r/O01cq7AHHLhXeLDtwd6cJzYZcup1hS4
         Cx1unPb1B4GfkvM8uF3PqhCvMhI7CTphGYuT7Tg1dF9CUPwljIyHjYKh0+neYi1G80Ed
         /6JtKVO3Fuc+0qoetvafmtrUrWPRo8+yQyYdouuV05mQghDOA4Edi1dnW0FpemXwq3Ww
         sRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532288; x=1698137088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmsMFOzw6DDo4sGJW291xAQW+LN+HB2lb3S1lOiqLbM=;
        b=b8/8atcKLfD9NhxNMjF/n4xrV9ADzskS5qyUg01LnmLLbe/MEJ5xE0Hby01yCf8oIt
         pjO+KF9gRlaydfsIUMlJuZIz1pdirbJ0ose8jqoEI1hXEeFecxkvhuXHdRFExh95lq0P
         wXzM0Rs9P4QU9GdRRIik/vjYe2Bkk9C6pNGQwdOUsjp8eN1qG5PrzsFGeAYp2klpurcn
         yXtigdL8TimRqYdgTCSntXgurYFcU325m+AAxOPa7+ZlC04SdPofjkg1xBwLyRpZTHvx
         toSNc5dPJBseiEgI/fFLabBlKwtv8MjB85xMaDZ6nL0ItYboKrrMEKy+ZcyyB/TX0FEN
         brxw==
X-Gm-Message-State: AOJu0Ywj/cRpZ24vFtGAoRlpyQ3bZutJoCjodVzqlzN9Yffysj1WQaeq
        f8MGiI3sKHTRjZ7qHeaGUg==
X-Google-Smtp-Source: AGHT+IH2TV8UJJYGPgu8FKx2WW718cPP7gAnkKjdnAT4ZmDMZY3hyupZUlDoPIAfIaxXivSpi3Hzjg==
X-Received: by 2002:a05:6402:40d0:b0:53e:2af1:e966 with SMTP id z16-20020a05640240d000b0053e2af1e966mr1533871edb.1.1697532287453;
        Tue, 17 Oct 2023 01:44:47 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b0053e408aec8bsm813926eda.6.2023.10.17.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:44:47 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:44:43 +0300
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
Message-ID: <ZS5JexVUSKZUuOd4@dorcaslitunya-virtual-machine>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
 <2023101724-diagram-legwork-0e53@gregkh>
 <ZS5FlsCPETnr8T5D@dorcaslitunya-virtual-machine>
 <2023101712-grudge-overtime-1f43@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101712-grudge-overtime-1f43@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:34:43AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 11:28:06AM +0300, Dorcas Litunya wrote:
> > On Tue, Oct 17, 2023 at 09:50:50AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> > > > Rename function displayControlAdjust_SM750E to
> > > > display_control_adjust_SM750E. This follows snakecase naming convention
> > > > and ensures a consistent naming style throughout the file. Issue found by
> > > > checkpatch.
> > > > 
> > > > Mutes the following error:
> > > > CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>
> > > > 
> > > > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > > > ---
> > > >  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > > > index e00a6cb31947..8708995f676c 100644
> > > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > > @@ -14,8 +14,8 @@
> > > >   * in bit 29:27 of Display Control register.
> > > >   */
> > > >  static unsigned long
> > > > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > > > -			     unsigned long dispControl)
> > > > +display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
> > > > +			       unsigned long dispControl)
> > > >  {
> > > >  	unsigned long x, y;
> > > >  
> > > > @@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
> > > >  			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
> > > >  
> > > >  		if (sm750_get_chip_type() == SM750LE) {
> > > > -			displayControlAdjust_SM750LE(pModeParam, tmp);
> > > > +			display_control_adjust_SM750LE(pModeParam, tmp);
> > > 
> > > Why is this function returning a value if it is just being ignored?
> > > 
> > > It's not the issue here in the patch, but for future changes.
> > >
> > Hi Greg,
> > 
> > I will do the correction in the next patchset to correct both functions
> > return value as this patchset was not focused on that. Does this mean
> > that this patchset has been accepted? Or should I submit another
> > patchset that includes the two changes suggested on function return
> > values?
> 
> You'll get an email from my system when it is accepted, wait a day or so
> before worrying about that.  And then send new patches on top of them
> then.
> 
Thanks for the clarification Greg. I will wait for the confirmation
email from your system then send the new patches shortly afterwards.

thanks,
Dorcas
> thanks,
> 
> greg k-h
