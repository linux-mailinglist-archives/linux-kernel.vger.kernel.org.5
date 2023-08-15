Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859377D007
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjHOQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbjHOQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:20:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE139EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:20:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68781a69befso805791b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692116441; x=1692721241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdxYwnLPec1MidJur/zecjHkvcyfCyI9WQjbMF3wcS8=;
        b=vyVpwe6k5qqVpx87pXYNaqSEyPyOV08XF8rrkniWizN7Ixcm53113jUPxVs63ieQku
         /k0e8QDhDielPuyZClzs/ud8xDAEmhzivtE7LzvZxfRyQxK24WwCUBVfjKyagrFuzYjM
         riomaGCFPwXiRkmNriROYB+k0ydZbXbTlw7/K1kFY4qGokzoMteD9l55x+HM34zap1hB
         OmXwCeJgWlhSjypVoKSyBVW7ES2cfiFXEwd9BSMXPClaU8KH4yv/2EZNrRgKidOyS3RR
         sZAkFunB60DGELTFy0ybFFWM7je0vSjG+q9m0sPnZ6cEwaCQATT8KiGd2iIAJqnfVMmP
         Qbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692116441; x=1692721241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdxYwnLPec1MidJur/zecjHkvcyfCyI9WQjbMF3wcS8=;
        b=I3V3IqRNDPVZ/lJnrUzE1yc+hKYbQeCP4k8fOiZ88g+MQV66ue9Y2AbaTY0uTb8Q+l
         YX1uD++GJSVmASpNaktdIWSKXUSgG8AKmDyCgXByAZUVe3zw1neuVDrc97Z01NqTPj9Q
         6+FSc+MXJM5URuaUdnUet1uFKBGTRn7YaQGUwGstf5QGAU6b/IJF5FnwS0/tl1+9xvev
         cqGlSfd9z89Xkj/vbFRneJ/LcAPkz17wW3W7SWpk+CXmUxAUw4olW31btV1+wH8ejZv6
         Dp+1OumV9DYhtpsQs6t+EHkPQxLEtKJzh6YYfYBcdhUjJaDWlxSK9zv10JlxCfsnWvdF
         rvew==
X-Gm-Message-State: AOJu0YxRGCngWqHOndNUhQhtjaxvhlpB4r82dFfztcHTRQM8MI2OLgdC
        //fP8WRbutl3hUbJqZM4HM8MRQ==
X-Google-Smtp-Source: AGHT+IGbvO0FyIVIttj436tW6W4rd51Q6NzyuT+7tt2dsmuChWhUPB088VQ1SL+eJ/oBKERqUO//qQ==
X-Received: by 2002:a05:6a20:9191:b0:12e:f6e6:882b with SMTP id v17-20020a056a20919100b0012ef6e6882bmr17320538pzd.1.1692116441236;
        Tue, 15 Aug 2023 09:20:41 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79219000000b006884549adc8sm1495528pfo.29.2023.08.15.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 09:20:40 -0700 (PDT)
Message-ID: <a30e4e08-7b8c-498c-b8af-82262b3ec6ff@kernel.dk>
Date:   Tue, 15 Aug 2023 10:20:39 -0600
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 10:17 AM, Song Liu wrote:
> On Wed, Aug 16, 2023 at 12:07?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/15/23 9:58 AM, Song Liu wrote:
>>> On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/14/23 9:21 PM, Yu Kuai wrote:
>>>>> Hi,
>>>>>
>>>>> ? 2023/08/15 7:19, Stephen Rothwell ??:
>>>>>> Hi all,
>>>>>>
>>>>>> In commit
>>>>>>
>>>>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()")
>>>>>>
>>>>>> Fixes tag
>>>>>>
>>>>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
>>>>>>
>>>>>> has these problem(s):
>>>>>>
>>>>>>    - Target SHA1 does not exist
>>>>>
>>>>> Sorry about this, the commit was picked from previous md-next branch,
>>>>> and I didn't know that it will change...
>>>>
>>>> It's most likely not your fault, I'm guessing Song rebased that branch
>>>> and this is why the sha changed. Song?
>>>
>>> Yeah, it is my fault. I am really sorry for this issue.
>>>
>>>>
>>>>> Is there any way that I can fix this ?
>>>>
>>>> Only way to fix this is if I rewind my branch and Song updates his
>>>> branch to not have this issue, and then sends a new pull request.
>>>
>>> Yes please. Let's fix this.
>>
>> Please send a new one, I've dropped the old one.
> 
> Is this the for-6.6/block branch? I haven't seen the change yet. The top
> commit on the branch (as I see) is
> 
> 306d74055754 ("ublk: Switch to memdup_user_nul() helper")

Where are you looking? It's at:

commit 66a6a5d0ec852eaced589da066376e69397cd71e (origin/for-6.6/block, for-6.6/block)
Author: Ruan Jinjie <ruanjinjie@huawei.com>
Date:   Tue Aug 15 19:48:14 2023 +0800

    ublk: Switch to memdup_user_nul() helper

since about 15 min ago.

-- 
Jens Axboe

