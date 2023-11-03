Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0E7E03E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377616AbjKCNoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:44:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC551B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:44:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1644131a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699019049; x=1699623849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAwnuNWOqdk8r7RMLFguMdGxoKK8GFPpsUqe+jMzKdA=;
        b=HD72wpgre/aRN7z4j5VH/VaiLXvjlaZMhA6TLb1lPeOOccfOIqFh71h1MPKA7YZOB7
         L3i2MbNw5JFHDdR1002HwqKoDbM8q/MkatZwiuzwJM8TSIdH91tHxAcxZE0oyfhHTsXz
         N7fyV3sZEjazy/nSqMEtteF+AEGDWAJ/f15xPP7ZEjZg3ynPc2A5Q7/YjtIAk1ac6JYz
         OTell7CmWJAwQCL89VHbmpS9SCgFfKz7h/mtYa12lHUqSmCMS/HVUGpYphjX6TxZODhX
         RAgZjUzoVsdd32mlMU655ri1nvw7Pu8PoK59Bk70uJWOMaTQJIIngiZfTzKX+Qp/1igK
         ftXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699019049; x=1699623849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAwnuNWOqdk8r7RMLFguMdGxoKK8GFPpsUqe+jMzKdA=;
        b=paCRZSf4YdGzFW/4L2PyeQzMM8ouU9+W5lCiwdjE5KOUWngGKEHD2o0T0Nl4uMIm1B
         DRvLL+CTNLtosJCX0wJ/VBWxzu0sNUzjV9zHNqquM5CUI5RF+SEOgDsdyNTjey+pSNls
         2aulauSAPU+6pThK5LQRG5zN44RJ4MrvhzrrLwS0jkvgupmVbszGmzaCMFfwy2i6T4RA
         6ZDNXKwKZmPsqvFuYWv99znrr7dTHJN63Lr85XIyT2EpxQGEY1UgaJPJtthw56C3mUWm
         a6VNVGWM59pBwnvLSisw0tj6gaxI/HDEBW748EwrKA+FYKfS0L9eLBmciOn2PwDHdCQk
         wVLQ==
X-Gm-Message-State: AOJu0YxuKT9RFV+Age2mvGcVRBacJZpmP4Ee8UoGX2V6uV3bk3iactbk
        NB3C20VGmE3B3/o7vovdi8A=
X-Google-Smtp-Source: AGHT+IGt8gFlTfzrJIRGBAC72qQjPlYWGPSABBzTLE9SMs00eMp4wOMMiOVSjuxBEX+fQWfTPHQfvw==
X-Received: by 2002:a05:6a21:7881:b0:17e:2afd:407f with SMTP id bf1-20020a056a21788100b0017e2afd407fmr28675924pzc.9.1699019049094;
        Fri, 03 Nov 2023 06:44:09 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b006b4a5569694sm1462691pfm.83.2023.11.03.06.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 06:44:08 -0700 (PDT)
Message-ID: <1578a6d3-e2f0-443e-85d1-55c639aa1910@gmail.com>
Date:   Fri, 3 Nov 2023 20:43:58 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US
To:     syed saba kareem <ssabakar@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
 <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2023 20:30, syed saba kareem wrote:
> 
> On 11/3/23 04:41, Bagas Sanjaya wrote:
>> On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:
>>> I'm trying to develop a sound machine driver based on the acp legacy driver.
>>> The first version of the driver was sent for review on the alsa mailing list this
>>> spring: https://lore.kernel.org/all/20230320203519.20137-1-posteuca@mutex.one
>>>
>>> I'm trying to fix some of the issues that were brought up during the review back then,
>>> but when I ported the patches to the latest commit on the for-next
>>> branch, I noticed a regression where I couldn't hear any sound at all.
>>>
>>> So I started a bisect session and found that the first bad commit is:
>>> ASoC: amd: acp: add pm ops support for acp pci driver
>>> commit 088a40980efbc2c449b72f0f2c7ebd82f71d08e2
>>> https://lore.kernel.org/lkml/20230622152406.3709231-11-Syed.SabaKareem@amd.com
>>>
>>> If I revert this commit sound works as expected. So I started tinkering a little bit
>>> with it and I believe that what happens is that the acp pci driver
>>> enters the autosuspend state and never leaves this state at all.
>>> I noticed this because if I increase the autosuspend delay to a much
>>> larger value, then the sound works until that delay passes.
>>> I added traces and I can see that when the delay expires the suspend callback snd_acp_suspend()
>>> gets called, but the resume callback snd_acp_resume() never gets called.
>>>
>>> I'm no expert in runtime power management (though I did read a bit on it), so I don't understand
>>> all the things that happen underneath, but one thing that is not clear to me is who's supposed
>>> to mark activity on this device and keep it from entering autosuspend if the user wants to play
>>> some sound? Shouldn't there be some counterpart that calls pm_runtime_mark_last_busy() ?
>>> I looked through the code and can't find who's calling pm_runtime_mark_last_busy().
>>>
>>> Some help here would be welcome. Is there something missing in my machine driver code, or
>>> is the runtime pm handling in acp pci driver wrong?
>> Thanks for the regression report. I'm adding it to regzbot:
>>
>> #regzbot ^introduced: 088a40980efbc2
>>
> We were working on some other priority tasks, will upstream the changes
> 
> by next week.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

