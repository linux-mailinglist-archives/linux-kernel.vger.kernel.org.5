Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1E7760A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHIN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjHIN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66D268C;
        Wed,  9 Aug 2023 06:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A0F63AE7;
        Wed,  9 Aug 2023 13:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40C1C4339A;
        Wed,  9 Aug 2023 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691587698;
        bh=IxApwh33/aJkVQAgEepQkLoYD1avbYlKUbd6GWQT4yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M55USQCRdGrLmiomuHVBXGof2MHxlCoeoQM1OZZ4SeZjwutoOXJOshQ8t2i5mPCYm
         Cijk5I7YBCtaiGAqZVyuk4EGuDtDnJIOb+SjtSV2gGU8FPiST5fH8iksGsXSRAnRuf
         hX4CfSqWpGT3mjLgye8U7HenSYS1ZW5ocQtTjVlG0FePmYTUKlsUZ5SfvAxCxmsNFf
         LeyC6wyCRm9WjM08Uaeg7gsnZnXSh0fW15ziNji0obmbxk/ch/5twygEnXQ7nrHqKl
         j5BKABss4g6+dH6x7ZuQAHu4aSQDW0eCF28ENPBGZMqElNtNJUMax8Srd98AocemJF
         Ikr9N4meNvmqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28138404DF; Wed,  9 Aug 2023 10:28:15 -0300 (-03)
Date:   Wed, 9 Aug 2023 10:28:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf build: Update build rule for generated files
Message-ID: <ZNOUb1Q5ifyLju/q@kernel.org>
References: <20230728022447.1323563-1-namhyung@kernel.org>
 <ZMPMHNjX2IxsLbAe@kernel.org>
 <CAM9d7cgqJatFn0tQVOxoQymFUruSzniPi5Okb1sotb6VLt+X_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgqJatFn0tQVOxoQymFUruSzniPi5Okb1sotb6VLt+X_g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 09, 2023 at 03:56:17PM +0900, Namhyung Kim escreveu:
> On Fri, Jul 28, 2023 at 11:09 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Jul 27, 2023 at 07:24:46PM -0700, Namhyung Kim escreveu:
> > > Let's update the build rule to specify those cases explicitly to depend
> > > on the files in the output directory.

> > > Note that it's not a complete fix and it needs the next patch for the
> > > include path too.

> > Applied, testing it on the container builds.

> I don't see these commits in the perf-tools{,-next} yet.

6 days	perf build: Include generated header files properly	Namhyung Kim	5	-9/+9
6 days	perf build: Update build rule for generated files	Namhyung Kim	2	-0/+16

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=7822a8913f4c51c7d1aff793b525d60c3384fb5b
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=c7e97f215a4ad634b746804679f5937d25f77e29

Did I miss something?

- Arnaldo
