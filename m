Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992327CCC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjJQTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjJQTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:43:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D0AC6;
        Tue, 17 Oct 2023 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697571792; x=1729107792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JF3kBYiZ7ja2TA5QXy9uKVO4oRFv5C/TTDXBiZDQ1GA=;
  b=M1nAayz14UVfm+ATwLcVXT4/IFgQXK6SbFv7vZPB3CnF0/GwQTHJLkia
   jG9ocmghjVekXIpPWPQM5vmhr9mgEfbPpXFzB1CiEr/xBHLFaydF57kzl
   A9hxbd2tYhWof0XVtJ6X0weSZ763BkBX7B2/ltSe6+l7jSZ2TeLlcAvZi
   RMIfLEj44vfJa0LHfPnovMWwmEL/hyRbNoGctZM93H00OZQ1BatLnwb5x
   i65k5ecrdTc9rT5S8uIWuu+sXtIGMM6bPGGwO1WnixcdabN3HtjbdTO9k
   C9BFVigaVYrsa3MkAp2n1Xssz2pT+9Xoy3Yj1Xiid7lfp47u40jvlJHYp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389738671"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="389738671"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="929879025"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="929879025"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:43:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qspy4-00000006PcA-2yxa;
        Tue, 17 Oct 2023 22:43:04 +0300
Date:   Tue, 17 Oct 2023 22:43:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <ZS7jyHkKJcubVxws@smile.fi.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
 <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
 <20230809185944.1ae78e34@jic23-huawei>
 <ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
 <20230828190101.50f70921@jic23-huawei>
 <CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:19:30PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 28, 2023 at 8:00 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> Sorry for the delay, I've lost track of this.

NP!

> Honestly, I have no strong opinion, but I think that this is going to
> reduce some code duplication which is a valid purpose, so please feel
> free to add
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> to this patch.

Thank you!

Jonathan, are we all set for applying this series?

-- 
With Best Regards,
Andy Shevchenko


