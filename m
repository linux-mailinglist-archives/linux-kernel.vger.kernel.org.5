Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546D790858
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjIBPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjIBPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:00:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60D116
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:00:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0bae4da38so165235ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693666839; x=1694271639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No82j0zelLGQZ1We1kpgGnX8WqgyXeJ+fKIBM7K2mfk=;
        b=fThpd0KB93D0Z9q996gYT3PK8biCc9lKLl+87nPvfXy/r116B+6lBjKk4UEXQl6pmt
         b+i/4rVEI15zSsCr43tCoDeSFbad3mZdbZVc06fuSmj1y8q5sUNRpogAu/ITHGrQ1ycs
         /SSnCqGJ1ZW7Zglyny1PgqAjj5Tn5+m3Gv/Bz4xq3VJsKLt2+0cwW1hEDqq4Oeku8lF0
         LXtWxdkEBwkXysBYdGeEbFHfHp+6XhADei7H5GzihhCbgjbFycFIq9BjjRLYPpAHODg7
         uLyVCLxLSKK5w5HgMXWnP4SbL9RignY9TwmKOToVo+AB/QNy+thuF+E4ZlKkJ9i6EbMC
         6lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693666839; x=1694271639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No82j0zelLGQZ1We1kpgGnX8WqgyXeJ+fKIBM7K2mfk=;
        b=XrM+grp7PuvCsqEfxiKpJlkq6SpJ7oJY9+sGdU+qPJifJR0/d6GEuBt+N9H4oqC3vD
         jJGoSNAxsWNu6s2TeqSkmarhi1A7IxhFRRcAJsG0cAbSQiHCv0oBwHOOmzOJ+39o22gN
         u3uxFb2cFG25JjfFZHPMsWMwhOQxYdfM/uebbtPDzSWyufPdOfLYU5qr7jTcwESG2Qiq
         8LQbXL06Q9DwMqNTI3x0vlZS1tFlnmSk+3Sma5crvDkGAwbHUH+otawPxybB841dNWAE
         B9BJ/P8TCPvh0ADvv81HXDxTbaKn/zH8czjhhCQHGim08A92tO1Gt9a5Y3h3EFqE3yqU
         EHJw==
X-Gm-Message-State: AOJu0YyGUnWoNP2a/TNetAS6x0RhrD6F+PycHmd5dM+rT8/xvIlzH6T3
        eY0Nkz3318Tm5NCyLLx5pd/P2A==
X-Google-Smtp-Source: AGHT+IG5aRowHJhHxeBK0pk6dfUKP7athUbLHijWDRdXGx1tdVm+r/1EhwdRBaCulNtmVhKHfiNyyQ==
X-Received: by 2002:a17:902:a408:b0:1bd:dbec:8673 with SMTP id p8-20020a170902a40800b001bddbec8673mr5868810plq.11.1693666839179;
        Sat, 02 Sep 2023 08:00:39 -0700 (PDT)
Received: from [10.254.27.61] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001c3267ae317sm1343163pll.165.2023.09.02.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 08:00:38 -0700 (PDT)
Message-ID: <fbe24ad1-0d76-0463-0d09-66404991d5b4@bytedance.com>
Date:   Sat, 2 Sep 2023 23:00:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 0/6] blk-mq: optimize the queue_rqs() support
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com, bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/24 22:43, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The current queue_rqs() support has limitation that it can't work on
> shared tags queue, which is resolved by patch 1-3. We move the account
> of active requests to where we really allocate the driver tag.
> 
> This is clearer and matched with the unaccount side which now happen
> when we put the driver tag. And we can remove RQF_MQ_INFLIGHT, which
> was used to avoid double account problem of flush request.
> 
> Another problem is that the driver that support queue_rqs() has to
> set inflight request table by itself, which is resolved in patch 4.
> 
> The patch 5 fixes a potential race problem which may cause false
> timeout because of the reorder of rq->state and rq->deadline.
> 
> The patch 6 add support queue_rqs() for null_blk, which showed a
> 3.6% IOPS improvement in fio/t/io_uring benchmark on my test VM.
> And we also use it for testing queue_rqs() on shared tags queue.

Hello, gentle ping.

Thanks.

> 
> Thanks for review!
> 
> Chengming Zhou (6):
>   blk-mq: account active requests when get driver tag
>   blk-mq: remove RQF_MQ_INFLIGHT
>   blk-mq: support batched queue_rqs() on shared tags queue
>   blk-mq: update driver tags request table when start request
>   blk-mq: fix potential reorder of request state and deadline
>   block/null_blk: add queue_rqs() support
> 
>  block/blk-flush.c             | 11 ++-----
>  block/blk-mq-debugfs.c        |  1 -
>  block/blk-mq.c                | 53 ++++++++++++++------------------
>  block/blk-mq.h                | 57 ++++++++++++++++++++++++-----------
>  drivers/block/null_blk/main.c | 20 ++++++++++++
>  drivers/block/virtio_blk.c    |  2 --
>  drivers/nvme/host/pci.c       |  1 -
>  include/linux/blk-mq.h        |  2 --
>  8 files changed, 84 insertions(+), 63 deletions(-)
> 
