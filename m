Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78E7F464A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjKVMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:31:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A5BB;
        Wed, 22 Nov 2023 04:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700656283; x=1732192283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MKSeH2UNcw3DN0X5a3zmDnW6Uu/Yb/CruWt+aB1pe0I=;
  b=n+X88qm3AYDzTJNCeHhgIqGfaHkigbbQEeoihsZ5cz2BLO9csFa/VHjm
   rUp55rayG/38TJhVbbYFF7vv4xeNC+eNIpUrjvZuMysNAbjcp7ngQnyxF
   yAmYMuJxZSOh2uOqeuf0dVtwlFKz4GS/os6gNtQvhA1G4rpuw8i9ufMg0
   7Z3vlTU/QTWlyQglLZMdPhiloFT+ypld9FnV1dQQ90dCB1z2pPn6MqiNR
   MFDK77rXakvWF18+kN4Z0K9d8nssYlL5UTPsPW5k/3PgREb7E4L1oZ6+h
   +Jh/wx+Z933aP8RFiy8HkCIkJlYVM4weRbONNo9VGYJ6uFbtdVSTm5Q46
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382440185"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="382440185"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="833000069"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="833000069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:31:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5mNy-0000000G5WO-2q5O;
        Wed, 22 Nov 2023 14:31:18 +0200
Date:   Wed, 22 Nov 2023 14:31:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 39/39] dma: cirrus: remove platform code
Message-ID: <ZV30llA4yDUs2G-Z@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-39-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-39-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:00:17PM +0300, Nikita Shubin wrote:
> Remove DMA platform header, from now on we use device tree for dma

DMA

> clients.

...

> +	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
> +		return true;
> +
> +	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");

Haven't you introduced an inliner with the similar flow? Why not reuse it?

...

> +/**
> + * ep93xx_dma_chan_direction - returns direction the channel can be used
> + * @chan: channel
> + *
> + * This function can be used in filter functions to find out whether the
> + * channel supports given DMA direction. Only M2P channels have such
> + * limitation, for M2M channels the direction is configurable.

I believe

	scripts/kernel-doc -v -none -Wall ...

against this file (and maybe others!) will complain ("no return section"
or alike).

> + */

-- 
With Best Regards,
Andy Shevchenko


