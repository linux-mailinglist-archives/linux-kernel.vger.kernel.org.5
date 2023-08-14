Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8AF77C3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjHNXXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjHNXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:22:51 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35F1735
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:22:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34a91a25db9so1666315ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692055370; x=1692660170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msgMONOeG9CbXeiHqVa9CjRn1VKdSZL6ymz64pRteHI=;
        b=F9Uzpdr3YWmF9ISBXcwKDYJ/Ifmi8SkhguotNy/QZNzVz12Sh7mcfBimZSX14Se1/e
         7bevjtCvGQC0TV57zwxMG+DLGIsT7MMP6TIo18vF4edVMukX2vpDpjhzAnIRJAv+ZxJm
         SAI2WErP5znuRxJJPhrYqOMBhfBnjiI9BCVXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692055370; x=1692660170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msgMONOeG9CbXeiHqVa9CjRn1VKdSZL6ymz64pRteHI=;
        b=WzbwUPZ6SzMf8OFSSdVCNzUHsKYJiA7GWTn7zHTqNZzRVWFccrU9KriybiCE1kMm2y
         nUeoBOJlUXu1JCFDne03hUJ4nBl+HAc3XpqdPBWbBnXKo1XBxE7AZBgFmZ6n2XrBce75
         nEQz6nvZ4njKMQsTMOhnO+Or3Gr4RqM15cANq90zHhveEd0knDtGBDDxujDk2Y8dh9c7
         HUUbfmoOLPJJsjHCMigItX/6IsQooTay9RneMY72UKIrnAlPWoIZod4z6bxazPbDS9Yx
         pXxvSeSfdSe0uMNKvWzab1jWeu39rQzayln7han2NDwIQrynOntagngBxwah2UWnAKFx
         jpfA==
X-Gm-Message-State: AOJu0Yy05egCKZHKtiTVBRneUgSoyytLTfPdSXBlt220kUdgA3/xeql3
        VOZLZWTM3cykD08e/6ceqFe5lA==
X-Google-Smtp-Source: AGHT+IGdBe4zNERKpK1RuWqDnvjfkyba6yUPrfzX2EEA+8IIaNaq1Hk4i9iZHjt4fZ3yo4F6V7YGqw==
X-Received: by 2002:a92:d3c6:0:b0:349:983c:4940 with SMTP id c6-20020a92d3c6000000b00349983c4940mr11986497ilh.1.1692055369954;
        Mon, 14 Aug 2023 16:22:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k11-20020a92c9cb000000b003498409f1a5sm3557827ilq.40.2023.08.14.16.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 16:22:49 -0700 (PDT)
Message-ID: <62da8b7c-3a90-cffc-4750-532c2b440764@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 17:22:48 -0600
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
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <696c34d0-3de0-4f56-8003-eac872298605@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 15:50, Limonciello, Mario wrote:
> 
> 
> On 8/14/2023 4:28 PM, Shuah Khan wrote:
>> On 8/13/23 22:14, Huang Rui wrote:
>>> On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
>>>> When running in active mode the driver for amd-pstate has -epp appended.
>>>> This throws off amd-pstate detection.
>>>>
>>>> To detect amd-pstate look for the prefix instead.
>>>>
>>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
>>>> Reported-by: chenhq2005@gmail.com
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Acked-by: Huang Rui <ray.huang@amd.com>
>>>
>>
>> This patch doesn't apply on top of cpupower latest:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git coupower
>>
>> Please rebase and send it.
>>
>> thanks,
>> -- Shuah
>>
> 
> It looks like a variation of it is already in your tree as:
> 
> a1cf97c2d43ae ("cpupower: Recognise amd-pstate active mode driver")
> 
> Considering it was also reported to a kernel bugzilla, perhaps this should be considered for fixes?

If it is already fixed, there is no need to revert and apply your fix.
Please close the bugzilla bug as fixed with the above commit.

thanks,
-- Shuah

