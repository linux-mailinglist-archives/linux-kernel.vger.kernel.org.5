Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A067F7598
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjKXNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjKXNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:51:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D241716
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:51:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AECC433C7;
        Fri, 24 Nov 2023 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700833878;
        bh=zL6LSOUpyol3f/TTZLpJE1N///sAY2bgqyQEwH2vTkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dz4lq766LPUPsGNg13Wj3cUhzgX7roA48usWCBEOUNwh2o5eEZS9ZMdO8vg2yUmE2
         JR9gEIts5UayGvhIHpm2f+lE9m2v/Ab3dt0dvePqK1ng7yQQRky5nkfYBAK1Szb1ab
         6et34VwqAaO3gt0YqEqF0TnRL4oZf2PKvmudFR4pbiHmKR7JKzdz/edbjvX4Q8Ufh5
         jTdjfAz1x6jpD/537bcMyUHGT7caB7uzh2agTQkLVYoveMobi/i2sok+78lOhRPgDy
         aVP/beH/uYvILfCOyTRA4+ogGJeb1TQKfR4KQEKUK8/zNooxIQTYGgZlREISYAN0Zd
         Ezlg2D3cRMmww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0245440094; Fri, 24 Nov 2023 10:51:15 -0300 (-03)
Date:   Fri, 24 Nov 2023 10:51:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZWCqUwZHUAWarXZY@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <86cyw0zeiu.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cyw0zeiu.wl-maz@kernel.org>
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

Em Thu, Nov 23, 2023 at 03:16:09PM +0000, Marc Zyngier escreveu:
> Now, in the interest of moving forward: this patch seems to address
> the basic problems I was seeing on both M1/M2 (running any kernel
> version) and Juno (running an older kernel), so:
 
> Tested-by: Marc Zyngier <maz@kernel.org>

Thanks, added to the cset.

- Arnaldo
