Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC77B5485
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjJBOGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjJBOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:06:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8681AD;
        Mon,  2 Oct 2023 07:06:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558D4C433C7;
        Mon,  2 Oct 2023 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696255564;
        bh=oewcKLq9leZeLUNbvL3ga7nSrHdL0EKdi+eyXGMLtGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNby3amfuHQMnQB9J2b8Ap7V4xMsYjdQ+XX8Ne1yQwFKEIv84i754KEVLeJUg8gjk
         eZTKvwinC7merJ7qh3W+Ryukjgt+Ym0L/vorD2BQb5irTxbdLjpDtXAHCd6QjBG+ei
         dy3qg4A5giv1IyOZdkFSdZB0DqgYAVyfuB/rZgF9WspTUP/kgYYQiWx8pGDeDCPUsV
         88TQek2wbfOllqc1CJUhTmDeKwr1V3nYM0Dx5pgKq7WA9HXKbc79/fwueApOG25YO2
         XY2NIwNXL/Nh56LmRlwLJVInrde4+cGRsTvcZU56epMHub7GBj0vwBexSCyF3poPFl
         fuCV5QO5Z3uIQ==
Date:   Mon, 2 Oct 2023 15:05:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
Message-ID: <20231002140559.GB8453@google.com>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928132632.200263-4-fe@dev.tdt.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023, Florian Eckert wrote:

> The Intel build robot has complained about this. Hence move the commit
> of the variable definition to the beginning of the function.

Please copy the robot's error message into the commit message.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/leds/trigger/ledtrig-tty.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> index 8ae0d2d284af..1c6fadf0b856 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -82,6 +82,7 @@ static void ledtrig_tty_work(struct work_struct *work)
>  {
>  	struct ledtrig_tty_data *trigger_data =
>  		container_of(work, struct ledtrig_tty_data, dwork.work);
> +	unsigned long interval = LEDTRIG_TTY_INTERVAL;
>  	struct serial_icounter_struct icount;
>  	int ret;
>  
> @@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct *work)
>  
>  	if (icount.rx != trigger_data->rx ||
>  	    icount.tx != trigger_data->tx) {
> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
> -
>  		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>  				      &interval, 0);
>  
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]
