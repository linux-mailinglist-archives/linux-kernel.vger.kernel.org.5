Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445108087ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379412AbjLGMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjLGMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:35:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA510EC;
        Thu,  7 Dec 2023 04:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701952533; x=1733488533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AxuJODfeSyZXtb5X5FLkqlPIc2Wt4J6QcOdZzYwKh/Y=;
  b=LGDczdMOyHE4VcOk81Aeg7E3So6POyeAatZJ3xZ2V/HiPJNS+jRubBS4
   QqXPRIELVHGJruhv0IYD+muPo275WUR/x2cQL+FrwIOYUEzRPyJjiB2Gy
   IVDbvm6+KuV/jnPBuZnZfbXqtKajeA2T0z6PmziL3buCq5zm6ai0rZyHv
   V25LA0oLy2tw8f6NaaFZgvIT2m4VW/oVqXSqdP3oRsJK2+w+W6EHvpzki
   eHquABXyDQWsS8+UcdFJU+ZHfxU9kq5hWZSiiDyEWNAz7ympX/PhzMNhR
   3sxF1UpraWQ1bXOyik8vM5HB4MjpPpwzbNucczDaXRWLAqRWZ3pTJl65p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="460711669"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="460711669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:35:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="747950280"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="747950280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:35:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rBDbA-00000002bBU-3Czz;
        Thu, 07 Dec 2023 14:35:24 +0200
Date:   Thu, 7 Dec 2023 14:35:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <ZXG8DI8diij72fBR@smile.fi.intel.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:42:53PM +0100, Lino Sanfilippo wrote:
> On 27.11.23 13:14, Christoph Niedermaier wrote:
> > From: Lino Sanfilippo [mailto:LinoSanfilippo@gmx.de]
> > Sent: Sunday, November 26, 2023 12:40 AM

...

> > RS-485 (2-wire NO RX_DURING_TX): rs485->flags = SER_RS485_ENABLED|SER_RS485_MODE_HALF_DUPLEX
> > RS-485 (2-wire RX_DURING_TX):    rs485->flags = SER_RS485_ENABLED|SER_RS485_MODE_HALF_DUPLEX|SER_RS485_RX_DURING_TX
> 
> I think we can omit the SER_RS485_MODE_HALF_DUPLEX flag if we assume that
> a missing SER_RS485_MODE_FULL_DUPLEX means half duplex (i.e. controlling
> the RTS line).

You should be very careful on these assumptions, i.e. one must to check _all_
existing user space tools (at least that are in use / supplied by main distros)
on how they behave.

-- 
With Best Regards,
Andy Shevchenko


