Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B462C7CD9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjJRK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJRK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:56:52 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64EB8;
        Wed, 18 Oct 2023 03:56:49 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9669ea70bf=fe@dev.tdt.de>)
        id 1qt4ED-00G2LT-4C; Wed, 18 Oct 2023 12:56:41 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qt4EC-000CcB-5x; Wed, 18 Oct 2023 12:56:40 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 873BA24004D;
        Wed, 18 Oct 2023 12:56:39 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id DA6C6240049;
        Wed, 18 Oct 2023 12:56:38 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 2710C20E48;
        Wed, 18 Oct 2023 12:56:38 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Oct 2023 12:56:38 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tty: whitespaces in descriptions corrected by
 replacing tabs with spaces.
In-Reply-To: <31ec59fb-4bcf-4c70-996a-ea67b4bfcd2b@kernel.org>
References: <20231016071332.597654-1-fe@dev.tdt.de>
 <20231016071332.597654-2-fe@dev.tdt.de>
 <31ec59fb-4bcf-4c70-996a-ea67b4bfcd2b@kernel.org>
Message-ID: <fb73fa183cf6619e042273db091056bd@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1697626600-65079C7C-B384EE48/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-10-16 14:32, Jiri Slaby wrote:
> On 16. 10. 23, 9:13, Florian Eckert wrote:
>> Tabs were used in the function description, to make this look more
>> uniform, the tabs were replaced by spaces where necessary.
>> 
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks for the review and adding your 'Reviewed-by:'.
Will add this to the v4 if I get feedback form the led
subsystem maintainers, if my change to ledtrig-tty are
correct. So this could get into for-led-next [1]
maintained by Lee Jones <lee@kernel.org>


> LGTM (spihnx prefers spaces), except:
> 
>> @@ -3470,7 +3470,7 @@ int tty_register_driver(struct tty_driver 
>> *driver)
>>   EXPORT_SYMBOL(tty_register_driver);
>>     /**
>> - * tty_unregister_driver -- unregister a tty driver
>> + * tty_unregister_driver - unregister a tty driver
> 
> you should have noted you changed ndashes to dashes too. (As only the
> latter is supported by sphinx.)

That was intentional.
However, I did not mention it in the commit message.
My mistake. Sorry.
Will add this to the information to an v4.

--
Florian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next
