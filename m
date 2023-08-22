Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0246B783EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjHVLUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjHVLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:20:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA231BE;
        Tue, 22 Aug 2023 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692703238; x=1724239238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjVL2Iu3A5MGQLZNkGOUWI3Hvef+G0HOPDfP0Lhj3/c=;
  b=jUK3OeJnkKYc1+UOOU5E/kdqfmEFvuawdG6V3CkwEHPUthYR9Xh0/wpV
   CP9vyX9towH1yIjwE9A2Qq7sijzDo1fHvyJXxaLuVeDgF8zQ5KQ95m0UI
   m6BnIissjc2Z7m0ChP02XahOi4DbfhQ5yQ2/Tdi/vfQjAThjwZ4fQqDnJ
   K2S1Lp7cgcLDdQ7ARjTum0avkkkYsX3fgHcFuRgOY3hhOqtqyDW4xmzoE
   pyvhxb5X7KrWEk4O5M4SNUF4uZmO00N8kotx71mn8LZoQ7s00LcATMmLB
   XGxLWRl8NgC46rrww9ijAFN/j+8m1XC31QeO/YO6TI1Q2rCnS7Ydiq3ys
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440218566"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="440218566"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="713125548"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="713125548"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2023 04:20:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2C8E2D87; Tue, 22 Aug 2023 14:20:34 +0300 (EEST)
Date:   Tue, 22 Aug 2023 14:20:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: cherryview: fix address_space_handler()
 argument
Message-ID: <20230822112034.GN3465@black.fi.intel.com>
References: <20230822072340.8783-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822072340.8783-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:53:40PM +0530, Raag Jadav wrote:
> First argument of acpi_*_address_space_handler() APIs is acpi_handle of
> the device, which is incorrectly passed in driver ->remove() path here.
> Fix it by passing the appropriate argument and while at it, make both
> API calls consistent using ACPI_HANDLE().
> 
> Fixes: a0b028597d59 ("pinctrl: cherryview: Add support for GMMR GPIO opregion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
