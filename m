Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE176F414
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjHCUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:39:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44830EA;
        Thu,  3 Aug 2023 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691095139; x=1722631139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ui8pT4QSnRjdR3WIhyY0tRtBQtjeMD2JTUos/SzfUik=;
  b=APLlFhxEc9jim+fFeg+3ggbjyWonJOkuceEkF9KNyYmHUOA6CeSk5LY9
   x+YnFroXIhTL5x8yb/0gy5KDn1tYnG2ATt3DEq3ksUUTCWj/502Y1d026
   UQ2F3SOfACRHSNwmfm/A/r4nA3FrXzLY5OXxYd/H7DO/wVO4qU+/4AlY6
   C+MGXtzGbsC284dJh72U3w42K0xgK7fhtUBzBv+RUYpWoQ73gLpi2JEhy
   dHBEyjA0d3mK3UFpYN+w11Mb48cpG6lHn97ukjShOwes1D70FPzd0ldC2
   zl86gNibYu9yctKy4r3VUvhYd9kAewGbU4nupprVmyakbuYR876mGt3EY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368891931"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="368891931"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 13:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819818851"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="819818851"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 13:38:58 -0700
Date:   Thu, 3 Aug 2023 13:38:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display zero tool counts
Message-ID: <ZMwQYTJeJ5cNfORr@tassilo>
References: <20230801205452.3380578-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801205452.3380578-1-irogers@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers wrote:
> Skip zero counts for tool events.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Andi Kleen <ak@linux.intel.com>
