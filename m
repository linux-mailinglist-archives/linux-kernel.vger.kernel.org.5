Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5DC793A34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjIFKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjIFKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:47:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273691730;
        Wed,  6 Sep 2023 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693997236; x=1725533236;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ymyiI8n2WES/QdaORSDqpei3Mu93ry3qBVlK6F6utw8=;
  b=lyWm1MvGzdb9NOFVY/4ux5G+gxNjLjfIPuzX7MUA7Gx/tKAYYiEnUBfa
   gjjxeWODjY2OVQ47OmXaOeWWrTGbLxIadHkN0suyRu/lmOo4Dq8yuevOC
   wjS8JS8AdwJwqlG/kjXIHbCVPE3Nrqc2oHUNRZjQZcmz13abXqGmz/AdL
   B2TJC6U0EdFAfy0R79BQ8u19aACr4RyGIr4+iC3jBm8xxYzhDVTX0Ur1H
   1nztbmw1c0P8jt9R5Vgq/2vHX32Dr6buKkXhifOaRTGAYsSZ8diGAX3ws
   zDoJYlSVr+R18RHAWBAWQ200eqHugQQa3uMvH9O2BNXREBJ+n3d02D/+A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375932777"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375932777"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 03:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988190501"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988190501"
Received: from swegrzyn-mobl.ger.corp.intel.com ([10.252.60.192])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 03:47:12 -0700
Date:   Wed, 6 Sep 2023 13:47:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: sc16is7xx: remove unused to_sc16is7xx_port
 macro
In-Reply-To: <20230905181649.134720-1-hugo@hugovil.com>
Message-ID: <f8912f92-dda9-9f56-99fa-f3f79d95c86@linux.intel.com>
References: <20230905181649.134720-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1916176287-1693997234=:1906"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1916176287-1693997234=:1906
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 5 Sep 2023, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> This macro is not used anywhere.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index f61d98e09dc3..d8534580c6d5 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -358,7 +358,6 @@ static struct uart_driver sc16is7xx_uart = {
>  static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
>  static void sc16is7xx_stop_tx(struct uart_port *port);
>  
> -#define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
>  #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
>  
>  static int sc16is7xx_line(struct uart_port *port)
> 
> base-commit: 3f86ed6ec0b390c033eae7f9c487a3fea268e027

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Note that Greg might be happier if you wait next time until after the 
merge window is closed before sending non-fixes patch like this.

-- 
 i.

--8323329-1916176287-1693997234=:1906--
