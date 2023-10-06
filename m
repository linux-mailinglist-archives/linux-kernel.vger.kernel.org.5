Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6757BB39F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjJFI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjJFI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:57:43 -0400
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F336483
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:57:39 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ogePqKYQGRbLIogePqUzfR; Fri, 06 Oct 2023 10:57:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1696582658; bh=IJDI1eWWavN8zcnH8yKbKAzLWin1rm4hxwkoyXI90AM=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=fjzWL8LLqOSO8UPnmfXSGzwUGAsf1pyGrQ7Ymp/oKkhJBZf5AhECwuudMryxU2jbY
         ulXpVDiAugaiAHfB6NaKd5f99U6anC66hTZ4Qz24e3mYWuTxWj4JSzh9jPZqNkfm3S
         OpBQDetYDkw81pOH+HC+C38X2MBzj70xqGtunrllCaL0FhnzFtiJJJjhlRNJa6DVKY
         YujuchcCSX8XGzgmX31uKrpQskv0IuOCYG/ICIeiCvwIlIKHaYxffPZlCFXAxr7yDo
         m0iQCAj6l+4ZyaYZHh2J6M9p+G6EpUKJYirigghQ78oNkYYC7vynX+gJ3yiQuXPJyV
         wFSWxA8nn/cVg==
Message-ID: <633ea9ab-7d86-33c7-f20c-6b7be945750a@enneenne.com>
Date:   Fri, 6 Oct 2023 10:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: PPS functionality for Intel Timed I/O
Content-Language: en-US
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "N, Pandith" <pandith.n@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
References: <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
 <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
 <BYAPR11MB32405694C3C9A1DE083EA673E1C9A@BYAPR11MB3240.namprd11.prod.outlook.com>
 <8ca736c3-7da9-2599-7e55-15e2fc9fedc2@enneenne.com>
 <ZR/GgpHAWYEKvzdN@smile.fi.intel.com> <ZR/Gs3q1JfJ3pCky@smile.fi.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <ZR/Gs3q1JfJ3pCky@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBOE/C0Zze3ac27LAy/+ILzhp4tHoOSOHyAG8NB2RmY3GzpeIsdsbaAMlRojNunnzctSMQtSkz1UYF7AGey8BxcPn4TG7+e+dQTUMmxUilavuTijFSPS
 kfOBlYN1whdI4beWEEaUE4bOqfCbd8nFoGq0reQDeQ2ouE+skbTCo5zCTvZr1e+clUYqDI8xMvl4yg9wkjlQHpAFr3pfMeX/shU8xPlpsg4FrDB2MJAvPdYR
 a5OqighUkDNn/iwxTiuM8hJ82vGe8eYYHgVzDztYWkXumxu5FC8fcEawVOfRp8UfF82kIf2CHA2zqI8tY7YOSmg08+Hvc3UsVwUXX10R0HpyNyLFcDJtfzic
 3yPnRLyDPySC7oF4TQd7zcJ5wQ1FSYssAQnST8FZhfsnnU76nWTPNhLILrYcGUsu1FDFycLMxCFmBI/Tt4EWT1qRzQ+4HfbKDUGMazF9KaDhC6fyky6dDOc6
 1Xj8kURtoHeBYbXPtv4d8RhxAsJCzi7uDvAY2Q==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/23 10:34, andriy.shevchenko@linux.intel.com wrote:
> On Fri, Oct 06, 2023 at 11:34:10AM +0300, andriy.shevchenko@linux.intel.com wrote:
>> On Fri, Oct 06, 2023 at 08:23:09AM +0200, Rodolfo Giometti wrote:
>>> On 06/10/23 07:31, N, Pandith wrote:
>>>>> From: Rodolfo Giometti <giometti@enneenne.com>
>>>>> Sent: Wednesday, February 15, 2023 1:16 PM
>>>>> On 15/02/23 08:09, N, Pandith wrote:
> 
> [snip]
> 
>>>>> Regarding Documentation/driver-api/pps.rst let me suggest you to prose a
>>>>> separate patch to rewrite the Generators section in such a way you easily can add
>>>>> your solution at the end. A possible example is attached but feel free to rewrite it
>>>>> according to your needs.
>>>>>
>>>> Ok, we are updating documentation as you have suggested as a separate patch.
>>>> Can we use your "Signed-off-by" tag for attached patch.
>>>
>>> If you just followed my suggestion then it's OK for me.
>>
>> But can we have your SoB or not? If so, please provide it explicitly as
>> the (Linux kernel) process requires.
> 
> Or even better if you provide the patch itself or apply directly to your tree
> that we can rebase the our stuff on.

Just send the patch to the kernel mail list and, if OK, I'm going to sign it and 
forwarding to Greg Kroah-Hartman.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

