Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC77834ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjHUVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHUVc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:32:59 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F2C7;
        Mon, 21 Aug 2023 14:32:56 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so3318345a91.0;
        Mon, 21 Aug 2023 14:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653576; x=1693258376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G37Wei01Y8O5fp9JSSi3pMAhLBKchH3SUOVoOVUVXs=;
        b=U3yXZytJesTJagePJ98RGBX1JMf5FdTCiGZsKJOuTWNgzNfrO/fw7CjD4yhC+EdXg2
         tl7Mqb+4cEh0NeRM7olNuj4RgFz4ootyKT57O/G3fT0NuBMucn+aRjr+KpkidfxID3Yv
         wAfENokK6TjQBPqazNS7evBlmas8Nlyg72iS+JpUvjpxV7g/VeKGN6hzJuq9esOg7GiH
         HzqqfvQIx6a9n5iiXGbXpWeJHDRZf6EOepZfEwVAkIPC4Bncknxr9FIgWvdc/F/BbYVh
         LQPvgxl/8yRf1EgpvK0memykmnkSJc8RsWFe/TbdGwFsXW0iC9BHyGqFjX7ev7Lx52cj
         bckg==
X-Gm-Message-State: AOJu0Yx0toQZasiTrQTGGvKm8cd8EHJ+31AgYifGgY6WWqNp59BMZgce
        BAMhhrZDr1k24tmW9TV7nZA=
X-Google-Smtp-Source: AGHT+IGXXfibu8Rfw5jNXwLQ4L2lqd508ae2M0Gvn3NC34yifVuYege5cUOyGY3t9H6aM4ujkQFAtw==
X-Received: by 2002:a17:90a:df08:b0:26d:3e6a:cd93 with SMTP id gp8-20020a17090adf0800b0026d3e6acd93mr11192492pjb.17.1692653576196;
        Mon, 21 Aug 2023 14:32:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ef58:6534:ec7a:8ab2? ([2620:15c:211:201:ef58:6534:ec7a:8ab2])
        by smtp.gmail.com with ESMTPSA id cx17-20020a17090afd9100b00262eccfa29fsm8322024pjb.33.2023.08.21.14.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 14:32:55 -0700 (PDT)
Message-ID: <01b61118-a192-dde2-09aa-de73f2ab2b5c@acm.org>
Date:   Mon, 21 Aug 2023 14:32:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 4/4] blk-mq-tag: update or fix functions documentation
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-5-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230821073528.3469210-5-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 00:35, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> There are some misleading or wrong documentation in the functions of
> blk-mq-tag, update it as we're here.

Are all changes in this patch updates for documentation that should have been
updated by commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")?
If not, please move any unrelated changes into a separate patch.

Please also consider adding the following to this patch:

Fixes: 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")

Thanks,

Bart.
