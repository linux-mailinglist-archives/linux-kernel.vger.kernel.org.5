Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C876F58A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHCWSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHCWSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:18:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BBB3598;
        Thu,  3 Aug 2023 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691101102; x=1722637102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JzN2XbPsoJDABkLht7CpNWdDOSshQ7y20yYwZaLzqvQ=;
  b=ZbuNC4BE96K0WurJXYkwne4S+0cExmIrXf4MUB69o+i5kKSUU65gfFtp
   IMQyg3m179NyuD3UEJlDDgim7bt9EaEsQ+6Vz+JfNlY84zZJiHCYzGDbc
   yYuWDSSXZDgVZT0mIN4BXcss5SmJ08bg3LbK5jXZtsNmzCW01Z8nAtodm
   xiulMumuaQ+tpa1m9AjmfwQrpfUjQz+cZFFNErKCDlxNhOt2Mh+HB6NQk
   zzi3fr6oP0dCdsZiis0sfYqTJxwuSyBpwh620Iio7IgevZSk11OB0kAbp
   JiDm4//cu//6USfxTEY8Q08Uyt0y4ix6qB1aYgEScwCn8kaSl7fJxuAr9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373646347"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="373646347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 15:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="903609565"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="903609565"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 15:18:22 -0700
Date:   Thu, 3 Aug 2023 15:18:21 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Parse event sort/regroup fixes
Message-ID: <ZMwnrVRlAKM4qhcl@tassilo>
References: <20230719001836.198363-1-irogers@google.com>
 <ZLf4C/+x2ZSpb1Uz@kernel.org>
 <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's the status of this patch kit ? I don't see it in perf-tools-next

It should be applied to any branches that have the original problem.

Thanks,
-Andi
