Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07777A2F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbjIPK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjIPK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:27:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55FCEC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694860025; x=1726396025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NpYRpck12yRE0afPagiZhDKRlGxV/J6TEPLL4JmygBU=;
  b=DzIgKbtRbrEpwsHadt0ZTCBi/7S5+nhtOYSBEUARLGN30GSGz6/9vb1K
   Ebd8NJmingtt/N33w1sB7mFaTwZTwxfemiznlGx+i1OdgDA+NZ4HVbEMG
   OjmS5e4fk6BrJ4TXWdQyfzvecLosEATiVa0wyPNWhb0ZNoMVgxoioS+q0
   C3Tem6Z4jhG4x4ZGTwRn4hsb7uD9sGuegtx5Idyshs0Ja7RMP+1wPHBhC
   1dFM3M+XwCnIUfny6NBYi95HR/DEEtjz90b2+twYxisWYV5tWVnicN2TP
   /CoJg13OqE4UZENNVf5OQ/Zp4R1qe7po+8gtZOm19CYRrKYaoOqU9qDJI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410358060"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="410358060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 03:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="695000890"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="695000890"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 03:24:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qhSTw-0000000F5fe-4AzJ;
        Sat, 16 Sep 2023 13:24:56 +0300
Date:   Sat, 16 Sep 2023 13:24:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v1 1/2] LoongArch: Add missing headers
Message-ID: <ZQWCeI6E7rm8Akbt@smile.fi.intel.com>
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
 <ZQNWh2DY319jGbfq@smile.fi.intel.com>
 <CAAhV-H66LUWHP-eGp6VGvs0F+QD=QJ69uR3_1A3SqH9cyPUPoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H66LUWHP-eGp6VGvs0F+QD=QJ69uR3_1A3SqH9cyPUPoQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:36:24AM +0800, Huacai Chen wrote:
> On Fri, Sep 15, 2023 at 2:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Sep 14, 2023 at 11:25:22PM +0800, Huacai Chen wrote:

> > > Thank you for your patch, can this patch solve the problem below?
> > > https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp@intel.com/T/#u
> >
> > Nope, this just adds missing includes.
> > No functional change, so warnings will still be there.
> But I think a patch should solve a problem.

No, that problem is static analyser concern, not the compiler nor linker.

> If we don't get a build
> error or warning without this patch, does that mean the 'missing'
> headers are actually included indirectly?

I might be missing something, but I do not see any build error in the above message.

-- 
With Best Regards,
Andy Shevchenko


