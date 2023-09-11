Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87879B50A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbjIKVdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbjIKPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:49:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37710127;
        Mon, 11 Sep 2023 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ko17kavfVj+HfXqIm9MQHdViB+9IoLlidL74lacsJAQ=; b=Hz33GisP6UUArNhPQCpdzrJXcS
        Clxa5Fgw+fqbEfcgxfu9b7bfofv7blrjh85D9CXsHpvnlckKV4Pq4t7MxkB+vm5fuAu6mewFy6Elw
        NLcM1L1mqX7lkbqZ+ynq81Xn+o2nx6dm72Ar0fvtpyufwXSkm6wIPHlnoZqwM3AHjotx2l13TzrJ6
        JoQ3yJsaus06qCAHBqkqbo0E5dgRGpc7wIkuYSqZqCCd1WP9QzXd75OPvbcNhBknJWZF0pZr22JTM
        a7TXENMtwlJGyW0lTX1U4/DMwEVQKAPYzE0GQ/pEsjjKcdNPIjUBbd3VaDsYrSULjzOOftDYUTdYh
        ZgSW05lQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfjAF-001lab-O2; Mon, 11 Sep 2023 15:49:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DCFB3005B2; Mon, 11 Sep 2023 17:49:27 +0200 (CEST)
Date:   Mon, 11 Sep 2023 17:49:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
Message-ID: <20230911154927.GD9098@noisy.programming.kicks-ass.net>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:49:14PM -0700, Elliot Berman wrote:

> Elliot Berman (2):
>       sched/core: Remove ifdeffery for saved_state
>       freezer,sched: Use saved_state to reduce some spurious wakeups

Thanks!
