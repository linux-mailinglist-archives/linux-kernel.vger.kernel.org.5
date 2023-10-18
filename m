Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10A37CE7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjJRTjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjJRTi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:38:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E611F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:38:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf55a81eeaso50065055ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697657937; x=1698262737; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbWpIm78ki4Fx1nMnnk18t9z2vykmSJma0XrCQOyKmQ=;
        b=PhbC3zvsbqSnCKVVVmQ+ve5EGfJkRVPMGtOEBQYCtp95cBPlAQ9EgXGlPDngkVhF4a
         VtlEFeeIgBzsNzQG7QPYBNlMouM25sPpLvd6isdInCOwW3Bu/9SUBnJNgq1r3BKMMpsy
         hfjg3BI+bFDPypvEANylJthpQp+p/cHxMPNmbe7SBkgewbR3IjKKUG/l2KCnVtXgFmHI
         VmGzPr1kQpFbwpUGcW2oWoWT5lNVVOEezRX8lGlIVD56ZDxgtcf9Sz1JXe75/4RBaDY0
         nMZ2gYblEIdcPWkhnTOSrjSv8ZRL4hF1uIMwtLqxBG+sSouo5VD1+WhWL26mTuxFPWJi
         3v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657937; x=1698262737;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbWpIm78ki4Fx1nMnnk18t9z2vykmSJma0XrCQOyKmQ=;
        b=X7NtlMkZiQrk22Y+/h4doPu0uMDtK/YUA5elKxmxFeR5/U4C9k5EXcGsX+hfUCObHe
         kIX4mxQCR68TW8pkGaAur8/ZknjUVKxF8ymmyhvMYaq7H1+en2ypPf2B20pfcMERjYED
         msw5tvr8gSRq0sAOyqDyH0yak/C8/s5+vb51Li0DXaPeNUgSaC32nlv97SNNXVDbqat7
         pOnv8O3odYQ9RM2xzOkcb1mFLJdc2lMTTdAYwso3P9lWgNoPdmbieSOi97SFI5xO3tyj
         v0cZH3ej7gyI8AJhtHcM3bmm/MKtGRpY+qfEkZfYg1g7xZbzC4ddnP2LJnrAGFQYvR9J
         TBVA==
X-Gm-Message-State: AOJu0YxyV3a90NWgyg7jQ4CDLr4cNWG58aizKtJ483u40ThtAEq4IYG9
        fFaljjooObYxg7dDTPw39Mg=
X-Google-Smtp-Source: AGHT+IGgVp5pZFDv7wfoIE5v7AmWPBT6HKlAlspyxnuNXWtvyCdJ3FtLj6kP9CH2Gk3zoAYZAe58Qw==
X-Received: by 2002:a17:903:2305:b0:1c8:9d32:3396 with SMTP id d5-20020a170903230500b001c89d323396mr332383plh.60.1697657937180;
        Wed, 18 Oct 2023 12:38:57 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090282c800b001b896d0eb3dsm311044plz.8.2023.10.18.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:38:56 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:38:56 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <20231018193855.GA32553@Negi>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
 <2023101823-unhidden-draw-d68c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101823-unhidden-draw-d68c@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Oct 18, 2023 at 03:26:07PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 09:36:32PM -0700, Soumya Negi wrote:
> > vme.c uses printk() to log messages. To improve and standardize message
> > formatting, use logging mechanisms pr_err()/pr_warn() and
> > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > messages during replacement.
> > 
> > Issue found by checkpatch.pl
> > 
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
> >  1 file changed, 94 insertions(+), 81 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > index 6519a7c994a0..e8c2c1e77b7d 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -9,6 +9,8 @@
> >   * Copyright 2004 Motorola Inc.
> >   */
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> No, this is a driver, as others have pointed out, always use dev_*()
> calls instead.

Some of the pr_ fns can be dev_, but I don't think all can.
e.g. device NULL-check error messages

Also, there are portions of the driver where we have no access to
any 'struct device' to feed into dev_.

> Yes, that means that sometimes you do need to propagate the proper
> device to the function, but that's ok, it's the correct solution here.

Got it. In v2, I'll make pr_*() to dev_*() wherever possible. In most cases, 
the VME bridge device is accessible or if not we can get it using find_bridge().

Thanks,
Soumya
> thanks,
> 
> greg k-h



