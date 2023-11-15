Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D17EBF68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjKOJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjKOJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:24:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF752FC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pJp8rJXM3io9nq87coHQ0NbKIn/xU8MByc/0PWNbDS8=; b=u5IGH/PBWeAZfuEgNJei8efTbB
        sO0ouK2tYFlgMCZeRvYsXDjxuIXcWI4ZYahKFHUc+dlfQnB2HFgnntunCH2keVsb9WBWwAI1R+jI/
        ilv7gmg3k/A/M0inmW0V02kO1/v7tT5hfz8oVzgkFSdQVY5zvsmf4Qe3zbwbhaY43ohWarLzuowQ7
        A1W5h5+FJGN9ZpGuC9yj0wvl83YSye04q4m95U2xxmvWzPhOjehVBETR5ucF2GWEuvc8exoKPnGia
        lHnXy4qpr3+vtWgYUC7d8Vvxf8b11Re1TcQPMuqia4wUcl8yC1ulCGoZv7qn+wLsNVkwf4tYQLP5s
        iFOVydsA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3C8W-00DM8R-Sy; Wed, 15 Nov 2023 09:24:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B9193002BE; Wed, 15 Nov 2023 10:24:40 +0100 (CET)
Date:   Wed, 15 Nov 2023 10:24:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: Re: [PATCH 07/13] perf: Simplify: __perf_install_in_context()
Message-ID: <20231115092440.GZ3818@noisy.programming.kicks-ass.net>
References: <20231102150919.719936610@infradead.org>
 <20231102152018.499897182@infradead.org>
 <CAM9d7cg9N9izyKu1D4u0g_pfjLWaeR8rucbRKMx23kj8gs7x4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg9N9izyKu1D4u0g_pfjLWaeR8rucbRKMx23kj8gs7x4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:08:06PM -0700, Namhyung Kim wrote:
> You may want to remove ":" after Simplify in the subject line
> here and the next patch.

Duh, typing hard. Thanks!
