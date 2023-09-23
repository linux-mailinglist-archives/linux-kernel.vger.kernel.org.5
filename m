Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0467AC076
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjIWK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjIWK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:27:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A15CD9;
        Sat, 23 Sep 2023 03:20:04 -0700 (PDT)
Received: from [192.168.1.129] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MysFQ-1reYJ00JV4-00vvV2; Sat, 23 Sep 2023 12:19:44 +0200
Message-ID: <21893e62-2a93-af84-a004-5bebc9916627@i2se.com>
Date:   Sat, 23 Sep 2023 12:19:42 +0200
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
 <d8395455-44eb-6762-d978-e912bf2cfe73@i2se.com>
 <3f040e44-3bdc-b09c-58b3-ea3b0ac6d5dd@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <3f040e44-3bdc-b09c-58b3-ea3b0ac6d5dd@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OFXh+SWAalxlA/BKarJEaKNh9elJf6QmZksB0h43QjpisjqGtPb
 P4dwfYkn0nxOJNRDcn+08zW0B50MOIcgT10MmI3ri06XRKELcujsGfJiJmNklFw7aTIEiqR
 O54kv1Rip8jhf20KE+df8IvZMrl8YiIldtOaqiK72Q5CQ2E6+gQeeRof4+poGtxuLrsEGhy
 fDjnHo+JYxMGWfb006x0w==
UI-OutboundReport: notjunk:1;M01:P0:wxOQh8MJRw8=;/OXycivT0mp7vH58Q7/B3taAhpO
 IvofYFeT2GzPwAz9phoOngRC+wamU1M/I3UF07JboQKWm9BQ/3WNxvzuZFB8dmHLbe2eDFo4G
 q1QF10VsWolLf6mkBp4qsOVhauvoIDnuO9sOuQl8ZRi4Ni4LDYaP3MQKrdB0vYdv9tuNNStu8
 BMZbTP4MmSSAa7VT09inq0ClzyuZzfc/iewKgSGEtGwXigIJW6B/7Rzl5TYe9kSdVv+c4QK3e
 f1yUsZH7aIbRuG6IxA+T7WQlf7YzlsIAdTf8Fqq/yP/n8jHZDAA38JCI4fXkwIvTDvePpevRr
 WLoAyKcDXeIWPOZlBnz3uU1hoVI0JDILSZSGTrFU8Aw5zuTktH/9BdkpWmEiIsYbvsMzZEP49
 fJoc4hPHEr45QkXIE/o23DT+o38TW+4U9UVD5IjOMcuFRFIkEnstm6Ho//c2Pgt4PGdlfEPp9
 /0fg66PflRf3letiUQjXgdbO6kz5x/mR88Ewnv9nl1ZyrwkgHCjQVPvMAHaRDOSQPAafwKPlJ
 6TA3cHAt1jdfvr2NoSg8zm8y6HiCr1Fm3WXzA9l3mffBaTKpoySahH1dORtxHTvTk9KsvvCiy
 ssAaRGK8xke5HW//eQrxqQrojOeiyTQINsZSLirmbWlEuu+mh3n+oIGyaa1slvFlD0X5UFspb
 w/5lb3XUkcN/PcPx6lFgNZsuafUzlxM2EjY0AKiNpKkINP3QOMG+RMUYPti4p9oJqm56pqdBH
 +SG31DqhXPwthfyd/FCuYn01OmCwqMgRnSztVMw4E7VaigRKwQSb6hFrIB9fCCZ6y6vgX076X
 DkgKgjXMuBp2puTQBd+4ifvBEnmLGPdEqVXUfhLy7mmC4kv/Y21EjYwLTosvpuV9kErT+HT/W
 hJDzImYbNHdCbIQ==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 23.09.23 um 11:39 schrieb Umang Jain:
> Hi Stefan,
> 
> On 9/17/23 9:06 PM, Stefan Wahren wrote:
>> Hi,
>>
>> Am 14.09.23 um 08:35 schrieb Dan Carpenter:
>>> On Thu, Sep 14, 2023 at 12:25:24AM +0530, Umang Jain wrote:
>>>> Hello,
>>>>
>>>> This series attempts to restart the discussion on custom logging used
>>>> in VC04. In the last feedback gathered in [1] it seems that the logging
>>>> would rather be moved to use dynamic debug. The series tries to move
>>>> in that direction.
>>>>
>>>> The elephant in the room is the ability of turning on/off log levels,
>>>> which this series just drops. Compensated by a crude strings
>>>> ("error", "warning", "info"... etc) for easier grepping.
>>>>
>>>> The log category are also just strings (which probably can be 
>>>> transformed
>>>> to dynamic debug class names moving forwards?).
>>>>
>>>> To move forwards, I would like feedback on the broader direction.
>>>> There are couple of TODOs in each of the patch (summarised in commit
>>>> messages) which require case-by-case discussion.
>>>>
>>>> Additional high-level questions to move forwards:
>>>> 1. Is loss of log levels by moving to dynamic debug, is actually a
>>>>     concern? Is dynamic debug a valid replacement?
>>>
>>> Dynamic debug is honestly going to be an improvement.  I guess, Greg and
>>> I said this back in Jan.
> 
> +1
>>>
>>>> 2. Whether debugfs should be dropped as well, found vestigial in [2]
>>>
>>> Yes. The "vchiq/log" should be removed.  Ideally as part of this
>>> patchset so it's easier to understand.
>>
>> Yes, but please do not remote vchiq_debugfs entirely. I'm working on a 
>> patch to move the state dump (debug feature) from the character device 
>> /dev/vchiq to debugfs /sys/kernel/debug/vchiq/dump_state.
> 
> Can't the state dump be printed to dev_dbg() ? Will it pollute the 
> kernel log?  Having debugfs for a single dump doesn't seem worthwhile if 
> the state dump can be incorporated to dev_dbg() too.

debugfs was created for a good reason. dev_dbg() is a nice tool, but it 
isn't useful in every situation. In case of communication the usage of 
counter is quite popular and removing this ability would make debugging 
not easier.

Try to make "cat /dev/vchiq" you will see you don't want pollute the 
kernel log with this kind of information.

Actually i don't see a problem with have a single dump in debugfs.

Let me send a draft of my changes for a better discussion ...

Regards
Stefan

>>
>>>
>>>> 3. whether vchiq_log_trace() should actually be tracing support for 
>>>> VC04
>>>
>>> That can be done later if people want.  No need to discuss it now.
> 
> Thanks Dan.
>>>
>>> regards,
>>> dan carpenter
>>>
> 
