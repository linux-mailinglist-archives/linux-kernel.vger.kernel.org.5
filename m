Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494727D542F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJXOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjJXOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:39:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8427C8F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XWTVzhfyS8eE4lS4i90Kj4AdBQgL75eH1l13yrEoFZg=; b=HhiYUYszXGh0hOf43V5FGyc88W
        axNL6dg8TWIOZ8+YYHODVEBJLCE6S+ZjDW7Mp5u7caLKCG5Q6yYxUGkyij/UbWmhAC/6qjgXKFk/r
        /k3cMXHOPkt0DUl4Lalr+AKtHgZsYM7GA9F8yldBRf/ZjQSVy8qJbh94kSESGskxTNQy/71BZoaeD
        D+WpPLlu+gq4KwMFVKWq6ckCu6+cTU1+rKMmX0LWkm8/UGblPF0hJQxQILf7v9l4pU2mdqgmpeTgL
        TL0Q36u6KEe5vaAgjW+9g/3ss8LHSJURyaC2zIIp+tiXw3CY1lAl+ZKv2GlwGXrfQdVZ1fS3RTO4V
        7j2GmaVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvIYn-00317T-Gn; Tue, 24 Oct 2023 14:39:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25CE3300451; Tue, 24 Oct 2023 16:39:09 +0200 (CEST)
Date:   Tue, 24 Oct 2023 16:39:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liangliang Li <liliangliang@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] freezer,sched: Report TASK_FROZEN tasks as
 TASK_UNINTERRUPTIBLE
Message-ID: <20231024143908.GA40044@noisy.programming.kicks-ass.net>
References: <20231023135736.17891-1-liliangliang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023135736.17891-1-liliangliang@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:57:35PM +0800, Liangliang Li wrote:
> TASK_FROZEN is not in TASK_REPORT, thus a frozen task will appear as
> state == 0, IOW TASK_RUNNING.
> 
> Fix this by make TASK_FROZEN appear as TASK_UNINTERRUPTIBLE, thus we
> dont need to imply a new state to userspace tools.

Who or what is seeing this and caring about the result?
