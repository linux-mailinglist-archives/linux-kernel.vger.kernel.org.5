Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB675FA18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGXOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGXOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:44:53 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC010F;
        Mon, 24 Jul 2023 07:44:51 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7C34961E5FE01;
        Mon, 24 Jul 2023 16:44:10 +0200 (CEST)
Message-ID: <45cf294e-3124-9a0d-864f-ba7c605405c0@molgen.mpg.de>
Date:   Mon, 24 Jul 2023 16:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314092311.8924-1-jim.t90615@gmail.com>
 <20230314092311.8924-2-jim.t90615@gmail.com>
 <519312b6-f28c-7482-21c1-d9628f0295cb@molgen.mpg.de>
 <CAKUZ0+FGSEgzbK6H_sHaGpP9JnvrLeBRQViqmViR1OVXoVs7vA@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAKUZ0+FGSEgzbK6H_sHaGpP9JnvrLeBRQViqmViR1OVXoVs7vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jim,


Am 24.07.23 um 05:04 schrieb Jim Liu:

> sorry for reply late.

No problem. Thank you for your reply. Some minor comments below.

> First, thanks for your review.
> 
> the description is as below:
> 
> The SGPIO module can be programmed to support from zero (none) to
> eight external output ports ,

No space before the comma.

> each with eight output pins (for a total of 64 output pins). The
> output ports must be serial-to-parallel devices (such as the HC595 or
> a faster equivalent).
> 
> The SGPIO can be programmed to accept from zero to eight external
> input ports (IXPp), each with eight input pins, supporting a total of
> 64 input pins. The input ports must be parallel-to-serial devices
> (such as the HC165 or a faster equivalent).
> 
> you can add hc595 and hc165 ic to get the serial data from BMC and
> send serial data to BMC.
> This driver can expand  extra gpio pins up to 64 input and 64 output.

One space before “extra”. Maybe:

hc595 and c165 ic allow to transmit serial data from and to the BMC. 
This driver can expand extra GPIO pins up to 64 inputs and 64 outputs.

> i will use jim.t90615@gmail.com this mail to upstream this driver not
> company mail.

If this is paid work, using your company email address should be 
preferred in my opinion.

> The driver needs to fix the length of the variables, because the reg
> size is one byte.

One byte would also fit into `unsigned int`, wouldn’t it?

> I will follow your suggestion to modify and upstream again. If you
> have any questions please let me know.

If you could use Mozilla Thunderbird to reply easily in interleaved 
style, that would great.

Otherwise, I am looking forward to the next revision.


Kind regards,

Paul
