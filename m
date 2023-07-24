Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18ED75FFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGXT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGXT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:26:22 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A71910F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:26:21 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id O1CFqanAvWFHOO1CFqny0F; Mon, 24 Jul 2023 21:26:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690226780;
        bh=g4zf0wpL3eIxvyspY9DPWAZT1rHuXgERjmvinPQG6Ns=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DmhgerbgazkaHALvbE8DSdBVCSkHNiydwqSKOdM3hCpTUVm10ePF/5dnDG8GSwiq5
         ZNC+00Y1gQNe6x2LgyefN2rzWWufkmublPZsYASzdNzw2Nu4r8Sp5Ovxa2CIUm+zK4
         QvPF5Kyl/bDZ7uAIFt6BYAjEqlJX+T0q2gqKATJ5jnMgsqYE1PGLoPKhdiE/ctU2NH
         exNRsaXGw/cHb0ht9HmErNSQ2etq9dwS99WH9utQm5dbK7twnpfNRMKU6yewwgOa3g
         joEwt7Vd2UKr9TJOtFt6KwcWL6Jj+Bi18TJ5KlpNVx72orT0Dy0aIRJ+Wn4/41KOjV
         AWGIZmovGoTGA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jul 2023 21:26:20 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1ed8db21-d97e-15ef-f39a-732e08a355fb@wanadoo.fr>
Date:   Mon, 24 Jul 2023 21:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] Input: lm8323 - convert to use devm_* api
Content-Language: fr
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        linux-kernel@vger.kernel.org
References: <20230724052901.350240-1-dmitry.torokhov@gmail.com>
 <20230724052901.350240-2-dmitry.torokhov@gmail.com>
 <b83df292-6f7a-a8bf-895e-6df80a17029f@wanadoo.fr>
 <ZL7KghF8L+y1Fzcs@google.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZL7KghF8L+y1Fzcs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/07/2023 à 21:01, Dmitry Torokhov a écrit :
> On Mon, Jul 24, 2023 at 08:53:11PM +0200, Christophe JAILLET wrote:
>> Le 24/07/2023 à 07:29, Dmitry Torokhov a écrit :
>>> From: Yangtao Li <frank.li@vivo.com>
>>> +
>>> +		err = devm_led_classdev_register(dev, &pwm->cdev);
> 
>                        ^^^^^^^^^^^^^^

Oops,
For some reason, I missed this hunk :(.

> 
>>> -
>>> -	for (i = 0; i < 3; i++)
>>> -		if (lm->pwm[i].enabled)
>>> -			led_classdev_unregister(&lm->pwm[i].cdev);
>>
>> this look wrong.
> 
> Why? It will be cleared up by devm.
> 
> Thanks.
> 

Sorry for the noise.

I've been puzzled by [1].

CJ

[1]: https://lore.kernel.org/all/20230714080611.81302-8-frank.li@vivo.com/
