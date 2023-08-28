Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E678AD54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjH1Kr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjH1KrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:47:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5E1B5;
        Mon, 28 Aug 2023 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219609; x=1724755609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6aIuEePhI+R/WwcV5311+vAEUge039LU9co8xUVBTSw=;
  b=Yu+Ro7qUj+Wo6vC5ilBLI5Hg7gBxWnvzKfAPhx9O3DcSDFEuAeT4EkMS
   PTq2uv+hRpumAm8hug5fiWbx9UBc1DT70t7T7ZOGubBSNBKOUo+bsCDTl
   h67ohtX4+2VjAKpzTd27kOMuGZ0ac57smikVe+KD8k/U/9mfB/GoGGkc6
   ukcqNe7EBBj4tIjO7xNIAyzLdOm9/6vrrt6lzEUjo21C96P4v+pFxp/H3
   sdT2tcnmkOXWNBg02nNoOHNQ+AtlUe10UKBdshq7+GRjpdLnTQkzDYSZr
   f59QZZGw0uZSJx6XybtKtrfxX0+diICNQBRksP/i2y6Hd6JKTgLPpgzQC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="406062240"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="406062240"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="808239802"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="808239802"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2023 03:46:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qaZlC-00EntD-2v;
        Mon, 28 Aug 2023 13:46:18 +0300
Date:   Mon, 28 Aug 2023 13:46:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
 <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:22:00PM +0800, Herbert Xu wrote:
> On Fri, Aug 25, 2023 at 03:37:53PM +0300, Andy Shevchenko wrote:
> >
> > Why?
> 
> Because we shouldn't be including every single header file that
> kernel.h includes individually.

kernel.h is misleading here. It includes 98% of something which this file is
not using or going to use. Can you tell _why_ we need that 98% bulk to be
included here?

-- 
With Best Regards,
Andy Shevchenko


