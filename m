Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335977B95A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHNNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjHNNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:02:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F519A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:02:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f25d045cso2829338b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692018130; x=1692622930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKCht00peaRonZGA470AHkVGtx/YrtjPfOWO9GGrZzg=;
        b=Fi96PZ+q51r/KWaS0v82cIaUFj22W88rqrhcM3ZieVQlx2ln7ILx36SFagURvZk7bX
         OKeHqTTGgzh/wKBBPtvVUKRu4/pQ+DX7JFl6ngi1jO2arrGpANWcrc9t542R7ZxhE+Jh
         DapNfKOD0BV0gzOC70h5HwOpybapk8ywL+IkQQPmr7OcIszeqgZxn0UYesWtI+B17Kca
         gZRi+gAz77b6QQf7c0F2MsIr02AJ1GousrUqfIwKoPfn98m+P2mrgQCiyijgvlqOBn6F
         bKxk91GqVNapodqJVujfRDo6aH1Kzu/Ky/RcjUXrQaX517CKD6Sa5h76ehStDBaKA+9U
         5qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692018130; x=1692622930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKCht00peaRonZGA470AHkVGtx/YrtjPfOWO9GGrZzg=;
        b=LgIgphHGYjRKLVF0Dls+mAIfzXrzdVbpj57OOB4IJ8Yd4J7b4Lr/ucR7NCP5GnGJXg
         024pTqUqLdRZVWA9aZ62G0QuCHXyDsGrlE2WxTJkd9pHbUIlb1WIf5X5QgoL2iorjUdA
         r/VYlzKHsHfLJhiBqCuiiXx4qS7/bTRB1cNWkFkBF7HWmJVNm1M49dw3Xbji3aTyzvrL
         rdu9wxx7OajB9A5tNuivT2s8A7MxxOExYl+AAVmfNoENiFyzxymORHKNngHPlgLhq08G
         JbLP7roXo3B98XgcrfB22yqFNhzHA9+9p6LbyQS0N/DaHDiCDr+gsVPBrKtbEpl5rIeL
         HFNQ==
X-Gm-Message-State: AOJu0Yzm/SskyMKTkmt+dsBcsNGe4g3vS8dioeNbwJqGOP61wdJ8vaaK
        c/xMXANvHk4hI00zjju+9BQ=
X-Google-Smtp-Source: AGHT+IFq133aawXmsL6sMEtTQbnpBUm3VWpWwop0jw8WiolamxjZOleHyHYPu/YQsquQWN0rn0zbkQ==
X-Received: by 2002:a05:6a20:7f8e:b0:135:4527:efcc with SMTP id d14-20020a056a207f8e00b001354527efccmr11185059pzj.46.1692018130088;
        Mon, 14 Aug 2023 06:02:10 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([171.49.234.213])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b00684b64da08bsm7889819pfu.132.2023.08.14.06.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:02:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 18:32:01 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZNolyVLwygowAzE2@ubuntu.myguest.virtualbox.org>
References: <ZNOK2u1sJoRAxhIC@ubuntu.myguest.virtualbox.org>
 <2023081150-hamster-sulfide-4231@gregkh>
 <ZNfPiQAL3ixA7tjz@ubuntu.myguest.virtualbox.org>
 <alpine.DEB.2.22.394.2308122041160.3315@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2308122041160.3315@hadrien>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 08:41:51PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 12 Aug 2023, Pavan Bobba wrote:
> 
> > On Fri, Aug 11, 2023 at 11:27:10PM +0200, Greg KH wrote:
> > > On Wed, Aug 09, 2023 at 06:17:22PM +0530, Pavan Bobba wrote:
> > > > Replace array name of camel case by snake case. Issue found
> > > > by checkpatch
> > > >
> > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > ---
> > > >  v1 -> v2: 1. array name renamed from byVT3253B0_RFMD to by_vt3253b0_rfmd
> > > >            2. typo in the subject line "small case" corrected with the
> > > >               proper word "snake case"
> > > >
> > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > ---
> > > >  drivers/staging/vt6655/baseband.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> > > > index 0e135af8316b..cc8793256661 100644
> > > > --- a/drivers/staging/vt6655/baseband.c
> > > > +++ b/drivers/staging/vt6655/baseband.c
> > > > @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
> > > >  };
> > > >
> > > >  #define CB_VT3253B0_INIT_FOR_RFMD 256
> > > > -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> > > > +static const unsigned char by_vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> > >
> > > Again, the "by" needs to just be dropped.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > hi greg...did'nt get your comment. can you please provide more elaborate
> > info?
> 
> Drop the letter "by_" at the beginning of the function name.  It is there
> ot indicate the type, which isn't done in the kernel.
> 
> julia

this is'nt a function name but an array name. is in't it fine?
