Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8B79D161
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjILMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjILMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:51:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F4C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:51:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401da71b7faso65122715e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694523074; x=1695127874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtE5SqeRAkjnVLGTAauDng5h1JtSEgXI0EncMf+8cQA=;
        b=JAv1Nh70wVe4pTkOwm0NR0qRheLQ/9XZqYDEtrUHYv7Mu8rKF3q8SvShOFli8AQXuL
         EYvRpgxZYwn3/ET3w39lH1OV6CGwxkSsaWI6ZeBE1MwqzsFnw/y003akOjUnNbq++JfE
         CHvMHFrTLrwJuwQBhhIM2nizv+rYc/w9pyDAE6GbfFAzy2YQ8GHki3oVALap3jgglTY6
         owKV9ZqmeP0EDrkXRoRzPb3OfzrsRXZvKVVFFOmo1EzxHmbrAHLF83cTZtRHZi4Qk04i
         zvmJtqrh8zUZU4EoWyroFxZR6fTRQ0ABdf4zScczh1Ok9NtKmFUr177PVW34Q0dWUza8
         oJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523074; x=1695127874;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtE5SqeRAkjnVLGTAauDng5h1JtSEgXI0EncMf+8cQA=;
        b=OYEUYh2uLRHbwkAzX6dJBnQxzKaI3w9UVD810HeJ9wdNtPc8PPYM2Zd/Wwy8JIgMon
         3C7h2IeEet+fu6Xp3oOfZUSK2o76ADFsEMLiNbaMB2bdaiJtWlAxdknxBB17/xnfPFEx
         V8k1c7MGbdRIqo53RaITgKEbS5NTLt2UZDwV1hfGpkumCzMEJJwbK90z7Gy4M9Vn8CN4
         AM5HJuxqWpdzI/e1FXH6AZpTsqsfgIvqdYwnzHVEBGnj1uwPhiKVdrA6FTdX2rkQwyWj
         mOaRoGCAlHhQDVzTWWmcqTrYAWizYH/5iLdIs74ruaV+yebRQoMVL2KzN3zNzjh6Sf3U
         QWGQ==
X-Gm-Message-State: AOJu0YzBUBEeV4wGNqjJ1xU8DYC2XWelv7HsY49HZ/0WKq0X9a1m14y+
        EKH+fLFN6piRTlYvScfIvXUUXA==
X-Google-Smtp-Source: AGHT+IG5zXMp0p5F/VqAfNrlJTFHFU2pEwZ2AEDv4ya1S044swD/nc1UErl8GE2XXNzK6Xyx/DcIYg==
X-Received: by 2002:a05:600c:ac4:b0:3fa:77ed:9894 with SMTP id c4-20020a05600c0ac400b003fa77ed9894mr11006744wmr.7.1694523074501;
        Tue, 12 Sep 2023 05:51:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:50fd:9518:7cfb:dc7e? ([2a02:578:8593:1200:50fd:9518:7cfb:dc7e])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bca46000000b00401dc20a070sm15919280wml.43.2023.09.12.05.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:51:14 -0700 (PDT)
Message-ID: <20c53c92-5f70-4471-bd4d-0cf001f1bf16@tessares.net>
Date:   Tue, 12 Sep 2023 14:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Remove duplicate worqueue attributes
 allocation
Content-Language: en-GB, fr-BE
To:     Catalin Marinas <catalin.marinas@arm.com>, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, dhavale@google.com
References: <20230906173904.475722-1-catalin.marinas@arm.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230906173904.475722-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 06/09/2023 19:39, Catalin Marinas wrote:
> Commit 84193c07105c ("workqueue: Generalize unbound CPU pods")
> inadvertently introduced another call to alloc_workqueue_attrs()
> overriding the pointer returned by a previous alloc_workqueue_attrs() a
> few lines up in workqueue_init_early(). This leads to a kmemleak report:
> 
> unreferenced object 0xffff000040015000 (size 96):
>   comm "swapper/0", pid 0, jiffies 4294892296 (age 163.956s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000004cec0d50>] __kmem_cache_alloc_node+0x1c4/0x288
>     [<0000000083361c2a>] kmalloc_trace+0x20/0x2c
>     [<000000005ca61f11>] workqueue_init_early+0xe4/0x538
>     [<000000004e6ea358>] start_kernel+0x23c/0x5ec
>     [<00000000aea9761e>] __primary_switched+0xbc/0xc4
> 
> Remove the first allocation.

Thank you for having shared this patch!

We had the same issue when validating MPTCP tree and your patch fixes
the problem on our side:

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
