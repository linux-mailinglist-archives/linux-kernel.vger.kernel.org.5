Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136E67EF94A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjKQVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:14:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17DB6;
        Fri, 17 Nov 2023 13:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700255652; x=1731791652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eVRu9XIzXKbN6tfwpVjUfg4tPIpkN45JOzL4f+o8wFg=;
  b=cyyMBqi4huGzPjALh3/lVFeBf+q4F+tvcwc1JttcwBDXeP6KvBSIlBKn
   MyFJ6aTwo2tHv2u3IsL6/iicpqDijZim7pwsoJ2Z5gS/aM00uRSCF3o7c
   SXX46KktzRdiwq9x4mHXOkZUMEnN9NEZUqTdOSs84CfwB6OtGZN0KHg7S
   sjNlIUeCyyBciGSauVAYszfFgrfO+at7zSi4rzkPJPQbnLBAA9SxffjsL
   AGTo6f7Jy1FCwHDRg9VrM+PQmNQsZodofqNFxXlkIUTeljokjSz73AATQ
   YR9XOblVX4CH+33JnKTFku0CWWorur659Utak3TkhoSqWePdT+WfZKh2d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="422463588"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="422463588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="794931834"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794931834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:14:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r46A6-0000000Eu87-2FQ3;
        Fri, 17 Nov 2023 23:14:02 +0200
Date:   Fri, 17 Nov 2023 23:14:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Cixi Geng <cixi.geng@linux.dev>, apw@canonical.com, joe@perches.co,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Industrial I/O <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add judgment condition for Kconfig help test
Message-ID: <ZVfXmlBbB3Y12Zz3@smile.fi.intel.com>
References: <20231116153904.15589-1-cixi.geng@linux.dev>
 <ZVarTLiczTZ8oCBg@archie.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVarTLiczTZ8oCBg@archie.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 06:52:44AM +0700, Bagas Sanjaya wrote:
> On Thu, Nov 16, 2023 at 11:39:04PM +0800, Cixi Geng wrote:

...

> > the checkpatch result:
> >     WARNING: please write a help paragraph that fully describes the config symbol
> >     #23: FILE: drivers/iio/adc/Kconfig:1050:

> >      	help
> >     +	  Say yes here to build support for the integrated ADC inside of the
> >     +	  Say yes here to build support for the integrated ADC inside of the
> >     +	  Say yes here to build support for the integrated ADC inside of the
> >     +	  Spreadtrum SC27xx and UMPxx series PMICs.
> > 
> >      	  This driver can also be built as a module. If so, the module
> >      	  will be called sc27xx_adc.
> > 
> >     total: 0 errors, 1 warnings, 17 lines checked
> 
> This confuses me. What are you trying to achieve there?

Is the indentation correct in each line? No TABs/spaces mix?

-- 
With Best Regards,
Andy Shevchenko


