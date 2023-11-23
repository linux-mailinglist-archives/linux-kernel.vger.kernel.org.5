Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949137F5797
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjKWFBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKWFBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:01:18 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006010E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:01:24 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso312329a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700715684; x=1701320484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spk4X+jG9kC9sYhfHPUCxUIKzBM1WIu5NlHz5meX1cg=;
        b=W0JThL9iED7gKnTp4xpBh907xIKt13QohxFan5aPSg3ATi3bmxB+EA0kMz2Rd8jdDJ
         IZ+hA7UOeynqNMG2IcrsZwLO4OVOc9NwtaICyCxKLPwbYdD3030TcNhizukLCljigGXz
         wgesog97c9+wy97RmGT7ksNgG2QmI9uvQl4UfUg2gwVPkSpSKi+BQn+xvo5fzuJYOws0
         qahtL9EkNBAWW39DSi9nvh2TuACQbI01xEQeyEZUG6u1u0DX4w11H2ht7AYAyHCK0Xhh
         LYaqtI3aaS4iafgpXO2KdG1sUjyAuQ8UJBL4avcxwYRScrjd3twOhKoVgxKw1tdPAl2m
         ETbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700715684; x=1701320484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spk4X+jG9kC9sYhfHPUCxUIKzBM1WIu5NlHz5meX1cg=;
        b=lnxO4HNTYiJmMcsyT3R6Doz5e/h9mhw3T+UMOu+0ckTk5hs84GSWcLEX07Wjp+k9hh
         S/OkRNz0J1Ef5uEJxpCNXH4iW+kyB0m7V7oq/tE7zmZOWJdXGVh7mizGkcbRMq2voHIz
         Ky4DSVEHIswWBysbV5+msnOsfYV/UReZw2QcgmkneeMQzRCrttO9exvsMMEhLiVUqzqx
         JgPnaV9TUoINK4vWDKaJKD4ZVZu1EsJvdur0DO5D2EiGqSo+lcHJLl0P2Aj6sfL23q5/
         Om4VY3ueXAy6zeaI47wd0xm5SJt9+LBq6YUbI8wO4P6e43QrpIPyYDLmQkjt9ZtnEKpT
         pxRw==
X-Gm-Message-State: AOJu0YwHVfAwP1GIEUuQqvD0QuEDAcoBZY1ISZsbPWRj/6liZHjNLaBF
        w01dtiLF9mvU21VbdGAwQuofO9f0MwlVjA==
X-Google-Smtp-Source: AGHT+IGF/14ncgBY07t3CKeIazyBsLqW6F1xXjOteOxP8f2tdI/1QBk7AczVlfQyKbYTX3oq4t5JmQ==
X-Received: by 2002:a05:6a20:9387:b0:18b:94c5:24c2 with SMTP id x7-20020a056a20938700b0018b94c524c2mr767609pzh.60.1700715684306;
        Wed, 22 Nov 2023 21:01:24 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id r27-20020aa78b9b000000b006cb6fee548esm349832pfd.91.2023.11.22.21.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 21:01:23 -0800 (PST)
Message-ID: <ec120f27-e2de-4429-abf2-411d090e3316@gmail.com>
Date:   Thu, 23 Nov 2023 12:01:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Content-Language: en-US
To:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV6oYmVYsyYizvgg@archie.me>
 <PH7PR12MB79373516F591C102110B4251D6B9A@PH7PR12MB7937.namprd12.prod.outlook.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <PH7PR12MB79373516F591C102110B4251D6B9A@PH7PR12MB7937.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 10:06, Chun Ng wrote:
>>> Did you mean that v6.0 doesn't have this regression?
> 
> No, k-6.0 does NOT have this regression. The regression starts from k-6.1.
> 

Thanks for confirmation.

-- 
An old man doll... just what I always wanted! - Clara

