Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999397FF19C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbjK3OTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345898AbjK3OTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:19:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB783;
        Thu, 30 Nov 2023 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701353982; x=1732889982;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yCwGWZ6omGh26nOrTHmakqG/E9HURyUlbCEKibso0J8=;
  b=IVVBQBcfWVf+4CAcFifLasnnajhg04Mwa76SQCtVHnx2GPOhA47AXS2J
   6v1IUbXGH+wDvRm6MPUiLUD8HKZOx2Fg+G9LpOS0s8Nr2Myhr+31DZGdJ
   OD+AC1vn0BWVjAXk3qGbiYr1MaLuEwseUtpJiLh2TIGAADsYgUfBFZPyk
   IQ+CPw0S7ABCskwXSM4fYz10ui0lBCTXYe/42YpLjkVEj6WufoWrGi0dI
   TgMFC0Qnr9x087VBkf6ngLXNApJcXBAq1WFlCMyoRROvzsxSNuZPu18WF
   H1M7G+xohB6nTHsIHhGDBOVtiy5Xoz6YwWjDuo+63mQBmz+G0/ukQtqqn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="188373"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="188373"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1100951359"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="1100951359"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:19:38 -0800
Date:   Thu, 30 Nov 2023 16:19:36 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v5 5/9] tty: serial: amba-pl011: avoid quoted string
 split across lines
In-Reply-To: <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
Message-ID: <439c1650-e88-4442-4025-38e9fbf465@linux.intel.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-210180421-1701353981=:1808"
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

--8323329-210180421-1701353981=:1808
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2023, Théo Lebrun wrote:

> Remove all instances of quoted strings split across lines. Fix four
> checkpatch warnings:
> 
>     $ ./scripts/checkpatch.pl --strict --file \
>         drivers/tty/serial/amba-pl011.c
>     WARNING: quoted string split across lines
>     [...]
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-210180421-1701353981=:1808--
