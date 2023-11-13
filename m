Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505847E9F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKMPF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:05:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E2D51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:05:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bdf5a025c1so2816069a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699887924; x=1700492724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbzSnqFAR6mwR3KcGuOJ/Kh93Fhn2bGB+nEhBmFxq4s=;
        b=eZTTCcFc/m7ItPHtSBXpve6B0E1sZa6Mjk+jvOtJDPdeepf8vVgJ3uCp+47z/t5E/E
         LIXI+MZMaH6V+0iWcaL4maRr1oJbtc/XhmjZIc6g3HYwN6VnxaI39aUx+PGg2J7ZuqBb
         S7lRKVGMoXELgum371NxgigUzzAUkMyja+ht2cJL1+EjRgJRhQb1EeTGgyyCSyXJgZ6M
         jj9IS6YbwXRnfuxhRZmdeMeOCD8svztgHlpiaT0H8XcHkAGMe9YAKrhBFXcm/AanLae4
         NWUvifj8p0KIMPGXQhFa/RRKwvjb7AmBNvMTMmdqLxmZQeyo7wCbrkXMvIrg1stGALfF
         S7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887924; x=1700492724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbzSnqFAR6mwR3KcGuOJ/Kh93Fhn2bGB+nEhBmFxq4s=;
        b=WPTgpd7NTcIGuHufGXh0xDwbgy0bKmZQ3td28ZCTdiM3oc1kgLbt8cUVJ0Ev5kJaag
         xM7AS1mJ+/aRkF1hBZykbMTJIaSsy3Cy/l8fQoSQypQXdBihbfZ5qAtj+4dtcUuO3mcW
         dih6/znpHOZnoa4p6um+Lc+Az/AdJ/F7WfS95Jp9c+SBAnFultRhAiaUTJKf0kUz3N20
         HTK5lXvr+AYGsqcZuT5S5KkYh4gjFmupvAaq+Yi6QcFgNQvk+MVL6tSoRQs8f/zsuhbS
         CPBFs1XiUhUC4QxunFWcpRW4qLzwteA9kAbL6D2HDJ8rwOH08DD5cOLQKQ14M6syh+uJ
         wquw==
X-Gm-Message-State: AOJu0YyzniBu1Sn1Z5t0N/DUOYJLJs7PoBXNZTq74iSrA3AsdVk7v9lS
        u3hrFDsM6kHf7zsw0AMhCRmLZw==
X-Google-Smtp-Source: AGHT+IHJem5aIMZ7rNpAWy/1W8yegYRJqh4hVs3ycIaSi7rD/U+QY2Q6T6m2vQpoUZh+Fn+uKoNmjA==
X-Received: by 2002:a17:90b:390c:b0:280:29e8:4379 with SMTP id ob12-20020a17090b390c00b0028029e84379mr4906585pjb.34.1699887923845;
        Mon, 13 Nov 2023 07:05:23 -0800 (PST)
Received: from ?IPV6:2409:8a28:e60:6e40:4d8e:5c2e:f2ee:32f0? ([2409:8a28:e60:6e40:4d8e:5c2e:f2ee:32f0])
        by smtp.gmail.com with ESMTPSA id fz10-20020a17090b024a00b00268b439a0cbsm3717714pjb.23.2023.11.13.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:05:23 -0800 (PST)
Message-ID: <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
Date:   Mon, 13 Nov 2023 23:05:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [syzbot] [block?] WARNING in blk_mq_start_request
To:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
 <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/10 02:13, Bart Van Assche wrote:
> On 11/8/23 17:27, Chengming Zhou wrote:
>> CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled in the kernel config,
>> so null_queue_rq() will return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE
>> for some requests, which have been marked as IN_FLIGHT status.
>>
>> Then null_queue_rqs() put these requests in the rqlist and return back,
>> blk-mq will try to queue them individually once again, caused the warning
>> "WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE)" in blk_mq_start_request().
>>
>> So handling of return value of null_queue_rq() in null_queue_rqs() is wrong,
>> maybe we should __blk_mq_requeue_request() for these requests, before
>> adding them in the rqlist?
> 
> Please follow the example of virtio_queue_rqs() and send any requests
> that need to be requeued back to the block layer core instead of
> handling these directly in null_queue_rqs().
> 

Ok, I reviewed the code of virtio_queue_rqs(), found the main difference
is that request won't fail after blk_mq_start_request().

But in null_blk case, the request will fail after blk_mq_start_request(),
return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE. If we return these rqs
back to the block layer core, they will be queued individually once again.
So caused the warning.

Thanks!
