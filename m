Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7A79C61A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjILFCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjILFBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:01:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4441703;
        Mon, 11 Sep 2023 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694494877; x=1726030877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKhrkHRdHrwlSpk0+9rDNzc2ZSUZAcIvDMmpAIY8uzM=;
  b=DFN+2SeaZQNiyguhegmjR30xmmWEa2jOMcmXqUVohTqJRBcAYS/+zhAk
   yFk2H3c03jmBwj03PCmGhVtm9eaR5KyK+9yqBq1Ex4UDto+6TriCkHn3G
   PaFA066FYLyVN2unCqVIKu97jy2DFK7bVZRahr3Uw8wH4FaUbYEPRrQUE
   ke2sWw9ND52YJNzjVamzCbD2o8JXztwQDcdT8SrxX3QimeQALt6Samjle
   C/0SJ9SzmFmQAzkhgGPEQC9NPjiLi7Qcn/+iDJPIz9piOdywGLU2/Z9zH
   kYGhfUXU3TxIty3ImThG+qjPV7kmCdAvKRuqwecnCmz01SF0Ig6AwOE5H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378184412"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="378184412"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 22:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867220932"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="867220932"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2023 22:01:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5B4EF248; Tue, 12 Sep 2023 08:01:11 +0300 (EEST)
Date:   Tue, 12 Sep 2023 08:01:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 3/4] platform/x86: intel_scu_ipc: Don't override scu
 in intel_scu_ipc_dev_simple_command()
Message-ID: <20230912050111.GB1599918@black.fi.intel.com>
References: <20230911193937.302552-1-swboyd@chromium.org>
 <20230911193937.302552-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911193937.302552-4-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:39:35PM -0700, Stephen Boyd wrote:
> Andy discovered this bug during patch review. The 'scu' argument to this
> function shouldn't be overridden by the function itself. It doesn't make
> any sense. Looking at the commit history, we see that commit
> f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
> removed the setting of the scu to ipcdev in other functions, but not
> this one. That was an oversight. Remove this line so that we stop
> overriding the scu instance that is used by this function.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/r/ZPjdZ3xNmBEBvNiS@smile.fi.intel.com
> Cc: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
