Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E850C75366C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjGNJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGNJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:29:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC522D55;
        Fri, 14 Jul 2023 02:29:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 52FBE1FD60;
        Fri, 14 Jul 2023 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689326944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJwS6jgM/F6rS04d9Wc7YkG+2OJLOoEr4udYg+BGyWw=;
        b=M7ByKjPFDt0Rl68Wb1mvPnAjDU5b3pAE5iH9/ciB8X3D6xixrnXoSQrV8Rh3yToMKgUEJR
        oPISriOh5bLfikITiwKuaJwUN6FaPBVWmMvx8nXWBTYMNZIeg+VjCkwG3EuRYshxXz7lPf
        A/phey/kQFkpQVENnHfz6gZD0tWjx6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689326944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJwS6jgM/F6rS04d9Wc7YkG+2OJLOoEr4udYg+BGyWw=;
        b=k+C8NSid4g/P8wTLz5Q9iHDOuQnYjvks/1FLJZmrLFGYlbJlJnkWj2ktRkgPOAZd1rNaqg
        1m+w+8kfkkYyhwDg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6FD42C142;
        Fri, 14 Jul 2023 09:29:00 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:28:53 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: Rename DIE domain
Message-ID: <20230714092853.tueulnlqloc3m4gw@suse.de>
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
 <xhsmh1qhduq9d.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <xhsmh1qhduq9d.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:02:38PM +0100, Valentin Schneider wrote:
> On 12/07/23 16:10, Peter Zijlstra wrote:
> > Hi
> >
> > Thomas just tripped over the x86 topology setup creating a 'DIE' domain
> > for the package mask :-)
> >
> > Since these names are SCHED_DEBUG only, rename them.
> > I don't think anybody *should* be relying on this, but who knows.
> >
> 
> FWIW I don't care much about the actual name.
> 
> There are some stray references to DIE in comments - see below. Bit funny
> to see:
> - *  - Package (DIE)
> + *  - Package (PKG)
> 
> With that:
> Acked-by: Valentin Schneider <vschneid@redhat.com>
> 

No objection either, PKG is less ambiguous than DIE

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
