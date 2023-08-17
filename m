Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E461780086
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355488AbjHQWAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355445AbjHQV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:59:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB730D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:59:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6889350bc2bso284089b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692309591; x=1692914391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzX54qwoezwotLDB/QZUBGDGOziSbH7AL2U5eu8UJEQ=;
        b=BYEayeaHZ5M3Ef8HHDfuqN6ZqOfczUgel3oYQeLTC9eokF/27onD392LGlVsLFz+8I
         Zhax23ZVD5l4TY0DvpW+xfwnIbiWP5A5ju4J2UI86CJkb46yO8BdC0BS1gaRmFpiY5xR
         g9iVEa60DCC2py0jM3gjWG2R7MSe0oqmZI2aystbvXKXXKmK2c+PkzCy0OSpPoKMPJt1
         YvRxH3xUksZjOKwNzKnrnzoRhB9qgX7D74cCY5/ZzbY/ea2GmRE9o0R1YVmShkLHOnP6
         ymqio57sflT2U9dvs3Mo5Ejxdm8s7clG2BROg8E3DIn/+pyBCD3pBOfCk3JucDw11AKK
         HE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309591; x=1692914391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzX54qwoezwotLDB/QZUBGDGOziSbH7AL2U5eu8UJEQ=;
        b=cYUNW5xORPJghvUAr0fnimoVeJYw764YYj7sJh5nodqc6ofW/k8CMFZJSZoAri/+cK
         rhtDgRImOQCagxXDivJlN+KD4TblqrLLk4JE26PWQE68tb7kms4W5uSrRxtK0QvGx0+T
         jdIt0mEG1F3jS0h8hCMmvC2ZweWjXOazllJv/UT0hzqBtYnjlklppMXKt1pHRl3hMKiG
         HAaJVv/U6HH0G0UqQwAoOGveAoCzB2xYTlM0kWAaEzojaaIJjQCP5qPqWNQ9vJgqWi4g
         k3/s5ZR3XQ/5+5Cm4C5g9bx7TI4nHmGGkzdTBAOzhmJjKcotPMReQLjDZivqB8wz9Kly
         9ojA==
X-Gm-Message-State: AOJu0YzGIAV9XFMo9VSPbwBgEjlTL1bUUgH61GJ4/rOsQI7RY0ShfmSD
        bIJqspL5P/BkJ/zpMxt4fpabsoJImhU=
X-Google-Smtp-Source: AGHT+IETHNML+YEs8vckAVXvWVu6rG+kkdLU/2JfZwztvkaFBkLjML+OgOI0yXn4/d8vu0QEUeXApw==
X-Received: by 2002:a05:6a00:189c:b0:668:82fe:16f1 with SMTP id x28-20020a056a00189c00b0066882fe16f1mr1073798pfh.1.1692309590746;
        Thu, 17 Aug 2023 14:59:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78244000000b00684ca1b45b9sm233170pfn.149.2023.08.17.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:59:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 17 Aug 2023 11:59:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [BUG] KCSAN: data-race in process_one_work / process_one_work
Message-ID: <ZN6YVG114AZv9Yp8@slm.duckdns.org>
References: <6057c45f-d045-4772-db7c-3d706ada654f@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6057c45f-d045-4772-db7c-3d706ada654f@alu.unizg.hr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:24:28PM +0200, Mirsad Todorovac wrote:
> Hi,
> 
> This is your friendly bug reporter.
> 
> The environment is vanilla torvalds tree kernel on Ubuntu 22.04 LTS and on a Ryzen 7950X
> assembled box.
> 
> The kernel reports G taint "properietary module loaded", but I know of no module since
> the boot state when the status was "Not tainted".
> 
> Please find the complete dmesg output (or what's left in the ring buffer) and lshw output
> attached.
> 
> Here is the dmesg output excerpt:
> 
> [ 6849.221584] ==================================================================
> [ 6849.221607] BUG: KCSAN: data-race in process_one_work / process_one_work
> 
> [ 6849.221635] write to 0xffff9b7440151398 of 8 bytes by task 6364 on cpu 7:
> [ 6849.221647]  process_one_work+0x504/0x930
> [ 6849.221660]  worker_thread+0x311/0x7e0
> [ 6849.221673]  kthread+0x18b/0x1d0
> [ 6849.221683]  ret_from_fork+0x43/0x70
> [ 6849.221695]  ret_from_fork_asm+0x1b/0x30
> 
> [ 6849.221712] read to 0xffff9b7440151398 of 8 bytes by task 5586 on cpu 28:
> [ 6849.221724]  process_one_work+0x4e8/0x930
> [ 6849.221737]  worker_thread+0x519/0x7e0
> [ 6849.221749]  kthread+0x18b/0x1d0
> [ 6849.221759]  ret_from_fork+0x43/0x70
> [ 6849.221770]  ret_from_fork_asm+0x1b/0x30
> 
> [ 6849.221786] value changed: 0x00000000000154d0 -> 0x00000000000154d1
> 
> [ 6849.221802] Reported by Kernel Concurrency Sanitizer on:
> [ 6849.221811] CPU: 28 PID: 5586 Comm: kworker/u64:0 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
> [ 6849.221825] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [ 6849.221833] Workqueue: events_unbound wq_barrier_func
> [ 6849.221846] ==================================================================

That looks like the PENDING bit. The setting is atomic. Maybe there's a raw
read? Can you map the addresses to lines?

Thanks.

-- 
tejun
