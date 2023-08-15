Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96B77D081
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjHORAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbjHOQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:59:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2921BDB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:59:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6878db91494so1108286b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692118776; x=1692723576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVS9kw63RMKsWpJwoAhjz5K99cSSF4a/aHLwrydCoEc=;
        b=CkVIz9nT1c3yULn4ni4wxRDarRZVM4+Xq6oytpLZI6fXFPx9O0YAK3bmZZ0DljduLP
         q7dxDPqXsx0k+Qb0it60QhKNz8sASX+LVk9XY9MgppVgDllmdmO8qyKnIWqRsMdottgM
         C/UiRB4ky+ivPaUsmvAE3vTahPdR2HJp9wLpyentuVoKMjYMMsCUVwq5ZzOiIHN9jUhp
         bj/T0iZUtJEU4J2/Su62LJ0Glqv/N7HVm4Sx7ZDJXxSl1NCDTuCAm720yQT4uwcIsPYi
         nS6IgmjqkJZQwhK3BIRXgH6TiOvZ4KpdV8qhWRRmhGCpt2c98m0EC0PdK9sFZ5YD2Yx+
         R/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118776; x=1692723576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVS9kw63RMKsWpJwoAhjz5K99cSSF4a/aHLwrydCoEc=;
        b=AZU24vfFYaFbv82Hg4qSN9ooJWH51fxOtzuzDPoeK96PT3gmE2ptWd1zCIsOsSaLhv
         S3aKLhIOL8zDCZWInvDYhBTTkDr3EiT6YW9lstYD4/LaMTAKAPuk/BOMUP3/P30tVX7M
         jiEGGsCE6QWuj3Ex2F9UGpz5uvidDJNceIAj1yYbPcVacr177b/LsnLUlcY6Upxc3Auc
         FaMZZkkWSaHU7miEde6gbSs5fgHjx3NkW9cgx3LGfOHXuHbWPhlkyOymVnHK0y5KVSD2
         zUPe2iqqWQ/7xyeF3ToEIl4SuY+f0C5cTR0Ni2jxuio+T61ULg9ICtwOjH11FF9FaUSZ
         ojCA==
X-Gm-Message-State: AOJu0YzYhOWdwG0ZrgHXnbSw70eOe3BUAJocq8kDFX3YToC9p246KQu8
        JnIt3LSB1y4xj0gjZ1Uxl6ozwA==
X-Google-Smtp-Source: AGHT+IHsKwulyAHg07o3ZI0SoxwJs7CYTDeZT+kA5hT2/QSV2M/xf6Lkn+BSlWnHDb6p43D7hvtWjQ==
X-Received: by 2002:a05:6a00:1ca9:b0:668:834d:4bd with SMTP id y41-20020a056a001ca900b00668834d04bdmr13379804pfw.0.1692118776288;
        Tue, 15 Aug 2023 09:59:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d5-20020a637345000000b00528da88275bsm10451824pgn.47.2023.08.15.09.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 09:59:35 -0700 (PDT)
Message-ID: <7e4aa4d3-2d65-41b0-9ae7-a79432ca6175@kernel.dk>
Date:   Tue, 15 Aug 2023 10:59:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230815091931.4dd2b277@canb.auug.org.au>
 <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk>
 <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
 <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk>
 <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
 <a30e4e08-7b8c-498c-b8af-82262b3ec6ff@kernel.dk>
 <CAPhsuW5AHQkf6wO_4Z6VFbTCxNN9GchW_ZPxmC1vtc23ByPc6g@mail.gmail.com>
 <d7d2aea2-66e3-4172-8c04-f71dbe66612c@kernel.dk>
 <CAPhsuW7AX-0JiycnaFHFHYWjWaGju-pXMJtrAFWYk62SkHk22w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPhsuW7AX-0JiycnaFHFHYWjWaGju-pXMJtrAFWYk62SkHk22w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 10:51 AM, Song Liu wrote:
> On Wed, Aug 16, 2023 at 12:31?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/15/23 10:26 AM, Song Liu wrote:
>>> On Wed, Aug 16, 2023 at 12:20?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/15/23 10:17 AM, Song Liu wrote:
>>>>> On Wed, Aug 16, 2023 at 12:07?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> On 8/15/23 9:58 AM, Song Liu wrote:
>>>>>>> On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>
>>>>>>>> On 8/14/23 9:21 PM, Yu Kuai wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> ? 2023/08/15 7:19, Stephen Rothwell ??:
>>>>>>>>>> Hi all,
>>>>>>>>>>
>>>>>>>>>> In commit
>>>>>>>>>>
>>>>>>>>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()")
>>>>>>>>>>
>>>>>>>>>> Fixes tag
>>>>>>>>>>
>>>>>>>>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
>>>>>>>>>>
>>>>>>>>>> has these problem(s):
>>>>>>>>>>
>>>>>>>>>>    - Target SHA1 does not exist
>>>>>>>>>
>>>>>>>>> Sorry about this, the commit was picked from previous md-next branch,
>>>>>>>>> and I didn't know that it will change...
>>>>>>>>
>>>>>>>> It's most likely not your fault, I'm guessing Song rebased that branch
>>>>>>>> and this is why the sha changed. Song?
>>>>>>>
>>>>>>> Yeah, it is my fault. I am really sorry for this issue.
>>>>>>>
>>>>>>>>
>>>>>>>>> Is there any way that I can fix this ?
>>>>>>>>
>>>>>>>> Only way to fix this is if I rewind my branch and Song updates his
>>>>>>>> branch to not have this issue, and then sends a new pull request.
>>>>>>>
>>>>>>> Yes please. Let's fix this.
>>>>>>
>>>>>> Please send a new one, I've dropped the old one.
>>>>>
>>>>> Is this the for-6.6/block branch? I haven't seen the change yet. The top
>>>>> commit on the branch (as I see) is
>>>>>
>>>>> 306d74055754 ("ublk: Switch to memdup_user_nul() helper")
>>>>
>>>> Where are you looking? It's at:
>>>
>>> I am looking at
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>
>>> It appears to be some lag from git server?
>>
>> That's just a backup, I always pull and push from git.kernel.dk. The
>> korg one will lag about an hour, depending on when things are pushed.
>> I've never used the korg one as the canonical location.
> 
> Got it. I will update my git config.
> 
> Here is the updated PR:
> 
> 
> The following changes since commit 66a6a5d0ec852eaced589da066376e69397cd71e:
> 
>   ublk: Switch to memdup_user_nul() helper (2023-08-15 10:06:54 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git
> tags/md-next-20230814-resend

Pulled.

-- 
Jens Axboe

