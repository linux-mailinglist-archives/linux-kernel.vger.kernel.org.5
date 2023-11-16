Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07FD7EE02E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbjKPLze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:55:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38829B0;
        Thu, 16 Nov 2023 03:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700135727; x=1731671727;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=idgzep+H+rCXGm/O2ITkrOwgiB1VoNxL3UyIBXGeatg=;
  b=c75nyKulhKKXE+8gX1FUh5/peDI7Vps0x6Ao1uwZZjBWLk87dGXSkSBl
   pDEkM7EXBD2dzqL7TYN9Nv1e4nVmByyOSUyvW2QSniFad645bVM/oYC4m
   90Gsmmfn1I0cey8otSBCoZohbNWtDEm+EGvG+XDm/yD89G0P5Fr5borEt
   KoMhb92Uwvt0uSrb6+4ej3eg4ZQw6X/VpYg1Jj20FKiqEHcyVORlYIDtn
   Hopu2ZOlsNbPEa1WEQU5eDkXi928KkNJIyt9M6nsFihkt32eE4Y4ZfzWt
   RIlW8lmOMOmbVio3+ZCOfJ2XYWQal3Q4m7tTCuXoMiwhpxMUjK9/CvyFk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422162705"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="422162705"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="715205764"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="715205764"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:55:23 -0800
Date:   Thu, 16 Nov 2023 13:55:20 +0200 (EET)
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
Subject: Re: [PATCH v2 2/5] tty: serial: amba: Use BIT() macro for constant
 declarations
In-Reply-To: <20231116-mbly-uart-v2-2-863f665ce520@bootlin.com>
Message-ID: <94d698d-f0a4-fe43-fbe4-4d4d62a8ee2c@linux.intel.com>
References: <20231116-mbly-uart-v2-0-863f665ce520@bootlin.com> <20231116-mbly-uart-v2-2-863f665ce520@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-312832558-1700135472=:1886"
Content-ID: <d1f22071-d360-5a9-6992-9ad91dd875@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-312832558-1700135472=:1886
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <2b55d7d3-433-8e8a-99bc-326bff513ad0@linux.intel.com>

On Thu, 16 Nov 2023, Théo Lebrun wrote:

> The driver uses bit shifts and hexadecimal expressions to declare
> constants. Replace that with the BIT() macro that clarifies intent.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> ---
>  include/linux/amba/serial.h | 183 ++++++++++++++++++++++----------------------
>  1 file changed, 92 insertions(+), 91 deletions(-)
> 
> diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
> index 27003ec52114..a1f966fcb9c5 100644
> --- a/include/linux/amba/serial.h
> +++ b/include/linux/amba/serial.h
> @@ -10,6 +10,7 @@

>  #define ST_UART011_DMAWM_RX_1	(0 << 3)
>  #define ST_UART011_DMAWM_RX_2	(1 << 3)

Just noting a potential futurework item, these (and alike) could be 
changed to:

#define ST_UART011_DMAWM_RX	GENMASK(5, 3)
#define ST_UART011_DMAWM_TX	GENMASK(2, 0)

#define ST_UART011_DMAWM_RX_1	FIELD_PREP(ST_UART011_DMAWM_RX, 0)
#define ST_UART011_DMAWM_RX_2	FIELD_PREP(ST_UART011_DMAWM_RX, 1)
...


-- 
 i.
--8323329-312832558-1700135472=:1886--
