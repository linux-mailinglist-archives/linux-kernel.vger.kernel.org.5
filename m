Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6F7F6BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjKXFbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:31:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB271BD;
        Thu, 23 Nov 2023 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700803897; x=1732339897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tMYQUYRHJkiNfAgz4/JDUhm1l9MYuzStRUkLJeVL9CY=;
  b=g9+3g8WiTfO7Shsr4OzCfj/6y7cd6YvupbxnEcDYvDoKOO+4lCaHtsq5
   YtwHO0mxFAMk2ZjIIE4p+q5ntLG2vVpKEL50eQNH8ZaRQqFh217eDHPAy
   2lF0hDeRWbpKqmq1hqIvw4a+rFWxGDbYokmQPPQwKO+xtTqP8eYRnnqEG
   lzx1pxxPaVH1Djc87Lx8KWlX/QpFih9hWd3db64tnvPnrVEsMbDJ8mhIg
   KfDv/aXLhPqo/n2riToDpsb07mR89VTaiB5pUCTpOyPqeTzZa7J8TOO9h
   NR796TewhQWTSXHeOY9JMHJtqyzzFHnt33y+hMyK8e8S3CaGqe9nD9CZ8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458857567"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="458857567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 21:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890972676"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="890972676"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2023 21:31:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8A33B1C7; Fri, 24 Nov 2023 07:31:33 +0200 (EET)
Date:   Fri, 24 Nov 2023 07:31:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/4] pinctrl: baytrail: Move default strength
 assignment to a switch-case
Message-ID: <20231124053133.GF1074920@black.fi.intel.com>
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com>
 <20231122175039.2289945-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122175039.2289945-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:50:38PM +0200, Andy Shevchenko wrote:
> iWhen ->pin_config_set() is called from the GPIO library (assumed

-i
