Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3448F7CA22D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjJPIq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjJPIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:46:52 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2846E5;
        Mon, 16 Oct 2023 01:46:47 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Mon, 16 Oct 2023 10:46:44 +0200
MIME-Version: 1.0
Date:   Mon, 16 Oct 2023 10:46:44 +0200
From:   m.brock@vanmierlo.com
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <20231016071332.597654-4-fe@dev.tdt.de>
References: <20231016071332.597654-1-fe@dev.tdt.de>
 <20231016071332.597654-4-fe@dev.tdt.de>
Message-ID: <93dcb9f6f218593084f834ba6b450999@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Eckert wrote on 2023-10-16 09:13:
> Has complained about the following construct:

Who is "Has" or who/what has complained?

> drivers/leds/trigger/ledtrig-tty.c:362:3: error: a label can only be
> part of a statement and a declaration is not a statement
> 
> Hence move the variable definition to the beginning of the function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> @@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct 
> *work)
> 
>  	if (icount.rx != trigger_data->rx ||
>  	    icount.tx != trigger_data->tx) {
> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
> -

Is this kernel test robot broken?
I see no label definition here.
And this variable declaration is at the start of a new block which does 
not
even require C99 support.

>  		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>  				      &interval, 0);

Maarten

