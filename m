Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961F7EA734
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjKMX5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMX5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:57:43 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479519E;
        Mon, 13 Nov 2023 15:57:40 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3998660a12.1;
        Mon, 13 Nov 2023 15:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699919860; x=1700524660;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2O33Z20Hw5m9jWPSsRRvDoAMyIPjKTQaup/hA8pvVwg=;
        b=rQzftL3T3jXjBlwlBEdQwrraDjCYgUR7plDSi6DH5jUJRjUDtvGNIt8au6aR2oZho4
         E5pDrByXLDc0Uj9e8QRSmqmSmtGCfqD1kM5fdHR04QunTjS3zGhQS/Gwozaer+sOnY68
         q7kOIsWSytpcgUr38fGR91P2qn2j5ZfItvKPu19vM8vfU6q6uN4HNWSHJV4HhVVHKXws
         wQlqbdVAuvTIo9dbLdI5uWZjPoBVeiyPNl48BIiYkj/iMXzA6pwXn5/8RamECrwfw1jg
         SQPY4Gc6pCoFT3DfQ/v3XOtqk3X3jr+qqwVbWeDrzh4ORUcqx9fd6iqhF3Yvcy9rfkei
         DbVg==
X-Gm-Message-State: AOJu0YzC2uhvltaviwnhdkM/Q5Zy/ocLiUoOevkgARFDkjntb129AeIh
        I9MtcMFKD2NXXwdptUA2gIw1iGhoW4M=
X-Google-Smtp-Source: AGHT+IHuHxh5mqX7RqLGEoVItvxSJ0QEO1HWwHcQdsilEu8FzLk6SzflzOyi+wzsLftN0NQJT9fDDg==
X-Received: by 2002:a05:6a20:8408:b0:186:736f:7798 with SMTP id c8-20020a056a20840800b00186736f7798mr5840594pzd.11.1699919859795;
        Mon, 13 Nov 2023 15:57:39 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:7575:f839:a613:3f5b? ([2620:0:1000:8411:7575:f839:a613:3f5b])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b006b97d5cbb7csm143897pfn.60.2023.11.13.15.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 15:57:39 -0800 (PST)
Message-ID: <3f2c2d33-2e5d-4c7b-80ea-e76885981dfb@acm.org>
Date:   Mon, 13 Nov 2023 15:57:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [syzbot] [block?] WARNING in blk_mq_start_request
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
 <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
 <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 07:05, Chengming Zhou wrote:
> Ok, I reviewed the code of virtio_queue_rqs(), found the main difference
> is that request won't fail after blk_mq_start_request().
> 
> But in null_blk case, the request will fail after blk_mq_start_request(),
> return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE. If we return these rqs
> back to the block layer core, they will be queued individually once again.
> So caused the warning.

I think it is safe to move the blk_mq_start_request() call under the if-block
that decides whether or not to requeue a request in null_queue_rq()

Thanks,

Bart.
