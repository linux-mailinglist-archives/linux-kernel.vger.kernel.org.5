Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B37788350
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbjHYJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbjHYJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:14:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC891FC4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692954856; x=1724490856;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=z42uogipUC9zou2NpoMy8c1SaoM0lCXF9ZrPXvTh8yQ=;
  b=f8oX7DIVO6OER5awvhmulT4tjYXnEJJ1H9Kz//d84qwnBbauMIL70Mq5
   gOZSkmmYVYWugvEXSqjrysRn49lZ9crO1xErunF9KypmBsPtZq2qXs3lK
   mwhkTI8VANkYSggm910Y7/t/KqFMlEmeFG1oAtrKi/n+uKHEsTDazYpaJ
   62BcZf6VnriFBLLZECddTh9OK8P0Ib+hyyWZG57ui9k4jf5S1r/toYXwg
   iMbJgUgGUTnzAnSxG3SUcreVwAP2c6pieCD0wPmrerCcHyNfLuvaFRNNo
   uznSfjAma0v4wh1Jaok1csvwebpBw1z2mpOfQvTwI6F51lUmfCwsYM7DI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="441018317"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="441018317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827518132"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827518132"
Received: from enguerra-mobl.ger.corp.intel.com ([10.251.213.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:14:14 -0700
Date:   Fri, 25 Aug 2023 12:14:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Subject: Re: [PATCH 3/3] selftests: Add printf attribute to ksefltest
 prints
In-Reply-To: <nvkf4tyi4kmsnlzcpfcercvjsmsibol6wbfzrginmzioyflwux@ttbzh3hqqatx>
Message-ID: <a2e6fddd-86f9-a413-47ff-5a9973a8e1ef@linux.intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com> <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com> <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com> <elcfjzpnxfeyum2t6w6nwu2mtfbgvnabypqmzw5p6f7g5rpr7p@74rg7ziipg7j>
 <0f5533a-92db-b462-f7bf-14a8d595baa1@linux.intel.com> <nvkf4tyi4kmsnlzcpfcercvjsmsibol6wbfzrginmzioyflwux@ttbzh3hqqatx>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1540759012-1692954591=:3206"
Content-ID: <36d832a9-1d22-4b3-2028-8919cc9c60cb@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1540759012-1692954591=:3206
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <f7f93e9f-da2e-5dca-9c41-4a7967273cd@linux.intel.com>

On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:

> On 2023-08-25 at 11:28:17 +0300, Ilpo Järvinen wrote:
> >On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
> >> On 2023-08-24 at 16:10:12 +0300, Ilpo Järvinen wrote:
> >> >On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
> >> >
> >> >> Kselftest header defines multiple variadic function that use printf
> >> >> along with other logic
> >> >> 
> >> >> There is no format checking for the variadic functions that use
> >> >> printing inside kselftest.h. Because of this the compiler won't
> >> >> be able to catch instances of mismatched print formats and debugging
> >> >> tests might be more difficult
> >> >> 
> >> >> Add the common __printf attribute macro to kselftest.h
> >> >> 
> >> >> Add __printf attribute to every function using formatted printing with
> >> >> variadic arguments
> >> >
> >> >Please add . to terminate the sentences.
> >> 
> >> Thanks, I'll fix it in the next version
> >> 
> >> >The patch looks fine:
> >> >Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >> >
> >> >...However, there are formatting errors it found yet to fix.
> >> 
> >> I believe you mean cache.c#L297.
> >> 
> >> I think I saw you're preparing some patches that remove the line that
> >> reports the formatting error so I chose to not correct here.
> >> 
> >> Please let me know if I still should change it or would that be
> >> redundant.
> >
> >There are other selftests besides resctrl which had a few warnings.
> >
> >Making the selftests to rebuild though might be a bit tricky (you won't 
> >see the warnings otherwise), I don't know the command needed to clean 
> >selftests but I guess one can always force their timestamps to force 
> >recompile with:
> >  git ls-files tools/testing/selftests | xargs touch
> 
> Okay, I think I counted 13 more caused by the __printf().
> I just ran:
> 	$ make -C tools/testing/selftests
> and to rerun it later:
> 	$ make -C tools/testing/selftests clean
> 
> But do you think all these fixes fit into this series?
> Is so, should I put them in a separate patch or just append to this one?

Please fix them in separate patches.

IMO, the most logical approach is to make own series out of these printf 
attribute fixes and change, and another series for anything that is purely 
resctrl related.

-- 
 i.
--8323329-1540759012-1692954591=:3206--
