Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5043E7D0140
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjJSSSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjJSSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:18:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEFC121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rFjZthvUcRHrev6/lNwdhcugrXSRgmA/ZDr/SVp/L4E=; b=h2dxGRcHaMBvH3z5pMDJFe2nei
        g6qmdgv7ovT9leyG2BQs/zEoVQ47YY92FE7Ef79BMCGvjXBORkv7I5Ni5AceIzLNzknZbgIgueiCH
        3UYypSyvNoBVj/2WEH+FyskYxvO9JXHd9Z9RKUYX9/R9woTX4bq2giaKpD41nDKJKag3EDl2sHxAG
        TVwaNVbavwP308iVI3UfYxaKQrEraGhJPXSE8pDY+nyEoAcHmyYhgVkjMPI8FvhnqfdiAj8MERsia
        7/ZsEKU7R81Eow5e60pEh9UygpYB86R65iA2LCYBzgx09adQJYrQ8wx91eK2pMktNF3MEPjvP9622
        5H7Minag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtXbH-008Uwk-Pw; Thu, 19 Oct 2023 18:18:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78AFE300392; Thu, 19 Oct 2023 20:18:27 +0200 (CEST)
Date:   Thu, 19 Oct 2023 20:18:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019181827.GB35308@noisy.programming.kicks-ass.net>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
 <20231019105231.GG36211@noisy.programming.kicks-ass.net>
 <c23fa9e8-1b37-4d44-a554-f8f0508968b0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c23fa9e8-1b37-4d44-a554-f8f0508968b0@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:26:01AM -0400, Liang, Kan wrote:

> The original LBR event data is saved at offset 32 of LBR_INFO register.
> In get_lbr_events(), the data was simply copied to the offset 32 of
> cpuc->lbr_events.

Urgh, missed that. Clearly reading is a skill :-)

> 
> The intel_pmu_update_lbr_event() reorders the value and saves it
> starting from the offset 0.
> 
> I agree it's hard to read since it combines the src and dst into the
> same variable.
> 
> I will use the suggested code and also update the get_lbr_events().

Thanks!
