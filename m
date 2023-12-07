Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945028085DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjLGJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjLGJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:56:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109BD133;
        Thu,  7 Dec 2023 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701942982; x=1733478982;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EsZ9iyoAmNB41lTSlRafnsFQSmgu2tbDM95/rM+nIpQ=;
  b=Qb0xm/uie5JS2QlyWOPixvIxf9N8qboBIco2lk0w8jqArgFskaXzrj9H
   TmWojtCtJbVDJIRU/TicUqWhT5bOSx5v9p2/n/IrFLVGP7/gLkCYhxRxS
   fqogLUPMQckqrmYjBScHwgspvdJWMtjr5p1g5TJXOUHFqKZkjRVL32ySu
   O62/4LnXLbnu1bZx4jkEMHVJlovqLZk/aZFHL4YsozeNne0Nx1JDlvsVU
   DocCn9kf3r2Gemim6Zq/Q38Q4ANeWoeDOivqLszMe1khcsUf10ZdulMck
   +ysXk6zt1BqoAvr1nZkgrYQvDtHzVqUxWnXV1oRziaDKe+amOO0hWzCkh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1289013"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1289013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:56:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944979494"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944979494"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:56:18 -0800
Date:   Thu, 7 Dec 2023 11:56:15 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
In-Reply-To: <CXHZXP7XVD0T.24N3YDLX7I929@bootlin.com>
Message-ID: <42e8faf-5293-18e4-3877-25e4d094f1d@linux.intel.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com> <2023120742-argue-slighting-6120@gregkh> <CXHZXP7XVD0T.24N3YDLX7I929@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1941806678-1701942827=:1765"
Content-ID: <e6839a44-23d8-86b-e736-5d7a4e41b2c5@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1941806678-1701942827=:1765
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <669795fb-a6b2-2749-cc7e-df83337e581a@linux.intel.com>

On Thu, 7 Dec 2023, Théo Lebrun wrote:

> Hello,
> 
> On Thu Dec 7, 2023 at 2:37 AM CET, Greg Kroah-Hartman wrote:
> > On Thu, Nov 30, 2023 at 03:07:14PM +0100, Théo Lebrun wrote:
> > > The driver uses bit shifts and hexadecimal expressions to declare
> > > constants. Replace that with the BIT(), GENMASK() & FIELD_PREP_CONST()
> > > macros to clarify intent.
> > > 
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  include/linux/amba/serial.h | 248 +++++++++++++++++++++++---------------------
> > >  1 file changed, 127 insertions(+), 121 deletions(-)
> >
> > As 0-day had a problem with this patch, I've applied only patch 1 of
> > this series.  Can you fix it up and rebase and resend the rest again
> > (while adding the collected reviewed-by that some patches in this series
> > had)?
> 
> So the issue is this: the header file gets included in
> arch/arm/include/debug/pl01x.S that gets included in arch/arm/kernel/debug.S
> (see #include CONFIG_DEBUG_LL_INCLUDE).
> 
> I don't see any easy way out of this, so I guess it means the patch must be
> dropped. If someone confirms that there are indeed no solution to have BIT(),
> GENMASK() & FIELD_PREP_CONST() accessible from assembly, I'll send the next
> version.

Yeah, it seems to require UART01x_FR_TXFF and UART01x_FR_BUSY, plus 
UART01x_DR and UART01x_FR that are not touched by your patch.

I suppose the rest might be convertable though..

-- 
 i.
--8323329-1941806678-1701942827=:1765--
