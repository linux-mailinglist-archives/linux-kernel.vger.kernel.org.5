Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2484577C449
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjHOAEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjHOAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:04:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2734A1715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:03:45 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34a99d8f40bso1581725ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692057824; x=1692662624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhScpRBW7fPtOH35Z8Mh7gZ+Y9NJISGq4qFa2XZ54qc=;
        b=dYL1hm61qjWbEDh2SYZ7vMI7skUU+M+8zrhFcJfZCO1x2pHKMeH1XvboT5mpbCt2ZZ
         tdSQe/cwBSth51n6lf55jFvZUFlpHwLYfdWvD2AwiKq5YhRajLcVxnKx89vt3tRO0GH9
         mtbg1c1d73Q08T5+eNru+quuBWC4+qDT1Wz+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692057824; x=1692662624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhScpRBW7fPtOH35Z8Mh7gZ+Y9NJISGq4qFa2XZ54qc=;
        b=hxTYkItXMwKXsgjC8RpYeAr0pZYqmNtqEu501E8tcvJyG02fYYccBMOVpMLRfz8IC2
         OD3F/pjBGfNoQyDzIFixbatxSB92HVswuHiQWm2jc9EEVIVWkFlQ65ZhyxzcU8svAMQ1
         4x47s7V1R0rnR6fxvgf0VEPsxmPHW1r5XRzvffseP7URROQQgyFef9nDwmeffgw6Vhin
         UDMUkpSTqZrqLzZAXvkzmMkfamE1z8lbLlUkRNjQNuplDz1EvHwO3jFimeeyWopw72JY
         EyvIaCeovOMAjq4VgtUxL2MkvRF7PWcd5QVR/j/rGD1DsFtpVXiSv4DkKpAxb4piwwIP
         NpXg==
X-Gm-Message-State: AOJu0Yyi2roq4oi/SZlsNM7Zhx3/vjFgCc6RjjtPHfv8td6NA0fY3HJ9
        WfB609ebNE+tp9gQiZKpJysJjQ==
X-Google-Smtp-Source: AGHT+IHB/OzHEQ+ulwLiK3yOh3mzRrC2jw/F/X1TKvCKuHLc83epBSF/TuUptUW4/YCWWVB/xZoFNA==
X-Received: by 2002:a92:d290:0:b0:348:f47c:ac60 with SMTP id p16-20020a92d290000000b00348f47cac60mr12408618ilp.1.1692057824171;
        Mon, 14 Aug 2023 17:03:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b15-20020a920b0f000000b003498cdb93dcsm3484300ilf.31.2023.08.14.17.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:03:43 -0700 (PDT)
Message-ID: <c5a9f8ad-35f1-fc89-7904-1eb42b48ef58@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:03:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp
 mode
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenhq2005@gmail.com" <chenhq2005@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230811213501.17293-1-mario.limonciello@amd.com>
 <ZNmqQkOK7CLa7TNl@amd.com>
 <dcb720bc-113f-e467-01bd-3d19869e13ac@linuxfoundation.org>
 <696c34d0-3de0-4f56-8003-eac872298605@amd.com>
 <62da8b7c-3a90-cffc-4750-532c2b440764@linuxfoundation.org>
 <764c49f6-0dd4-4bc0-8d7a-3054a5d75999@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <764c49f6-0dd4-4bc0-8d7a-3054a5d75999@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 17:33, Limonciello, Mario wrote:
> 
> 
> On 8/14/2023 6:22 PM, Shuah Khan wrote:
>> On 8/14/23 15:50, Limonciello, Mario wrote:
>>>
>>>
>>> On 8/14/2023 4:28 PM, Shuah Khan wrote:
>>>> On 8/13/23 22:14, Huang Rui wrote:
>>>>> On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
>>>>>> When running in active mode the driver for amd-pstate has -epp appended.
>>>>>> This throws off amd-pstate detection.
>>>>>>
>>>>>> To detect amd-pstate look for the prefix instead.
>>>>>>
>>>>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
>>>>>> Reported-by: chenhq2005@gmail.com
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> Acked-by: Huang Rui <ray.huang@amd.com>
>>>>>
>>>>
>>>> This patch doesn't apply on top of cpupower latest:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git coupower
>>>>
>>>> Please rebase and send it.
>>>>
>>>> thanks,
>>>> -- Shuah
>>>>
>>>
>>> It looks like a variation of it is already in your tree as:
>>>
>>> a1cf97c2d43ae ("cpupower: Recognise amd-pstate active mode driver")
>>>
>>> Considering it was also reported to a kernel bugzilla, perhaps this should be considered for fixes?
>>
>> If it is already fixed, there is no need to revert and apply your fix.
>> Please close the bugzilla bug as fixed with the above commit.
> 
> Sorry I was unclear. My suggestion was that perhaps a1cf97c2d43ae should be considered alone for 6.5-rc7 instead of waiting for 6.6-rc1 as it fixes the Bugzilla issue.  Otherwise we should wait until it's in Linus' tree for 6.6-rc1 to close the Bugzilla.

Got it. There isn't enough time now to get this to flow through
my workflow and then into pm workflow. Since the bug is fixed
in linux-next, it will go inot Linux 6.6-rc1. Then it can go into
stables.

thanks,
-- Shuah

