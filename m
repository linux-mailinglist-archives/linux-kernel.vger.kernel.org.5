Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22742776C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHIWOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIWOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:14:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0FC2704
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691619254; x=1723155254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W3IB25k2Co18Z7vs9YCum1Rliyq4Rp5Ep/oX7D69sSk=;
  b=jXPy1vQNrWY5h3zvFhE6yYBmv56f8Zo/0Wdp6hZbTZp8Fwl3sES3LyK+
   Qjl0DGPHJ0bf3uaVys7baO7jEKea1Q7jn7f3g2sDZGrMBQ7qbdimhFgRq
   H3gGT+zCkyT5ounhPfWW0l+jEzfwqQk6C2SR5Ap2SQWy1brwOikLBYpVw
   SPf2vtNPR+hM2uR01yq/0eU/RvmoGhXfZhyoiF7ZAlMrNLQEUIMXnfJqE
   wSug4RC81R+93sOXV1qz28sCNJnbXdocnuL49JgOkSbsKxv9LK6W13EDU
   pwKrOsvr1iKQrxXOn4yo3X2EXW9V2cZh5btpBKeKJ7s1qG1Py3Fkx62mM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="437600058"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="437600058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="731975171"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="731975171"
Received: from ridwanfa-mobl1.amr.corp.intel.com (HELO [10.252.128.201]) ([10.252.128.201])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:13:59 -0700
Message-ID: <4442b44b-9680-90c0-c47f-b96c51cf284e@intel.com>
Date:   Wed, 9 Aug 2023 15:13:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] x86/speculation: add cpu_show_gds() prototype
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230809130530.1913368-1-arnd@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230809130530.1913368-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 06:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function has two definitions but no prototypes:

Thanks for these, Arnd.  We'll get these up to Linus, probably alongside
some of the other fixes for the other hardware issues that got mitigated
this week.


