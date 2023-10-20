Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7B7D0FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377276AbjJTMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377079AbjJTMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:33:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159E93;
        Fri, 20 Oct 2023 05:33:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a86b6391e9so8291307b3.0;
        Fri, 20 Oct 2023 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805197; x=1698409997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMvYl/tRg1JdMrVfnge+eYKdiJFbxif6udcePNEzkKY=;
        b=eG9KWzYIiZI7+LZR/9UE/QFwnfC19VY1Mx0y/XlRqa5toNHVu19q9cSTLPphhq/hIl
         +5wmqmP9KV/Q/vOFzqCvJl2FwoC9RPIz57EKJR4xGplR9LlMADQPdppdiNy7mAWc6zjp
         jtU15GvI7lKHy+JGrQxr0nsKD16BGZv1QDm8IoGX6NhgULsH4JzpduFQiJgiXyXd7xe3
         Bb+YyCmdP6vQrCyZ+KGj/xqeM+4MlaGb74gNPSxB/Qi7RW7X7RFltnzebmtaye7KxwPD
         9W2NuPVpQEnzU9HtH/KFqxAuhUawez+j522KjfA+Ey+HERJaN8aQ6CBKu08vTx6AgGzz
         xY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805197; x=1698409997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMvYl/tRg1JdMrVfnge+eYKdiJFbxif6udcePNEzkKY=;
        b=SPGIETPmL8D3WleJxlejE2FVo2KrsrQe83Gfcgg7Cp3ARpakS9mRP0m/I41t8rBBl3
         gkfHgzWLAHaapAEpH//hk0f7+6JVXC2UcZlDribDbIqZO4+fLPvYMggQuZuD9RqfcLaB
         NmtKlod2lYCLJy7MHI4YrJITkqtt84Mx+F7HmcJCc1kZCOseEKmWXSuQZDXIbtqjdmI0
         1xWJNSUwWcu6ovhXZukPKgsajX9U3CLSdgzZ7jsFzGIuS6AasrZOgJS/P1l3mwLXYnRe
         Pa3HfqHvEP4fGq9+7QfYOVS+ICYifPlBRMIoG91sOZKWcf01IVQR9LCzGDZgYzHz3ckc
         gUzg==
X-Gm-Message-State: AOJu0YwOsp0zLIvulgQ3dsIxRdVI8SW7sDa7FtjDHkurJIyUjjSrckJW
        rHb+dxqIarpM/jpDAMq5fCvEnFSkqKSiig==
X-Google-Smtp-Source: AGHT+IGFC/VGdmb0heFEHGl0OHhT2G1hp9HMrDrk1QrhUgHJlHMvAOM/CPKt0O0iW7w/9VJpwwGHjA==
X-Received: by 2002:a0d:e20a:0:b0:59b:fb69:1639 with SMTP id l10-20020a0de20a000000b0059bfb691639mr1766239ywe.32.1697805196684;
        Fri, 20 Oct 2023 05:33:16 -0700 (PDT)
Received: from localhost ([2607:fb90:3e1a:8bc6:bf58:5f88:bb90:604])
        by smtp.gmail.com with ESMTPSA id d8-20020a814f08000000b005a23a62a25csm649266ywb.9.2023.10.20.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:33:16 -0700 (PDT)
Date:   Fri, 20 Oct 2023 05:33:15 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <ZTJzi6OM9w/hYL1v@yury-ThinkPad>
References: <20231019170106.4159eac5@canb.auug.org.au>
 <ZTFSHqjkHLM5iAqH@yury-ThinkPad>
 <ZTIBESMp9qsRdVja@yury-ThinkPad>
 <20231020155113.31acd611@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020155113.31acd611@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:51:13PM +1100, Stephen Rothwell wrote:
> Hi Yury,
> 
> On Thu, 19 Oct 2023 21:24:49 -0700 Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Thu, Oct 19, 2023 at 08:58:24AM -0700, Yury Norov wrote:
> > > On Thu, Oct 19, 2023 at 05:01:06PM +1100, Stephen Rothwell wrote:  
> > > > 
> > > > After merging the bitmap tree, today's linux-next build (native perf)
> > > > failed like this:
> > > > 
> > > > In file included from /home/sfr/next/next/tools/perf/util/header.h:10,
> > > >                  from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
> > > > /home/sfr/next/next/tools/include/linux/bitmap.h:5:10: fatal error: linux/align.h: No such file or directory
> > > >     5 | #include <linux/align.h>
> > > >       |          ^~~~~~~~~~~~~~~
> > > > 
> > > > Caused by commit
> > > > 
> > > >   ed46ac8199f0 ("bitmap: introduce generic optimized bitmap_size()")
> > > > 
> > > > I have used the bitmap tree from next-20231018 for today.  
> > > 
> > > Thanks, Stephen. I'll take a look and let you know when it's resolved.  
> > 
> > So the problem is that the patch "bitmap: introduce generic optimized
> > bitmap_size()" adds reference to the linux/align.h, which doesn't exist
> > in tools.
> > 
> > I removed tools part of the patch entirely, and now tools/perf, for
> > example, builds OK for me natively. The tree doesn't touch tools at
> > all now, except for moving BYTES_TO_BITS() from a source file to a
> > header, which looks safe.
> 
> Almost - see my other email.
> 
> > Can you please try the latest bitmap-for-next?
> 
> See above.
> 
> My "native" is PowerPC 64 LE.

I tried arm64. Anyways, it's clear that the series is not ready yet.
I'll drop it from bitmap_for_next. Sorry for this mess.
