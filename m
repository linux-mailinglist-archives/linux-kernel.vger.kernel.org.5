Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7209975B222
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGTPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGTPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89A26B7;
        Thu, 20 Jul 2023 08:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8558F61B40;
        Thu, 20 Jul 2023 15:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7459C433C7;
        Thu, 20 Jul 2023 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866053;
        bh=SYfNfhlOZs1q5RkjFnYWwaHIEk3S3ptpgkBUSyHPVoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9FPvbKy84f13PnvFGY9rliE0oVvRlk4NdpYAIpnfmGpeaW9fyY/cpBobj9rWYp6i
         PZjOg4Z2d40z7gEOO/acq2hPBeOK2Rttv64+wDmPy0j2wIkjeGIfzS65qJZpndg44l
         +6J+4XSRJeKyx2DEnM4HZThEmond57P1huiW8C9Ul72JHgneflt76RixZ+7r5LePiM
         DLtwOy/h9jNZXaAiT4s6p6kBuo7zo8S9vOwXx5oVc8dzwoiOHdp9W/oaTTFP7Ao06Q
         rslPvZodmeCqCgJdoEEkeEdFZYUdccLllSBP9pro/i3ATtR+F54GyOOL5ebxXBal10
         hP7e9XDekWTNg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BA9140516; Thu, 20 Jul 2023 12:14:10 -0300 (-03)
Date:   Thu, 20 Jul 2023 12:14:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add support for Firefox's gecko profile format
Message-ID: <ZLlPQsPeIXDGP02m@kernel.org>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
 <ZLfDPPYK1PXc9xOe@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLfDPPYK1PXc9xOe@yoga>
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

Em Wed, Jul 19, 2023 at 04:34:28PM +0530, Anup Sharma escreveu:
> On Wed, Jul 19, 2023 at 04:15:52AM +0530, Anup Sharma wrote:
> > This patch series adds support for Firefox's gecko profile format.
> > The format is documented here [1].
> > 
> > I have incorporated several changes based on feedback from the
> > previous version of the patch.
> > 
> > Changes in v3:
> a small typo here. It should be v4 instead of v3 (changes in v4).
> > - Implemented object-oriented programming (OOP) approach for Thread and Sample
> >   to improve code organization and maintainability.
> > - Enhanced user experience by introducing argparse for changing color settings
> >   of user and kernel symbols during execution.
> > - Ensured proper module encapsulation by adding imports wherever necessary.
> > - Improved code readability by adding descriptive comments and type annotations.
> > 
> > These changes focus on adopting OOP principles, enhancing user interaction with argparse,
> > and making the code more readable with comments and type information.
> > 
> > TODO:
> > - use cpu_mode to determine the category instead of finding it from symbol name.
> > - Write a test.
> > - add direct execution command for this script under script/python/bin directory.
> > 
> > Committer Testing:
> > - Tested with a perf.data file generated for single and multiple cpu
> >   cores enabled.
> > - Uploaded the stdout into profiler.firefox.com and verified the
> >   output.
> > - Verified the output with the output generated by the existing
> >   script as mentioned here [2].
> > Method:
> > - perf record -F 99 -a -g -- sleep 5
> > - perf script firefox-gecko-converter.py > output.json
> > - upload output.json to profiler.firefox.com

I see it in the cover letter, will try now.

> > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> > [2] https://perf.wiki.kernel.org/index.php/Tutorial#Firefox_Profiler
> > 
> > Anup Sharma (6):
> >   perf scripts python: Add initial script file with usage information
> >   perf scripts python: Extact necessary information from process event
> >   perf scripts python: Add classes and conversion functions
> >   perf scripts python: Add trace end processing and PRODUCT and
> >     CATEGORIES information
> >   perf scripts python: implement internal get or create frame, stack and
> >     string function
> >   perf scripts python: Implement add sample function and thread
> >     processing
> > 
> >  .../scripts/python/firefox-gecko-converter.py | 339 ++++++++++++++++++
> >  1 file changed, 339 insertions(+)
> >  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> > 
> > -- 
> > 2.34.1
> > 

-- 

- Arnaldo
