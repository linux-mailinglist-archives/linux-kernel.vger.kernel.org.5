Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC887F61D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjKWOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbjKWOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:45:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC84D47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:45:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC5C433CB;
        Thu, 23 Nov 2023 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700750719;
        bh=xSS4XJ6jsV62nRxW5pw1LAIvE4xH/2T8q1MLLBd7+Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=st1k0okmO1npp2rBVOAMJV8vQk+sETYRZQoovYhJoEe57+4PXXMPuo4w5ZO03zIoZ
         qoq6C7vIVAny4Po1a0G2rYOFMxW7a/2CJcY5FIasxSmwnaOVAZBB57e8bzB5Q9dHNd
         X/0DUXnS6UjI6rglv/7hwsslR7U7IOdv4owPF1ZfHctD6MMkIb0OnX0QCX6eut5HcL
         qN67KeJmjSsEvRSoMFwhmJnr1pem7Xck9mnLjnUZZRVUdJxrncQm1/HWHCOvUrhu5M
         LjBdtj9I44nqAK3FMJhpSC2xotDDgQWskLVQEUTZoEqpwBQCz+qnKPO7ifN5lf0Boj
         BRbJLZMWgebdw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C9C340094; Thu, 23 Nov 2023 11:45:16 -0300 (-03)
Date:   Thu, 23 Nov 2023 11:45:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
Message-ID: <ZV9lfJyyC7xawHBC@kernel.org>
References: <20230602194513.1589179-1-namhyung@kernel.org>
 <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
> > The AMD IBS PMU doesn't handle branch stacks, so it should not accept
> > events with brstack.
> > 
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

It seems this patch was not merged, can you please check?

- Arnaldo
