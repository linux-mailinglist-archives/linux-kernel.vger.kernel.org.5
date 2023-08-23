Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF8785C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjHWP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjHWP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:26:45 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C132CF1;
        Wed, 23 Aug 2023 08:26:43 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a741f46fadso4216108b6e.0;
        Wed, 23 Aug 2023 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804403; x=1693409203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFvHPIv8iGfPkbYW5RlA5xNi6MZfGEzKYk4w0TdFSmo=;
        b=VFKrbG6FPv3NsVncKlLrEE7cLkY/r+9BxGRvh1OsKSsdj0ODKZgB4eO94OmzwSbCIm
         Y4351Aphy/4mf63VlrYtk7usCO4CTVoT5n/QRGcPF10uTjpwXv13ax5naj5gfQhKZSOf
         3fOu5PaHb0s92wsvq8I+nXwSo7vRvaQg1ouVzAaTYmO//ngcr65kwB8g0sJUMY50sE/Y
         vB9boNhmR3bJtt2276PJfjdYxkWZ0U75nzeTj0xdDGr3y/LwOzgslkzmRdSjJq9BnQxx
         s+BO+aMR0ggHUOHxU0uxU65wEl+JLSDRXhfvVr0cqXtK4REDvqWuOaBYJ450afRDqqRO
         AR+g==
X-Gm-Message-State: AOJu0YxTCqjuv0IzbQq6B1jLQ1G6Oxzq3RtHK4SD7dW6TVlH6udARGQA
        h3VIjuwzaKllYD+RRnxwTks=
X-Google-Smtp-Source: AGHT+IFYzObcsdzja9TmeiqyQLpgZJqSNJfhID6x+odKA/vX3QKLzUFWwIcpOBWIxlp780a2IFcoKg==
X-Received: by 2002:a05:6808:283:b0:3a8:4dfd:4f17 with SMTP id z3-20020a056808028300b003a84dfd4f17mr13178833oic.20.1692804402730;
        Wed, 23 Aug 2023 08:26:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id i8-20020a63a848000000b005634343cd9esm9950144pgp.44.2023.08.23.08.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 08:26:41 -0700 (PDT)
Message-ID: <870a7ddd-812c-b26f-5ae7-2b67d6be8b11@acm.org>
Date:   Wed, 23 Aug 2023 08:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 6/6] blk-mq-tag: fix blk_mq_queue_tag_busy_iter()
 documentation
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
 <20230823151803.926382-7-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823151803.926382-7-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 08:18, chengming.zhou@linux.dev wrote:
> The blk_mq_queue_tag_busy_iter() is only used to iterate over reqeusts
> of the specified queue, fix the documentation.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

