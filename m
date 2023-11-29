Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A427FD252
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjK2JWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2JWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:22:04 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABCC120
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:22:10 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40b36e721fcso2874795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249729; x=1701854529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dwwehw4d9HyccGS0nN0GlCOx2n1TT0gBIUWGwguXPUlIiXehjqniHyTY1aH9o4dfIL
         og9G5iS7fR7289qdf/bwLjc7qLj7vTOT8zw/Ln++d44l28ANluznABEGjYnWFp+G1t5s
         tH+2YmPCFSWX0Gec+nSWjHm/uR6hHu8/OA+nJUI+FnYZa+vF/75Z53pZ9ZHyqozEaU1w
         ywoSysBepQuhO24RhpOklLWIizMOA8jhsZQ8cMlX0O2vsBH8T1I0Z49WRuBbbwcRWwI5
         WGF3g4jx+uUNq+ok4cZDQXHXalyb2aEer3rTTYdBn2LFnWWzodEj5r0iokH4EHm1t/wt
         OCAw==
X-Gm-Message-State: AOJu0YzivniXrD0WdsKgnYioo8onLPd4AvUhMKb18u5uFV0ue1LOMVHd
        d7gkYX3h/CjmUB75ktxJO3s=
X-Google-Smtp-Source: AGHT+IF2352qk2ABKk7cSBNYQBLl0iLKZzpsQO6+jTsB/d7H2BYz82b+J0FuuZt2jmiK/PjCZGTARg==
X-Received: by 2002:a05:600c:3d8b:b0:40b:3d6d:e46b with SMTP id bi11-20020a05600c3d8b00b0040b3d6de46bmr10683872wmb.4.1701249729052;
        Wed, 29 Nov 2023 01:22:09 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b0040b360cc65csm1524542wmq.0.2023.11.29.01.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:22:08 -0800 (PST)
Message-ID: <4a688846-fd5c-4b36-8ccf-634fbcfe5567@grimberg.me>
Date:   Wed, 29 Nov 2023 11:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     error27@gmail.com, gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231128122958.2235-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
