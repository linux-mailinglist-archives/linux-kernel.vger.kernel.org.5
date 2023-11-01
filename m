Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFDC7DDCCD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjKAGnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjKAGnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:43:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECAF7;
        Tue, 31 Oct 2023 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698820988; x=1730356988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldcrNXcpF8P35uuZgLgIsrYAfKX7Vsm4RFFm2udWw1Q=;
  b=LIyaFtoOtuAo63QHzG1vErf5NUsOXRU2+wSiQ8a9RvYdqOcM3BBbipmx
   HUEoc1wHyb/1s0lGbfQkLa/ZTx1YpfMwMbJOhh/QiDU7rJl+DK2MEbrCh
   rd57G+p+ZlgQKK8PWNwTjy98Pu2gctBtCKfM/e7uKNgsRDrm9Swm7F3Kh
   1Q1ZwEImupNJdDxQHt0OqLtlK3hvcoW0PBZ7M/wYzRc2tGhcnVsdq14OH
   uAnbgAyibC3vqRw9J40Otff4JmHVY7tx0UgBaOogAVyTOHATlQzkgbVGH
   5Gzu7cxBgZBTNCsYfNNivIAjf0jEpTxrroN+vTouXOinr5sRirZk1mJM5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452731715"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="452731715"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 23:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="831270934"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="831270934"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2023 23:43:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 04FA752A; Wed,  1 Nov 2023 08:32:45 +0200 (EET)
Date:   Wed, 1 Nov 2023 08:32:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/3] pinctrl: intel: Add ACPI ID to the generic
 platform driver
Message-ID: <20231101063245.GA17433@black.fi.intel.com>
References: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
 <20231030141034.3241674-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030141034.3241674-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:10:34PM +0200, Andy Shevchenko wrote:
> The INTC105F is an ACPI _CID that reflects compatibility with
> the _DSD shema supported by the generic Intel pin control
> platform driver. Add it there.

You can add this in the patch introducing the driver.
