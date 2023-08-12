Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACC779E52
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjHLIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbjHLIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:54:11 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779E3AA4;
        Sat, 12 Aug 2023 01:53:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A618260196;
        Sat, 12 Aug 2023 10:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691830407; bh=ZvwpYSkibYett1PUvz5bict5ZehBa6wQbGtDgsxXuc8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C8qPGag+h5Mf2WSoKE4fLlgI/NKJMq379/xz6tcFFVeMJYERCZPl0YDyWZOGNHiwV
         5JJONN8GQZZ1w4I9XWzLV6oLMn+1kfnkCTKsQW4DAJe9E981+cYzo2n3CJrZxeqkaY
         w+SN9gCAdfou6RrAKb8EsckY17dPbRcbhILRq4VfJdrJhVRJjIr1q02NPyPsL6OsBK
         CUAgK/FuGMFie3+32rPRY0tJQ2Qyj9P24HfCSKQS0lugspWz6eFlq1TiCXrxUljfYO
         pd6GLbOXef1sxJ/LIeFx8G/OK1kbYlq4GREmzR35/kZN3jQhT0lGXsd0xkMOruNYgP
         43EX54EuNcqmA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ba2qonlcokwe; Sat, 12 Aug 2023 10:53:25 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 10F5260192;
        Sat, 12 Aug 2023 10:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691830405; bh=ZvwpYSkibYett1PUvz5bict5ZehBa6wQbGtDgsxXuc8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UNrCg5rOcMJkYpp1hrt/Omw+ri6019Do9SMp/MjzyxJEqDOMlh617b6xvvVsXEPmY
         CeQI8lt5Q1cuqDrwFNlrJzlGD3D6RbeExlVvBlD8OfHA2B+GDPHk0IsvQqH+Cf9xw8
         SMhYi7zzV6nwiHppjlwlcyFAKml6W/UmNkLY6cp8myYoebf5Ld1yaxAU6H1kAnD8xK
         twCXPAo5rLTUhx/1CXASwMYWOUZQkXA2pnhTpC+Gut9i4bnsT5nx/IYaHcrIER0OOr
         fPFdpWIT3KBVB4xwrutkJj/SknJfy74+9FQ2jYjwrz5eWtrk2YfwYampiDe0yrtG22
         qA0YHsjjl3XPA==
Message-ID: <831b54af-c705-d9d6-026e-bbb6c1d375d5@alu.unizg.hr>
Date:   Sat, 12 Aug 2023 10:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/1] test_fimware: return -ENOMEM instead of -ENOSPC on
 failed memory allocation
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
References: <20230812054346.168223-1-mirsad.todorovac@alu.unizg.hr>
 <2023081213-reset-tadpole-fc94@gregkh>
 <4de9ce71-2d6d-6955-4316-e604b211ff8d@alu.unizg.hr>
 <2023081246-dimple-polygon-9097@gregkh>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023081246-dimple-polygon-9097@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/23 10:12, Greg KH wrote:
> On Sat, Aug 12, 2023 at 10:06:53AM +0200, Mirsad Todorovac wrote:
>>
>>
>> On 8/12/23 09:29, Greg KH wrote:
>>> On Sat, Aug 12, 2023 at 07:43:47AM +0200, Mirsad Todorovac wrote:
>>>> [ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]
>>>>
>>>> In a couple of situations like
>>>>
>>>> 	name = kstrndup(buf, count, GFP_KERNEL);
>>>> 	if (!name)
>>>> 		return -ENOSPC;
>>>>
>>>> the error is not actually "No space left on device", but "Out of memory".
>>>>
>>>> It is semantically correct to return -ENOMEM in all failed kstrndup()
>>>> and kzalloc() cases in this driver, as it is not a problem with disk
>>>> space, but with kernel memory allocator failing allocation.
>>>>
>>>> The semantically correct should be:
>>>>
>>>>           name = kstrndup(buf, count, GFP_KERNEL);
>>>>           if (!name)
>>>>                   return -ENOMEM;
>>>>
>>>> Cc: Dan Carpenter <error27@gmail.com>
>>>> Cc: Takashi Iwai <tiwai@suse.de>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>>>> Cc: Brian Norris <computersforpeace@gmail.com>
>>>> Cc: stable@vger.kernel.org # 4.14
>>>> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
>>>> Fixes: 0a8adf584759c ("test: add firmware_class loader test")
>>>> Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
>>>> Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
>>>> Link: https://lore.kernel.org/all/20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr/
>>>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>>
>>>> [ This is the backport of the patch to 4.19 and 4.14 branches. There are no	]
>>>> [ semantic differences in the commit. Backport is provided for completenes sake	]
>>>> [ so it would apply to all of the supported LTS kernels				]
>>>
>>> This commit is already in the 4.19.291 release, does it need to be
>>> included in there again for some reason?
>>
>> Hi Mr. Greg,
>>
>> I think the patchwork did not apply the commit to the 4.14 stable tree.
>> Only the 19be3eccd000 ("test_firmware: fix a memory leak with reqs buffer" propagated to 4.14.322.
>>
>> I would like to have us this chapter (backporting) completed before moving on.
> 
> That's fine, but your comment here said that this is for 4.19, but this
> is already in 4.19, so I'm confused.  I'll queue this up for 4.14.y
> now...

I will not contradict, however, it is the verbatim same patch as for the 4.19 stable tree.

I know that you have to quick pick among hundreds of patches each day, because I follow the commit log.
So I try to guess what would be the best, but I am still kinda newbie to the patch submission process. :-)

I think we got it sorted out right this time.

I will cooperate with the required number of iterations, as I understood this is an incremental development.

However, please note that I could not boot the 4.14 kernel, it was only built properly.
There is no reason for this change to work, but the actual test is always preferred, of course.

Kind regards,
Mirsad Todorovac
