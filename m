Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54C788DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjHYROH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjHYROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:14:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE51FFA;
        Fri, 25 Aug 2023 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692983640; x=1724519640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNizbAUX2vHUEcLO1lnDqTj1v3bGzD9yzFiCUNYjnNk=;
  b=RodNunyaDrW5+4c5mWQrjw3N5FnZjNkVyGZgNnXU78V8HAr9BJWUxMDQ
   ZV4/apQ55WrZx5/e6A3HeS1+oFPE8EEW6EJExBp94Im48VGvZ3dQUg+6B
   UNkieUguAfPk7xDd12HEYomgm1eA0ncC8SgJr9KF2Xoq/hy/70mt16iEp
   dOlx8QBo07sp8w3w4i4yPIxfcJlAa4YsrLaO0PBiQgPpkNZg6apwa6ID6
   PocldbfnonnxIH/jCw4mb7p25TVNrH7nTpb13kFeqddWiJZNh76grkBQT
   1t5Eq4Wg4+ZZbnPgQT8kYZsmS8ODMtK8oqcZght1Ca2QZnmynC7RTbT0p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="373627368"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="373627368"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="861144294"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="861144294"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:13:49 -0700
Date:   Fri, 25 Aug 2023 10:13:47 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 4/7] x86/resctrl: Delete unused fields from struct
 rdt_domain
Message-ID: <ZOjhS32vVBfrYgrG@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-5-tony.luck@intel.com>
 <8a5722f0-35aa-a0f4-84a6-467c263e4a88@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5722f0-35aa-a0f4-84a6-467c263e4a88@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:30:47AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/22/2023 12:07 PM, Tony Luck wrote:
> > Now that all the monitoring functions use struct rdt_mondomain the
> > monitor fields can be dropped from the structure used for control
> > operations.
> 
> Please provide some context for this patch so that it
> can stand by itself when merged.
> 
> Note that two structures are changed in the patch.
> 
> Reinette

Commit comment rewritten.

-Tony
