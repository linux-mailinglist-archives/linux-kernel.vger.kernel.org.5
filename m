Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625B77CEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbjHOPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjHOPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:08:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD7138
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:08:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bda3d0f0f1so7026825ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692112085; x=1692716885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ardLpPzsr7Tjzv/PEhX1ISfceYOB53E6DIF1b0Xw1c=;
        b=jNIM2oyZSHeFsV5Gq9GM+l1KEzbR200w06JDFZWDa29zAbzwbhXw0BbdFYLwaJUBR1
         GYvRy88tlJ8Pdk+wbZaj0tynSi5JocEQdUkC/iBWwQA3GXX2GuHSS2dA2dP0+yl+tCz3
         DGrLFm/H6Tzc7CvWDiJaHYe6rmNNhbls3EhGLAuUX19XeGHQXexfEYyqgcN4ZoTmYtJo
         RRwnzr6uAENPbmfQS0kNdCGj/p+Md8UeQU6f9mM4OvkKgT5eQQIAVwOEPMDarf6MK4At
         AE0dL0O/VEJvu0Izd+l+uDe4YLI7gM8Qy0KWwuLbAXwe7rS9CCxDlYPcjBi1RdDToPFo
         FSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112085; x=1692716885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ardLpPzsr7Tjzv/PEhX1ISfceYOB53E6DIF1b0Xw1c=;
        b=jNDZC0U3FT5Pi/caPDxKPvFHD5eaUSqO6ZsO3uY+5RzDfCwSGd6OLG9WOu5JrBEyJK
         xnw/sosxr+7wxBuSiU3di04eYqa8eTBiVSgVUvTAl3IvVWzBgDv4CRQRSyN72buj6/1S
         V1lBN4kA8l1lVVfiSIdUQOqGyyfDhjJyP2QlUDnpWjBhnPpmr21qORxPm6om8/k447Y/
         GEBIgqPNg+06nmMRKHWhKr4hMWY0Pi46CbQMzuPO4/zh2j3DrkK971h85+83V6IfUAQC
         RHcvhnm0Ya3VAYNhqNJSe9STnaggkFhd91wo3ZMOwTddUC4ZQn4t+YX5m9lC6cqf1Fvy
         P/Sg==
X-Gm-Message-State: AOJu0YzeMBGtnR4Dzu/bzEI40J2IFYyV8Wl8PJvfiAygpi8yiDgR95Pd
        JhYR0/7DlxQz3ReFg/Jo4SEUhQ==
X-Google-Smtp-Source: AGHT+IEnuBktlNYwmu21Ts876LBoTJvo25LkSGJ5bY01k3c183yzSE8VYGkQfy1CjhNK7/Fj9wKy7Q==
X-Received: by 2002:a17:903:190:b0:1b8:35fa:cdcc with SMTP id z16-20020a170903019000b001b835facdccmr15244448plg.5.1692112084669;
        Tue, 15 Aug 2023 08:08:04 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001bdeb6bdfbasm3228746plj.241.2023.08.15.08.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 08:08:03 -0700 (PDT)
Message-ID: <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk>
Date:   Tue, 15 Aug 2023 09:08:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "song@kernel.org" <song@kernel.org>
References: <20230815091931.4dd2b277@canb.auug.org.au>
 <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 9:21 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2023/08/15 7:19, Stephen Rothwell ??:
>> Hi all,
>>
>> In commit
>>
>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()")
>>
>> Fixes tag
>>
>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
>>
>> has these problem(s):
>>
>>    - Target SHA1 does not exist
> 
> Sorry about this, the commit was picked from previous md-next branch,
> and I didn't know that it will change...

It's most likely not your fault, I'm guessing Song rebased that branch
and this is why the sha changed. Song?

> Is there any way that I can fix this ?

Only way to fix this is if I rewind my branch and Song updates his
branch to not have this issue, and then sends a new pull request.

-- 
Jens Axboe

