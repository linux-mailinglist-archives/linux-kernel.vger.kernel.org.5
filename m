Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE997DE7DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjKAWAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjKAWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:00:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B658D77
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:59:34 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yJFFqHI8mvx99yJFFq7gSV; Wed, 01 Nov 2023 22:59:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698875971;
        bh=CZUc2x18jLVE3/dA5z40LzEyxqd/JgpG1ks1H6XqaJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JfMKBQJKcuW5hVFeb3FkC6gJN5P5gPM/1BhbVn5FB5fv3w7Oqy9eWrWY/ZPfBpp1T
         7lgy+AaRo815BcThA8C/vRY6KjtoifDvpeTBNhrSqZuj9/vG++7eZIGjeEBKWydnB8
         C8xrraykwVdaGIi0d0m7Dzfs3VDkYxifFGKkrsfeDJ+i5l3P2f50y7qL1HwnL9rrqm
         2+plC3k9BRoryJ+5D3k6CY3HkZdYWIOHkRK3nbFc0C0TWBbn2h3V3IBihLeYJQejhg
         I8lsYTZt6tAKDfG8QvnoS/tiqUkvMqiBZLv9InOo2wve2wq9Kc1qxSBeQHpSAkGLAE
         5fS7RRSgeVWqQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 22:59:31 +0100
X-ME-IP: 86.243.2.178
Message-ID: <ee352f12-084d-45d4-9c8e-172e073b7e36@wanadoo.fr>
Date:   Wed, 1 Nov 2023 22:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] seq_buf: Export seq_buf_putc() &nd seq_buf_puts()
Content-Language: fr, en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     gregkh@linuxfoundation.org, keescook@chromium.org,
        willy@infradead.org, senozhatsky@chromium.org, list@mail.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <cover.1698861216.git.christophe.jaillet@wanadoo.fr>
 <20231101141705.4208d441@gandalf.local.home>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231101141705.4208d441@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/11/2023 à 19:17, Steven Rostedt a écrit :
> On Wed,  1 Nov 2023 18:59:04 +0100
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>> seq_buf_putc() has a potential real use-case (link in the patch), but
>> seq_buf_puts() has currently no forseen use-case, so I have split it in 2
>> patches if only the 1st one is accepted.
>>
>> Christophe JAILLET (2):
>>    seq_buf: Export seq_buf_putc()
>>    seq_buf: Export seq_buf_puts()
>>
>>   lib/seq_buf.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> 
> I can pull these in as I'm getting ready for my pull request to Linus soon
> (and just kicked off my testing).
> 
> Or do you need them as part of the patch you mentioned? When does that need
> to go in? Can it wait till it hits Linus's tree?
> 
> -- Steve
> 

You timing will be mine, no need to hurry.
I'll see when it reaches -next.

Thanks for taking care of it.

CJ
