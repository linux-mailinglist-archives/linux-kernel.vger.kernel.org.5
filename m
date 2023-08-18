Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25878130D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379498AbjHRSq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379493AbjHRSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:46:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909633C3F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:46:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68879c4cadeso1053133b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692384382; x=1692989182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+2hSnqS9Yzw5UTj15WMzjQ4zmGmjbbgkpHMU7Oa/T4=;
        b=UGM65oHnI7oqrbisB5aTDPxGyCJnzpdwN0H0USoMcryzreFY0ONqRc/qg1vwjk1sq3
         qFoovE7ZU111JOa8bRkXKvDMWQPwf90N8xDBjMdvpDzPnkSYv2djLX94Y6ZB1jiZeWdb
         TkJSyWpXy92Rmq5gWls3IQDvHLP4CnwS2f+Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384382; x=1692989182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+2hSnqS9Yzw5UTj15WMzjQ4zmGmjbbgkpHMU7Oa/T4=;
        b=J0uojuAJkVDM7y8e+iw0z7IpxzaTyTcE+jn5es2bZt/TBeH5nQeMf9rB6shpJYxoDr
         gFk8L9VvyHFdsOqwoKWLoKMha4iq4PkftdwL8a24LRnUXza/QKh0a4qZsg8hM3vWJlcs
         jQM+ngN0TAqKpbtINPENKhKeIYd64AHkFcNYQWvEbqWokuRRBAjucqjwQe55cEsR5rBe
         KVyG9Knpxqj7rwirHehUC+W3AJqv6LNBCV2bcopTOzElI5NsTITMmEgnPP+Nz83BSO5T
         ud4dHvN5GzCsSw/ck3wQN+Kff+ST0syJclRYeH9iN77oyEhqYsW+mUdOPB+d1DQnKVUD
         q7Tg==
X-Gm-Message-State: AOJu0YxTmH1J4iQ5XduOPZV1sgnTLaGsYErGd6H2zuWeiNcmbjlOq7Jc
        BulAL2e6tn7kmjNB0cz69RTsuA==
X-Google-Smtp-Source: AGHT+IE3Zchz6xeyBBEDLoYNbU06PWpcwMQMcoo53Bn+vR9Ag+FUXv04ngK0q6kWf3a8SLZaL9fVbw==
X-Received: by 2002:a05:6a00:150d:b0:678:ee57:7b29 with SMTP id q13-20020a056a00150d00b00678ee577b29mr15648pfu.30.1692384381927;
        Fri, 18 Aug 2023 11:46:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a62e903000000b006879493aca0sm1855587pfh.26.2023.08.18.11.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:46:21 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:46:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-ID: <202308181131.045F806@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:55:42AM -0700, Andrew Morton wrote:
> On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > From: Elena Reshetova <elena.reshetova@intel.com>
> > 
> > atomic_t variables are currently used to implement reference counters
> > with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > 
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows and
> > underflows. This is important since overflows and underflows can lead
> > to use-after-free situation and be exploitable.
> 
> ie, if we have bugs which we have no reason to believe presently exist,
> let's bloat and slow down the kernel just in case we add some in the
> future?  Or something like that.  dangnabbit, that refcount_t.
> 
> x86_64 defconfig:
> 
> before:
>    text	   data	    bss	    dec	    hex	filename
>    3869	    552	      8	   4429	   114d	kernel/cred.o
>    6140	    724	     16	   6880	   1ae0	net/sunrpc/auth.o
> 
> after:
>    text	   data	    bss	    dec	    hex	filename
>    4573	    552	      8	   5133	   140d	kernel/cred.o
>    6236	    724	     16	   6976	   1b40	net/sunrpc/auth.o
> 
> 
> Please explain, in a non handwavy and non cargoculty fashion why this
> speed and space cost is justified.

Since it's introduction, refcount_t has found a lot of bugs. This is easy
to see even with a simplistic review of commits:

$ git log --date=short --pretty='format:%ad %C(auto)%h ("%s")' \
          --grep 'refcount_t:' | \
  cut -d- -f1 | sort | uniq -c
      1 2016
     15 2017
      9 2018
     23 2019
     24 2020
     18 2021
     24 2022
     10 2023

It's not really tapering off, either. All of these would have been silent
memory corruptions, etc. In the face of _what_ is being protected,
"cred" is pretty important for enforcing security boundaries, etc,
so having it still not protected is a weird choice we've implicitly
made. Given cred code is still seeing changes and novel uses (e.g.
io_uring), it's not unreasonable to protect it from detectable (and
_exploitable_) problems.

While the size differences look large in cred.o, it's basically limited
only to cred.o:

   text    data     bss     dec     hex filename
30515570        12255806        17190916        59962292        392f3b4 vmlinux.before
30517500        12255838        17190916        59964254        392fb5e vmlinux.after

And we've even seen performance _improvements_ in some conditions:
https://lore.kernel.org/lkml/20200615005732.GV12456@shao2-debian/

Looking at confirmed security flaws, exploitable reference counting
related bugs have dropped significantly. (The CVE database is irritating
to search, but most recent refcount-related CVEs are due to counts that
are _not_ using refcount_t.)

I'd rather ask the question, "Why should we _not_ protect cred lifetime
management?"

-Kees

-- 
Kees Cook
