Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7267E5EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjKHUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjKHUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00202121
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:10:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCCDC433C8;
        Wed,  8 Nov 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699474222;
        bh=J25KUy86NfApZ0qWpYlZcp82HfO5i4wtIPpaV2apC5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F58oEApuCiR9Ul+qxxkzzzJLijYO6ROIj5DIlTxjrW8VkenFlFJItHBB6X5KvtNr5
         Aozn8mM8MTBp0fOn4WkgO2b0WUea/dP7sLK1IAl+ZH2J2vc7/IIOOuh2kXng3UaZF/
         +EH3+aRjz+IuPSgEmEi3ujOFjWArpRX5pTtIwn1PJtNZzQwnO5mW1yOapZ7Upw2KAR
         /nDvpEk1OMayjfw+90UWMr5iRZMSlL6VoExiDR6tLISBssJyivC26SjtilJl0BELOK
         057c405lKiBPXglVrsL0KhoY5XPsibymUMp1TeB/sZ+hl86FJp1SpExosY1uNqDZXr
         /Tw+KkejaLDkw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1298C4035D; Wed,  8 Nov 2023 17:10:18 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:10:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2] perf test: Simplify object code reading test
Message-ID: <ZUvrKT0TjGeSi98K@kernel.org>
References: <20231103195541.67788-1-namhyung@kernel.org>
 <c1aedc2e-e51b-4b17-a05e-cd347f56d83b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1aedc2e-e51b-4b17-a05e-cd347f56d83b@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 06, 2023 at 10:15:07AM +0200, Adrian Hunter escreveu:
> On 3/11/23 21:55, Namhyung Kim wrote:
> > It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
> > open.  But other arch on a VM can fail with the hardware event and need
> > to fallback to the software event in the same way.
> > 
> > So let's get rid of the cpuid check and use generic fallback mechanism
> > using an array of event candidates.  Now event in the odd index excludes
> > the kernel so use that for the return value.
> > 
> > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > Tested-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next.

- Arnaldo

