Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46182781123
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378848AbjHRRCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378872AbjHRRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:01:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA74200
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692378091; x=1723914091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=caq96PDrOVqQ3tEIxkcaDXSnE06/7ClYFQb1q4M3iPc=;
  b=d8XFkHMCxGbrn/MUDFbe+mObBvnrV3HldybPVcjJslf4+fx+POM696tP
   pXBqFBZpZiG4qbOCwd0Ot2yHeb46DOYXZ0J0ZuKPwiTPJtPVkmjKtGmZV
   GJ/ReCTNdIyKjnQd8jBnmUCcDu/o26zgP4kIUGFnIAaFaMuiggdZT32gB
   5bPpHh9qEVTUab2T1McF2u29Spp3jjdPd1poTApsStmoEXQpz1aiC8fNE
   JSzVev0+7dZwXg9D5Kc9e75CGZDEiZgrcznsdNuv9AlpUdGCkTIznJJf0
   UFhKaL4yn/gcJ25MUoI0ZgdmX0XQ/bOm9Rc7nvL4O/9E+nEobxDIDjFj/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="372050856"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="372050856"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770188157"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770188157"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2023 10:01:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX2qa-00GyU7-2D;
        Fri, 18 Aug 2023 20:01:16 +0300
Date:   Fri, 18 Aug 2023 20:01:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
Subject: Re: [PATCH v3 2/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Message-ID: <ZN+j3LmfUW2vB+QS@smile.fi.intel.com>
References: <20230818085558.1431-1-shenghao-ding@ti.com>
 <20230818085558.1431-2-shenghao-ding@ti.com>
 <4c1b44b5-995a-fac7-a72b-89b8bf816dd2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1b44b5-995a-fac7-a72b-89b8bf816dd2@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:00:34AM -0500, Pierre-Louis Bossart wrote:

...

> > +static int comp_match_tas2781_dev_name(struct device *dev,
> > +	void *data)
> > +{
> > +	struct scodec_dev_name *p = data;
> > +	const char *d = dev_name(dev);
> > +	int n = strlen(p->bus);
> > +	char tmp[32];
> > +
> > +	/* check the bus name */
> > +	if (strncmp(d, p->bus, n))
> > +		return 0;

> > +	/* skip the bus number */
> > +	if (isdigit(d[n]))
> > +		n++;

Why do you think it can't be two or more digits?

> > +	/* the rest must be exact matching */
> > +	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
> 
> ACPI can sometimes add :01 suffixes, this looks like the re-invention of
> an ACPI helper?
> 
> Adding Andy for the ACPI review.
> 
> > +	return !strcmp(d + n, tmp);
> > +}

Yes, this looks like reinventing a wheel.
Just compare dev_name() against what is in p->....

...

> > +static void tas2781_fixup_i2c(struct hda_codec *cdc,
> > +	const struct hda_fixup *fix, int action)
> > +{
> > +	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
> 
> TI ACPI ID is TXNW
> 
> https://uefi.org/ACPI_ID_List?search=TEXAS
> 
> There's also a PNP ID PXN
> 
> https://uefi.org/PNP_ID_List?search=TEXAS
> 
> "TIAS" looks like an invented identifier. It's not uncommon but should
> be recorded with a comment if I am not mistaken.
> 
> > +}

Thank you, but actually it's a strong NAK to this even with the comment.
We have to teach people to follow the specification (may be even hard way).

So where did you get the ill-formed ACPI ID?
Is Texas Instrument aware of this?
Can we have a confirmation letter from TI for this ID, please?

-- 
With Best Regards,
Andy Shevchenko


