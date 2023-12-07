Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF08088B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379503AbjLGNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjLGNAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:00:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ABD10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701954027; x=1733490027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zwPMEj8AGYxUrl9j0Jq1ozkQShkFbNl7hWQyodjk+mQ=;
  b=GvpX52Gjn6pCgGpp963TdCvjdmmIHpZSDotBD3ZavhxHyJ9VXPC0JoTJ
   JDA59R+Z+uWx+l0LWh/vuAVGQzvc56LW7idBEfX30KszvKv+crbcnhvmK
   bafuNSKQ03EpO+hxOV1zIRTmvmgmeoKVzAm/GQvQhbQpzslKSBI/N3twx
   XMv9/+4qRrMFlIi3Fe/2LDuzbOkxDlOx9WaQk+Teq7K8QkB8gYemVaSPl
   eruu6AbE5XQS1nVC+qKgx76h7aoxGdAV9f1hCrqoPFEPTTkxFhhiiQ86Q
   +r744b1WDP+wqgQJ2DKCayhKe0f4/x7oYoC/lcapBNuf/iR+NlygiEFPG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12938860"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12938860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 05:00:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1103191636"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103191636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 05:00:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rBDzH-00000002bUI-1HzU;
        Thu, 07 Dec 2023 15:00:19 +0200
Date:   Thu, 7 Dec 2023 15:00:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Gergo Koteles <soyer@irl.hu>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Message-ID: <ZXHB4651b8OUAtt8@smile.fi.intel.com>
References: <cover.1701733441.git.soyer@irl.hu>
 <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
 <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
 <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
 <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
 <9c3846ae0da417c0fe5d4fa2d9d4134143184dda.camel@irl.hu>
 <830d8e26-dbb9-4b9c-bbab-a5c4c49a7ffd@linux.intel.com>
 <4cd78962-027c-4bbb-a42a-6ccbca81ac8e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cd78962-027c-4bbb-a42a-6ccbca81ac8e@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:07:16PM +0100, Amadeusz Sławiński wrote:
> On 12/5/2023 6:22 PM, Pierre-Louis Bossart wrote:

...

> > > > > > > +	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
> > > > > > 
> > > > > > Any specific reason to use an Intel ACPI identifier? Why not use
> > > > > > "TIAS2563" ?
> 
> Will just note that prefix should probably be TXNW (not TIAS) as discussed
> recently on list.

...which should come directly from TI as it's their responsibility to allocate
an ACPI ID.

...

> > > > > INT8866 is in the ACPI.
> > > > > I don't know why Lenovo uses this name.
> > > > > I think it's more internal than intel.

This is wrong (PNP) ID.

...

> > > > >              Name (_HID, "INT8866")  // _HID: Hardware ID
> > > > 
> > > > Ouch, I hope they checked with Intel that this isn't an HID already in
> > > > use...
> > > > 
> > > It looks the INT prefix is not reserved. (yet)
> > > https://uefi.org/ACPI_ID_List?acpi_search=INT

You are looking into wrong registry, and yeah, Intel used wrong PNP ID
for years...

> > It's been de-facto reclaimed by Intel over the years, apparently using
> > INTC or INTL was too hard for some of my colleagues...
> 
> Perhaps it should be reserved then, so it is present on above list?

-- 
With Best Regards,
Andy Shevchenko


