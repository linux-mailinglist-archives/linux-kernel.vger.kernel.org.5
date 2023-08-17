Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EB77F3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbjHQJq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349802AbjHQJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:46:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B12D67
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265590; x=1723801590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeD2sBxt8JBticPv4pBHDW5wyFNnKF8mQTRdvEheOOo=;
  b=Zo7Yo6q8VKGlFDh/BadSVkMNeAEozJvtRJhWpdlS57ulxvLmbIhYRt0Q
   yJNcH6SjDK+ktnSVZeYoehyLi7jCdtZZXDAvQ1JxXzqLD77aCMfk4AVMh
   2YLS6qGM/OKq6/6qInDcLDstw9zwf+tuh4dHHc3CJPuR2+H97+4eWOpsw
   j18jkxmRhgQVFn0IZ4TlvZB1USmfE7TRKhyZOo3OrhFNJYK2z47NgT3gI
   eSvCaeoggkL8qVDMcfJXI+WMLZf/p5a0nxMSVNRFubUvYSlBW/IB4zbCv
   VoK6SeG4G4trK3Qr6H5yiNdJjpBBrIbFqQ5HSIit0KVHno5CdyOMJNQmi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376501574"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376501574"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804568574"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="804568574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 02:46:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZa9-005mmP-1E;
        Thu, 17 Aug 2023 12:46:21 +0300
Date:   Thu, 17 Aug 2023 12:46:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 5/8] bitmap: replace _reg_op(REG_OP_RELEASE) with
 bitmap_clear()
Message-ID: <ZN3sbde9OgZX3458@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815233628.45016-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:36:25PM -0700, Yury Norov wrote:
> _reg_op(REG_OP_RELEASE) duplicates bitmap_clear(). Fix it.

Ditto, it's not a fix per se.

-- 
With Best Regards,
Andy Shevchenko


