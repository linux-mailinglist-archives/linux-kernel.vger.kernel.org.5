Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B17D0B00
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376555AbjJTI7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376520AbjJTI7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:59:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CBD41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:59:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9be3b66f254so84321566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697792377; x=1698397177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzeT2I7KXF5wrth1EFsyiB8PmNqQND3ZfwJGRCIPSH8=;
        b=j/8zfEjA0l2ThfzwQCJzfSIsV8YTybT4+j90bD1jE6hHKzlvhQc+OUlnxqjP0Dcmrj
         UyX1CY34EOHnLCpdG/eS5Dz21aUYgt6RFEKz64P/hd9RXuHPXJdn7wNGNUNq9NtpG6Fd
         BZy8VIlPYd3RkHYZ8UkewfLFwHLCFlF5TxQVSk4xIakilebCVe3wt648mHOH4ONj1X+i
         iBAmpZd3zps2Xz+nn9vG3GtxKhMmI6QeNsd+STWT4mwdPxB9p+2QHO7m5ZbhrDVpUGiA
         3CsiI0ngDQX0Wl1L30Iix6qU0PNWHJbDHeg+XrniLKYvUahzWJzdm4Z0Cf8cU7K7Of4j
         1OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697792377; x=1698397177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzeT2I7KXF5wrth1EFsyiB8PmNqQND3ZfwJGRCIPSH8=;
        b=RkELGyTNeRFypYagePplHG3sjDSMARsHcbbKtEvdHD3WLexheCyBXiZ2hdrp9KH7lx
         g7fPlIOJpBWQEPG7ZeohHkxrxapPXX8k06YaUMn3tHbmoLEzNBMo3YS0Th/zjd/eMZ/E
         b679tonDFTdnycu1CLqMPB9zCSH7CNw/37iL+PR9wK5Ciwbajd0i7h/jxBc/3ClnK8y6
         XbcrVPSyizTuFabhJXjjr/t5xZs6LsRx7crC8u8F6pVwMxKomOQx5Xvi1zMqr0oruHXe
         iEwP7ThgAvND2lqFqF6Og+bzIs/2krhNipLU2ymKSAOzqRDaYAh6BVfLdgy7mqdFm8I9
         io+g==
X-Gm-Message-State: AOJu0YyNSeubcnHtnV47NyvevYvQN9fUeGIGVYKJrsfJwu1YGlEnIgNt
        Awvz/ehIR3ldwcZ2kxkMUcc=
X-Google-Smtp-Source: AGHT+IHbUAIgDmB/mPMI+dTSsWNw8h1KO9nlStFsLpeBR6x2qKVlXwlVnXT3Cc+aJlB2MPA+co6xmg==
X-Received: by 2002:a17:907:9342:b0:9be:40ba:5f1 with SMTP id bv2-20020a170907934200b009be40ba05f1mr862046ejc.60.1697792376690;
        Fri, 20 Oct 2023 01:59:36 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709062c5100b009c5c5c2c5a4sm1043079ejh.219.2023.10.20.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:59:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 10:59:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node
 memory size
Message-ID: <ZTJBdY7CLhHLeVmh@gmail.com>
References: <20231017062215.171670-1-rppt@kernel.org>
 <ZS+2qqjEO5/867br@gmail.com>
 <605cc166-e731-e7d1-25d7-b6797a802e6f@bytedance.com>
 <ZS/TRNf02Un8IOTK@gmail.com>
 <35bd1d51-35ac-3ee6-e068-f50dff7774bf@bytedance.com>
 <ZTI+aiL/eKGbem6G@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTI+aiL/eKGbem6G@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > > Mind resubmitting that to the MM folks, with the NULL dereference 
> > > crash mentioned prominently? Feel free to Cc: me.
> > 
> > OK, I will resend it if no one else objects. :)
> 
> Thanks, much appreciated - and I see Andrew already applied your two 
> fixes to -mm.
> 
> With that background I was able to apply the x86 fix as well - which can 
> be backported without the MM changes. The current commit in tip:x86/mm 
> is:
> 
>   a1e2b8b36820 ("x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size")
> 
> Which should hit v6.7 in about ~1.5 weeks, unless there's unexpected 
> problems.

Note that I haven't added a Cc: stable tag, a 17 years old bug is not 
really a regression - but I have no objections against this fix getting 
into -stable once it gains a bit more testing and hits upstream.

Thanks,

	Ingo
