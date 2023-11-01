Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590897DDEA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjKAJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjKAJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:42:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15763101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698831756; x=1730367756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lss+qwZLb3QE4i4ElhvKc9XdrIQkAW4ycY1faJ14OsA=;
  b=ZRq/mgjmMlUPyDYt/PzryXJzJvJF5smUYLcnIubBh72dfN6uh8S8G8zi
   KljxA0+73eX3vodR5YRndAAqo1bg9/2E/+PVpz+XUoG3DJIqdAXFPtZ2O
   zNWDjbCLvrRxvHDEvuzSRBJkuHZtHd69ojhoQ5OwH3MHhEW4+pn0XGVlX
   53b8LgwZLjhttQUHuYVf6ClmEjjwsavUNhysUjJjGvX36eZSFgVGc60/D
   LXfexf1vGlbOfcjlJ0a1oKfbbNACvLiMI2OkYflrzMF3dNwfvr7ARz3+3
   QsrWE2lmm/VjNFrdHKzPXODT6979llSHXKrxEuyu8EfA2Hdch+AgVtvbq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373510566"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="373510566"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754429874"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="754429874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:42:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qy7k5-0000000APVo-43Xi;
        Wed, 01 Nov 2023 11:42:29 +0200
Date:   Wed, 1 Nov 2023 11:42:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Chen Ni <nichen@iscas.ac.cn>, lee@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <ZUIdhd6QAyjcozZU@smile.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
 <20231101070310.GF17433@black.fi.intel.com>
 <ZUIclOuVocLUUk7_@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIclOuVocLUUk7_@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:38:28AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 01, 2023 at 09:03:10AM +0200, Mika Westerberg wrote:
> > On Wed, Nov 01, 2023 at 06:26:43AM +0000, Chen Ni wrote:

...

> We should actually fix the PCI code to guarantee that.

(which also barely a fix as PCI IRQ == 0 is quite unusual case IRL)

-- 
With Best Regards,
Andy Shevchenko


