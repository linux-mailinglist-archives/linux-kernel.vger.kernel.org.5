Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7737F6BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKXFef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXFec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:34:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476FD6F;
        Thu, 23 Nov 2023 21:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700804079; x=1732340079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LH3PwsW1t1Y6hWbSRydDUMbWoG30hSVbvNfUjNQfvtE=;
  b=FFWCXIFHHT10hdorFDh2HeHSHLONI5FsRw1pC6/iYEVzriAPVSr+iH4x
   ucbsugna4s/eZwIRNFxC1KPIlWmsplzNCgqJXJXx+ge9twv9zhNhNYXyX
   659pGrLYbOETSybUx5U3ObQlA8aW68U03Oi3C1uOt2qyIDH7pRO6rtXcf
   n7jH22qjkrcgN7zw73iSTbLHEVf0NtR6UTl6cbRoR7u4aXW/Upp+88E7r
   Qmy0IgVWwQXhxkQ8qyGvYDeVVMFaTsRu4DqPzEnsOLuhbOWNiny4p5fnm
   tMAog9FHTlJzCiM+MiPvbKnjiwC//mAMtkrzAG5pS69LtKG5DSrn7OrS8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458858004"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="458858004"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 21:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890974106"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="890974106"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2023 21:34:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 24759305; Fri, 24 Nov 2023 07:34:29 +0200 (EET)
Date:   Fri, 24 Nov 2023 07:34:29 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: lynxpoint: Simplify code with cleanup
 helpers
Message-ID: <20231124053429.GH1074920@black.fi.intel.com>
References: <20231122175444.2316719-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122175444.2316719-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:54:44PM +0200, Andy Shevchenko wrote:
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
