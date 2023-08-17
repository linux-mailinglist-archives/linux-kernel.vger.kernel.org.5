Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9077F612
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350662AbjHQMJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350682AbjHQMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:08:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CEA213F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:08:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68896d7eb1eso928650b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692274124; x=1692878924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HqxtbcBfbYTw4bwKds0vVLnrXgHI7+miuCUNWaBWa7U=;
        b=BSgwA8FXepJGHNhfB9zJbVWBhnIrXJhVXSUfj4T0t1L4KxfRWLvdnF3uzzzq62kDXT
         BxgWWjNkFkbM+xhp8I833GFtzfUuY6fJLTiPdmR32nFDbiFaUtrGpq8838hxJtMXIBdm
         gkvNanDoQ8SdBc4j8h4t7bpE6MeZmN/cjc9L+/5U1rguB3Hl1Ap4CZs6LUOnaI8EqzT9
         qMLRvvNIpuG/8jQJIvLTDWVURSRlrACQyMTU22DMCR5Zp1Kk3McH83kZdmYUeZzqAGT+
         eNGE938Y9W5dXbSsUeIVmSXC0eEqSNXVphiWmynPp12fUtifvL1wkRtoPdP7oiBImD9m
         i4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692274124; x=1692878924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqxtbcBfbYTw4bwKds0vVLnrXgHI7+miuCUNWaBWa7U=;
        b=WY3bKMViM07GoePinNgnxQq/73U6c4dT2bHdGjQBfPbhhw6EfYQDLjZGxGBN3bIX3J
         b4ryOxteH+EyfWwgdr338d42d8Wz7wlaiGa0r7ibh1qOYfGG6s9/rIZvvjjB30H6jvnU
         zhHrGmGrQkR5UCaPggGH3FloC5LcicvRuU5PtC3nEWY8dOjZ2bBpGRYk9ODSg0D8Iowh
         TLDMy8Z9UAwB0CiqCZkUynndbDe0FgcWB2vfh7VZcV4UEaH1Jd1CoVxsY1JlE/DbZf5k
         6HVJh90Slb8Zzn22UsPBXZqZzBXJgJPTIarSB0vhsRsApksdgvrOQVb9CC6Hn7sweZ4h
         ETEg==
X-Gm-Message-State: AOJu0YwY8K6uxhieT/jZwxgLpOW/oHrc5pLYJabixv0OdzH1RLFpAepW
        n+FonIVlpWK0e0ODGdRnfs4=
X-Google-Smtp-Source: AGHT+IEaXBIjxK7FY23yjT6hXgMXg2LTXvxMF1ggJVAz2jrS50SMzy16h8KpOxh3qWjqck/pag4OaA==
X-Received: by 2002:a05:6a21:4889:b0:140:b178:9b36 with SMTP id av9-20020a056a21488900b00140b1789b36mr5468021pzc.48.1692274123919;
        Thu, 17 Aug 2023 05:08:43 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.54.25])
        by smtp.gmail.com with ESMTPSA id y18-20020a62b512000000b006875df47743sm12724003pfe.156.2023.08.17.05.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:08:43 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:38:39 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZN4NxzozblvEX7IS@ubuntu.myguest.virtualbox.org>
References: <ZNOK2u1sJoRAxhIC@ubuntu.myguest.virtualbox.org>
 <2023081150-hamster-sulfide-4231@gregkh>
 <ZNfPiQAL3ixA7tjz@ubuntu.myguest.virtualbox.org>
 <alpine.DEB.2.22.394.2308122041160.3315@hadrien>
 <ZNolyVLwygowAzE2@ubuntu.myguest.virtualbox.org>
 <2023081442-cartridge-thaw-1656@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081442-cartridge-thaw-1656@gregkh>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:20:40PM +0200, Greg KH wrote:
> On Mon, Aug 14, 2023 at 06:32:01PM +0530, Pavan Bobba wrote:
> > On Sat, Aug 12, 2023 at 08:41:51PM +0200, Julia Lawall wrote:
> > > 
> > > 
> > > On Sat, 12 Aug 2023, Pavan Bobba wrote:
> > > 
> > > > On Fri, Aug 11, 2023 at 11:27:10PM +0200, Greg KH wrote:
> > > > > On Wed, Aug 09, 2023 at 06:17:22PM +0530, Pavan Bobba wrote:
> > > > > > Replace array name of camel case by snake case. Issue found
> > > > > > by checkpatch
> > > > > >
> > > > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > > > ---
> > > > > >  v1 -> v2: 1. array name renamed from byVT3253B0_RFMD to by_vt3253b0_rfmd
> > > > > >            2. typo in the subject line "small case" corrected with the
> > > > > >               proper word "snake case"
> > > > > >
> > > > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/vt6655/baseband.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> > > > > > index 0e135af8316b..cc8793256661 100644
> > > > > > --- a/drivers/staging/vt6655/baseband.c
> > > > > > +++ b/drivers/staging/vt6655/baseband.c
> > > > > > @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
> > > > > >  };
> > > > > >
> > > > > >  #define CB_VT3253B0_INIT_FOR_RFMD 256
> > > > > > -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> > > > > > +static const unsigned char by_vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> > > > >
> > > > > Again, the "by" needs to just be dropped.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > hi greg...did'nt get your comment. can you please provide more elaborate
> > > > info?
> > > 
> > > Drop the letter "by_" at the beginning of the function name.  It is there
> > > ot indicate the type, which isn't done in the kernel.
> > > 
> > > julia
> > 
> > this is'nt a function name but an array name. is in't it fine?
> > 
> 
> Not at all.  The issue is the name, why are you just adding a "_" here?
> What does "by" mean?  (hint, this is a rhetorical question, I know, I
> need you to figure it out so you know how to properly rename the
> variable here...)
> 
> thanks,
> 
> greg k-h

Thank you for the info. i have updated the patchset V3 based on this
discussion and will keep this point for future patchsets
