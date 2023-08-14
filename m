Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C077BBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHNOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjHNOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:48:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F0183;
        Mon, 14 Aug 2023 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692024536; x=1723560536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HEQ7bMjV6zvFAEz/6m8nVvqz4UjcR+Et4FYEL/1wKDo=;
  b=f7GoO5BuVcLYdlOo3xSU4gpivipfeRsry8fnh1T/QwMWm3zASj3Fszpb
   vjv4w2WC0f87K6spcaBm/s6V2uZLnzcIgJXNL/4PvsxKx0yzPLHGLUggj
   idJrX2otwg5rXFm2WzmLLipyMJm5HyoAY4RqCmp17HFYaCbH3ZKQKYBW4
   xenayIeQ8A1gHjQmUjnnK+kWmNJc5GdvmFUQmdWyeTQF+I+R7TEYiHF0I
   pD07hbeb5JJltGsdXDA/EfMGwHUW78TsDlOL7eA5OWmekGhNzEfTxBwTm
   pyrLQL2X4big9QTTVKCRdvvKEaoPYtDRkNtQGSBcrQN76rV0JMARVPAB6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403039120"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="403039120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710343355"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="710343355"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 07:48:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVYsG-009KBc-1F;
        Mon, 14 Aug 2023 17:48:52 +0300
Date:   Mon, 14 Aug 2023 17:48:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH 4/4] usb: typec: intel_pmc_mux: Configure Displayport
 Alternate mode 2.1
Message-ID: <ZNo+1LRMfcjFEMu5@smile.fi.intel.com>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
 <20230811210735.159529-5-utkarsh.h.patel@intel.com>
 <e9d83459-623e-34e1-ce9d-eb0b83ea170f@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d83459-623e-34e1-ce9d-eb0b83ea170f@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:47:43PM +0300, Sergey Shtylyov wrote:
> On 8/12/23 12:07 AM, Utkarsh Patel wrote:
> 
> > Mux agent driver can configure cable details such as cable type and
> > cable speed received as a part of displayport configuration to support
> > Displayport Alternate mode 2.1.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
>    Hm, I think the R-b tags should follow your signoff...

They following historical order.
So, before this patch appears upstream, it had collected Rb tags.

> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

-- 
With Best Regards,
Andy Shevchenko


