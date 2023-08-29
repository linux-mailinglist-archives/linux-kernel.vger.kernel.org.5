Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA178C8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjH2Pag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjH2Pa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:30:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327FCC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693323025; x=1724859025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfN84d/8ivRT5vwu8VAWJZ/v5sei+a+/XQ6HoRxHJmg=;
  b=JoIsU5HCmmPzFd63nryORqt/IRF1pj0aMfbLS8EKxaCYjIkrIQfHXO0x
   vDNEE1ThaiT/xqt8TnqlmnIhKqzNNfBOZjliLJxsXV+2a9J961Kvx4z+3
   eV1nUSt/u4KWlO9N9CEhEuIRi6py4cmUQqvVCE35/bfRkw2yfM6Ra3WDm
   gTVteDlJp/Haq5TxanTxHQtcbEI/ggcf8Fe/AK9zl5QWg+aVC1yGEqPDY
   Mu24F7TfzaHJeDzERTpf/xQX6BPkufkxR3cnyg5NTiWi3WmcnSMbFm2pr
   yKBv/ccwnVfMHQTzwWW5DTwhM3w77zv6cXFVZUdxsTl8SQiiI5dxMT+Gr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406393903"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406393903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="828862934"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="828862934"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2023 08:30:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0fe-004uoG-1Z;
        Tue, 29 Aug 2023 18:30:22 +0300
Date:   Tue, 29 Aug 2023 18:30:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 3/8] bitmap: fix opencoded bitmap_allocate_region()
Message-ID: <ZO4PDnqB64VVe9kw@smile.fi.intel.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
 <20230829023911.64335-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829023911.64335-4-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:39:06PM -0700, Yury Norov wrote:
> bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

I don't think you "fix" anything here. You just refactor / replace the old code
with new one. I guess I made the same remark against v3.

-- 
With Best Regards,
Andy Shevchenko


