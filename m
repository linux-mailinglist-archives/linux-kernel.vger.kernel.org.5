Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78617618D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjGYMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGYMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:51:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4419A2;
        Tue, 25 Jul 2023 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690289488; x=1721825488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eC9JYYny7fzTWzMint7Bf1073AJMuH1Fj6VitKBlCJs=;
  b=QOD6+StajrLJsOzZ3DPaewJqEVlsqZM/3l64ZxDlyg3hprHQCVJjQVcY
   KTQ1DlfbK1GiWbSWaNetPDRomVYgDlzP4lwATqQCzhy97+fqKD3oL4Q+v
   ok0KqjNb0U4HvGoq8Cd38j4c7fa5Xq5VbZ0kwvWd4nlO1bF5h5JdKTnYm
   CdZ04QX2ME3eoTcZYNhZb9kqN+VniGd8Cos1EZ5DwR/LGY9lIbjpyMMMS
   WfwL3ETFcQA/uBHTwOZ43YoP0O8B4kDBsUmdIGcc+mv7Nz5lJyYnbN+1G
   MIE7XpNcxyKhhL+FlNnz89aMVKuIGlBkLRhObF8M+4z2d9k/msl6Kb4Sy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431512467"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431512467"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="720056033"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720056033"
Received: from kshutemo-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.37.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:51:21 -0700
Date:   Tue, 25 Jul 2023 14:51:18 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-15?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Stephen Boyd <sboyd@kernel.org>, Helge Deller <deller@gmx.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: Re: [Intel-gfx] [PATCH v3 1/1] drm/i915: Move abs_diff() to math.h
Message-ID: <ZL/FRsllUVUhruAZ@ashyti-mobl2.lan>
References: <20230724082511.3225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724082511.3225-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jul 24, 2023 at 11:25:11AM +0300, Andy Shevchenko wrote:
> abs_diff() belongs to math.h. Move it there.
> This will allow others to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org> # tty/serial

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
