Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED195785DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjHWQ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjHWQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F6CE66;
        Wed, 23 Aug 2023 09:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55C062E36;
        Wed, 23 Aug 2023 16:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AA0C433C7;
        Wed, 23 Aug 2023 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692809754;
        bh=++6HhCwUPGOWOXz/P0X/vVAw0YbnEpCGFrio3lMQ3Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAKTh5FZImC+h77+VqXozdKosY6YXBqcozXkt86lRDoT0uUmnO/OEf2dmeos0AKi2
         nvuZjri7s4qfW2AIiMeJxIH8ubMErybJGZRkUDQGiQZKRaUYYFMO/+9J13IzCxT3gj
         nLJBr56VuQ2pccCvA5t09JPH3onw0M5Xp8XtF9Gmlm6EMeJ1socehOefzIZDTU70HL
         lT5g/mTeTgerFgutR79HMmC3rN9Xa64fFAkr0MCMgv8schPnYo0q4VuxCCmAcepYzA
         HcBWx/Hzrin8dQ2THBqEXu5HSuAXplhwvK0Y00EsraUXs5OY5iaRU2NeRVVHrL94cL
         po7tfIAzOJGaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B184A40722; Wed, 23 Aug 2023 13:55:51 -0300 (-03)
Date:   Wed, 23 Aug 2023 13:55:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [perf-tools-next:tmp.perf-tools-next] [perf dlfilter]
 f178a76b05: perf-sanity-tests.dlfilter_C_API.fail
Message-ID: <ZOY6F1+o05kHOwMi@kernel.org>
References: <202308232146.94d82cb4-oliver.sang@intel.com>
 <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 23, 2023 at 06:37:49PM +0300, Adrian Hunter escreveu:
> On 23/08/23 17:57, kernel test robot wrote:
> > kernel test robot noticed "perf-sanity-tests.dlfilter_C_API.fail" on:

> > commit: f178a76b054fd046d212c3c67745146ff191a443 ("perf dlfilter: Add a test for resolve_address()")
> > https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

> > [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
 
> We sometimes make a test for an issue then fix it, so the new test fails,
> but is fixed in a subsequent patch.  If you read the commit it says as much:
 
> commit f178a76b054fd046d212c3c67745146ff191a443
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Mon Jul 31 12:18:55 2023 +0300
> 
>     perf dlfilter: Add a test for resolve_address()
>     
>     Extend the "dlfilter C API" test to test
>     perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
>     after a subsequent patch.
>     
>     Reviewed-by: Ian Rogers <irogers@google.com>
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Link: https://lore.kernel.org/r/20230731091857.10681-1-adrian.hunter@intel.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> The fix is:
 
> 42c6dd9d23019ff339d0aca80a444eb71087050e perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()

I wonder if we can automate this aspect of testing, by adding some
markup that states that this _is supposed_ to fail, and if it doesn't,
then we get a notification. It should probably also means that the next
cset will make the test pass, ideas?

- Arnaldo

> > 
> > in testcase: perf-sanity-tests
> > version: perf-x86_64-00c7b5f4ddc5-1_20230402
> > with following parameters:
> > 
> > 	perf_compiler: gcc
> > 
> > 
> > 
> > compiler: gcc-12
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com
> > 
> > 
> > 
> >  66: Convert perf time to TSC                                        :
> >  66.1: TSC support                                                   : Ok
> >  66.2: Perf time to TSC                                              : Ok
> >  67: dlfilter C API                                                  : FAILED!  <---
> >  68: Sigtrap                                                         : Ok
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20230823/202308232146.94d82cb4-oliver.sang@intel.com
> > 
> > 
> > 
> 

-- 

- Arnaldo
