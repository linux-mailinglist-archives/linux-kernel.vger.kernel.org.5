Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14757765A89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjG0RiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjG0RiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:38:01 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93359D9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:38:00 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-569bad45b63so1445936eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690479480; x=1691084280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0SfZCWmWIh2WNL4AjazYD4f56u8ZIvWeRVkzgtI3H0=;
        b=XUbXtI/4j3vglCphGsXW0u8s3q1q8tJzsfJvnZiXA4PaSs0z+7nAKtSHDztADz1Fm6
         cModolNbl3PqUdVkHTqk6cQbK3muspkusA+hNSnCIOHge3dJhsc17f8LWDAjz/Oa13YE
         hc5CDHF3bXfSZSToHZA14dnK4Y9t05yYczNNOYh/hcAiwsr8OpFgbr8w+9QSaWMZq+3F
         Vxr8YtmV/r0u3PhUMV87MsdGd22kUCwzIu8Zmxbjz1CCPrhLAB2tjTGSqEUH7Nt77Hla
         64X3B70h0Vekkrf4Yf/canq+9hbyBHsteaqXvKy5kUYlZvEZ+w+g35jYgT7bHpzMHpT8
         PZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479480; x=1691084280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0SfZCWmWIh2WNL4AjazYD4f56u8ZIvWeRVkzgtI3H0=;
        b=CSA80TcbczLPRHLDJGylklWnjLBDP6hOb4TpSdl+6So6JSwQt/bdWyTpaRF7QBt5Yb
         BQxU5+xRwRZz3fv/BhhTF7ImrZWrqsdSQg9fmFRpkG6gpVyANA+/2XmcbqMWjj92CA0H
         1+t69AVyaLGOgXjlaYIYebyLkNtTQbdbkhK3/IvdONA85qHE91tm1X6yJGH52Y01ru7E
         JZ42kdMcUSZryfFmlxiAS/VfOsvCyC7NwA0+3w3dsw1bOzCI7VtRHD9FXgTfDYs3Ug3r
         ++mzOTMpfYGrz7HNXN2ULdOTLUOvDDTtOS/Jb7KOoUzRLRk3sVsiRxDKUd7f/pd3WwSO
         HEWA==
X-Gm-Message-State: ABy/qLbm3Lx4kNC20e4QwgpZWRSjydxFd5p8OuS957qrl1Pa4yt8lskR
        MyyIP4wW/2AcG3JlpwUb304=
X-Google-Smtp-Source: APBJJlFWAasGc/bypjLgUL63W7kuDctXmqYZoLR/DAjWXaAo0dy91vdZBqL3HURFOU5Yhzju2q3x7w==
X-Received: by 2002:a05:6870:c348:b0:1b0:2ef7:2434 with SMTP id e8-20020a056870c34800b001b02ef72434mr18601oak.15.1690479479721;
        Thu, 27 Jul 2023 10:37:59 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id s6-20020a0568301e0600b006b93c6c97basm841220otr.44.2023.07.27.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:37:59 -0700 (PDT)
Date:   Thu, 27 Jul 2023 14:37:54 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <ZMKrcvpu3b15Hdif@alolivei-thinkpadt480s.gru.csb>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
 <2023072741-mankind-ethics-b95b@gregkh>
 <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
 <2023072752-stem-pupil-76ab@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072752-stem-pupil-76ab@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:21:08PM +0200, Greg KH wrote:
> On Thu, Jul 27, 2023 at 02:08:16PM -0300, Alexon Oliveira wrote:
> > On Thu, Jul 27, 2023 at 05:05:03PM +0200, Greg KH wrote:
> > > You resolved one warning by replacing it with a different one, that's
> > > not good :(
> > 
> > Well, honestly, I couldn't spot any new issue caused by this patch. At least it was not reported by the checkpatch.pl. The ones that are still showing up were already there. But, to move on, if you think it's more productive, I can fix all warnings and checks reported by the checkpatch.pl and send them over in only one patch. Is it that feasible?
> 
> I would have thought you would get a "line is too long" warning, that
> didn't happen?
$ pwd
/home/alolivei/git/kernels/staging
$ perl scripts/checkpatch.pl --strict -f drivers/staging/vme_user/vme_bridge.h | grep -i parenthesis
$ 
Nope. I didn't get any of that. Check it out:

$ pwd
/home/alolivei/git/kernels/staging
$ perl scripts/checkpatch.pl --strict -f drivers/staging/vme_user/vme_bridge.h | grep -i parenthesis
$

No more checks/warnings about that. Sure, that are other checks/warnings, but not related to this, and I was intending to fix them in another patch (or multiple patches), because they involve to change the code itself.

> 
> Anyway, no, you can't send a "fix all the issues at once" patch, sorry,
> if you do that you will get a message from my patch bot that says:
> 
> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.  This will make it easier to review the
>   patches to ensure that they are correct, and to help alleviate any
>   merge issues that larger patches can cause.
> 

That's what I thought, thank you for the explanation. That's why I sent this "little one" only correcting the check reported by checkpatch.pl related to the code formatting style. At least, as you can see above, the tool is not complaining about that issue anymore, as I made sure to follow up the guidelines on that.

> So please break it up into logical changes.
> 

The logical change of this patch is to fix all the "CHECK: Alignment should match open parenthesis" reported by checkpatch.pl in this specific code in all the lines (11 of them) I reported in my first message.

> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
