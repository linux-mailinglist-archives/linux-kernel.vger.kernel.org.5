Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB77AFC42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjI0HoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0HoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:44:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96710E;
        Wed, 27 Sep 2023 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695800639; x=1727336639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TkIhOBuEyWg5XuVB5v8CrmT/CVihxP0rBUx+tqvbtic=;
  b=UblKG9qaQvFFn2fa5f/yoYmkIXvkCi/Y6YoEj6hYn66B76HlDh8DsLpb
   GNNTpf+yBGEtdvryGJRl7eqrGG3P1rbYx6buE8yBqUYSwZIzwZXo2jv9h
   uiqziILBikLzXa5KZzm1dv/2ZjJ198CzFp9UAQ4hxI6zlOs6o/I+ZRq8N
   sKpEqacN0UZ8K7cizNcDW4b7X2zFb2QOzk7ID/fey70UXg5IXtFEpHno8
   ZmNeCxm0FaS+zIkug+4cDJbiGupY+AYOEN9SUVhy6wJEVn6PNHKy5Crsj
   WvSSU72o3Mf23AOt75ca9R6htqr/iuuOBbn/BFhuShm+DE1G7faThIsa8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372094021"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372094021"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922686057"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="922686057"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2023 00:43:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6899B133D; Wed, 27 Sep 2023 10:43:55 +0300 (EEST)
Date:   Wed, 27 Sep 2023 10:43:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the
 absence of ACPI enumeration
Message-ID: <20230927074355.GZ3208943@black.fi.intel.com>
References: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:08:18PM +0300, Andy Shevchenko wrote:
> This is to cater the need for non-ACPI system whereby
> a platform device has to be created in order to bind
> with the Denverton pinctrl platform driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
