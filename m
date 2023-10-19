Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13617CF3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjJSJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345016AbjJSJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:13:06 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0976218C;
        Thu, 19 Oct 2023 02:12:57 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Thu, 19 Oct 2023 11:12:53 +0200
MIME-Version: 1.0
Date:   Thu, 19 Oct 2023 11:12:53 +0200
From:   m.brock@vanmierlo.com
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <34e8fcd94b4a959fe2336485e4722c3b@dev.tdt.de>
References: <20231016071332.597654-1-fe@dev.tdt.de>
 <20231016071332.597654-4-fe@dev.tdt.de>
 <93dcb9f6f218593084f834ba6b450999@vanmierlo.com>
 <34e8fcd94b4a959fe2336485e4722c3b@dev.tdt.de>
Message-ID: <9cecf21f8691d474441f8ff30a9dcb23@vanmierlo.com>
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

Florian Eckert wrote on 2023-10-16 11:12:
> On 2023-10-16 10:46, m.brock@vanmierlo.com wrote:
>> Florian Eckert wrote on 2023-10-16 09:13:
>>> Has complained about the following construct:
>> 
>> Who is "Has" or who/what has complained?
> 
> The test robot who does not agree with my change in the v1 patchset.

You don't have to explain to me, just fix the comment.

>>> drivers/leds/trigger/ledtrig-tty.c:362:3: error: a label can only be
>>> part of a statement and a declaration is not a statement
>>> 
>>> Hence move the variable definition to the beginning of the function.
>>> 
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes:
>>> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
>>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>>> ---
>>> @@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct 
>>> *work)
>>> 
>>>  	if (icount.rx != trigger_data->rx ||
>>>  	    icount.tx != trigger_data->tx) {
>>> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
>>> -
>> 
>> Is this kernel test robot broken?
> 
> The test robot does nothing wrong.
> 
>> I see no label definition here.
>> And this variable declaration is at the start of a new block which 
>> does
>> not even require C99 support.
> 
> I made change in patch set v1, that moves the definition of the 
> variable
> `interval` into the switch case statement.
> https://lore.kernel.org/linux-leds/20230926093607.59536-3-fe@dev.tdt.de/
> The robot complained about this.
> 
> So I decided to move the definition of the variable 'interval' to 
> function
> head to make the test robot happy in the commit. So this commit 
> prepares
> the code for my change.
> 
> If it is more common, I can merge this patch [1] into the next patch 
> [2]
> of this set.

Yes, please. You're fixing a problem that does not exist yet (and never
will), because the patch that introduces it is not yet applied. So fix
the proposed patch instead of patching the patch.

> [1] 
> https://lore.kernel.org/linux-leds/20231016071332.597654-4-fe@dev.tdt.de/
> [2] 
> https://lore.kernel.org/linux-leds/20231016071332.597654-5-fe@dev.tdt.de/
> 
> 
> Florian

Maarten

