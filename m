Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8717AEC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjIZMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjIZMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:04:20 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE5E6;
        Tue, 26 Sep 2023 05:04:08 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8647860101=fe@dev.tdt.de>)
        id 1ql6nJ-00DGsF-TT; Tue, 26 Sep 2023 14:04:01 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1ql6nJ-00FZfF-0r; Tue, 26 Sep 2023 14:04:01 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 90A63240049;
        Tue, 26 Sep 2023 14:04:00 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id E4C63240040;
        Tue, 26 Sep 2023 14:03:59 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 83F0E2EFEB;
        Tue, 26 Sep 2023 14:03:59 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Sep 2023 14:03:59 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: add new helper function tty_get_mget
In-Reply-To: <dc5ac2cb-71b3-4946-a58b-2ec353bc40a4@kernel.org>
References: <20230926093607.59536-1-fe@dev.tdt.de>
 <20230926093607.59536-2-fe@dev.tdt.de>
 <dc5ac2cb-71b3-4946-a58b-2ec353bc40a4@kernel.org>
Message-ID: <2c36a83654942416cfdcb2e40ecb539d@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1695729841-26600C1B-B82AB986/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your fast respond!

>> @@ -2494,6 +2494,25 @@ static int send_break(struct tty_struct *tty, 
>> unsigned int duration)
>>   	return retval;
>>   }
>>   +/**
>> + * tty_get_mget		-	get modem status
> 
> Heh, the naming is funny. It apparently comes from tiocmget. But that
> comes from:
> tty ioctl modem get (TIOCMGET)
> tty ioctl modem set (TIOCMSET)
> 
> So you should name it like tty_get_modem() not get_mget().

I didn't like the name too, but I couldn't think of another.
The function is returning the state of serial control and status 
signals.

 From your suggestion for the name, however, you can not deduce that at 
all.
How would it be then with the following name?

tty_tioctl_state() ?

> 
> Also those extra spaces around "-" caused some issues in the generated
> output and should be removed (everywhere).

Ok, I will change this in an own commit throughout the file.


Thanks

Florian

@jirislaby: Forgot to send this message to the mailing list as well!
