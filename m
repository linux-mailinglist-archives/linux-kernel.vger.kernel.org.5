Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B675B2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGTPgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjGTPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136FD2736;
        Thu, 20 Jul 2023 08:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CDF7619D3;
        Thu, 20 Jul 2023 15:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC785C433C7;
        Thu, 20 Jul 2023 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689867365;
        bh=SOzOaZcxUwotyfy7EE1Z0020fjnxmP5RBNM/JGQZF8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNyOBCrAF9O3xXs3kXkF1oesh8velKQP6zAvyU/LtoGoR8cf6uwJy80UIKr6Cs6gv
         9QT21CYpbWwzM6U6EslVurwe9LJHRAooMLvWPyIyiYCjN7PT+bF7p6u1ZCDnQepOQd
         3ikn3zZEH5CDPWrsatK3xYCrO5qnzfLS8YF6Y+EjjQW6mazHBHRiPXvxAIASqSPM7+
         JwB0HTUQK4YvKeodFrRQN1dlmVfobZ8ix0fVUdz8kNNRzjp5oLhW1BMgARROmH0kVm
         mddXZsRr9kRHp5O8LyeAJDYvGSjVD/wcsePXTYeOD4VfBteVZy9Em7bsjKjEZAdHUY
         S8xCHg1YPoV4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E565240516; Thu, 20 Jul 2023 12:36:01 -0300 (-03)
Date:   Thu, 20 Jul 2023 12:36:01 -0300
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
Message-ID: <ZLlUYZTzSWCPi5sS@kernel.org>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
 <ZLfDPPYK1PXc9xOe@yoga>
 <ZLlPQsPeIXDGP02m@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLlPQsPeIXDGP02m@kernel.org>
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

Em Thu, Jul 20, 2023 at 12:14:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jul 19, 2023 at 04:34:28PM +0530, Anup Sharma escreveu:
> > On Wed, Jul 19, 2023 at 04:15:52AM +0530, Anup Sharma wrote:
> > > This patch series adds support for Firefox's gecko profile format.
> > > The format is documented here [1].
> > > 
> > > I have incorporated several changes based on feedback from the
> > > previous version of the patch.
> > > 
> > > Changes in v3:
> > a small typo here. It should be v4 instead of v3 (changes in v4).
> > > - Implemented object-oriented programming (OOP) approach for Thread and Sample
> > >   to improve code organization and maintainability.
> > > - Enhanced user experience by introducing argparse for changing color settings
> > >   of user and kernel symbols during execution.
> > > - Ensured proper module encapsulation by adding imports wherever necessary.
> > > - Improved code readability by adding descriptive comments and type annotations.
> > > 
> > > These changes focus on adopting OOP principles, enhancing user interaction with argparse,
> > > and making the code more readable with comments and type information.
> > > 
> > > TODO:
> > > - use cpu_mode to determine the category instead of finding it from symbol name.
> > > - Write a test.
> > > - add direct execution command for this script under script/python/bin directory.
> > > 
> > > Committer Testing:
> > > - Tested with a perf.data file generated for single and multiple cpu
> > >   cores enabled.
> > > - Uploaded the stdout into profiler.firefox.com and verified the
> > >   output.
> > > - Verified the output with the output generated by the existing
> > >   script as mentioned here [2].
> > > Method:
> > > - perf record -F 99 -a -g -- sleep 5
> > > - perf script firefox-gecko-converter.py > output.json
> > > - upload output.json to profiler.firefox.com
> 
> I see it in the cover letter, will try now.

I followed the instructions, uploaded a output.json produced and it
seems to work, good job!

- Arnaldo
