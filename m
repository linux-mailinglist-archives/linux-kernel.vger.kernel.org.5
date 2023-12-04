Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26E8803F34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjLDUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDUYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:24:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FB4AF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:24:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E507FC433C8;
        Mon,  4 Dec 2023 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701721455;
        bh=t6guQdtuvsHBXGA9XvBw3/0jpl3bZJRV5CbnFCzgr8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMc5oSRXoiHioGPOtY1GE/dQzL6bQNubzpwIBn8FdTOx62Zdn0JK4Pbjxw50QBPaI
         0pk4xr8RFQfnHsNwxu7DKHDlRUEvOglimx3Q6XhlLrd57IA2ESTbAjfGjyaz5CN39/
         K8Ge0PXIsBTJBM3Stqb6D163QI3ug/rVcdXScMQkQuR9CN1k48hpdnBsbE3WGvuL5S
         BmNsgqx/EFaAP5FHyVSUYq3spfSfJJFWi5tSv8J9wUvTTIVMDV9peFKtqvBQdp1XuD
         CtSMWerMrtNxo19B3lzLcFyPx++fSj9jPdgoN9wMBn3G6+jldf27MCQliXQ1hNGqyP
         GOkh6hsdv3+IA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49F2440094; Mon,  4 Dec 2023 17:24:12 -0300 (-03)
Date:   Mon, 4 Dec 2023 17:24:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v1] perf test: Add basic perf diff test
Message-ID: <ZW41bFSyg/xQLcEg@kernel.org>
References: <20231120190408.281826-1-irogers@google.com>
 <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
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

Em Mon, Dec 04, 2023 at 08:00:35AM -0800, Ian Rogers escreveu:
> On Mon, Nov 20, 2023 at 11:04 AM Ian Rogers <irogers@google.com> wrote:
> >
> > There are some old bug reports on perf diff crashing:
> > https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html
> >
> > Happening across them I was prompted to add two very basic tests that
> > will give some perf diff coverage.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied to perf-tools-next.

- Arnaldo

