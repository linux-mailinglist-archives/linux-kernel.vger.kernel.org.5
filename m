Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE778FFFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbjIAPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjIAPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:34:52 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369B10D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:34:49 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760dff4b701so19023139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693582489; x=1694187289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy/OYZjEThy9PnU+XOs2FP+vp54WWzeQiLbmJLp6KHo=;
        b=WMM5Dm+dpqvkniH36mPBdC5cKYoQYOv5kqETdgLNo3TWgfDXy5heLNkb9nWDOcKISk
         7jbCL9rHdODSXn59qT/013M3hg5LaAGhImFpRu0AfvlIkl9Hqjsx1OS5pMcsZVJAfbCE
         EDO9AD25m68BIPES3gppr0wdgEPxLpt5j6q3uL20yhuGja2lsgyhhVltgNe/uiSfjROr
         hg0TWvEMYjJ0aAHJ8+MQmW+dA5yPZkogcxLMZrHxjD8D3floAXp6OHCEjnBURLWbsfUF
         PMe5m7lsA63Hkp/5OaA5ajNvgaaG9ujsM1C1z47YPrCbbuF8hcSOzFV0chKZYIaESl7S
         FPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582489; x=1694187289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy/OYZjEThy9PnU+XOs2FP+vp54WWzeQiLbmJLp6KHo=;
        b=gCDmLSkJ3w2ah+/MhxG8/WiBp2eEFTHjhXBWGCRKdAgr0kR0nhWkZGZMDzxPX/FwS5
         ZzMuSqFvf6YFXNzS12dD8V9Rr+4bLh6PstMsC8xYRnSndQA0fsgic5wjaLMTCGPotb4O
         FW4aOqzzbes0s6DgaiUpCQ9jn+gEKtY2UenguOrrVe84eUoycJgeRPX1GSaqT0ZKqSBm
         yWlJMLDMx//9h1WfMYdKZL+i9Zvt1At8sERnvL3lScJ7kaV/2sDi82cnYXphKOLcyWg5
         3AiUjQ2k9VQGPuFMYXr0H4qsb2xNvrKt1tP26h0hlHamL0NDQXz4X05+9HHLAISLPt3+
         l97g==
X-Gm-Message-State: AOJu0Yx7WhxRtt+YjY4nRPJxFHpzGnTF//n6+EdR4xquogxFBGmlltmd
        TRzhe+YwHQ44ehi8RS7pFKtTHA==
X-Google-Smtp-Source: AGHT+IE25sW9iNQNVMCxEyOy37iHO5xdtl+9ffputSUWi9pZwG7+OF/RT+RNDdNOXuIZcLLsJ4GQow==
X-Received: by 2002:a6b:1495:0:b0:790:958e:a667 with SMTP id 143-20020a6b1495000000b00790958ea667mr2898469iou.2.1693582488777;
        Fri, 01 Sep 2023 08:34:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c16-20020a5ea910000000b0079263d9b6a8sm1113234iod.11.2023.09.01.08.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:34:48 -0700 (PDT)
Message-ID: <3969ed5a-b422-4b27-bff4-1db38d9d238b@kernel.dk>
Date:   Fri, 1 Sep 2023 09:34:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] lib/group_cpus.c: avoid to acquire cpu hotplug lock in
 group_cpus_evenly
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230831093754.2322955-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230831093754.2322955-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 3:37 AM, Ming Lei wrote:
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
> 
> Then dead lock is caused:
> 
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
> 
> 2) error handler is waiting for CPU hotplug lock
> 
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
> 
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.
> 
> Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

