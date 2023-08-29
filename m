Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3278C391
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjH2LrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjH2LrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:47:23 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A328A109
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:47:18 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3159b524c56so219059f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309637; x=1693914437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnBRLlrjJm65dKWmzfp0myrxXxwEj3XstWIqKRwvXTQ=;
        b=Vhe09xZYqTGEmgUvOjOoEmzhjzIdDsd4cPo3hBE1KQ9jsINFgsfb/vU4s5GUH0c4qt
         /8u+WAx/MY8z1LStTe70vXtiLzY/ikuJdGjXSJiWRecL2NZL9w6BJm6YQ8qLmQYhW3dW
         4NPvtS/PLVOsr9hnY1rNbZy5smF/oMMTnZgVfIC9br18NzZ80eTalwO7k2pR5/4Lvzi0
         Txr633ejjTZOxdmFK2lCb4NF9iMWU9XNWzKy1gE/YZ6E+qnq1m8Pq223ERDF5sEaoSue
         GpwZztSbUQy8qxqVck0UdJkzA0litywr+mjXbTJx3Egb1KTRPEoggivn8ydzNY3suPcN
         Pvjw==
X-Gm-Message-State: AOJu0Yy9RY5/PZNleXLFdBX95Zq0g/Q8XcN7qHP+0i9JQtwfwInBXVkm
        ph4oDfp7o0nQaolLaRTjViw=
X-Google-Smtp-Source: AGHT+IFcIjreaBHVB78N+1oJoKt7GAcxh2dsQ9uagonFQatQi8ZL8hckUUUre/MBZrryPL8M9OYrKw==
X-Received: by 2002:adf:fc42:0:b0:31a:e29f:5eab with SMTP id e2-20020adffc42000000b0031ae29f5eabmr19677721wrs.7.1693309636564;
        Tue, 29 Aug 2023 04:47:16 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d46cf000000b0031762e89f94sm13429070wrs.117.2023.08.29.04.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:47:15 -0700 (PDT)
Message-ID: <34c159dc-c534-2329-4049-7e9e8a53cd4d@grimberg.me>
Date:   Tue, 29 Aug 2023 14:47:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not nvme-tcp specific.
prefix should be "nvme-auth: ..."

I'm assuming that this passes blktests?

Nonetheless looks fine to me.
