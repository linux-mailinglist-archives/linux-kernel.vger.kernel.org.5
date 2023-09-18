Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FCB7A5192
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjIRSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIRSF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:05:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A8FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:05:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c136ee106so642338166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695060349; x=1695665149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9he4ZTvSFJmzzOtbECfSpps3SrCLJMjInfE6GKKq3k=;
        b=bUVgWHMnkjjX89LpVYBlYAFFxi7k49SUfS7HOxtazHqfaavZYbHJ5mwmm1coywq111
         tGHfxKK31VpOn6AABTT5Xp5Q7VLKplkdPhUdm0OfncABSqD0cnfWMK9ffvYojxqAogwa
         bXHHzKnuiWMh6HMPur4X7IFW2OUut4UM6PXXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060349; x=1695665149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9he4ZTvSFJmzzOtbECfSpps3SrCLJMjInfE6GKKq3k=;
        b=gXy2vlvPQrEBOSgigzinI8HjlELuXyo2xPVLVvNktuV7HaAIgOf6W2aCIVGlKFsd3r
         MGBgUj0uE6vZnHq2NKgDh3A6KzqW4FN429oHXL0w48q+Xn4BXYlJk+lxmAZeL7obS464
         DrN4mEmgeqE4tfuWJzpoK737QbnVQSGPkpf/8QDei34dBAZ3rd+uKpDrIrp/TldqL+4p
         JXHgCbdxYi1JjzKYyTx5zprtiN6orwr2rO4+/Iil7ZHazQQ73t328i9pLfwKn0aZFOmt
         UwNBotCJzlu0BGBCM1z+TuJhhQg+g3DdYR4elYvGIWK53c5m54icLQnupwyraJ31IdHR
         L0xQ==
X-Gm-Message-State: AOJu0Ywla6KZOSZJraG8THSnHpcGZl+T7mwvzrMmc1ZC5yJ/0gMQD+dN
        N7XzlbQXPVPOwlE9Owkd7DRnYjSWvcnYqzZfVBBVUh4t
X-Google-Smtp-Source: AGHT+IEMb3qIYb5ezjAENw5Fqe3A0/ZhLdewNJUMocy9VO51dzsrO3JZxGxSQtm9mv2MaDzqiPhKNg==
X-Received: by 2002:a17:907:7714:b0:9a1:bb8f:17d0 with SMTP id kw20-20020a170907771400b009a1bb8f17d0mr9026024ejc.30.1695060348940;
        Mon, 18 Sep 2023 11:05:48 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id oq8-20020a170906cc8800b0099bc08862b6sm6919775ejb.171.2023.09.18.11.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:05:48 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso5862569a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:05:48 -0700 (PDT)
X-Received: by 2002:a05:6402:2903:b0:530:d53c:b4d with SMTP id
 ee3-20020a056402290300b00530d53c0b4dmr5507496edb.35.1695060348351; Mon, 18
 Sep 2023 11:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com> <ZQiLX0W2Tcr+wdJT@gmail.com>
In-Reply-To: <ZQiLX0W2Tcr+wdJT@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 11:05:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
Message-ID: <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Matteo Rizzo <matteorizzo@google.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 10:39, Ingo Molnar <mingo@kernel.org> wrote:
>
> What's the split of the increase in overhead due to SLAB_VIRTUAL=y, between
> user-space execution and kernel-space execution?

... and equally importantly, what about DMA?

Or what about the fixed-size slabs (aka kmalloc?) What's the point of
"never re-use the same address for a different slab", when the *same*
slab will contain different kinds of allocations anyway?

I think the whole "make it one single compile-time option" model is
completely and fundamentally broken.

                     Linus
