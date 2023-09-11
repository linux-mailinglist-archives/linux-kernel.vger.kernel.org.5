Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A979A0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjIKAz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIKAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:55:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A0F194
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 17:55:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68e3083aa1dso3756007b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694393751; x=1694998551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkCptR4EZl+Hose2vw9ASu1TJniSm3o/K3PjtvBEpBw=;
        b=zVk8WH6coNsqn7kPYrZLIiFRBhFy+leTcjyST+NoX27HWvjxheNJl8rYnXe/Pp2Ykh
         /qoo0clRbh9j7XRJApDp0h1vDFwMYsI+TmmdBM804FC2ehbAxUZUDatkTGPtsobaaXUn
         zWd+ospmA6INrPT1UjzXx01HXWfldLyye32x1PDQzGxLeQFGFoWD6nmA4apxr1dlYuCl
         R/8tIsWSO2ea8Liox0B+VEF8C65cNJZjQRpb71dXOtj4p6bDIMqXkyHY5F2qCxMcXD/M
         JIROBDN/xYS8NhuWbc1GXhnO8LNKqOjAlqdDcF2w/kdPyBVXrL0saz+k/Z6JopWd3hez
         XoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393751; x=1694998551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkCptR4EZl+Hose2vw9ASu1TJniSm3o/K3PjtvBEpBw=;
        b=Vg0pcjZy9mpYToVVMuj+o28xSVVNsYdmyC0wzDby2z9tdI+ZFUjHPovd5N+kl/mFwI
         QUzBcFWpD1hMV74DEnsP6oVi6sJF//Mglplgj8F+yEU4B/hZJlEt291L+IzGxUgSovLj
         tXrL3cV/0BDtgDVAPsPXcBznShNcEKtP1prAOZr8FQKs0mbmGWxuropreLXmJiALqa10
         XvUiqEYF/e3hNQL8JrJvKOju+u43toz+vDw3dySXFgukOQ4LAYiCvEMcpBABwgbYcXam
         xp2/9WNMlGXVimRD5J3YEAVg3M1DoIPjLo+TX9yc+8RUMrDFsPSKTx3BMOdXkYw3y2Zp
         poHQ==
X-Gm-Message-State: AOJu0YxKwpquF/T3AWQfUuEA+g3EGMd9mUN/+4A/GhUySWJ493yIYRvL
        p7pcUUzCbhqb2eucah4ABMuLag==
X-Google-Smtp-Source: AGHT+IH15x/YR43uoyl1Igs4BKI5BpHWhTAknaIVAizD2C3adaIwS+/qRVdEJvMrhTE7oaO6xaZlkA==
X-Received: by 2002:a05:6a20:9489:b0:14c:512c:c138 with SMTP id hs9-20020a056a20948900b0014c512cc138mr8689849pzb.60.1694393751245;
        Sun, 10 Sep 2023 17:55:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b0068bc014f352sm4447993pfa.7.2023.09.10.17.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:55:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfVDQ-00DZQp-0P;
        Mon, 11 Sep 2023 10:55:48 +1000
Date:   Mon, 11 Sep 2023 10:55:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZP5llBaVrJteHQf3@dread.disaster.area>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP5OfhXhPkntaEkc@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:17:18AM +0100, Matthew Wilcox wrote:
> On Mon, Sep 11, 2023 at 08:56:45AM +1000, Dave Chinner wrote:
> > On Fri, Sep 08, 2023 at 12:44:34PM +0200, Peter Zijlstra wrote:
> > > Agreed, and this is fine. However there's been some very creative
> > > 'use' of the _is_locked() class of functions in the past that did not
> > > follow 'common' sense.
> > > 
> > > If all usage was: I should be holding this, lets check. I probably
> > > wouldn't have this bad feeling about things.
> > 
> > So your argument against such an interface is essentially "we can't
> > have nice things because someone might abuse them"?
> 
> Some people are very creative ...

Sure, but that's no reason to stop anyone else from making progress.

> I was thinking about how to handle this better.  We could have
> 
> static inline void rwsem_assert_locked(const struct rw_semaphore *sem)
> {
> 	BUG_ON(atomic_long_read(&sem->count) == 0);
> }
> 
> static inline void rwsem_assert_write_locked(const struct rw_semaphore *sem)
> {
> 	BUG_ON((atomic_long_read(&sem->count) & 1) != 1);
> }

We already have CONFIG_DEBUG_RWSEMS, so we can put these
introspection interfaces inside debug code, and make any attempt to
use them outside of debug builds break the build. e.g:

#if DEBUG_RWSEMS
/*
 * rwsem locked checks can only be used by conditionally compiled
 * subsystem debug code. It is not valid to use them in normal
 * production code.
 */
static inline bool rwsem_is_write_locked()
{
	....
}

static inline bool rwsem_is_locked()
{
	....
}
#else /* !DEBUG_RWSEMS */
#define rwsem_is_write_locked()		BUILD_BUG()
#define rwsem_is_locked()		BUILD_BUG()
#endif /* DEBUG_RWSEMS */

And now we simply add a single line to subsystem Kconfig debug
options to turn on rwsem introspection for their debug checks like
so:

 config XFS_DEBUG
 	bool "XFS Debugging support"
 	depends on XFS_FS
+	select RWSEM_DEBUG
 	help
 	  Say Y here to get an XFS build with many debugging features,
 	  including ASSERT checks, function wrappers around macros,

> but then we'd also need to change how XFS currently uses the ASSERT()
> macro to be ASSERT_LOCKED(ip, flags), and I understand this code is also
> used in userspace, so it'd involve changing that shim, and we're getting
> way past the amount of code I'm comfortable changing, and way past the
> amount of time I should be spending on this.
> 
> And then there'd be the inevitable bikeshedding about "don't use BUG_ON"
> and it's probably just for the best if I walk away at this point,
> becoming the third person to fail to remove the mrlock.

Yeah, which further points out how ridiculous the situation is. This
is useful debug code and it can *obviously* and *easily* be
constrained to debug environments.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
