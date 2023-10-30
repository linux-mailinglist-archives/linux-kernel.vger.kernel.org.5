Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD77DC1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJ3VOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3VOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:14:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D97E1;
        Mon, 30 Oct 2023 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700457; x=1730236457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FHDjm5OgiKx3EgZqFfEjFepEWVhsEVZS/sP/rm1i8dA=;
  b=PQJF7tAd6IZmvhtvGoSgBk5uxDVuk5+wE+yIIKqa9DtDypAfvhjbWWjK
   xjclgpjB91b1+v78sFIHb3fGQqAv9bTJxUAyqbf6FZ/F5rgtc5nbatbkz
   9Oq65H5C3yXtgiA2TsxOXjaclpBcESOjJwkPrvPAXHf4D5m9rchLb09ki
   EOrrM73PnYIoxEb2ujGxNrzzXgirKfl8VMGy6r895CGPIZPc94xxWQ1Q7
   AmH/61H/KtRFLbmgFYOiUoq9J9hQ8ZoXPPn11megAQiCHW2OaudN37Pm3
   FDbbUTj1zP9uwHlolb8RRZRHz5uwR+OME4Wzd/aJWIPBRiLasUtmLLYkX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="454630970"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="454630970"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="933900736"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="933900736"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:14:14 -0700
Date:   Mon, 30 Oct 2023 23:14:11 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <ZUAcffriaEkNcRH_@black.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:53:40PM +0200, Andy Shevchenko wrote:
> iWhen ->pin_config_set() is called from the GPIO library (assumed
> GpioIo() ACPI resource), the argument can be 1, when, for example,
> PullDefault is provided. In such case we supply sane default in
> the driver. Move that default assingment to a switch-case, so
> it will be consolidated in one place.

Looks good.

iWhen -> When

Raag
