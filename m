Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0580DD43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbjLKVdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345281AbjLKVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:32:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1BF4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:33:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB4C433C8;
        Mon, 11 Dec 2023 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702330379;
        bh=SOhK9Lq2M03sHZRGNtRe2gM1uwO43Dw3Vsd4hkpKqeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpfnzWkI9kltgIjchkhkVBWL5Ymd8PEmkFsAPYhKAONsoVGCqAkGBM/z97al55l+o
         jUeuKhRn8eefNEYz9ol+IKkYG1hFgVSzrCMLzVLu9h1omUt2/Ji3uVOoyEvzuYF+SZ
         VD4v87Pzhr3uMwltGLzV8YWTBqQm72f8A6eON+nGWpuD1qBPfqCRlLiB7M7nU8roVQ
         JJAFCATWC/ppt9Q1p1C+JlAPYGxM8lzmSbOtgPsJ6zekHBVr3DHmi5GPnpeCotGOxa
         PWloC1wSyDfMsruZxObMUMxaTWLsGalnuEylqXOH6rzRF2yFV5s6U+0LoJfrSHpnug
         kgeDwlpRvY59Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C30FD403EF; Mon, 11 Dec 2023 18:32:56 -0300 (-03)
Date:   Mon, 11 Dec 2023 18:32:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf stat: Fix help message for --metric-no-threshold
 option
Message-ID: <ZXeACPegTbAHqkHh@kernel.org>
References: <20231129223540.2247030-1-irogers@google.com>
 <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
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

Em Mon, Dec 11, 2023 at 11:39:02AM -0800, Ian Rogers escreveu:
> On Wed, Nov 29, 2023 at 2:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Copy-paste error led to help message for metric-no-threshold repeating
> > that of metric-no-merge.
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. Thanks,

Thanks, applied to perf-tools-next.

- Arnaldo

