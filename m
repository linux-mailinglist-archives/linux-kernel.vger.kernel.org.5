Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836EF7C6F05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjJLNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJLNSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:18:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438191
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:18:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e2308198dso115129a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1697116729; x=1697721529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pESXSq2cB1yHJ+chcqnwZf4qBvXPZQ+xBIxCqTvUZk=;
        b=AWP9WKmZXZaU5jBtG/bU92wsbY0NX0Dx/XgPz6/FyIMPT/F27aNUxCvvoTVjPBH2Bd
         H5SN9HjIUGnRR7uDQmpVSgrrnRe42AVNJYRfLPd7J0zMFVlAdXcb7Bhaah1THGgo44Rk
         JR/sy6aS96WSvbg9JFRKKSg3p/QWuOGEicnLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697116729; x=1697721529;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pESXSq2cB1yHJ+chcqnwZf4qBvXPZQ+xBIxCqTvUZk=;
        b=UABSv5SMcEX9gXGyTnwKNJ2nrDb4Lk0xwzhxANr5EGVx+E2uG9nQIaeHtlEoylCZjh
         rUQ//2OSYEXiCi123rG9yrSg1xOWV5wy93j6iGFUh/9grI7k0etVSC9u9okgwM18N0wF
         eq6hP2V6kSg1lUlXWU1ZlQbakhRPW2dgSdXQdpJ2uUpFvjMmkTGW6OAO4UG6yRfE9C4e
         5fG93S8EO1K586aBLURM0w0Dx2sEimU6HLyEGQeBmtpY4hnRIMFXnvJgU6PtqTIBJSKv
         oEwydi20RLFMWJ2bgdQHSHK1xJ95MjDIwc6bVDwmMaiGrdEHxdWDbpru57fasyzHRqmJ
         zs3w==
X-Gm-Message-State: AOJu0YypMx4FBxrerjrhRzalzdIeB5CgJ1mQGshsSE5MDbOEnNsBISzo
        UkGaNznZ62EGnEP8kdrUUSxE4Q==
X-Google-Smtp-Source: AGHT+IGJcRZ7cTA96fEttPOGRTmKTsJPCw4j/SDo4Z8rYwpHN8ZI7B+Q4X82DmJvmTQpxyufoY2UqQ==
X-Received: by 2002:a05:6402:278c:b0:523:2e64:122b with SMTP id b12-20020a056402278c00b005232e64122bmr22060277ede.3.1697116729023;
        Thu, 12 Oct 2023 06:18:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gy6-20020a0564025bc600b0053e2a64b5f8sm137382edb.14.2023.10.12.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:18:48 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:18:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, jim.cromie@gmail.com,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
Message-ID: <ZSfyNgaHGGPiKqjN@phenom.ffwll.local>
Mail-Followup-To: Pekka Paalanen <ppaalanen@gmail.com>,
        jim.cromie@gmail.com,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
 <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
 <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
 <20231011114816.19d79f43@eldfell>
 <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
 <20231012115548.292fa0bb@eldfell>
 <ZSfCMBXOOi9Luc6F@phenom.ffwll.local>
 <20231012133944.69711822@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012133944.69711822@eldfell>
X-Operating-System: Linux phenom 6.5.0-1-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:39:44PM +0300, Pekka Paalanen wrote:
> On Thu, 12 Oct 2023 11:53:52 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
> > On Thu, Oct 12, 2023 at 11:55:48AM +0300, Pekka Paalanen wrote:
> > > On Wed, 11 Oct 2023 11:42:24 +0200
> > > Daniel Vetter <daniel@ffwll.ch> wrote:
> > >   
> > > > On Wed, Oct 11, 2023 at 11:48:16AM +0300, Pekka Paalanen wrote:  
> 
> ...
> 
> > > > > - all selections tailored separately for each userspace subscriber
> > > > > (- per open device file description selection of messages)    
> > > > 
> > > > Again this feels like a userspace problem. Sessions could register what
> > > > kind of info they need for their session, and something like journald can
> > > > figure out how to record it all.  
> > > 
> > > Only if the kernel actually attaches all the required information to
> > > the debug messages *in machine readable form* so that userspace
> > > actually can do the filtering. And that makes *that* information UABI.
> > > Maybe that's fine? I wouldn't know.  
> > 
> > Well if you configure the filters to go into separate ringbuffers for each
> > session (or whatever you want to split) it also becomes uapi.
> 
> It's a different UAPI: filter configuration vs. message structure. I
> don't mind which it is, I just suspect one is easier to maintain and
> extend than the other.
> 
> > Also I'd say that for the first cut just getting the logs out on demand
> > should be good enough, multi-gpu (or multi-compositor) systems are a step
> > further. We can figure those out when we get there.
> 
> This reminds me of what you recently said in IRC about a very different
> topic:
> 
> 	<sima> swick[m], tell this past me roughly 10 years ago, would
> 	have been easy to add into the design back when there was no
> 	driver code yet 
> 
> I just want to mention today everything I can see as useful. It's up to
> the people doing the actual work to decide what they include and how.

I actually pondered this a bit more today, and I think even with hindsight
the atomic design we ended up with was probably rather close to optimal.

Sure there's a bunch of things that would have been nice to include, but
another very hard requirement of atomic was that it's feasible to convert
current drivers over to it. And I think going full free-standing state
structures with unlimited (at least at the design level) queue depth would
have been a bridge too far.

The hacks and conversion helpers are all gone by now, but "you can just
peek at the object struct to get your state" was a huge help in reducing
the conversion churn.

But it definitely resulted in a big price we're still paying.

tldr I don't think getting somewhere useful, even if somewhat deficient,
is bad.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
