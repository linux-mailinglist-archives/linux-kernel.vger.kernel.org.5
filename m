Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA078F118
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbjHaQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346770AbjHaQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:21:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228E12D;
        Thu, 31 Aug 2023 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693498860; x=1725034860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yLXWNzLVDaTYijGoHSWuUrcTscpwQEpiN7KQeH1OWSY=;
  b=LgNyM2tS4V0fkAESP/js0k7+r459DfOi8QN0V7PGPiNYHW0pyqkHXjpD
   GnjmO+HfBUrPUmzh+GhQOzEu2PywmBhSxGubNqnzQ9g7/WCaMq8DW71YI
   Z3EXGEGLMSfk9d0qDz1CEhOaj2c3/f4h6X8CxX0BLXN3rsCQcNpzb+hZs
   dwYrcBd6jnJbdYJqWgNBPHW3kxuiwKp3c95f4mY9zuKjk96oHlVtVESu3
   k39vvJrFMx7UfdDkUco8brpxZ/EpbByA1OHOKbN9uRci4KMRnJReBy38t
   VUkZvBUfkTvcQK20BqJjUY2ajlGILQOqtkK4wMMj4X03/Hjqsjc09P0wS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373394292"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="373394292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863157386"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="863157386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:20:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbkPe-005QuL-32;
        Thu, 31 Aug 2023 19:20:54 +0300
Date:   Thu, 31 Aug 2023 19:20:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] usb: typec: tcpci_rt1711h: Drop CONFIG_OF
 ifdeffery
Message-ID: <ZPC95l6TKxiMqIk6@smile.fi.intel.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
 <20230831160501.55081-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831160501.55081-6-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:05:01PM +0100, Biju Das wrote:
> Drop of_match_ptr() from rt1711h_of_match and get rid of ugly CONFIG_OF
> ifdeffery. This slightly increases the size of rt1711h_of_match on non-OF
> system and shouldn't be an issue.
> 
> Add mod_devicetable.h include.

It also allows, in case if needed, to enumerate this device via ACPI with
PRP0001 magic.

-- 
With Best Regards,
Andy Shevchenko


