Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD13A7A365A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjIQPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjIQPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8414F7;
        Sun, 17 Sep 2023 08:36:31 -0700 (PDT)
Received: from [192.168.1.129] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M5jA2-1qnvQi1KaQ-007D1k; Sun, 17 Sep 2023 17:36:14 +0200
Message-ID: <d8395455-44eb-6762-d978-e912bf2cfe73@i2se.com>
Date:   Sun, 17 Sep 2023 17:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/4] staging: vc04: Drop custom logging
To:     Umang Jain <umang.jain@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>
References: <20230913185528.770634-1-umang.jain@ideasonboard.com>
 <1d54715d-25f9-4937-bdff-de0136c95fe8@kadam.mountain>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <1d54715d-25f9-4937-bdff-de0136c95fe8@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uPuw4stiPpBMOYelFVe2qtzF38EcAPeTCrViqcm3NlXkWZhzOZ0
 lnRBC8e0/8mhwjdFMc30OAJI+h5CV08nCC/h9O57Az0+31d+fXxvmXIH5shRDQWVqCQNuI5
 RZpM7Pn5yh8AxGTEn1BqkJRGQdwiij6WEhjLn3gV3wAN25rievUtmdoHdJlw0XhiEVedt50
 kQvy+lNWkN9hZTPJgq1EA==
UI-OutboundReport: notjunk:1;M01:P0:+VdWnsPgrrI=;T37xSK4VxoSptZfT7xZGg0iUS14
 JQE1cZm1YURTNMVGQtCROf7RJPspOj4NIGnhfPZcQsUNhh6QEDVWoaPAI2FCmBmyVM2g0bE0E
 E1WsQ7YlN+CCmbJ4ZWidCiY6VhBzkKHOUMP0BeTuDc0j2JfOMWEz6uGKwz0ThDoc4lHf5ZSWG
 Yb96VYx7BRV9PaL4CSiIFk3FUEyHxPdMQ26E1LFW3NhQSotoiGMQmA4tW9QoSAZYJxKo8ivoW
 7qQrliTagWRa2eNQ+PCPZA8x2/DSzvEuFLTuRpLi8VH1y66KYywGoFIlhoN9LcWrPA9w1IqLl
 clgsC+2bcFXnom/srlkhh709duwNQldehrK93WMi5SarECMRLjM/scRv0fgg+1eVsiPA0vONf
 GGsL/MQh0C/mN1hXa2ovLE22vw4izu54MLh5sHD7Oh07RU9SVar6eF1nGeCQQPsszHCK5vn3l
 XCBg7ss6VT8ekSW1ax21kL4pRO0j6VJuK8WJeG+6RxFiqExtBvI5VX5vQ5kUALAdlHaO0ajyu
 U4aJBr6Up2p2nhSHbCrJAJ2EK9oR98MeaRAGd26IRqY0zmtpsHPedJbRup+jyuVZJIduIvoLd
 6c1JIqtmjEVL/BatKyj9JNDTaNTb+61rd6qZD3KUNmDKpOStqdlVV+STXlQvk1oiFQtXYbHD7
 wJRvHZRwCjYLm7BoR+G59jnLn830j1ZVNJ1nWRLyQ1GyniaSfmYYjlyz31WCyYKdsJjDcVSTG
 VUL94g7l1j1KG0i3UH6y8Wd6SzVOG9sowtqz+5h0T+YoQ5R5OS1UNMl15bsP7Jie1m5N7GUD8
 lHqCC+oCW7JjE7YOf+5TcGhHyIlXiYszeo9lLPWMDMZYfgWVZ1TwZkE2srMUkadi7bkFLYfvL
 IFPUvTJvPegpBzw==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 14.09.23 um 08:35 schrieb Dan Carpenter:
> On Thu, Sep 14, 2023 at 12:25:24AM +0530, Umang Jain wrote:
>> Hello,
>>
>> This series attempts to restart the discussion on custom logging used
>> in VC04. In the last feedback gathered in [1] it seems that the logging
>> would rather be moved to use dynamic debug. The series tries to move
>> in that direction.
>>
>> The elephant in the room is the ability of turning on/off log levels,
>> which this series just drops. Compensated by a crude strings
>> ("error", "warning", "info"... etc) for easier grepping.
>>
>> The log category are also just strings (which probably can be transformed
>> to dynamic debug class names moving forwards?).
>>
>> To move forwards, I would like feedback on the broader direction.
>> There are couple of TODOs in each of the patch (summarised in commit
>> messages) which require case-by-case discussion.
>>
>> Additional high-level questions to move forwards:
>> 1. Is loss of log levels by moving to dynamic debug, is actually a
>>     concern? Is dynamic debug a valid replacement?
> 
> Dynamic debug is honestly going to be an improvement.  I guess, Greg and
> I said this back in Jan.
> 
>> 2. Whether debugfs should be dropped as well, found vestigial in [2]
> 
> Yes. The "vchiq/log" should be removed.  Ideally as part of this
> patchset so it's easier to understand.

Yes, but please do not remote vchiq_debugfs entirely. I'm working on a 
patch to move the state dump (debug feature) from the character device 
/dev/vchiq to debugfs /sys/kernel/debug/vchiq/dump_state.

> 
>> 3. whether vchiq_log_trace() should actually be tracing support for VC04
> 
> That can be done later if people want.  No need to discuss it now.
> 
> regards,
> dan carpenter
> 
