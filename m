Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3833379EE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjIMQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIMQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:15:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F253B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/UvxbVpr/bNuH2u+xtjCtQukacB0w3B75uyMebXh8Xc=; b=t4P5Kpqv+8ksntvRZSB3nYDa0v
        WG63pskzTdKCNzhk1yvz88h8C0/7sMFTs4vqPOs6rrPak2Tp9Gh3rTRIUQoKuePe+0Wz0e3eY3aaV
        Tmm578NTKAT9yQOOb0hHRIgfdi5Bf/IxsJNKHc7uX6zjv38hLaYb0fa6G2OoNOaN0uEpzlVm9HeCI
        jMMl+RqiIp4//WbLd49IzjSW3fUZxsFmkDMcCX7FEKcKA/KbiOhkDgUurALaUDu97yR9vPc2EoGTh
        MM8cXqzEXlx0i/+IqR7rL/liG69nadgVrPZANsjNBas/zOkQDnrr6L3m3B3oazzGu5TnyiqFfgagr
        8Lx9GUoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgSVp-00Er3t-1z; Wed, 13 Sep 2023 16:14:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4D6B300348; Wed, 13 Sep 2023 18:14:44 +0200 (CEST)
Date:   Wed, 13 Sep 2023 18:14:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230913161444.GJ692@noisy.programming.kicks-ass.net>
References: <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
 <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
 <20230913084658.GA692@noisy.programming.kicks-ass.net>
 <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:47PM +0200, Borislav Petkov wrote:
> On Wed, Sep 13, 2023 at 10:46:58AM +0200, Peter Zijlstra wrote:
> > We've gone over this multiple times already, also see commit
> > 6c480f222128. That made sure the kernel side adhered to this scheme by
> > making the tail a single instruction irrespective of the length.
> 
> Yes, sorry about that. I've been putting off digging deep into objtool
> internals for a while now and there are no more excuses so lemme finally
> read that whole thing and what it does in detail. And thanks for
> explaining again. :-\

No worries, I always seem to forget a detail or two myself :-)

> As to the patch at hand, how does the below look like?

Brain is fried, I'll give it a look tomorrow.
