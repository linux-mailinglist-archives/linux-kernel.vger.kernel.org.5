Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2588A7819D1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHSNvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHSNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:51:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22DAD02
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:49:40 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9da57da6bso192448a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692452980; x=1693057780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/B6UoozTgOvnZDnxvKImlq9ysTnzY+A8aabIbXLECc=;
        b=ysEPnZ2wprO0ADtzkzFOQbi7bEuESJ1oyXnNd6Eu23By6wTNHjH4fDZx3zPpgJQczq
         0I3TXeDp5C6tVxw3uM7aTSPAYA03ihPLYtcR0VDidIoSySeemZrSGLverCzXaTzYx79F
         KQ7RENQd9GfXw1N7024GodNHyJ3NJVzX6dDjH1pRTMgLdamvF1zGo9q0MJAlpxLAGMci
         G/kQPyFD++2gJETmXPg+BSN0rD2lnYJNX3bB57w+aV3/O/iuZeYuMyOEdEM5JJLOhWKv
         81FarjqGZ4mX79INTv2PeipQR8BjfVELg0LWyEf26VN3Z1A0rC4PLwwaRVVstv7wMRQE
         EAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692452980; x=1693057780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/B6UoozTgOvnZDnxvKImlq9ysTnzY+A8aabIbXLECc=;
        b=F1ds9J2LNDDV8oUU2C/gZeHuV4JOy2aoflrG70/zW3wXB4ydZv1yuXTGRvs28uY6Ps
         iq+LXXRKj3YuZIO+WQjpWc/AmyNhlYzDG0F0HNeMIKpqfga1w+6pZHoaeDJbdzfrA4l0
         rTRkKJzH0HvsnaIlePmo0Xj5ByQTt3os4FSJ+DWuu6m97Xf70w1UVpG1tVkvFiqRyEBu
         QRE2PG/qFzA31Uhh6uPHepHWwjn69/Gl4dmnPELJtdlBKw/IX9YJH4DEQGussnZJ3Wsi
         EFAkU+1zy5XXL+NThODvbYn2xQL5Ji6oh1veHpzcObSbMdupIoJw/Ydy1b+EfsqZRIc2
         8Xnw==
X-Gm-Message-State: AOJu0Yw3YPEZ31OjFIX7UPlYMVOvAAbTztMnj8eUZI8mGpAkd23knBhN
        HsqzTIVIvkh+2uXV+gWQzSPHeQ==
X-Google-Smtp-Source: AGHT+IEvvRLkc8kEmD2lgUo1aiyAPBpFrWPhmPLSWQOJ/warFZK5d4mY9EP3phvx8nF6CuIPv7vQew==
X-Received: by 2002:a05:6870:330a:b0:1bf:9fa2:bfa3 with SMTP id x10-20020a056870330a00b001bf9fa2bfa3mr2603134oae.1.1692452978347;
        Sat, 19 Aug 2023 06:49:38 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002693505391csm4895881pjt.37.2023.08.19.06.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 06:49:36 -0700 (PDT)
Message-ID: <05ce0ba0-9c34-4da4-b8d0-e1b5a1c6c125@kernel.dk>
Date:   Sat, 19 Aug 2023 07:49:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix mismatch between IO scheduler insert and
 finish
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, bvanassche@acm.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, chuck.lever@oracle.com, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
References: <20230819031206.2744005-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230819031206.2744005-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 9:12 PM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> IO scheduler has requirement that one request which has been inserted
> must call finish_request() only once.
> 
> Now we have three special cases to consider:
> 1. rq has not insert, has complete: e.g. empty preflush
> 2. rq has insert, has not complete: e.g. merged requests will be freed
> 3. rq has insert, has twice complete: e.g. postflushes
> 
> Note case 1 which existed before, has been no problem since all the
> schedulers will check in their finish_request() if the rq has been
> inserted or not, like checking "rq->elv.priv[0]".
> 
> Then case 2 and case 3 are the introduced regression, we moved the
> scheduler finish_request() from free phase to complete phase to solve
> a deadlock problem. But it caused no finish_request() for request in
> case 2, and double finish_request() for request in case 3.
> 
> So we still need finish_request() in blk_mq_free_request() to cover
> case 2. And clear RQF_USE_SCHED flag to avoid double finish_request().
> It should be fine since we're freeing the request now anyway.
> 
> Of course, we can also make all schedulers' finish_request() to clear
> "rq->elv.priv[0]" to avoid double finish. Or clear it in blk-mq, make
> the rq like not inserted as case 1.
> 
> FYI it's easy to reproduce warning in mq-deadline using this:
> ```
> DEV=sdb
> echo mq-deadline > /sys/block/$DEV/queue/scheduler
> mkfs.ext4 /dev/$DEV
> mount /dev/$DEV /mnt
> cd /mnt
> stress-ng --symlink 4 --timeout 60
> echo none > /sys/block/$DEV/queue/scheduler
> ```
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308172100.8ce4b853-oliver.sang@intel.com
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

I folded in this one and added a link to it as well, final result is here:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=e5c0ca13659e9d18f53368d651ed7e6e433ec1cf

I'll get this sent off today.

-- 
Jens Axboe

