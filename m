Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2831D7F6BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjKXFlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:41:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336E101;
        Thu, 23 Nov 2023 21:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700804488; x=1732340488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oVQwgv2ow7U2EuiQeF94cjR2sx9Q558B5162Jzqi6NM=;
  b=dETjZJfxTz8iHOTyyjXsxXtXFbLfMAmotA8qC45IbN9pqHf4lv21cMEe
   zputlPDJ4iRgCNn1rNwXG3KruPkf7ZZV0g69c4JirphqbBs6wKS7snqPO
   2rpZ4ZGYy5sNRebX8bCCFte7nFVaEomnx7UeD7rWFQzPkgsB2rZD16reC
   BQTprucHLZL3TJZyxf8jrkz/d2OnK24fjndM1c/yb6DD2VCyG1KdOPSrM
   fDozETJQWOYDdyrZYtIcpVoyPwbxEnO3mHhdBpRj+a9by9DJ4nX6zlFDq
   uoeEjhTUZiV4ck9n5Uf9IJcHlukzL7OdhugqKVxcox95B56+eW7Ezax8u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423505261"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="423505261"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 21:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796494457"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="796494457"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2023 21:41:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 20B2B1C7; Fri, 24 Nov 2023 07:33:39 +0200 (EET)
Date:   Fri, 24 Nov 2023 07:33:39 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] pinctrl: baytrail: Fix types of config value in
 byt_pin_config_set()
Message-ID: <20231124053339.GG1074920@black.fi.intel.com>
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:50:36PM +0200, Andy Shevchenko wrote:
> When unpacked, the config value is split to two of different types.
> Fix the types accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There was one typo which I commented (please fix when applying).
Otherwise the series looks good to me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
