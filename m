Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD27B7A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbjJDIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbjJDIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:36:30 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57557AD;
        Wed,  4 Oct 2023 01:36:27 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8655c94f36=fe@dev.tdt.de>)
        id 1qnxMa-001bp2-Al; Wed, 04 Oct 2023 10:36:12 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qnxMZ-00GJIj-DL; Wed, 04 Oct 2023 10:36:11 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 0A0B224004B;
        Wed,  4 Oct 2023 10:36:11 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 5DD97240040;
        Wed,  4 Oct 2023 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id B023132186;
        Wed,  4 Oct 2023 10:36:09 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Oct 2023 10:36:09 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <05b03f3e-5863-4d33-8c70-03be7d7e972f@kernel.org>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de> <20231002140559.GB8453@google.com>
 <acda5dc4-e6d3-4870-929f-fb91636b5649@kernel.org>
 <59cc4073a94edbdec5d77f8457ed4f73@dev.tdt.de>
 <05b03f3e-5863-4d33-8c70-03be7d7e972f@kernel.org>
Message-ID: <d59855493baa936485a2b00aa29d0449@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1696408572-7EFD07FE-61C52306/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> I decided to move the variable definition with a separate commit
>> to the top of the function, to make the build robot happy. After that
>> I made my changes for v2 to the ledtrig-tty to add the feature.
>> 
>>> Ah, lkp, then also the Closes: line as it suggests.
>> 
>> Sorry I do not understand your statement
> 
> The link you pasted above states:
> =======
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
> =======
> 
> So please follow that suggestion ;).

Ok, I understand, thanks will to this on a v3 patchset.
I will now wait for the comments of my changes in ledtrig-tty from the 
led subsystem.
And then I will send a new patch set with the requested changes.

Sorry for the silly question. But do I have to send this patch again for 
a v3?
https://lore.kernel.org/linux-leds/f41dc1e1-6d34-48b2-97dd-ba67df6003c6@kernel.org/T/#u
It was already marked by you with a `Reviewed-by:` from you?

--
Best regards
Florian
