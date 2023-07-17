Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0217F755CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGQHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjGQHXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:23:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572310D7;
        Mon, 17 Jul 2023 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689578594; x=1721114594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfiGMmXYe+HdZA7eduej8t7HZf3otdWWMTmNFs8E/Fw=;
  b=hm/ViwUzuDcTT+H2GBgxC3wZ4VOjxJ9CZt4M5KkxCeRI1nBJOEUX5g0U
   EypKiJVZ+IEyLlvJUvzTq6wL6z114PS9fuzCbv3v6GePQFbM7PHB8RVIa
   yH4kMSF0oPM+z4lhJRDeJCX/LY3HhULCyAyw7Wwcxe2ZlIRaZ6HT/7uk3
   ph+RuK5aXT8LlCsME3uUcvWJLED9pRvfHghIKOxvTxUOM44SbawXBYgNw
   HLG8cxbCkZg1Di/h5+BqUbcgaq9wLSC3kyKDTuHWs/u6xcti+UKZD4pCY
   jXSOTT7YSQz6ZNTDb/qwaqrtHXbuOiTd2AuBANfDeGvyafdtLgqBK1bDN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="345456337"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345456337"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 00:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="758299676"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="758299676"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 00:23:12 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id ABFC411F913;
        Mon, 17 Jul 2023 10:23:09 +0300 (EEST)
Date:   Mon, 17 Jul 2023 07:23:09 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-fixes tree
Message-ID: <ZLTsXUFZy4Iggk5u@kekkonen.localdomain>
References: <20230714083645.4e587f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714083645.4e587f71@canb.auug.org.au>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Stephen,

On Fri, Jul 14, 2023 at 08:38:25AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   b0b43354c345 ("media: tc358746: Address compiler warnings")
> 
> Fixes tag
> 
>   Fixes: 80a21da3605 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
> 
> Also, please keep all the commit message tags together at the end of
> the commit message.

Apologies for this, I guess I've removed one character too many from the
hash.

I'll switch to a script (or alias) to do this. It'd be, though, helpful if
git could do this on its own.

-- 
Kind regards,

Sakari Ailus
