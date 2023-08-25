Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05600788215
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjHYI3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbjHYI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:28:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA25C1FF2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692952102; x=1724488102;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=W9yaD+iT4rsMR1BTSj/evhNvoFbsYSRZkQ9B0szKXcQ=;
  b=LVIf2NX4vEV7rVXKpKub5G3lDQtPXmfagXvSDPAKty1Kk1vIn02BJSlI
   7ZbCudbG5P7ASj6igDUbiJjezXTCsFGaRmBVOMVoR6vTgi9BbQwQBlDKH
   RWPnMT8lnNnGCwY0r/sBMj5OPPlc/goNOwFAGD4rkYN0XnEDZfFF+U8vN
   66zWO4++t+lj99gWmquCTcZv6y92FP4DxDwqbqMwTiDGfzjZPaNZFfxbx
   fqeE7kcQQWRJgWsPnoh8fDBfJumSobwaO60kv5kC6TxCIAmWAMpOvv+o5
   q023EXIZlRGFL1MT2YXENdskgaAGfmtY5GHXwMQuFEt+yV0Ex3+t1Xuxm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359663032"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359663032"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851880811"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851880811"
Received: from enguerra-mobl.ger.corp.intel.com ([10.251.213.8])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:28:20 -0700
Date:   Fri, 25 Aug 2023 11:28:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Subject: Re: [PATCH 3/3] selftests: Add printf attribute to ksefltest
 prints
In-Reply-To: <elcfjzpnxfeyum2t6w6nwu2mtfbgvnabypqmzw5p6f7g5rpr7p@74rg7ziipg7j>
Message-ID: <0f5533a-92db-b462-f7bf-14a8d595baa1@linux.intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com> <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com> <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com>
 <elcfjzpnxfeyum2t6w6nwu2mtfbgvnabypqmzw5p6f7g5rpr7p@74rg7ziipg7j>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-892991405-1692951316=:3206"
Content-ID: <4f1b8332-acf7-6878-fd79-f8658137e131@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-892991405-1692951316=:3206
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <4cf39b2-10c0-29da-ddb1-c59a3d509f8d@linux.intel.com>

On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
> On 2023-08-24 at 16:10:12 +0300, Ilpo Järvinen wrote:
> >On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
> >
> >> Kselftest header defines multiple variadic function that use printf
> >> along with other logic
> >> 
> >> There is no format checking for the variadic functions that use
> >> printing inside kselftest.h. Because of this the compiler won't
> >> be able to catch instances of mismatched print formats and debugging
> >> tests might be more difficult
> >> 
> >> Add the common __printf attribute macro to kselftest.h
> >> 
> >> Add __printf attribute to every function using formatted printing with
> >> variadic arguments
> >
> >Please add . to terminate the sentences.
> 
> Thanks, I'll fix it in the next version
> 
> >The patch looks fine:
> >Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >
> >...However, there are formatting errors it found yet to fix.
> 
> I believe you mean cache.c#L297.
> 
> I think I saw you're preparing some patches that remove the line that
> reports the formatting error so I chose to not correct here.
> 
> Please let me know if I still should change it or would that be
> redundant.

There are other selftests besides resctrl which had a few warnings.

Making the selftests to rebuild though might be a bit tricky (you won't 
see the warnings otherwise), I don't know the command needed to clean 
selftests but I guess one can always force their timestamps to force 
recompile with:
  git ls-files tools/testing/selftests | xargs touch

-- 
 i.
--8323329-892991405-1692951316=:3206--
