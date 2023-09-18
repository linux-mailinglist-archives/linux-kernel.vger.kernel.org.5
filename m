Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333637A4543
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbjIRI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbjIRI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:57:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B754BC5;
        Mon, 18 Sep 2023 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695027459; x=1726563459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HeFp7tILd3nxt9A1X2feyEpN3APhXPS4vq/kQkpBxPg=;
  b=lLA1bQcYf729vRNzqMhNkZCWVNOF/2AAKfesF8/L7IxBZnTkdFEXzm8c
   Rf4Et2j+t7oCVoJ0EwpYg9KkxfV9rPB+Qk0xMccSi5IaBF/IGEDonBbsC
   J+XqXQ6q8Agy0yfTpiLm3mQc+zVpXGQTM0KNxmmsUEpBtJzpYHiqebbev
   mNQlGsIZIMhwZ7qh7AXxq/2KH58wmGqqlBePAWDRPIBb2QBK8ODGxyNIr
   dz16rcjLyESuRSPNCzdJ5my6YhI6EPUq4JE2nfo4syv9as/grA+mbyNMm
   oUGpDPYtx/X13JYsPbqk9b8Zhicd67h8gDEYGkuzwpDHKjAIUtV8byngO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="376916427"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="376916427"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="811280109"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811280109"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:55:42 -0700
Date:   Mon, 18 Sep 2023 11:55:38 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, rmfrfs@gmail.com, jean-baptiste.maneyrol@tdk.com,
        lee@kernel.org, laurentiu.palcu@oss.nxp.com,
        l.stach@pengutronix.de, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, rf@opensource.cirrus.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH for-next v2 02/10] PM: Update EXPORT_*_DEV_PM_OPS() to
 EXPORT_*_RUNTIME_PM_OPS()
Message-ID: <ZQgQilY20yEUPtt3@black.fi.intel.com>
References: <20230918080951.3615-1-raag.jadav@intel.com>
 <20230918080951.3615-3-raag.jadav@intel.com>
 <a31817a460f8ee66c9d460e97aeea62b2bcfbc51.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a31817a460f8ee66c9d460e97aeea62b2bcfbc51.camel@crapouillou.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:20:29AM +0200, Paul Cercueil wrote:
> Le lundi 18 septembre 2023 à 13:39 +0530, Raag Jadav a écrit :
> > Rename EXPORT_*_DEV_PM_OPS() macros to EXPORT_*_RUNTIME_PM_OPS()
> > and while at it, move them to pm_runtime.h.
> > This is done in conjunction with the introduction of
> > EXPORT_*_SIMPLE_PM_OPS() set of macros, to make things less
> > confusing.
> > This makes both _RUNTIME_ and _SIMPLE_ variants of export macros more
> > distinguishable and self explanatory.
> 
> Well I don't really agree with this one. The EXPORT_*_DEV_PM_OPS() can
> be used with any callback you need, not just the typical runtime-PM
> callbacks. They are generic PM macros.

I agree on the usage part. But with the introduction of export macros for
_SIMPLE_ variants, current naming scheme would make things unnecessarily
confusing to the users in my opinion.

Perhaps we can have it simplified some other way?

Raag
