Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37746810880
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378353AbjLMC5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjLMC5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:57:50 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA2AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:57:33 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b88f2a37deso5056952b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702436253; x=1703041053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLWQ3Y/puZnM0632pjGmh7GqZF/HieDMjCcRFXmLY5k=;
        b=HofIe5qKl4v98zQHESb1qxpclD0jMWx6XEL7RjPQveBnpRuN0BDYvS7AkKfi209id4
         EJYLvdI6+034P4GCuzZcSsy7sw36xAN4/lQrwLwBKjpGTaBZNByi/eLpIUr6iz1lDfHh
         FyGVd94Y4DxmIPoFXAwLV2/lq+nZjEgyoQoQYF5U1AUpwWHJIAGlwg0A66Hrn5UGhsS8
         i/gynsyE5nE1xEkhgXXT5wXgq/NjgXXIiiYAZTU/B+UsdaNa8ssUiMLCj18b/CqbHuke
         4gtUjzq96NelBVLpizPWe3OK/vYwuYf/sbtPtzBq1plcAuNX449cQMmn2gzaEyAG2iy6
         nV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702436253; x=1703041053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLWQ3Y/puZnM0632pjGmh7GqZF/HieDMjCcRFXmLY5k=;
        b=BJ/xQ5IM2BKczl3rLSwLwhH5UGo8f1WxTwXMrzgrosdpoFPAjkItvo0cpy+MLvd81a
         igUtPY58dkyig/hLI1/vMKU+JnhRW/eQLeu3dWHK0IVEscwDTNCzAb7X6xVdz0bY68ER
         cyVBcyZ2QH7i+xQbW/OIKgdIG/JEmaW1txebRhnCloqn5560jR+zQSvXA42CJjkpLaCn
         JpMOwc7U3K0HInDZSNOUY5ez6iBuq4Tb7ony4AU0iBDz6aryVitHwqo/tpF8p0x+U2Ha
         ZJXCQrpv6CBKbqEA2O3AeBWnbPU1UEnN9RfdUKeuDclBKNqSAyZxHjESXPPYvNXUURHW
         nJ+A==
X-Gm-Message-State: AOJu0YyAY2236UfYYSPZiktZI2CNbOU2y7qIptJ2Vp7L0krSeW1qRtOa
        R0tVOz03FPGUgg5+bM5SpSRePA==
X-Google-Smtp-Source: AGHT+IEmkUbxSzpAz7MuEqoDgiRYykwXuYHAFRa816gEyRibtPZ1yK1RdGQq9t/8rodmc6Zejh4FOQ==
X-Received: by 2002:a05:6808:140d:b0:3b8:4125:c1e with SMTP id w13-20020a056808140d00b003b841250c1emr8582165oiv.31.1702436252893;
        Tue, 12 Dec 2023 18:57:32 -0800 (PST)
Received: from [10.254.248.243] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006ce4c7ba448sm8851643pff.25.2023.12.12.18.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 18:57:32 -0800 (PST)
Message-ID: <74bb08ba-25c8-4aca-af04-18a45208bdad@bytedance.com>
Date:   Wed, 13 Dec 2023 10:57:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
Content-Language: en-US
To:     Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc:     Chris Li <chriscli@google.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
 <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
 <CAF8kJuMegmMD3+YZfvsW3h1y1z1-kH7SiyJHPVnrSc89OZASuA@mail.gmail.com>
 <77d628dc-ab8c-4d8c-bc63-7e4518ea92d7@bytedance.com>
 <CAJD7tkZCxwDpNm-jQv_ieDvYhrtvMTXXjRp9_dQW3_VqYgUUsw@mail.gmail.com>
 <CAKEwX=PfRNLL_t5q8vfEKA_rxgFcAer=9EFwLWDo9kDsmroAGw@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=PfRNLL_t5q8vfEKA_rxgFcAer=9EFwLWDo9kDsmroAGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/13 07:33, Nhat Pham wrote:
> On Tue, Dec 12, 2023 at 3:27 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> Let's split the rbtree breakdown into a separate series. This series
>> has irrelevant (and very nice) cleanups and optimizations, let's get
>> them separately and defer the rbtree breakdown part until we get data

Ok, will split and just send the cleanups/optimizations with dstmem reuse.

>> about the xarray implementation. Perhaps the tree breakdown is not
>> needed as much with an xarray, or at the very least the implementation
>> would look different on top of an xarray.

Yeah, will retest on the xarray version of Chris, the implementation is
easy anyway.

> 
> Actually, kinda agree - I quite like the cleanup/optimization done
> w.r.t dstmem reuse :)

Thanks!
