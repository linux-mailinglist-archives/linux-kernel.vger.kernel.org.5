Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5EA764244
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGZWtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGZWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:49:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD419B5;
        Wed, 26 Jul 2023 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690411769; x=1721947769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6koQF/Wr+M0D3mGhnezuTmrPsuSRozteMCwklm//iMM=;
  b=T8vVcU9f2s1z+HIC4S0gv2NuzvbX539F1GBtbfOBYvOs3sEamCglf4wx
   RlK7/3+w/jB0N6nhBioY2ZYcvgrnWZ+0OTDfPzMNLb30WFWnp3fEiY334
   9UYtdoW7VJrkwi2sCXUuq1rHb7B2i7kLTir+9gp91Ey0JLQb2Wig5C8pP
   Jv3xFDNi/0nWcqkbwtNEt4h+ZKeajxuEr3YQ9KD8QwT73YulO2F4AbvKZ
   tfXhqlF+NdKCT/3TBoHXVxB+lZZFN5qY2sscCWR8P1P3u+K9ZFOK845Ne
   VFpMinfRJPU4sLpzKDbIHn+L4oJgs/g42XzG+cX0QDgNoWHbxrqNSMX3v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434421434"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="434421434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 15:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="973310738"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="973310738"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 15:49:28 -0700
Date:   Wed, 26 Jul 2023 15:49:23 -0700
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
Message-ID: <ZMGi3uY9f43VOd8C@tassilo>
References: <20230719001836.198363-1-irogers@google.com>
 <ZLf4C/+x2ZSpb1Uz@kernel.org>
 <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andi,
> >
> >         Can you please check these patches and provide a Tested-by?
> 
> I think we should be aiming to get these fixes/changes into Linux 6.5
> and it's a shame this didn't happen last week. Feedback appreciated.

Sorry for the delay, I was finally able to test them now and they
resolve my issues. Thanks

Tested-by: Andi Kleen <ak@linux.intel.com>

-Andi

