Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C427B77FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbjJDGh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjJDGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:37:49 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047DD9;
        Tue,  3 Oct 2023 23:37:43 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8655c94f36=fe@dev.tdt.de>)
        id 1qnvVj-00GrEg-CB; Wed, 04 Oct 2023 08:37:31 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qnvVi-006jS9-94; Wed, 04 Oct 2023 08:37:30 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id D864E240049;
        Wed,  4 Oct 2023 08:37:29 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 39A7E240040;
        Wed,  4 Oct 2023 08:37:29 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id A38DB32F62;
        Wed,  4 Oct 2023 08:37:28 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Oct 2023 08:37:28 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <acda5dc4-e6d3-4870-929f-fb91636b5649@kernel.org>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de> <20231002140559.GB8453@google.com>
 <acda5dc4-e6d3-4870-929f-fb91636b5649@kernel.org>
Message-ID: <59cc4073a94edbdec5d77f8457ed4f73@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1696401451-B1C31B19-0543AF23/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-03 07:00, Jiri Slaby wrote:
> On 02. 10. 23, 16:05, Lee Jones wrote:
>> On Thu, 28 Sep 2023, Florian Eckert wrote:
>> 
>>> The Intel build robot has complained about this. Hence move the 
>>> commit
>>> of the variable definition to the beginning of the function.

>> Please copy the robot's error message into the commit message.

For a v3 patch-set I will add the error message from build robot.

Build robot output of my v1 change:
https://lore.kernel.org/linux-leds/20230926093607.59536-1-fe@dev.tdt.de/T/#m777371c5de8fadc505a833139b8ae69ac7fa8dab

I decided to move the variable definition with a separate commit
to the top of the function, to make the build robot happy. After that
I made my changes for v2 to the ledtrig-tty to add the feature.

> Ah, lkp, then also the Closes: line as it suggests.

Sorry I do not understand your statement

>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>>> ---
>>>   drivers/leds/trigger/ledtrig-tty.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/leds/trigger/ledtrig-tty.c 
>>> b/drivers/leds/trigger/ledtrig-tty.c
>>> index 8ae0d2d284af..1c6fadf0b856 100644
>>> --- a/drivers/leds/trigger/ledtrig-tty.c
>>> +++ b/drivers/leds/trigger/ledtrig-tty.c
>>> @@ -82,6 +82,7 @@ static void ledtrig_tty_work(struct work_struct 
>>> *work)
>>>   {
>>>   	struct ledtrig_tty_data *trigger_data =
>>>   		container_of(work, struct ledtrig_tty_data, dwork.work);
>>> +	unsigned long interval = LEDTRIG_TTY_INTERVAL;
>>>   	struct serial_icounter_struct icount;
>>>   	int ret;
>>>   @@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct 
>>> *work)
>>>     	if (icount.rx != trigger_data->rx ||
>>>   	    icount.tx != trigger_data->tx) {
>>> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
>>> -
>>>   		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>>>   				      &interval, 0);
>>>   -- 2.30.2
>>> 
>> 
