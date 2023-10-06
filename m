Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477837BB55F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjJFKiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJFKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD59F;
        Fri,  6 Oct 2023 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588678; x=1728124678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GrH/J2J8Ux35o9V1vvBRR3zKhEBbuN6jvk75UPYnP9w=;
  b=KDZ9JGd96peGjYaQzboY9CR57Uckx/4okPag3z9sYc48CBtndAr10gy8
   MehHsY/3v0ksDJwYrkV3WSmfzHPk1U7KNdp4oOz2m4XqgtWYRnYe/g+iU
   dFHHhDC0gU9cryPvewBYTST0Pxsj2wDsj6DvRnU1eDdIuJyfPtyktMw/7
   f4I+Nc4VmoAHc/qDFjEs40JBfMby7yUHwfWrnm3BXx1jNjnW2UFrF4SQ7
   YcEMM40dBtVGgCpp+h9sx2qYds/ZdS6J7Azx/PTShKoe55oQFnH/GdAGy
   WXKO5QwXSPB/6TxnfuPgGWgFb1Gfro3XMntj0EbmmmFW9emhalmneFwxR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382592991"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382592991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781616208"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="781616208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:37:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoiDR-00000003GgY-1Enq;
        Fri, 06 Oct 2023 13:37:53 +0300
Date:   Fri, 6 Oct 2023 13:37:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 2/2] pinctrl: cherryview: Simplify code with cleanup
 helpers
Message-ID: <ZR/jgbDL3CxmFrX+@smile.fi.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
 <20231006094033.3082468-2-andriy.shevchenko@linux.intel.com>
 <20231006102641.GZ3208943@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006102641.GZ3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:26:41PM +0300, Mika Westerberg wrote:
> On Fri, Oct 06, 2023 at 12:40:33PM +0300, Andy Shevchenko wrote:

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


