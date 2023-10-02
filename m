Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173307B4F99
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjJBJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjJBJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:55:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7B8E;
        Mon,  2 Oct 2023 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240522; x=1727776522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fOrOmvdF6LT3+L3Jy/6pyrjx2JfHMcCZvJIukRslaqg=;
  b=g/PtyqUjQJGgwpVUO4BSTBuy7+c9gWBRGG8ojvT2/xjFHR7KFVT5ZPzE
   ZnpzzuWbRkA2U32+FHcrbUUaE1WJba4mIRGpNQAmpmpxPSkBvev5WECXJ
   ODVL0sNxn//dyXzMUvCH3TLJTtvsQ1KoRU845+1FlpvYqdC49gmVye4ii
   aLpmoxLmEL6MUuAdXcz8G8tSPS8p+ewsjZ8/XInIOOT/dxaMMD5vGo/5L
   QAz/2yLKR0PAXfgrCnDKDemnpv4GhOfO3QdfZOhHIZ8MQLnRup8n3Dcj1
   Na4i1020zm8G/JZQjpZnQfu+uYX0BitLk6k5UtOaAcRlf7s2B6JeO7OgB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="413524513"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413524513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="840935007"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="840935007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:55:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFe1-000000027n8-0Hr2;
        Mon, 02 Oct 2023 12:55:17 +0300
Date:   Mon, 2 Oct 2023 12:55:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Message-ID: <ZRqThAuMogtcMtHI@smile.fi.intel.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
 <20231002102745.0000540b@Huawei.com>
 <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
 <OS0PR01MB5922C468BEF67BC2A19F87D286C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB5922C468BEF67BC2A19F87D286C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:38:17AM +0000, Biju Das wrote:
> > On Mon, Oct 02, 2023 at 10:27:45AM +0100, Jonathan Cameron wrote:
> > > On Sun, 1 Oct 2023 18:09:56 +0200
> > > André Apitzsch <git@apitzsch.eu> wrote:
> > 
> > > > Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert
> > > > enum->pointer for data in the match tables")
> > 
> > ^^^ (1)

...

> > > So we need the spacer until someone converts this driver to use
> > > pointers instead for both of and ACPI tables.
> > 
> > Isn't it done by (1) which is in your tree?
> 
> How (1) can trigger 'Unexpected device' error??
> It returns match_data, and match_data has correct device type.

How? The enum starts from 0 with a AKXXXX and ak_def_array starts from 0
indexing, it's classical off-by-one, you got the driver data for a wrong chip.

-- 
With Best Regards,
Andy Shevchenko


