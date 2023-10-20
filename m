Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF57D0664
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbjJTCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346758AbjJTCOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:14:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F7115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:14:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c4b9e09521so237463a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697768049; x=1698372849; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvDKp7hGETEWZJw5WAV27rym9fjaXJFJb3QCgDpE28Q=;
        b=X3iLdymMkG0IfukecjMPMBOuYLTMcmh7Bm1+qGggrMZuQs44QrTcGb6eJb3Ng+dZx5
         1SdNsLUwH7mCCKAlsnSJIjvEZuXzsgkMlUyZzhIO4qdvKhRHU7HAa0G0jC18ABH7jPJU
         SEIBSbIfyMgJoCmHXD2ISHjZWsTF6yZ6zRYkkTMtqBh2F6knxRL0ekhEeIrn1JSUjH6H
         a7elb6hemAbz1ZsarzyQxNyTxuQAJDwh81SxkOVCAwviPv1SsK+hdHdiCqvj1yNRdtc+
         3GSQl0TknQBTPYCkqAo/OkGL/FLfEAYUpL80CTqgNGGlWnxf+OGi8/LeTDn8XDIWpcc5
         c6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697768049; x=1698372849;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvDKp7hGETEWZJw5WAV27rym9fjaXJFJb3QCgDpE28Q=;
        b=CXyBfk8m65scq/Gdxzt1UGBWUfcx92sb9t/LFu0iDM3B45MiESPV+HwF0L/9iNGL/6
         OY4adyVcJf9QyWwsH+NaF9SixtK+qQK0TR8pOcbpOYHclW/BUZrKdmVEsFy4zxfW16Ix
         tz5qs5NIYLVR6Nps95kVHarTY9PAww0TaP8elBm/O/j/DJ7/7AkMPjfxuur5GRa9cU1M
         X7AOyNZpeHfUROKLdiqdTrJI1j1Jdhz1snWCQ2Kt6IaopZjuHbKDBgx/m3DqdxLACEMW
         PTFYsB/RJVvlwp2u/QjKwof4dkCJF+WXUjib4iOfdOTlMTnSNwKdS+ibyCo0+lz7zkL4
         4i7A==
X-Gm-Message-State: AOJu0YzpYL72Bs8DTvxYCqlSqLdS0dSe5fX8ntcTDTAs5IIcroABBE8p
        aki1lWL22d1oden+PjCOSqi895Rl51hF7w==
X-Google-Smtp-Source: AGHT+IHHzT5cCsgqilYJXtUJWoq7MAjWGJO46hlMyo5MGSER1NeY0qkGafr/DU6FSi9cbq93rty10g==
X-Received: by 2002:a05:6830:60f:b0:6c4:fc6d:88fb with SMTP id w15-20020a056830060f00b006c4fc6d88fbmr579599oti.33.1697768048866;
        Thu, 19 Oct 2023 19:14:08 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id k12-20020a62840c000000b0068fb8080939sm467275pfd.65.2023.10.19.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 19:14:08 -0700 (PDT)
Date:   Thu, 19 Oct 2023 19:14:07 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: gdm724x: Match alignment with open parenthesis
Message-ID: <20231020021407.GE3017@Negi>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <ff627fcbc9e450c2e8f4aa5810b94e56151efa2a.1697184167.git.soumya.negi97@gmail.com>
 <a0a7274f-eba6-4f72-9569-ec4c4fff3a1a@kadam.mountain>
 <20231013211326.GB25352@Negi>
 <52732a88-7f40-4ce4-b75b-dded9827c1f0@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52732a88-7f40-4ce4-b75b-dded9827c1f0@kadam.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 10:38:22AM +0300, Dan Carpenter wrote:
> On Fri, Oct 13, 2023 at 02:13:26PM -0700, Soumya Negi wrote:
> > On Fri, Oct 13, 2023 at 11:57:40AM +0300, Dan Carpenter wrote:
> > > On Fri, Oct 13, 2023 at 01:26:34AM -0700, Soumya Negi wrote:
> > > > Fix CHECK: Alignment should match open parenthesis
> > > > Issue found by checkpatch.pl
> > > > 
> > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > ---
> > > >  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> > > > index 32b2e817ff04..4e5cac76db58 100644
> > > > --- a/drivers/staging/gdm724x/gdm_tty.c
> > > > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > > > @@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
> > > >  	int ret;
> > > >  
> > > >  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> > > > -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> > > > -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> > > > +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> > > > +					      TTY_DRIVER_DYNAMIC_DEV);
> > > 
> > > I prefered the original code.  It was more readable.
> > > 
> > > regards,
> > > dan carpenter
> > Hi Dan,
> > 
> > Noted. I'm curious what happens when some of the patches in a patchset
> > are acceptable and some are not. Is everything disregarded by
> > maintainers or are the good patches cherry-picked from the set?
> 
> Most of the time, you should just resend the series.  Sometimes a
> maintainer will take the first few patches and then when they hit one
> that can't be merged they'll stop.  So you should try to organize your
> patchsets from fixes first, then cleanups and then least controversial
> to most controversial.  Except people might be annoyed if it looks like
> you're hiding a really controversial one at the end of a long series.
> 
> regards,
> dan carpenter

Thank you!

- Soumya

