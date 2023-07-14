Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BA753D33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjGNOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjGNOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:24:19 -0400
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 07:24:17 PDT
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D851BC9;
        Fri, 14 Jul 2023 07:24:16 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4R2YRK42Myz4c;
        Fri, 14 Jul 2023 16:15:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1689344141; bh=DNdQ06e/S5icm2HaN8am9uGS6XfPvtLWqg9ojI4q4Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbhWDbNyTyPmB+DGbsm5bAcE5l8efEKuxaQZVNFhZFInOvOicnbR+dMyZN8wsZ86y
         47W5sN+McTXZU0LXWgKpl4ZVxC9CCanCDsEf/r536UAz8ptDmHx89JrZvTqr2dhSCa
         u8qBpE3c8XQqavfNBz/wWDOE5wjtB/nZeP9jjQXqiWak9CYJ56s/p/3SW4WLMRtMuw
         khzBksaZqHMzU3x+/rTdmpu4gOjTCZOeLHCwhhjzegeuxP9uESl90DjoR5urc2RjFY
         XMiltF81n79WVVLH8HevP3dMfYF6PkURt02zTbXFyG4706mX6WOe4A3ApczC0S76X6
         Qx6dInIYvfkcw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Fri, 14 Jul 2023 16:15:40 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/58] mmc: cb710: Convert to platform remove callback
 returning void
Message-ID: <ZLFYjM/+SLlHwWQF@qmqm.qmqm.pl>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713080807.69999-6-frank.li@vivo.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:07:15PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

> ---
>  drivers/mmc/host/cb710-mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 6d623b2681c3..0aec33b88bef 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -745,7 +745,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int cb710_mmc_exit(struct platform_device *pdev)
> +static void cb710_mmc_exit(struct platform_device *pdev)
>  {
>  	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
>  	struct mmc_host *mmc = cb710_slot_to_mmc(slot);
> @@ -766,13 +766,12 @@ static int cb710_mmc_exit(struct platform_device *pdev)
>  	tasklet_kill(&reader->finish_req_tasklet);
>  
>  	mmc_free_host(mmc);
> -	return 0;
>  }
>  
>  static struct platform_driver cb710_mmc_driver = {
>  	.driver.name = "cb710-mmc",
>  	.probe = cb710_mmc_init,
> -	.remove = cb710_mmc_exit,
> +	.remove_new = cb710_mmc_exit,
>  #ifdef CONFIG_PM
>  	.suspend = cb710_mmc_suspend,
>  	.resume = cb710_mmc_resume,
> -- 
> 2.39.0
> 

-- 
Micha³ Miros³aw
