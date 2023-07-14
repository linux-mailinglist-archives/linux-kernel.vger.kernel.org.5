Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275A3753DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjGNOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjGNOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:43:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE410FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:43:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-785ccd731a7so25724339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689345829; x=1689950629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dejGPXZJlM5BRQ/HIVPGPhqt4ApF8pZ0rT01yr91iIw=;
        b=y/tNTa4Th1EFRh9TixEREZnCULKHa33ztPlS01n895a9dpcF9hEhV43/TT1GYzmQyg
         UaqdB6LfKlrdiG+Q4PURAT5ZPDWEEBsglsuq7n9oOvbMz3eib6NVME7JMq8aL3XeVhzj
         VH+iBjOJzhhntewVqP+U6TshPE7SXP3rhCUToTn6aXPmbpaILU1zg/V8jOwZLsNVetJV
         5OzC7wT0Evz2eVMdOw8Lk2kqUuAec9eaY8B3xVbODA/KxGqfP0kz5loUBjLxsJy54ecc
         FZ8jMlZqeMajFNf2qOcM4B8iYGGzBXQu8l1LaG1aYBy/ltLaAp2DrQkPxjtzLot7yY0P
         Jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345829; x=1689950629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dejGPXZJlM5BRQ/HIVPGPhqt4ApF8pZ0rT01yr91iIw=;
        b=lu+k5qVTFBzC8CihDrA5QzcfjWQ/+hhxUj0fBEAz22oQYwZwYndKGxu4mYh2AfOqKs
         quGH6MGMG558REvD5JrFVMhCVYD1/1KAZrFI5gAVK6KsUgHBXXs4h4ZKufDUMrmTyzAZ
         syh5NP3+089JjBnxmJIyViHLSoktI9S1gIMOwsICSXtowksfGoxN6R4HPOnEjPSxH6Dj
         tKNN5d3Ln7UfGmQI4P+wjdX66nl9VG+1XBEM9fWDsRh3qIA4GqoYo6iFaRAyf+rLdPfW
         HO2JAMTIZuoWUJIiN2hlZdzparkhoCJpXridHpNaznC6Lh1YcKJkpp2rV10K6kukEPal
         yVDw==
X-Gm-Message-State: ABy/qLYlr6Pi9yP/vWiWGLHiXQzMMdnBIyVgeiKkvJDCVJvJoVHtRYn/
        hek5NWePOB1RdVk2cSrXQ9tddA==
X-Google-Smtp-Source: APBJJlGA6FB5rzPdcD74UYx5gxzH9yM5f7+DG4L5VYl2S7TJRitIUfehrcJVV9Dt2M+t4chhZDozaw==
X-Received: by 2002:a6b:b7c1:0:b0:783:6ec1:65f6 with SMTP id h184-20020a6bb7c1000000b007836ec165f6mr4498550iof.1.1689345829556;
        Fri, 14 Jul 2023 07:43:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a05660220d900b00783581fd200sm2678915ioz.20.2023.07.14.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:43:49 -0700 (PDT)
Message-ID: <4dc89f6c-ab93-d3e7-5b5a-4b2f34e2fcac@kernel.dk>
Date:   Fri, 14 Jul 2023 08:43:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Tejun Heo <tj@kernel.org>
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
 <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
 <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
 <ZLA7QAfSojxu_FMW@slm.duckdns.org>
 <5be1cba6-b141-3a05-f801-3af7d2092674@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5be1cba6-b141-3a05-f801-3af7d2092674@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 5:31?AM, Chengming Zhou wrote:
> On 2023/7/14 01:58, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Jul 13, 2023 at 08:25:50PM +0800, Chengming Zhou wrote:
>>> Ok, this version will only get time stamp once for one request, it's actually
>>> not worse than the current code, which will get start time stamp once for each
>>> request even in the batch allocation.
>>>
>>> But yes, maybe we can also set the start time stamp in the batch mode, and only
>>> update the time stamp in the block case, like you said, has better performance.
>>>
>>> The first version [1] I posted actually just did this, in which use a nr_flush counter
>>> in plug to indicate that we blocked & flushed plug. Tejun and I think it seems fragile.
>>> So go to this way that only set time stamp once when the request actually used.
>>>
>>> [1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/
>>>
>>> Another way I can think of is to make rq_qos_throttle() return a bool to indicate
>>> if it blocked. Tejun and Jens, how do you think about this way?
>>>
>>> Although it's better performance, in case of preemption, the time stamp maybe not accurate.
>>
>> Trying to manually optimized timestamp reads seems like a bit of fool's
>> errand to me. I don't think anyone cares about nanosec accuracy, so there
>> are ample opportunities for generically caching timestamp so that we don't
>> have to contort code to optimzie timestamp calls.
>>
>> It's a bit out of scope for this patchset but I think it might make sense to
>> build a timestamp caching infrastructure. The cached timestamp can be
>> invalidated on context switches (block layer already hooks into them) and
>> issue and other path boundaries (e.g. at the end of plug flush).
>>
> 
> Yes, this is a really great idea. It has better performance and is
> more generic.

Do you want to work on that approach? I pretty much outlined how I think
it'd work in the previous reply.

-- 
Jens Axboe

