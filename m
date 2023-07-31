Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8926A76A1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGaUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:16:46 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6414E10FB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:16:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="371828127"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="371828127"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="722210853"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="722210853"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 31 Jul 2023 13:16:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qQZJp-004RKT-2N;
        Mon, 31 Jul 2023 23:16:41 +0300
Date:   Mon, 31 Jul 2023 23:16:41 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <ZMgWqVb4wg5h6poh@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
 <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
 <79619e92b70fdb4b324758ddb34f84b3b8963256.camel@maquefel.me>
 <CAHp75VdSaxzU_7A7b=Htph29XA=ZbqUPJ6RJu+HtrSA2EbcXig@mail.gmail.com>
 <cbc0c2d68b950bf984b5cb16ce7fa6d2348940ad.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc0c2d68b950bf984b5cb16ce7fa6d2348940ad.camel@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,MAY_BE_FORGED,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:01:11PM +0300, Nikita Shubin wrote:
> On Fri, 2023-07-28 at 12:46 +0300, Andy Shevchenko wrote:

...

> I see your point now - citing docs:
> 
> "Logic safeguards are included to condition the control signals for
> power connection to the matrix to prevent part damage. In addition, a
> software lock register is included that must be written with 0xAA
> before each register write to change the values of the four switch
> matrix control registers."
> 
> So reading SHOULDN'T affect the lock.
> 
> But as we checked reading also breaks the lock, that's why this looks
> so odd, it was done for purpose - i'll check it once again anyway.

This is very interesting information! Please, document this somewhere in
the code.

-- 
With Best Regards,
Andy Shevchenko


