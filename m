Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A37FA2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjK0OfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjK0Oer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:34:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F384499
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:33:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CF8C433C7;
        Mon, 27 Nov 2023 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701095580;
        bh=k7wVp+e3D9F3NQ0pFi06SqvZGVEp4myFmLgXPyk901I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbL2pOFjeXHRDBv9+zX6T95CNUa5LMCl2XTD3hvqHVaA7Prmm9stp3P5FAlvTIwOO
         fL8OvhdzKN9wZ0NGNgrH9zvBSLeXJxM9CChSL9j7AnKBQKYe5lKzN9PK51cg5OxPvn
         3t5u+CQzZWYQ7FPO4ox/IucyF+KOPJqS6pXWMm0e0ow9EwozpJtzzQvC7bLW1j5Dbs
         FPKFitsXqUOnXfbVDeS78E372JM0lsFwgfzurqqFz6Jejh7XxlqCOFmnJ8RjMP87g5
         /Co3vuX9DRNkfa+qzu6R3Kr0HVnMwjzMeLIm1oWG5fba27MPhDXDZ51noyE73TSP7K
         GKi8YKpfxbbRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A041E40094; Mon, 27 Nov 2023 11:32:57 -0300 (-03)
Date:   Mon, 27 Nov 2023 11:32:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
Message-ID: <ZWSombzfCkxHc7lC@kernel.org>
References: <20230602194513.1589179-1-namhyung@kernel.org>
 <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
 <ZV9lfJyyC7xawHBC@kernel.org>
 <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 24, 2023 at 09:30:37AM +0530, Ravi Bangoria escreveu:
> On 23-Nov-23 8:15 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
> >> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
> >>> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
> >>> events with brstack.
> >>>
> >>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>
> >> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > 
> > It seems this patch was not merged, can you please check?
> 
> Right. And it does not apply cleanly on peterz/queue.git/perf/core, since
> surrounding code has changed.

Can you please refresh it if PeterZ has nothing against?

- Arnaldo
