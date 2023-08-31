Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D278F116
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjHaQUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHaQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:20:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE46B0;
        Thu, 31 Aug 2023 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693498851; x=1725034851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W95vrfEhM+tnCwAJgPQ7tpdnP/tAmrtfQ5NvhkpIxc0=;
  b=OUsFl70mqTFnSTlR4ywmpLVFSBw16qgR0DqqFW+dB19kWEyqXEVO+PdK
   kZSCmDkWGScduJaM7Ot/E6W1IjPvVWM/GPVWf+/BAU5vA3/w/zwytMWOJ
   +FbOPDnZudQ+3ZY52G26Zht/fcLTFx58DOJZ3X/fqAWfPTXBXKrPLNv4n
   u8hU4nPZ8+syT9G81bkKKebwWjrQ7FX2EyKSuRflwzqFc2pUCIYvUeKty
   RWak+D6wDkRWV3ON/daURMqZYsNDkeOHt7XiEM0NRLQTzEv3Q54EsKtFF
   x12/juOlyCOHHjj8lxBNR0f1OtXyhEr462cl4Dt9ax53ejVermbAh8feB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="439975102"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="439975102"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739596548"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="739596548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:18:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbkNB-005Qsk-1c;
        Thu, 31 Aug 2023 19:18:21 +0300
Date:   Thu, 31 Aug 2023 19:18:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] usb: typec: tcpci_rt1711h: Make similar OF and ID
 table
Message-ID: <ZPC9TY0kisFt47z8@smile.fi.intel.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
 <20230831160501.55081-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831160501.55081-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:04:57PM +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match
> using i2c_match_data() later. Currently it works only for OF match
> tables as the driver_data is wrong for ID match.

> While at it, drop a space from the terminator braces for ID table and
> remove trailing comma in the terminator entry for OF table.

Just as simple as:

While at it, drop a space and remove trailing comma in the terminator entry
for OF table.

-- 
With Best Regards,
Andy Shevchenko


