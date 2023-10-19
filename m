Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91277D0374
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjJSUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjJSUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:55:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FAD7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:55:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso143383b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697748941; x=1698353741; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbXLmjJs4tDfsTjbZlYEpWsUipeZmvWuN4h1mPUkDJ0=;
        b=ZOi7CXqhJsiv9A5OCuhNTJmx79o2Q/ApOQXzoIsoAdbAVL3Qwu+lK0sOj0WOM8ZFgh
         xV3GZt0qEQpZ0ZqDpG5zw7xhZbAdCgofF0MPS86WT/4G5M8CGXXDacJCu9KbX1oLRamJ
         bx3Bs+DciM+voQwx6bCmI6nnxwT/NSt0a/jqGp4u+P12z9kDCjNLSep55qPbcPNe2uSL
         c9I6mN2NhpR379wvjp2EgCwnSAi3Bk88sYqk0U3eCTMu+k90g2IZcVwBXyP29CcJsoc8
         c1Q0MpJnxiSuxMmEyryIVEP26ipKhPZp0RNf6brAiOsbd0E502KPPcxlYg7Wp9ABnuDI
         e4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697748941; x=1698353741;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbXLmjJs4tDfsTjbZlYEpWsUipeZmvWuN4h1mPUkDJ0=;
        b=dhZkxQjvPWVTWpgn8iuwU5lF9K3oUB+X8OzAHdUmr7OFm+Vn0noZXVCvfevESZjwHS
         cRnYDv8Q0maIXPzP3xpo4kFPSCFDyltFEiyxOVplF9hD4LEeBwpYfjqLJ2aDwoJOXjYc
         kdSaJ7um/8FAekKP7TaewUiwYIdmhs+hjUFZEkHD/J0ngcWUVLNQQ/NMb0nPPaKLrI5c
         6WagNyydIH8Vrtf+9F4UTLBEF7zEu47RuObK+FIeXBP0klaagOSpW8pWgt3iSgsRWm2R
         UgIUt9yG7+P9oSuhvkklqPbDlHjzCw9uZK/r4ShMTQFdXwqoFYNMOa69IJyrOI3v8l7E
         GWBQ==
X-Gm-Message-State: AOJu0Yx1lCapGEixgn/5SRl5Im3SSDi02nbZCXAO3ugGLSzQqg/j/NzW
        sYeXRzKv7hqwSffEo0FXW4I=
X-Google-Smtp-Source: AGHT+IH7Gs2YuSv4uXr04F6lQ+npE/GpevyFYc7uZJwJ5aXaB5RN8oXxxiVdsBQ8DsgKo/v/cXQFWQ==
X-Received: by 2002:a05:6a20:7486:b0:17a:fa76:805f with SMTP id p6-20020a056a20748600b0017afa76805fmr3692636pzd.23.1697748940668;
        Thu, 19 Oct 2023 13:55:40 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090aec1200b0027dc2af3a17sm1974326pjy.27.2023.10.19.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 13:55:40 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:55:39 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <20231019205539.GA3017@Negi>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
 <2023101823-unhidden-draw-d68c@gregkh>
 <20231018193855.GA32553@Negi>
 <2023101925-kudos-playful-7c5a@gregkh>
 <20231019190618.GA29750@Negi>
 <2023101941-poncho-disagree-8c77@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101941-poncho-disagree-8c77@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:42:26PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 12:06:18PM -0700, Soumya Negi wrote:
> > On Thu, Oct 19, 2023 at 05:34:01PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 18, 2023 at 12:38:56PM -0700, Soumya Negi wrote:
> > > > Hi Greg,
> > > > 
> > > > On Wed, Oct 18, 2023 at 03:26:07PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Tue, Oct 17, 2023 at 09:36:32PM -0700, Soumya Negi wrote:
> > > > > > vme.c uses printk() to log messages. To improve and standardize message
> > > > > > formatting, use logging mechanisms pr_err()/pr_warn() and
> > > > > > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > > > > > messages during replacement.
> > > > > > 
> > > > > > Issue found by checkpatch.pl
> > > > > > 
> > > > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
> > > > > >  1 file changed, 94 insertions(+), 81 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > > > > index 6519a7c994a0..e8c2c1e77b7d 100644
> > > > > > --- a/drivers/staging/vme_user/vme.c
> > > > > > +++ b/drivers/staging/vme_user/vme.c
> > > > > > @@ -9,6 +9,8 @@
> > > > > >   * Copyright 2004 Motorola Inc.
> > > > > >   */
> > > > > >  
> > > > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > 
> > > > > No, this is a driver, as others have pointed out, always use dev_*()
> > > > > calls instead.
> > > > 
> > > > Some of the pr_ fns can be dev_, but I don't think all can.
> > > > e.g. device NULL-check error messages
> > > 
> > > I would argue that those are pointless and can be removed and also the
> > > check is probably not needed either.
> > 
> > Got it. The pr_() in find_bridge() can't be converted to dev_ so I'll remove 
> > the message entirely in another patch.
> > 
> > I understand that the device-NULL checks should be done on the caller's side. 
> > Since empty devices would mean something went wrong, would it be better to
> > put in an assertion(..WARN_ON) when removing the check? 
> 
> WARN_ON() means "I have no idea what can happen here so I give up",
> which is not a good idea in kernel development.  If that every hits,
> then your machine will reboot as the huge majority of all Linux systems
> in the world run with panic-on-warn enabled.
> 
> If it is impossible for something to happen (i.e. you control all
> callers) then just do not check for it.  If it happens, you will get a
> NULL-dereference which is the same as a WARN_ON() in a way.
> 
> No new WARN_ON() should ever be added to the kernel, especially in a
> driver.  Handle the condition if it is possible to be hit.  If it can
> never be hit, don't even check it.
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thank you for explaining in detail. I'll remove the device NULL-checks
completely.

Regards,
Soumya


