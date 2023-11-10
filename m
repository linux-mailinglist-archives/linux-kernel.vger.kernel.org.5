Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D57E75FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjKJAgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJAgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:36:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AA7D5B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:36:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC14C433C8;
        Fri, 10 Nov 2023 00:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699576607;
        bh=uaX2GRKJcT3QsiQ08mwuxaU2ExcVV+upzZMY17FIQyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glecga37pnbe4SYO7TmX6VZVcFvFIVqEI/d5WAaHj4xgU1oxZfJt8dTq9B96I4vOQ
         TjfUTY6HbfpWGDrhSq3dSZEAWuEaP2vhXDiCEyVOoUcpX4rqCsKHzO97Xh6cC63c8+
         Lt9U5OQdQ7MsEx6siGZHcVA7X3tZKZ7MlQ2NS77Df0Z/e90VKW3kPnldyHqCVBVs4t
         LQViupOeD8t20fYJycTYsUWq+V9NYOiSZHXQEv/+XL4QISAkCx7aI0HCrvza5TNpMZ
         ptI/5DMNNG3T3Y9VAPw2/M0ZnNSCl+Gtm0ezuXOlx9B7j6wAjdZpGZHgb35AsSpbvg
         GNjqtYqH+zi3Q==
Date:   Thu, 9 Nov 2023 16:36:45 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH] x86/retpoline,kprobes: Fix "Fix position of thunk
 sections with CONFIG_LTO_CLANG"
Message-ID: <20231110003645.pfkoptpma4dkt7ey@treble>
References: <20230803215555.zl5oabntc44ry3uc@treble>
 <20230803230323.1478869-1-andrew.cooper3@citrix.com>
 <20230804082853.GM212435@hirez.programming.kicks-ass.net>
 <20230804084328.GA220434@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804084328.GA220434@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:43:28AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 04, 2023 at 10:28:53AM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 04, 2023 at 12:03:23AM +0100, Andrew Cooper wrote:
> > > Alternatively,
> > > 
> > > int strstarts(const char *s1, const char *s2)
> > > {
> > >         return strncmp(s1, s2, strlen(s2));
> > > }
> > 
> > Durr, I hate C ;-/ And yes, we have a ton of it, lemme try that
> > strstarts thing.
> 
> So there, that builds and compiles a kernel, must be good :-)

Would be nice to see this strstarts() change go in ;-)

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
