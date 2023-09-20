Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412007A7D43
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjITMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjITMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:07:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B86CD3;
        Wed, 20 Sep 2023 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695211670; x=1726747670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Eich1diZa61bm9DUbVFnbrlfWTqnw80BheWaNkb4YQE=;
  b=nIJHmRAhm9D/UMXDh0WrS2kY/lt4p/qW1G8xhFjz+7TOjFSbJmnbg/Sz
   qfbvWsXYeAyzMFE1cZdIlv9SxFFlO59+7UKj/1oHd9aWi8yIYN9G77pMy
   hDNmlIN+JOpttFhY7eSN4N1/HbI3gnGd0JYw2ffjbR69gmHwBfkdeB+Ec
   saXLXJwpOsjwSsbs9MSLdDQZwIEn/NzGsuc7vr0Qoi5B6OlcBJ/iP76RM
   hzC0R0WTeBmVn0Kbi99ojT35guCAZknTJXyHChEVx14poMgLuArv6avD5
   xTV+WP9ZHZLVwKDVE21A80uAPQwTHmylLwR+quaGFAKXMLo2l+NN/hvar
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360460136"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360460136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 05:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="746624821"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="746624821"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 05:07:45 -0700
Date:   Wed, 20 Sep 2023 15:07:42 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3] PM: Fix symbol export for _SIMPLE_ variants of
 _PM_OPS()
Message-ID: <ZQrgjn6uY+B6ZL2j@black.fi.intel.com>
References: <20230920084121.14131-1-raag.jadav@intel.com>
 <790fac97ce79534733fe0bbd93cc0c9eaa835bf2.camel@crapouillou.net>
 <ZQq8V5D06CaMxWqQ@black.fi.intel.com>
 <46a28af1045211edd6c44f7b6aa4c23e7b3a208d.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46a28af1045211edd6c44f7b6aa4c23e7b3a208d.camel@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:00:05PM +0200, Paul Cercueil wrote:
> Le mercredi 20 septembre 2023 à 12:33 +0300, Raag Jadav a écrit :
> > On Wed, Sep 20, 2023 at 10:53:23AM +0200, Paul Cercueil wrote:
> > > Le mercredi 20 septembre 2023 à 14:11 +0530, Raag Jadav a écrit :
> > > > Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS()
> > > > set
> > > > of macros to export dev_pm_ops symbol, which export the symbol in
> > > > case
> > > > CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.
> > > > 
> > > > Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM
> > > > handles
> > > > and are only used in case CONFIG_PM_SLEEP=y, we should not be
> > > > exporting
> > > > their dev_pm_ops symbol in case CONFIG_PM_SLEEP=n.
> > > > 
> > > > This can be fixed by having two distinct set of export macros for
> > > > both
> > > > _RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the
> > > > export of
> > > > dev_pm_ops symbol used in each variant depends on CONFIG_PM and
> > > > CONFIG_PM_SLEEP respectively.
> > > > 
> > > > Introduce _DEV_SLEEP_PM_OPS() set of export macros for _SIMPLE_
> > > > variants
> > > > of _PM_OPS(), which export dev_pm_ops symbol only in case
> > > > CONFIG_PM_SLEEP=y
> > > > and discard it otherwise.
> > > > 
> > > > Fixes: 34e1ed189fab ("PM: Improve EXPORT_*_DEV_PM_OPS macros")
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > ---
> > > > PS: This is a standalone fix and works without updating any
> > > > drivers.
> > > 
> > > I had to double-check that, to make sure that none of the drivers
> > > using
> > > these macros also use pm_ptr() instead of pm_sleep_ptr() to access
> > > the
> > > exported dev_pm_ops.
> > > 
> > > I did not check extensively but everything seems to use
> > > pm_sleep_ptr(),
> > > so it looks safe enough.
> > 
> > I have tested it against -rc2 without any problems.
> 
> You'd need to test an "allyesconfig" with CONFIG_PM=y, and
> CONFIG_PM_SLEEP disabled. Is that what you tested?

Yes, and also validated *.symvers if dev_pm_ops symbol is really discarded.

Seems to work as expected.

Raag
