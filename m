Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20FB7753BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHIHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:12:13 -0400
Received: from smtpdh16-1.aruba.it (smtpdh16-1.aruba.it [62.149.155.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0A1BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:12:11 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id TdMVqAVZwF2qgTdMVqIfrI; Wed, 09 Aug 2023 09:12:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691565128; bh=eUlpDM+QsMiFLCXcciSVoOhwc43weYL1BhsUjKf5WVY=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=cdd34G5OLJPqW6yNizV2KHkVL7aE6HncBSiSvdkWo3Ouo3RUZm+MR5rZ9uIhGa6cH
         /GGojLZZj4Z5mnsiGWm07B40SLuIUGQfLZdFVtc1ETj5kjn93xc1xdWOwLYBEsv+Pl
         APghvByl9fW771bcknhX/fug/Lf5W//OCSkfdz5rYCOu1BkrrbnBFC0rPwat9teKMM
         aZhIq/J506sivKp85FBOQY/12GTbEC70lRF8FYQi4JiHhEih6qK80A8YQKByaO5cTb
         rxJBQOepCk0hY/O0EvoevvDE8GxqHe0XmrMR3HPFjJCxMVjwj/2/yLY90gZI0l7ado
         ZHIkNZXbpUG3Q==
Message-ID: <e8081a25-1ca8-4552-5a13-41ace1c9a522@enneenne.com>
Date:   Wed, 9 Aug 2023 09:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] include/uapi pps.h: drop not needed PPS_MAX_SOURCES
 define
To:     Charlie Johnston <charlie.johnston@ni.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230630071826.105501-1-giometti@enneenne.com>
 <20230630071826.105501-2-giometti@enneenne.com>
 <2023063017-traverse-accustom-97f4@gregkh>
 <56e461b4-2cd8-ec89-86b2-68544826cf73@enneenne.com>
 <2023063015-immerse-broadside-3dab@gregkh>
 <ca137a28-28a3-f563-52e9-4ee0ef1daa9f@enneenne.com>
 <2023070327-gangway-comic-6e15@gregkh>
 <a743ab0a-fd45-2cd1-2546-44cf4547266f@enneenne.com>
 <9bac379c-c482-e52b-f7bb-33ed4ef49b40@ni.com>
 <a2754968-de3e-4442-ff7b-394193422128@enneenne.com>
 <9ccd49a2-5451-1f02-e03f-849e2f87d5ac@ni.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <9ccd49a2-5451-1f02-e03f-849e2f87d5ac@ni.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDRtfsXasPxbkO4jxQNuhogxdGRpqSeyjfgK+wDw89QYABir6x+Kvabc53uNe9C+ZGlMiiaUM0Aklm7o5eZ4QC4TaGL9/5/2dx/uWq1pXNOrl//+zn2E
 BClayHTRz5dUTUVyyY9ATd5Tg2Z0cS+0hSDcjXiBYSGzU/o64rVRDhmadGQiLqMtyC6m8HIXEzt3zrsbMHHmN2H7n2TK9YU0PePdCgn3cbc3o85JpbY6wAjb
 NSYkrobQHVxGNHFVN06BZn4Fi9dtXAwWcLg323WCXks=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 19:58, Charlie Johnston wrote:
> On 7/18/23 02:47, Rodolfo Giometti wrote:
>> On 17/07/23 17:52, Charlie Johnston wrote:
>>> On 7/3/23 09:47, Rodolfo Giometti wrote:
>>>> On 03/07/23 15:38, Greg Kroah-Hartman wrote:
>>>>> On Fri, Jun 30, 2023 at 03:29:50PM +0200, Rodolfo Giometti wrote:
>>>>>> On 30/06/23 14:53, Greg Kroah-Hartman wrote:
>>>>>>> On Fri, Jun 30, 2023 at 09:50:33AM +0200, Rodolfo Giometti wrote:
>>>>>>>> On 30/06/23 09:31, Greg Kroah-Hartman wrote:
>>>>>>>>> On Fri, Jun 30, 2023 at 09:18:26AM +0200, Rodolfo Giometti wrote:
>>>>>>>>>> Userspace PPS clients should not known about how many PPS sources can
>>>>>>>>>> be defined within the system (nor the rfc2783 say so), so we can
>>>>>>>>>> safely drop this define since is not used anymore in the kernel too.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/pps/pps.c        | 6 +++---
>>>>>>>>>>       include/uapi/linux/pps.h | 1 -
>>>>>>>>>>       2 files changed, 3 insertions(+), 4 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>>>>>>>>> index 5d19baae6a38..1a6131608036 100644
>>>>>>>>>> --- a/drivers/pps/pps.c
>>>>>>>>>> +++ b/drivers/pps/pps.c
>>>>>>>>>> @@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
>>>>>>>>>>            * Get new ID for the new PPS source.  After idr_alloc() calling
>>>>>>>>>>            * the new source will be freely available into the kernel.
>>>>>>>>>>            */
>>>>>>>>>> -    err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
>>>>>>>>>> +    err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
>>>>>>>>>>           if (err < 0) {
>>>>>>>>>>               if (err == -ENOSPC) {
>>>>>>>>>>                   pr_err("%s: too many PPS sources in the system\n",
>>>>>>>>>> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>>>>>>>>>>       static void __exit pps_exit(void)
>>>>>>>>>>       {
>>>>>>>>>>           class_destroy(pps_class);
>>>>>>>>>> -    unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
>>>>>>>>>> +    unregister_chrdev_region(pps_devt, MINORMASK);
>>>>>>>>>>       }
>>>>>>>>>>       static int __init pps_init(void)
>>>>>>>>>> @@ -463,7 +463,7 @@ static int __init pps_init(void)
>>>>>>>>>>           }
>>>>>>>>>>           pps_class->dev_groups = pps_groups;
>>>>>>>>>> -    err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
>>>>>>>>>> +    err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
>>>>>>>>>>           if (err < 0) {
>>>>>>>>>>               pr_err("failed to allocate char device region\n");
>>>>>>>>>>               goto remove_class;
>>>>>>>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>>>>>>>> index 90f2e86020ba..8a4096f18af1 100644
>>>>>>>>>> --- a/include/uapi/linux/pps.h
>>>>>>>>>> +++ b/include/uapi/linux/pps.h
>>>>>>>>>> @@ -26,7 +26,6 @@
>>>>>>>>>>       #include <linux/types.h>
>>>>>>>>>>       #define PPS_VERSION        "5.3.6"
>>>>>>>>>> -#define PPS_MAX_SOURCES        MINORMASK
>>>>>>>>>
>>>>>>>>> Why change this in patch 1, and then delete this here?
>>>>>>>>>
>>>>>>>>> That makes no sense.
>>>>>>>>
>>>>>>>> I did it in two steps to be clear that the first step is about a better
>>>>>>>> redefinition of the PPS_MAX_SOURCES define, while the second step is about
>>>>>>>> the fact it's now that define is useless.
>>>>>>>
>>>>>>> Better to just convert everything in patch one, and then in patch 2
>>>>>>> delete the .h #define.  That way, when userspace breaks, you can revert
>>>>>>> just the last patch :)
>>>>>>
>>>>>> I'm puzzled since I did as you say... patch 1/2 increases PPS_MAX_SOURCES
>>>>>> value while patch 2/2 drops PPS_MAX_SOURCES define.
>>>>>
>>>>> Ah, I thought patch 1/2 renamed it.
>>>>
>>>> No, patch 1/2 just safely increases PPS_MAX_SOURCES value as other drivers does.
>>>>
>>>>> But why increase it if you are removing it?
>>>>
>>>> As I said I splitted the modification in two steps just to highlight that the first step is a better redefinition of PPS_MAX_SOURCES, while the second step drops it since it's useless for userspace. As you noticed this last step is not trivial since it may breaks some userspace programs, but it's also true that RFC2783 doesn't define it, so well written userspace programs should not use that define and then they should not break at all. :)
>>>>
>>>>>>>>> And if this is exported to userspace, removing it should break things,
>>>>>>>>> right?  If not, why was it there in the first place?
>>>>>>>>
>>>>>>>> In reality such define is not stated within the PPS RFC2783, so userspace
>>>>>>>> programs whose relies on such define are broken.
>>>>>>>
>>>>>>> RFC's do not document Linux kernel apis.
>>>>>>
>>>>>> It's true, but well written PPS clients should relay only on PPS API which
>>>>>> in turn doesn't states that define. :P
>>>>>
>>>>> Are you sure?  Have you audited the clients?  if so, please document
>>>>> that in the changelog text.
>>>>
>>>> OK, I'm going to re-write the changelog text adding this information.
>>>>
>>>>>>> So if any userspace code breaks, you have to put this back, sorry.
>>>>>>
>>>>>> If you think that patch 2 is not good, no problem, just drop it, but please
>>>>>> just consider applying patch 1, since increasing PPS_MAX_SOURCES value is
>>>>>> good.
>>>>>
>>>>> You can't change a uapi value either without breaking things :(
>>>>
>>>> I see, but in this case what do you suggest to do? Keeping 1/2 and dropping 2/2?
>>>
>>> I'm confused here. Is the problem just that the uapi value cannot be dropped (since it is part of uapi) and only patch 1 can be applied?
>>
>> Yes.
>>
>>> Or is it that the uapi value cannot be dropped OR changed so neither patch can be applied?
>>
>> No.
>>
>>> If the latter, how would one go about raising a value like this to allow a higher limit without causing issues for existing uapi users?
>>
>> My opinion is that both patches should be applied since, the first one just increases the value of possible PPS sources, while the second just drops a define that userspace tools should NOT use since RFC 2783 - Pulse-Per-Second API for UNIX-like Operating Systems doesn't define it.
>>
>> Is some userspace tool breaks, it should be fixed.
>>
>> Ciao,
>>
>> Rodolfo
>>
> 
> Hi Rodolfo,
> 
> Is there any other testing or help I can provide for this patch set?

I don't think so... I'll to ask to Greg to just apply the first patch and drop 
the second one.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

