Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6775785AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjHWOks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjHWOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:40:47 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4AE7A;
        Wed, 23 Aug 2023 07:40:37 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso37350375ad.2;
        Wed, 23 Aug 2023 07:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801636; x=1693406436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz0HFn8gRQglqP7ddP1+GajPwJrC4gqU13+uW397ajk=;
        b=R++LmEoBqddnjlogFohUhzT+YMPk4wuxuIVGyMYbhuA3oceEHhHDRNmef3iJxKmu1w
         A9pssB1ymmEd6cGs6x3ZTlmWrn8VZFIHWXM1AZpYZEUDxtazbGU2GieDXtb13qqT03wk
         uepya3s1VfSl2tIhb9Phlr2G0imn+rrnyTSEgN3XiohM1XM5UJAEW9jOvVFKLmPAwOmB
         3xTTQtnuieomd437VvekhsgkRDUVgmzdWmMsAMrK5rFSAxkEMNc4xHYa2jWLesYcg8QJ
         Zn9rsdlanlBe+mqKh3mjIKevIo1JejVVlqZe9GyNJ1sO3oOhFFcRQJ2qkzZdIeyVa5kW
         GBXg==
X-Gm-Message-State: AOJu0YyB6QLXu+j/lTH40YIg566qEY1Z8QOYR1Jmr9gF0o68KQBGRAgK
        LXh0oUbbK3TjXLd1xSofbes=
X-Google-Smtp-Source: AGHT+IHI6ICMDzcC43Is0P94N8ROg+ZtNc9ghqFY5rPduFeQsW//Nh85Mx5cuqrmGGgZXyC7yy5b9A==
X-Received: by 2002:a17:902:ed53:b0:1bf:5df2:8e97 with SMTP id y19-20020a170902ed5300b001bf5df28e97mr8412377plb.4.1692801636359;
        Wed, 23 Aug 2023 07:40:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ecb6:e8b9:f433:b4b4? ([2620:15c:211:201:ecb6:e8b9:f433:b4b4])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902900500b001b694140d96sm10991811plp.170.2023.08.23.07.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 07:40:35 -0700 (PDT)
Message-ID: <54f28655-fe21-67a2-eb6a-30910ac06f05@acm.org>
Date:   Wed, 23 Aug 2023 07:40:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 5/6] blk-mq-tag: fix functions documentation
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
 <20230823090441.3986631-6-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230823090441.3986631-6-chengming.zhou@linux.dev>
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

On 8/23/23 02:04, chengming.zhou@linux.dev wrote:
> There are some stale functions documentation in blk-mq-tag, since
> the prototype of busy_tag_iter_fn() has changed. Fix it as we're here.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
