Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75E7CDC24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjJRMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:44:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF51798
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:44:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso10629554a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633096; x=1698237896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEU1LGbzWJlYQImQ/FQQEXA9hWg9U9vQlJ46IkPulMM=;
        b=P5ZqWimteKLPB8oar6v2qgRf0OVOpja4Eydg2ZeQYh3UJ1CNhOesssoeHIT2zEZEig
         wFAZIEPllxtsclLMi+3Brp8M2qnyWyJPKIIOkL/MeVw7rEdtYVrlWp3kpxfqQR17Z8BZ
         ygIBSJyCcNGlJoq5TVYBgCSzdt2BR4yA6ldexphF2e+GAnoCDf9ssK/QHHrw0yqiLggm
         Ll6rG2nTjEN7QLAraaLggftsn0BZWQOqJxpT2chH5bFp4B8aMYKx+AxurDkIRqjTT7Uy
         q3Ezk5S2SZ/1IG5olccy/pWqgEJwCR/8qMXjR6+SCyTLGsELTEhuwtgt3dNFzzsP2miT
         6OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633096; x=1698237896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEU1LGbzWJlYQImQ/FQQEXA9hWg9U9vQlJ46IkPulMM=;
        b=tEsnv4K02DrqG4xv5x1BI/SP7e2LdU+phC9WjEY5JS2zuLW5QLQRv3xXj+5fxGIKRd
         0TzojwZ+P4HwDikiKZ1o3CcXYOK1WkKryZmYCOdctrEBPWDPZktSeXg1Tk4KAkTFojz9
         M5gRVjifunAORalTMP93e3Uu1KW5XkKOy0OR6A1M2pKm7IlYIcpgNp57kxk8g5KOqF+A
         0O8lto4omevS4wgmyX2i5fgA8wFXvnvinF9zEZfKvWzYj7zYf43AejmbMkzHIRwuI7WY
         NZPrFZdQEivGVJAA7vuG9f4q+5eqD9BB8def/S6mM8rGxiWnhsbxGJrtiEItWq26WdLm
         0+CA==
X-Gm-Message-State: AOJu0YzadM62LuHyNEkyAX/o6kpt3Q4JEy3iSV0t5zIGO37nAk6yW33T
        dppuZ+0mecxPXg6ZVE8rsg+dT1Slp9I=
X-Google-Smtp-Source: AGHT+IEAez9HT1UAqDAySoV5yAJbIFqzJMjfsVFtgpV1VYBAlh4y4QnjWE7xYuczgUxAGxcYlWcyFA==
X-Received: by 2002:a17:907:36cd:b0:9be:fc31:8cd2 with SMTP id bj13-20020a17090736cd00b009befc318cd2mr4663212ejc.24.1697633095875;
        Wed, 18 Oct 2023 05:44:55 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906560400b009ad81554c1bsm1597719ejq.55.2023.10.18.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:44:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 14:44:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node
 memory size
Message-ID: <ZS/TRNf02Un8IOTK@gmail.com>
References: <20231017062215.171670-1-rppt@kernel.org>
 <ZS+2qqjEO5/867br@gmail.com>
 <605cc166-e731-e7d1-25d7-b6797a802e6f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605cc166-e731-e7d1-25d7-b6797a802e6f@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> > While I agree with dropping the limitation, and I agree that 
> > 9391a3f9c7f1 should have provided more of a justification, I believe a 
> > core MM fix is in order as well, for it to not crash. [ If it's fixed 
> > upstream already, please reference the relevant commit ID. ]
> 
> Agree. I posted a fixed patchset[1] before, maybe we can reconsider it. 
> :)
> 
> [1]. https://lore.kernel.org/lkml/20230215152412.13368-1-zhengqi.arch@bytedance.com/
> 
> For memoryless node, this patchset skip it and fallback to other nodes
> when build its zonelists.

Mind resubmitting that to the MM folks, with the NULL dereference crash 
mentioned prominently? Feel free to Cc: me.

Fixing hypothetical robustness problems is good, fixing specific crashes is 
better. :-)

Thanks,

	Ingo
