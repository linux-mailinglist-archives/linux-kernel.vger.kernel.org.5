Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD37CA713
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjJPLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJPLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:53:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049A3F1;
        Mon, 16 Oct 2023 04:53:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so44640855e9.2;
        Mon, 16 Oct 2023 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697457196; x=1698061996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9jKl/9AOz583fNo8bRchi+qyfwMXZwoKdGYZrb+aak=;
        b=RBjtDYrkVCJ4aPGPqPvwBmAl87NVTHZItqSDqzBdojSAENvuiGo073wbzgN2DKGukS
         xVtT9AxtoPifO3lHzs7C68jaKbBXTshnkYR61xvWiTWcxUp4smUPsTNyk5Ugw8cCd6pe
         EQiBdCIQVZk4BDQKqhm7FG0g8x99TVwIBLKUEc+vLLHQZ4TzMJR1PvbDn6H+DnJ8R1YA
         /3K7gAGmX6ImG0j9Yprhn6rulxYg5XTmH/wJS2zhfgHbU6Yaz7oyrlEOEwMiQtBdhlar
         n6ZLXNWirTjQ03pvbKh9yjWZPcMuWa5atorh1iSzZI7zfHv4FVWYCY9i0zTvFDaOdfJw
         gr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457196; x=1698061996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9jKl/9AOz583fNo8bRchi+qyfwMXZwoKdGYZrb+aak=;
        b=lvpFa0d1/yaRRY0/FaAlbX897RrpIqW7CRhz8bWN7uvLBexJSGlaNhDyv+0IrcTWzH
         W21E+1KnzLJmfPuwCTjk8Ipg/87ZAe+14P9Cj/gsHSdxDqR5S9EtEaO75uW5C/YzoFM9
         O4MMcginkBVz5ajS4MQIGjAx/Y1KbROU7vwk7OzuhERlhW8DXqp1E8e91ZbJzZeWHa4+
         QF2Q5GMLEwnrQgZ7Hch8vzqN+sR5mYZBkf6L4ifypuVbRIowweF/jvuD725gAGa+j7dY
         BRq4nakO7BNjNmqpMNzuBeFtfniHYnjNid3TXnQVsQWW4DjF78wmF2SxyDQrNA9+ScuE
         KBGA==
X-Gm-Message-State: AOJu0YyNd3sP7G7kv7b/6Ft4rg82g+6ZpnjPipyOZp7xaDQOjl1jYMPj
        vBsbgDeLkLcaBwR/nzt5tGxdN1YRQzY=
X-Google-Smtp-Source: AGHT+IE929vjAV4QvxVlJG8MoDHd9hEmZSlGpa3V3HXjC/ZC1421M8M9lfJS5RbslYUrhsQFEGzMVw==
X-Received: by 2002:a1c:4b07:0:b0:405:3ca1:f6ba with SMTP id y7-20020a1c4b07000000b004053ca1f6bamr27526897wma.3.1697457196091;
        Mon, 16 Oct 2023 04:53:16 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b0040651505684sm7001403wmf.29.2023.10.16.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:53:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 13:53:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <ZS0kKWsCaYHhKeHa@gmail.com>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
 <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
 <20231011175407.GG6307@noisy.programming.kicks-ass.net>
 <ZScUhud9eqKIQJjC@gmail.com>
 <bf5ecd2d-06a7-4c51-a762-6fe3753044b6@kernel.dk>
 <ZScbKPQur2qao5Gf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZScbKPQur2qao5Gf@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jens Axboe <axboe@kernel.dk> wrote:
> 
> > >>> Peter, what's the verdict - do you want to rebase it, or leave it 
> > >>> as-is?
> > >>
> > >> Ah, I looked into doing this, but tip/locking/core has since grown a 
> > >> bunch of patches and has a merge commit -- I talked to Ingo yesterday 
> > >> and he proposed just queueing a fix on top instead of doing a full 
> > >> rebase.
> > >>
> > >> Ingo, that still your preferred solution?
> > > 
> > > Yeah, that would be the best solution IMO - it's not like there's any 
> > > real prospect of someone bisecting futex2 patch-enablement commits on 
> > > Alpha ... and the bisection distance isn't particularly large either in 
> > > any case.
> > 
> > OK, works for me. I'll keep my branch as-is, and just ensure it gets sent 
> > out after locking/core has been pulled by Linus.
> 
> Thank you!

Heads-up: the futex syscall numbers are now fixed on Alpha in the locking 
tree via:

  dcc134510eef ("alpha: Fix up new futex syscall numbers")

This would, I presume, trigger a new conflict in -next, which should be 
resolved in an identical fashion.

Jens, feel free to send your tree to Linus in any ordering with the
locking tree, there's no real dependency between them, and whoever
sends last should warn Linus about the known conflict.

Thanks,

	Ingo
