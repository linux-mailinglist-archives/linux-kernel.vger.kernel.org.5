Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0F75C4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGUKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGUKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:32:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFBCFD;
        Fri, 21 Jul 2023 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689935533; x=1721471533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nf9QbkElZtARbma1oFBDBsdMpUut36F5eRGJGQxQECw=;
  b=ZeoShgt4MqbtthhciCQGw5aZMN4f8oLiTlH4ns5ityVWuZEJ1wRUkJHa
   sXLnCerSJLvDH5G5IgBsnpGM+P1wBZMjEOZwvwbxBnZnBn9lEdgkO1kIz
   m/G1YgBKBC4CuFm5Y4J3WDsJiiOydh6zuEbz+LdPVOLO34y//PBaQ/aGt
   EfUTpo31LvAl6pKD4dHJ0HgQfAyTkS0MWpxreQ+wWNRUHD7CDgob5sMgO
   a6iVlB9DXSDhSfzP/3mGOduD99JXWZ/UCqLSfSYSN7UojcR6a8uHulpho
   jNgKDiXM8pqGH/cedhoO8aLcx/CiSkSAdKnVSJeesO0oOs1DT8ACV9oGI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364455663"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364455663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868200839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 03:32:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnQe-000Api-2n;
        Fri, 21 Jul 2023 13:32:08 +0300
Date:   Fri, 21 Jul 2023 13:32:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] media: i2c: ds90ub9xx: Misc improvements
Message-ID: <ZLpeqLgVPBHdl/HZ@smile.fi.intel.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:30:31PM +0300, Tomi Valkeinen wrote:
> This series contains small miscellaneous improvements to the FPD-Link
> drivers.
> 
> These were sent originally in v14 of the "i2c-atr and FPDLink" series
> (link below), but were then left out for v15. So I have assigned v2 to
> this series.
> 
> I have trimmed the to/cc list a bit, as these don't really deal with i2c
> and dt anymore.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for all, but patch 6. I still think u32_fract makes sense.

-- 
With Best Regards,
Andy Shevchenko


