Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DD7BBB54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjJFPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJFPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:09:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49748A6;
        Fri,  6 Oct 2023 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696604967; x=1728140967;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oZWHLp8rEbbCuhuo4sc/OR17bG/f9b7o8I+6W2ItdkM=;
  b=ZGzXUDqlMyRqPMaKABqK4ZmtcgbiJKN8MwSiKb1LUpE3re2+6yb3SSx4
   33YbsiwkAgY4LIK2CiHCeXR4K10W6lQ76bKGrN3f1W5kmAr56mYBbBT5T
   u0rUR24CvN61apj7hHmo/AOq+qM3n3MnPcDwm+rMYuiYxHl/z3+zTkOeP
   LWKA/VlD+MxC3ATv0RRdVB0nKKq/GfrEWTXeiWLDYecJwIScIzL45YLBE
   Xw7QC1IR2WyaLUDaOaRjUttatlyGHmX5gitFC4EnOkxnquiYxTY0/M198
   +yoMw19nC51+2KIkuRE634Ea7CBvuMKoBtcK0N01UdFQ/9bMn7XyL/ZWh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368843482"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368843482"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="875960494"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="875960494"
Received: from srab-mobl1.ger.corp.intel.com ([10.252.43.69])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:09:13 -0700
Date:   Fri, 6 Oct 2023 18:09:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally
 create attribute for read frequency
In-Reply-To: <5dda866185a286e61f949a48e04ff1ea6b3a5b03.camel@linux.intel.com>
Message-ID: <cf4b9dd-de19-67a4-b980-fa7662d14a1@linux.intel.com>
References: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>  <e84bc80e-1fd9-f07b-526a-b4eb4780ea9b@redhat.com> <5dda866185a286e61f949a48e04ff1ea6b3a5b03.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-192677936-1696604955=:3530"
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

--8323329-192677936-1696604955=:3530
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 5 Oct 2023, srinivas pandruvada wrote:
> On Thu, 2023-10-05 at 09:03 +0200, Hans de Goede wrote:
> > Hi Srinivas,
> > 
> > On 10/4/23 20:19, Srinivas Pandruvada wrote:
> > > When the current uncore frequency can't be read, don't create
> > > attribute
> > > "current_freq_khz" as any read will fail later. Some user space
> > > applications like turbostat fail to continue with the failure. So,
> > > check
> > > error during attribute creation.
> > > 
> > > Fixes: 414eef27283a ("platform/x86/intel/uncore-freq: Display
> > > uncore current frequency")
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > ---
> > > Added fixes tag which added current_freq_khz. But after this
> > > tag there is reorg of code, so need manual backport for some
> > > versions.
> > > I will separately submit to stable trees after merge.
> > 
> > Can you for future updated patches please use the ususal [PATCH v2],
> > [PATCH v3], etc. prefix ?
> > 
> Sorry about this. I usually do with code change. But will keep in mind.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-192677936-1696604955=:3530--
