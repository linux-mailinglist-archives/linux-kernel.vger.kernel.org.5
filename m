Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C579D04A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjILLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjILLpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:45:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D3B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BE2BxPL7+/Xuf8hAcCNkgmDP0+B9knqhriBIud97pBs=; b=iqOzGmDe5ZGBFsq9ZbLXfxWvaI
        awItlqn7ywPYpaYH7Dhd/5/cIOwd7j1uh6RZE2efnevx/PbqB6Py5UbXjMqzDZTPhx439OIzcwZaI
        gJd4js6CQ5OfHJS32MmRmY6IcDsRg5vMTYw3aiawaRPjb5a5nCWEixWLfztjKnniLcPf/guMfFWtG
        cKZIywZFaLbRg289xWqBjoGoslz0sYF6H2iqiTGnxrmIr0Q0u4gWVfQfG+EQKMYUaP9rSczzPRiKo
        X6BJLBEUgCHbssiN71rFDB9Fxaa9G+NqeJh0vL70WqGokWR25AgojXxmCmbVVGKaaNrTpOzme4ISt
        wQnhDdiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg1pK-007NGt-De; Tue, 12 Sep 2023 11:45:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16077300348; Tue, 12 Sep 2023 13:45:06 +0200 (CEST)
Date:   Tue, 12 Sep 2023 13:45:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ben Segall <bsegall@google.com>,
        Caleb Callaway <caleb.callaway@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sched: Restore the SD_ASYM_PACKING flag in the DIE
 domain
Message-ID: <20230912114505.GC12405@noisy.programming.kicks-ass.net>
References: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:57:47PM -0700, Ricardo Neri wrote:
> Commit 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup") dropped the
> SD_ASYM_PACKING flag in the DIE domain

Urgh.. indeed.

> added in commit 044f0e27dec6
> ("x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
> processors"). Restore it on hybrid processors.
> 
> The die-level domain does not depend on any build configuration and now
> x86_sched_itmt_flags() is always needed. Remove the build dependency on
> CONFIG_SCHED_[SMT|CLUSTER|MC].
> 
> Fixes: 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup")
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Caleb Callaway <caleb.callaway@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks!
