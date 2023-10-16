Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7764B7C9DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjJPDTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJPDTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:19:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA1C5;
        Sun, 15 Oct 2023 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697426340; x=1728962340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fcUG58giWoEKU3oiVPmtUtFpvJmOfLyRlGKMLMYYUw0=;
  b=EMtuULL9t2117FxPLXwjEhlKQ/p3+6nWEpHnPU3BQi9CUgKFc/K0Lomn
   mNY3a64QiM15/dg8HaoR5BgrO2P5f7Z11Pnb4MMCdVpTM13Uy4nYI7yIo
   +rlZ2Ep/jf2868yu3tXw02bdCnGvGT0ZWi4RYQdhljOJfLUP67qdk50jy
   gJz1kDz5eEpFJDtL0VmMdRYBVnF24WRPZ0AHgTb3b+LROmpYUmvbHkXyj
   e+6t7Qg3sSRNrglac+WvfgpxsmvIe67A4TMwX7hK1uuwxb8sUp0+Hi8Fj
   HbC9wI8NA/iKpCq/CqLnDbC8KYiKpCaYVGx844FMjuRJ7jUDMDYVuuvWW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416504819"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="416504819"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929209406"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929209406"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2023 20:18:57 -0700
Date:   Mon, 16 Oct 2023 11:17:55 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        kernel test robot <lkp@intel.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Fix unused
 xlnx_pr_decoupler_of_match warning for !CONFIG_OF
Message-ID: <ZSyrY+hQvR3+fwP5@yilunxu-OptiPlex-7050>
References: <20231012192149.1546368-1-robh@kernel.org>
 <ZSkPjRp/xPfVQ/NB@yilunxu-OptiPlex-7050>
 <CAL_JsqLHKTQi0i-V4C5UA6WJjnMeen0WR4jjcA4YSRXOYZOrZA@mail.gmail.com>
 <CAL_JsqLuKF3Cnu38F9CY+_yeU8eCBpBBh82_8E6FcoAa_jU=sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLuKF3Cnu38F9CY+_yeU8eCBpBBh82_8E6FcoAa_jU=sw@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:36:28PM -0500, Rob Herring wrote:
> On Fri, Oct 13, 2023 at 8:15 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 13, 2023 at 4:37 AM Xu Yilun <yilun.xu@linux.intel.com> wrote:
> > >
> > > On Thu, Oct 12, 2023 at 02:21:48PM -0500, Rob Herring wrote:
> > > > Commit 8c966aadcc02 ("fpga: Use device_get_match_data()") dropped the
> > >
> > > Hi rob:
> > >
> > > Unfortunately I re-applied Commit 8c966aadcc02 and the previous commit
> > > id is lost.
> > >
> > > Since the 2 patches are not upstreamed yet, could I just merge them into
> > > one?
> >
> > Yes, that's fine.
> 
> Looks like altera-ps-spi.c also needs the same fix. Do you mind making
> the same change there?

Fixed & applied.

Thanks,
Yilun

> 
> Rob
