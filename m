Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07574779E1B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjHLIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHLIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:07:07 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37471CE;
        Sat, 12 Aug 2023 01:07:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 912816015F;
        Sat, 12 Aug 2023 10:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691827619; bh=beQxs3Oz17kyNCK1UHZxhMqhuq8LZC64TmBujJm+Zb8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XKTPGlbbWyx0XbZTxZ2Uu+K4XfL7BPdfks2Hfz0oadXGXr/dvMkRAxjqex34ZUj/N
         1/HzzBBXzctRf8NDWTMCRIpeqDwZ29e0RWMlVLi8xB1HxOeLf58X2YOXssPTeywWzj
         80TEhYp0W95KXEk98CkV1SrNpuhR1qOEg9aNQC7b8tHl6JbM0PDX/Ywx8B1id/q/vd
         GjAht0xbttLKqJ1M4pL5Edib7IieSe4mwOgld8jFWII3OxAdTU5p4uVV2ot8gXNB/2
         6kBztnHBpUbcqOn2i0ecZiWR5pIjuY1tOLMKd9t15s89/iYTG4h9/6ye7e+Bt/8fTd
         OMRcWRvX3yoFw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SSqAVKQMzte4; Sat, 12 Aug 2023 10:06:57 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 052296015E;
        Sat, 12 Aug 2023 10:06:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691827617; bh=beQxs3Oz17kyNCK1UHZxhMqhuq8LZC64TmBujJm+Zb8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q5fBh4iGIMis9jEUUE2YJuz5wYE6uC9CWjXuKX1g7N32XJJdVStkugiEnYUOgWqoA
         VT+eCySmdq257To2XtIH0tivDW+VHYOnKxeLCF3ufyau9ivCbolUZkjD+y/6QKzWI8
         bZLg8Upk9kHuHg/rItS9dDp/oSR9h89xiw0/lwvP/GGSgBdMqNp0E1MDwE1VdYZizp
         lSwMEkTOUWsHUpCEJfbON408pWs7MwajvjPe0TMXzHo3GBw61uX+DAuxJz0KZm9djX
         FHnbeS9a5eRVSAAPjP0BYdGD6guJIGtbucBJhSD4/Jdy7OPTgiKFQcKqCbHyTaRhIb
         7s53Xp6uqDDRA==
Message-ID: <4de9ce71-2d6d-6955-4316-e604b211ff8d@alu.unizg.hr>
Date:   Sat, 12 Aug 2023 10:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/1] test_fimware: return -ENOMEM instead of -ENOSPC on
 failed memory allocation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
References: <20230812054346.168223-1-mirsad.todorovac@alu.unizg.hr>
 <2023081213-reset-tadpole-fc94@gregkh>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023081213-reset-tadpole-fc94@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/23 09:29, Greg KH wrote:
> On Sat, Aug 12, 2023 at 07:43:47AM +0200, Mirsad Todorovac wrote:
>> [ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]
>>
>> In a couple of situations like
>>
>> 	name = kstrndup(buf, count, GFP_KERNEL);
>> 	if (!name)
>> 		return -ENOSPC;
>>
>> the error is not actually "No space left on device", but "Out of memory".
>>
>> It is semantically correct to return -ENOMEM in all failed kstrndup()
>> and kzalloc() cases in this driver, as it is not a problem with disk
>> space, but with kernel memory allocator failing allocation.
>>
>> The semantically correct should be:
>>
>>          name = kstrndup(buf, count, GFP_KERNEL);
>>          if (!name)
>>                  return -ENOMEM;
>>
>> Cc: Dan Carpenter <error27@gmail.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>> Cc: Brian Norris <computersforpeace@gmail.com>
>> Cc: stable@vger.kernel.org # 4.14
>> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
>> Fixes: 0a8adf584759c ("test: add firmware_class loader test")
>> Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
>> Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
>> Link: https://lore.kernel.org/all/20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr/
>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>
>> [ This is the backport of the patch to 4.19 and 4.14 branches. There are no	]
>> [ semantic differences in the commit. Backport is provided for completenes sake	]
>> [ so it would apply to all of the supported LTS kernels				]
> 
> This commit is already in the 4.19.291 release, does it need to be
> included in there again for some reason?

Hi Mr. Greg,

I think the patchwork did not apply the commit to the 4.14 stable tree.
Only the 19be3eccd000 ("test_firmware: fix a memory leak with reqs buffer" propagated to 4.14.322.

I would like to have us this chapter (backporting) completed before moving on.

Kind regards,
Mirsad Todorovac
