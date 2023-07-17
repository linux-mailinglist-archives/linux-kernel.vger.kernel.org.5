Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F096756637
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGQOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:20:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A111C;
        Mon, 17 Jul 2023 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YTB3jIgbCA+yJ3H1mtGWhQsDDrkuDaZKrW1gtwvuVxw=; b=UcRyakYhuDKcAWEKsdazUAfnw7
        RZaCbDIX67l1zTgCL4TNh834+LTtzG27eLggbDRa8yNpcJBCsVna3JyHV07e3Dz5VkqUlzmWl/uoB
        APnmOkx45QsftA4QPmMS4iaum5dgUpwxSFo29wpCSM0xPK3YqyTgHfYEdhxTdX81gXLVb5XRx+cSk
        MyBs+tvZlbCeOc+y0uyqzUrVa5SB69j/gRSSuvnw/ZzVw67Zy0eNszDs1KyYngZGNRaRnCT/si91J
        5g8w7fB0dCACyy65wy/r1v7rK+P9RUOQGUjNPu+Has65LcE8+kTg/+OztQa+KLMhmOWG4K7AzpBZB
        5hDd07aA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLP4n-0098rB-0r;
        Mon, 17 Jul 2023 14:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 243E330020C;
        Mon, 17 Jul 2023 16:19:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A48E2461DA7A; Mon, 17 Jul 2023 16:19:47 +0200 (CEST)
Date:   Mon, 17 Jul 2023 16:19:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: Rename DIE domain
Message-ID: <20230717141946.GL4253@hirez.programming.kicks-ass.net>
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
 <CAKfTPtBga3CMVNGt5YEJiyfWDiWWQ0c+5_EAzY0spMFiUQBMmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBga3CMVNGt5YEJiyfWDiWWQ0c+5_EAzY0spMFiUQBMmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:51:25PM +0200, Vincent Guittot wrote:
> On Wed, 12 Jul 2023 at 16:11, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi
> >
> > Thomas just tripped over the x86 topology setup creating a 'DIE' domain
> > for the package mask :-)
> 
> May be a link to the change that triggers this patch could be useful

Thomas should post soonish..
