Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C407EBED7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbjKOIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:51:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C210D;
        Wed, 15 Nov 2023 00:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qSmi0veZCxUyGsLIdDPUXJ4vVHzrPiXaYm87kEuEwtw=; b=H7M1Wp9m2EXKmNVfz1TjHl0Sfm
        3sgLP+KLvxQSv8VrApa0Ha95zjbV4jksXoU+aoNTtWHabtjPRj/jAHfxLFyuKeXmQV+Kin7xPSH+e
        V5P6tPpgx2f80QmPyXXrs3Gr0YhXN/qMlpJJT50c98eC7NyHoAqxAarnnQ6xF+fD5SY/ROM4SJtQ5
        71iC7sMV7x2bo+JpGW5+2g17CsCK0SAN4OZ5P0K/6k0zSlNgDh2zwXvrTz8FeJ0R1yZRdtvSrh7QA
        +VcXPdzfkJR5o9AOC3bm2vgVygwJByx6x1OEYX7sQ+5K5Tv4tjnDXLYGxGJ9NMk6YK799S/emBPrn
        UswzkVuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3Bbz-003rZz-1O;
        Wed, 15 Nov 2023 08:51:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C7903002BE; Wed, 15 Nov 2023 09:51:03 +0100 (CET)
Date:   Wed, 15 Nov 2023 09:51:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "xry111@xry111.site" <xry111@xry111.site>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Message-ID: <20231115085102.GY3818@noisy.programming.kicks-ass.net>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
 <20231114154017.GI4779@noisy.programming.kicks-ass.net>
 <87ttpowajb.fsf@oldenburg.str.redhat.com>
 <20231114201402.GA25315@noisy.programming.kicks-ass.net>
 <822f3a867e5661ce61cea075a00ce04a4e4733f3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822f3a867e5661ce61cea075a00ce04a4e4733f3.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:11:20AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-14 at 21:14 +0100, Peter Zijlstra wrote:
> > Urgh, thanks!
> > 
> > Confirmed, the below cures things. Although I should probably make
> > that
> > FLAGS_SIZE_32 | FLAGS_SHARED against Linus' tree.
> > 
> > Let me go do a proper patch.
> 
> I saw these fail on the glibc shadow stack branch today, and I also saw
> this one failing:
> FAIL: nptl/tst-robustpi8

tip/locking/urgent (branch with the fix on) gets me:

root@ivb-ep:/usr/local/src/glibc# ./build/nptl/tst-robustpi8 
running child
verifying locks
running child
verifying locks
running child
verifying locks
running child
verifying locks
running child
verifying locks
root@ivb-ep:/usr/local/src/glibc#

Which, to my untrained eye, looks like a pass to me.
