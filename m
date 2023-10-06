Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097DC7BB181
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjJFGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJFGYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:24:19 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 23:24:16 PDT
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300590
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:24:16 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id oeEwqIZBPRbLIoeExqSU1E; Fri, 06 Oct 2023 08:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1696573392; bh=1g4cE2HuG32l4c0jdgyiNG0Vc4f/Jd4BC4OAvpvtJu8=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=m6x/TAAfP6HnbJu44l9yFOq+rN+xFSmM2Cu0xkgvVT3A1PnyRjldZ9sVAo92jitTN
         vU5poXE2Oh4NZnF9PaCPoLMsojq/gxS/Rme/Bh1M2H7tS82gRSWAqELkyujuRSXCkf
         pK21CckOXU5H2YONqoVUluYCdRn60U5DkB2+CXFwQxLSGZ0JZUJwBf4OOR7tLb/ZfR
         QrBhjuJGuxexB7ep+vHSTeJUc4MYioCWhlUFNWt6/WjvhnjIqIuzrs784RsBDPp2VH
         nIX5kq4X/ng7KXABWJcsZfxi6jiYFFUh4yiji0ouaGjEZIKtCXTLy/j9Dp7rhmYvj9
         cbr+4WDKBbIjg==
Message-ID: <8ca736c3-7da9-2599-7e55-15e2fc9fedc2@enneenne.com>
Date:   Fri, 6 Oct 2023 08:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: PPS functionality for Intel Timed I/O
Content-Language: en-US
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
 <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
 <BYAPR11MB32405694C3C9A1DE083EA673E1C9A@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <BYAPR11MB32405694C3C9A1DE083EA673E1C9A@BYAPR11MB3240.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMAx4tZAxRB7YBxzABY8FxJ4N3jczSvovPedbUKVPywsYjMWLUH6jDo+TwaOhasfJFiG2l8OCieAyiy/DbTSIMEgwdAEYtu/FSLtxznBpXS2ej/HQeKB
 mxySHZA7U+8rv6mjdrLbM2EwX8mCZKPTqhyfCY+50Chho7SiQjvkgk5qlcn+I+XykDtZvWEhiF6JE09zyd5QNG6toCoIouI3Qo5PzygcjPlmHHg8h6VFXXN0
 eYX2HuQmv3i9aN4ua5vgheHAl20XQnIzOgQcpKh7wHuei+FFb3cLvmFQZz1dBotbTXSahLv4glluFtkze766i5h0NxmLS+qa3k/MMnkgDTbA5atIeaMAUpr0
 ZVVHcC9S2IbRF/v1pTfimwlKiTKi11/e97P/vHdHOahSIM5rj1jZVJroCqfyNOxQAHxUq/Uzgkd1jPOSURwK9pp8tMa2sgIjvnAKLNbNiZf2zOQNF2jEa1bd
 xCjD1KhOUoR4yBTCu7S4nvaL8tW+80BylMalfQ==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/23 07:31, N, Pandith wrote:
> Hi,

Hello.

>> -----Original Message-----
>> From: Rodolfo Giometti <giometti@enneenne.com>
>> Sent: Wednesday, February 15, 2023 1:16 PM
>> To: N, Pandith <pandith.n@intel.com>
>> Cc: linux-kernel@vger.kernel.org; Sangannavar, Mallikarjunappa
>> <mallikarjunappa.sangannavar@intel.com>; D, Lakshmi Sowjanya
>> <lakshmi.sowjanya.d@intel.com>; T R, Thejesh Reddy
>> <thejesh.reddy.t.r@intel.com>; Hall, Christopher S
>> <christopher.s.hall@intel.com>; Gross, Mark <mark.gross@intel.com>
>> Subject: Re: PPS functionality for Intel Timed I/O
>>
>> On 15/02/23 08:09, N, Pandith wrote:
>>> Hi Rodolfo,
>>
>> Hello.
>>
>>>> -----Original Message-----
>>>> From: Rodolfo Giometti <giometti@enneenne.com>
>>>> Sent: Monday, February 6, 2023 4:17 PM
>>>> To: N, Pandith <pandith.n@intel.com>
>>>> Cc: linux-kernel@vger.kernel.org; Sangannavar, Mallikarjunappa
>>>> <mallikarjunappa.sangannavar@intel.com>; D, Lakshmi Sowjanya
>>>> <lakshmi.sowjanya.d@intel.com>; T R, Thejesh Reddy
>>>> <thejesh.reddy.t.r@intel.com>; Hall, Christopher S
>>>> <christopher.s.hall@intel.com>
>>>> Subject: Re: PPS functionality for Intel Timed I/O
>>
>> [snip]
>>
>>>> Mmm... I'm not sure this is correct since PPS generators should
>>>> generate their pulses according to system clock and not according to
>>>> their internal clocks even if they are synced with the system clock.
>>>>
>>> Timed I/O and system time are both driven by the *same* hardware clock.
>>> Timed I/O is a high precision device (nanoseconds), able to output pulses.
>>> The driver gets the system time and schedules output at target_time in
>>> the future.
>>
>> OK, in this case it would be OK. Please put an appropriate note within the
>> generator's code and a detailed one within Documentation/driver-api/pps.rst.
>>
>> Regarding Documentation/driver-api/pps.rst let me suggest you to prose a
>> separate patch to rewrite the Generators section in such a way you easily can add
>> your solution at the end. A possible example is attached but feel free to rewrite it
>> according to your needs.
>>
> Ok, we are updating documentation as you have suggested as a separate patch.
> Can we use your "Signed-off-by" tag for attached patch.

If you just followed my suggestion then it's OK for me.

> We are adding Intel timed I/O documentation as a separate patch.

OK.

Ciao,

Rodolfo Giometti

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

