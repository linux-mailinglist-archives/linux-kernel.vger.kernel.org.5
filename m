Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF337705F3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjHDQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHDQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:27:48 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14388195
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:27:47 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34913c049c4so8194975ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691166466; x=1691771266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m8UhWgmZb5OUVlukjKB0JQMUBqmgUbKdZZ4Yk5upog=;
        b=UVF/HhK4rBizjWxO9q9vcT5xmJ3gNMxSqRgOFsdMkBF42GY64GRoJFDSbGmeRHM32J
         PpOyunPxeXNfPyow49P+8ivEMf5kUBNXsRMJKKL1z6UJcMhyqwsI1ih0OdkUW1iw455z
         4ivNZR5X9SACkvcpXmXbN5etWISA7wpl1DjoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166466; x=1691771266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m8UhWgmZb5OUVlukjKB0JQMUBqmgUbKdZZ4Yk5upog=;
        b=SIe2G1v49RARAz+9gjyefh3ilCBWyMbvzwRwgsz1D2Ka3gIS0QgBvTV1lIbuJN6tRp
         NQscO7TbrIqUHh5bNt1iLpUeeBuyxAVfpQRppq0hWr1DDeIAAkF4CR2yF1QAuJgHy2DV
         Zk0cDfToOOfio6IguiLCOiQs7RgKVak2mCJPEZIQ69Rp5YuxSl5N2Jly/bsw0pn+0XdP
         71n2fh5GzAoYWCfj6uHlNqUGwzyA+kiHTheCvZOYDA1kV82qHQfDCIXOPHYkn7Qzc3wj
         mUgsVH3SCdDsfc4KFa9FCfkGkviGH2T9xJREMgfrgKQV97PfbJL1fn1uIFpQFdXvFP81
         Edgw==
X-Gm-Message-State: AOJu0Yz/jbO3HLl+6LxNx1CJrc6tH2tnSiDr1R8TbwXjlD0AkbmiXPJj
        ORqCyT8oF1/Ys6wZH3cBICoAwA==
X-Google-Smtp-Source: AGHT+IGaQzXSq698n/jizu1SNhS5Vy787VCwMRNHWCctojQ1ejB2RcjgaiUR4WdyIEVoRazZPoZKeA==
X-Received: by 2002:a92:dc4f:0:b0:348:7ace:d2dc with SMTP id x15-20020a92dc4f000000b003487aced2dcmr2516076ilq.20.1691166466356;
        Fri, 04 Aug 2023 09:27:46 -0700 (PDT)
Received: from localhost (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id x25-20020a029719000000b0042b39b2289asm663468jai.102.2023.08.04.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:27:45 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:27:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/2] docs: memory-barriers: Add note on plain-accesses to
 address-dependency barriers
Message-ID: <20230804162745.GA256944@google.com>
References: <20230803032408.2514989-1-joel@joelfernandes.org>
 <20230803032408.2514989-2-joel@joelfernandes.org>
 <626d1b48-de6a-4a0b-95d3-3ac438878757@paulmck-laptop>
 <20230804051127.GA3860381@google.com>
 <3f53035f-3251-4531-b9b9-e12f371c1051@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f53035f-3251-4531-b9b9-e12f371c1051@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:52:32AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 04, 2023 at 05:11:27AM +0000, Joel Fernandes wrote:
> > On Thu, Aug 03, 2023 at 11:52:06AM -0700, Paul E. McKenney wrote:
> > > On Thu, Aug 03, 2023 at 03:24:07AM +0000, Joel Fernandes (Google) wrote:
> > > > The compiler has the ability to cause misordering by destroying
> > > > address-dependency barriers if comparison operations are used. Add a
> > > > note about this to memory-barriers.txt and point to rcu-dereference.rst
> > > > for more information.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  Documentation/memory-barriers.txt | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > > index 06e14efd8662..acc8ec5ce563 100644
> > > > --- a/Documentation/memory-barriers.txt
> > > > +++ b/Documentation/memory-barriers.txt
> > > > @@ -435,6 +435,11 @@ Memory barriers come in four basic varieties:
> > > >       variables such as READ_ONCE() and rcu_dereference() provide implicit
> > > >       address-dependency barriers.
> > > >  
> > > > +     [!] Note that address dependency barriers can be destroyed by comparison
> > > > +     of a pointer obtained by a marked accessor such as READ_ONCE() or
> > > > +     rcu_dereference() with some value.  For an example of this, see
> > > > +     rcu_dereference.rst (part where the comparison of pointers is discussed).
> > > 
> > > Hmmm...
> > > 
> > > Given that this is in a section marked "historical" (for the old
> > > smp_read_barrier_depends() API), why not instead add a pointer to
> > > Documentation/RCU/rcu_dereference.rst to the beginning of the section,
> > > noted as the updated material?
> > 
> > Sounds good. There's also another section in the same file on Address
> > dependency barriers (also marked historical). So something like the
> > following?
> 
> Given a Signed-off-by and so forth, I would be happy to take this one.

Thank you for helping me improve the docs, here it goes:

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] docs: memory-barriers: Add note on compiler transformation
 and address deps

The compiler has the ability to cause misordering by destroying
address-dependency barriers if comparison operations are used. Add a
note about this to memory-barriers.txt in the beginning of both the
historical address-dependency sections and point to rcu-dereference.rst
for more information.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/memory-barriers.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index acc8ec5ce563..ba50220716ca 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
 
 
  (2) Address-dependency barriers (historical).
+     [!] This section is marked as HISTORICAL: For more up-to-date
+     information, including how compiler transformations related to pointer
+     comparisons can sometimes cause problems, see
+     Documentation/RCU/rcu_dereference.rst.
 
      An address-dependency barrier is a weaker form of read barrier.  In the
      case where two loads are performed such that the second depends on the
@@ -561,6 +565,9 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
 ----------------------------------------
+[!] This section is marked as HISTORICAL: For more up-to-date information,
+including how compiler transformations related to pointer comparisons can
+sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
-- 
2.41.0.585.gd2178a4bd4-goog

