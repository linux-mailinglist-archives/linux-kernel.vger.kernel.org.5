Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD87EEDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbjKQIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKQImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:42:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08529196;
        Fri, 17 Nov 2023 00:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700210542; x=1731746542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EEkIXmHOKSdswOgaeNVurkzd4xWtTvPVbwH173FnRxI=;
  b=JmVawmQWwkubjkpFPPt21FapUn4Oib0i7Uat9NWO/eEdGdTGXHClYWXt
   ZIj/2AeyNGresgaC/QOTu0JjBBsXtpfXIa7o5JptbPtnEJXCGgBlonzeH
   v1lRPtyvqtkw3su9uqBVQN0VJXLdTtdcuoFI0R7NOR99Ej/TVhn9wUFZG
   e9SJM6XcvCKU/9XYLtnXMS+5SvekBt7AELWF/dxzvmL7io8JOCCN6Ioo6
   Wb8GfmhHHWG61k/bUGgrNBgdaRGCI3sHzeNeGk20zERrIHA08nzqiM0Em
   yzVOqzaMJhf8lTgiONbairYJ607gVGqv7jFFXhshzs5d+h2bxG/bwttZm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390116125"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390116125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883059947"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="883059947"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2023 00:42:19 -0800
Date:   Fri, 17 Nov 2023 16:40:33 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2] drivers/fpga: use standard array-copy function
Message-ID: <ZVcnAa246LUOhlG0@yilunxu-OptiPlex-7050>
References: <20231114111901.19380-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114111901.19380-2-pstanner@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:19:02PM +0100, Philipp Stanner wrote:
> dfl.c utilizes memdup_user() and array_size() to copy a userspace array.
> array_size() will likely never trigger thanks to the preceeding check.


checkpatch says:

  WARNING: 'preceeding' may be misspelled - perhaps 'preceding'?
  #7:
  array_size() will likely never trigger thanks to the preceeding check.
                                                     ^^^^^^^^^^

I fixed it myself.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

Thanks.
