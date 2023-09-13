Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1279E651
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbjIMLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjIMLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:14:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49892D4C;
        Wed, 13 Sep 2023 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603561; x=1726139561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tGJ4M6q95QKK9r+I8xoFUhp9gNf1DYxmXMPssTAzTm0=;
  b=cSm2JPzVuP61ry5vjVpGqgiFCvbi4DQAL/IIjZR14Eamj+FagrM7u8xg
   Gb0AZbEaVAY+unuhInFCb5W3TK7PihJHo9OPtwpy2y22I5tq4XVVKwwh6
   LGOQWLbVOH3MABvF/ZiM2+chf0kJpcL8CJW6c8Q3jS+IL/7a9E/ITX7Xp
   XiIKF1iE2jGMa/IUF+38RYRZwBNyLSky4Vg+mKT4oXS6c4SkrtPU0+uSw
   Lz0Jdw5N2nDk5Ikb/CV6Ycf8DPNAyqMsnKhOuEpYyvO9Fkra2dy22mBwz
   TjJCdXH8aYkBjfpNSfq6cPD+4rnymlF9Nt0f/IQ5aVo17/0ZQkSFBiSwM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358899934"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358899934"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990879528"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="990879528"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:12:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgNnO-008qa5-20;
        Wed, 13 Sep 2023 14:12:34 +0300
Date:   Wed, 13 Sep 2023 14:12:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm7271: Use dev_err_probe() instead
 of dev_err()
Message-ID: <ZQGZItGcauus7l9F@smile.fi.intel.com>
References: <20230912165550.402540-1-andriy.shevchenko@linux.intel.com>
 <412c5225-e9c0-6a8d-1b39-2ce60cbf8074@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <412c5225-e9c0-6a8d-1b39-2ce60cbf8074@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:20:49PM +0200, Christophe JAILLET wrote:
> Le 12/09/2023 à 18:55, Andy Shevchenko a écrit :

...

> > -			ret = dma_irq;
> > -			dev_err(dev, "no IRQ resource info\n");
> > +			dev_err_probe(dev, dma_irq, "no IRQ resource info\n");
> 
> ret = dev_err_probe(dev, dma_irq, "no IRQ resource info\n");

Good catch, thanks!

> >   			goto err1;
> >   		}

-- 
With Best Regards,
Andy Shevchenko


