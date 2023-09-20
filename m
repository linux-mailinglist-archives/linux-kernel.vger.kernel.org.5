Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D807B7A79DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjITK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjITK7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:59:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E5ECA;
        Wed, 20 Sep 2023 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695207567; x=1726743567;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1hyw2ZvhoVedT7i2zlNBzAL3I0rK4jx4XG0J+0d5o0Q=;
  b=X3sPjkTXpV43V+a8zeCfQy5rnRrVI1eFKwgffmsg6ZCYVKLbcQpCh9Ht
   ioRWppCUWJy53iKFV9cicaMKBtMfXmPVSF2lFEhjawHOUylNw1dXQd5fN
   ToNM3vSJ58ix6K+BBWdwUQiN2K83TjszHS7Oo/POaIwUD1pLN5qaTgVwg
   VNQrtpjiF7rm61maKu0ZwISGh2pSX4sUblXI3uWCRbdwaBBfXdDs0uI4g
   teXFT07l33VO+xlJSUvpt9jsVd6heH24ZoR/ESRw8p8Oi8HV97BLqgi/O
   IqWwj3N29wWQM1vHyoZ1DFrXbX3I8Tl7z16jogt5wnEX8yeZ2FunG7iu3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="411134545"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="411134545"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920241733"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920241733"
Received: from swegrzyn-mobl.ger.corp.intel.com ([10.252.52.91])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 03:59:24 -0700
Date:   Wed, 20 Sep 2023 13:59:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Use
 devm_clk_get_optional_enabled()
In-Reply-To: <20230919195513.3197930-1-andriy.shevchenko@linux.intel.com>
Message-ID: <1b8e8791-688a-59b4-db5b-d7b0b47dbf2e@linux.intel.com>
References: <20230919195513.3197930-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1467541756-1695207565=:1961"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1467541756-1695207565=:1961
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 19 Sep 2023, Andy Shevchenko wrote:

> Use devm_clk_get_optional_enabled() to simplify the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f4cafca1a7da..bdd7ed282061 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -498,11 +498,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  	}
>  }
>  
> -static void dw8250_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static void dw8250_reset_control_assert(void *data)
>  {
>  	reset_control_assert(data);
> @@ -598,23 +593,15 @@ static int dw8250_probe(struct platform_device *pdev)
>  	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
>  
>  	/* If there is separate baudclk, get the rate from it. */
> -	data->clk = devm_clk_get_optional(dev, "baudclk");
> +	data->clk = devm_clk_get_optional_enabled(dev, "baudclk");
>  	if (data->clk == NULL)
> -		data->clk = devm_clk_get_optional(dev, NULL);
> +		data->clk = devm_clk_get_optional_enabled(dev, NULL);
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
>  	INIT_WORK(&data->clk_work, dw8250_clk_work_cb);
>  	data->clk_notifier.notifier_call = dw8250_clk_notifier_cb;
>  
> -	err = clk_prepare_enable(data->clk);
> -	if (err)
> -		return dev_err_probe(dev, err, "could not enable optional baudclk\n");
> -
> -	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
> -	if (err)
> -		return err;
> -
>  	if (data->clk)
>  		p->uartclk = clk_get_rate(data->clk);
>  
> @@ -622,18 +609,10 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (!p->uartclk)
>  		return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
>  
> -	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
> +	data->pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
>  	if (IS_ERR(data->pclk))
>  		return PTR_ERR(data->pclk);
>  
> -	err = clk_prepare_enable(data->pclk);
> -	if (err)
> -		return dev_err_probe(dev, err, "could not enable apb_pclk\n");
> -
> -	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
> -	if (err)
> -		return err;
> -
>  	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
>  	if (IS_ERR(data->rst))
>  		return PTR_ERR(data->rst);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1467541756-1695207565=:1961--
