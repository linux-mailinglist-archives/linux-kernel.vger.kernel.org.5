Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D677CA3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjJPJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJPJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:12:34 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BFF0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:12:29 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=966793e2c5=fe@dev.tdt.de>)
        id 1qsJe8-003dDl-Ay; Mon, 16 Oct 2023 11:12:20 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qsJe7-006tet-9U; Mon, 16 Oct 2023 11:12:19 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id D4BEC240050;
        Mon, 16 Oct 2023 11:12:18 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 300BB240049;
        Mon, 16 Oct 2023 11:12:18 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 0603A2BD22;
        Mon, 16 Oct 2023 11:12:16 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Oct 2023 11:12:15 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     m.brock@vanmierlo.com
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <93dcb9f6f218593084f834ba6b450999@vanmierlo.com>
References: <20231016071332.597654-1-fe@dev.tdt.de>
 <20231016071332.597654-4-fe@dev.tdt.de>
 <93dcb9f6f218593084f834ba6b450999@vanmierlo.com>
Message-ID: <34e8fcd94b4a959fe2336485e4722c3b@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-type: clean
X-purgate-ID: 151534::1697447540-65079C7C-307F4F24/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-16 10:46, m.brock@vanmierlo.com wrote:
> Florian Eckert wrote on 2023-10-16 09:13:
>> Has complained about the following construct:
> 
> Who is "Has" or who/what has complained?

The test robot who does not agree with my change in the v1 patchset.

>> drivers/leds/trigger/ledtrig-tty.c:362:3: error: a label can only be
>> part of a statement and a declaration is not a statement
>> 
>> Hence move the variable definition to the beginning of the function.
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>> @@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct 
>> *work)
>> 
>>  	if (icount.rx != trigger_data->rx ||
>>  	    icount.tx != trigger_data->tx) {
>> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
>> -
> 
> Is this kernel test robot broken?

The test robot does nothing wrong.

> I see no label definition here.
> And this variable declaration is at the start of a new block which does 
> not
> even require C99 support.

I made change in patch set v1, that moves the definition of the variable
`interval` into the switch case statement.
https://lore.kernel.org/linux-leds/20230926093607.59536-3-fe@dev.tdt.de/
The robot complained about this.

So I decided to move the definition of the variable 'interval' to 
function
head to make the test robot happy in the commit. So this commit prepares
the code for my change.

If it is more common, I can merge this patch [1] into the next patch [2]
of this set.

[1] 
https://lore.kernel.org/linux-leds/20231016071332.597654-4-fe@dev.tdt.de/
[2] 
https://lore.kernel.org/linux-leds/20231016071332.597654-5-fe@dev.tdt.de/


Florian
