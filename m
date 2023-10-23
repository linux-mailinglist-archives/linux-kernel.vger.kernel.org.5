Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECF7D2E47
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjJWJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjJWJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:29:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A181DF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:29:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9be02fcf268so445925466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698053390; x=1698658190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzbc4eG/qaPCBJHuI4nQtGU/B0+uO8x8gO5710LAtH8=;
        b=nBiXPsSMCaZ2voSGuAEWWxKq3kBAORTSVz/0Gs6Jp8vwLpaxCuE8quSiAQdpJp/r1N
         kAxblmoSMU+AhXri+lvSPZSfQ58/uMZnFL6vBnCG9arW8BRDAMtsjTITBFxzu3Mtg8hw
         O5H9t/YkJOr7vbD+MyBOQg8UUjCzmgyxtlLhmDFIXjjAAZ6Fm19UVIlafwENUqSjD5YA
         AozHGEelvf02LRBi0kGrPM7ixRR7G+Oj6n6QvejvDwhRtGQOeGbm2+qcwAosXTCJZXtW
         jkJ+nAx8+usGKCExN0UCK6nkYk+Z42YfiB3bDO7RktXl2ZzWGpEdLSVFZMBBfMguAJel
         Nirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698053390; x=1698658190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzbc4eG/qaPCBJHuI4nQtGU/B0+uO8x8gO5710LAtH8=;
        b=d3/xY5AgOec1tY6LhCWYzmFKlscGBfzHHaWFFwxfirQyQNXyZq7DSC5ht9DG0ha4//
         xpOQSRu+wsZvC4gVVPXscZKo7X56XuxI+bK1ZWk/0PcAwBiNt4hb/6g3+yuLuXgeUGVA
         UrDWWnxmXnb9/tVbiyWQtmESNJ4osT+CnXyGI0lllqTX/Zeq6sHmzWIc5BwXqBLCNi+m
         CYIVNEYKh4d1pcurn/r+j1+SBTTNCRccQ3ZAhaynhFj1BSAzWLRe6rixFCGdHscuwzOE
         SZeLVVK73dNVKp1YyQeoXxJvkdbSVh6TkAz31ku5OWeMOKWVMjctX6kQEWaylQzDr8Tz
         G78A==
X-Gm-Message-State: AOJu0YwtyProdik9TEF8rcF3Lc/1g1qMdbPuUPdwFM1X2yJLgBC8D1zO
        6OwZb8QDPLnTrqXdAb1CmPU=
X-Google-Smtp-Source: AGHT+IEpDHw8u9vN5Rzjc5p2gZjpF56+46kjAfnGbqdWwkm4Ir/NzPGqpl569RbIIIpZpikSIw6FtQ==
X-Received: by 2002:a17:906:fe4a:b0:9c3:b3cb:29b2 with SMTP id wz10-20020a170906fe4a00b009c3b3cb29b2mr7225450ejb.42.1698053389767;
        Mon, 23 Oct 2023 02:29:49 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709062b0700b009932337747esm6206196ejg.86.2023.10.23.02.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:29:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 23 Oct 2023 11:29:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH -tip v2] x86/percpu: Introduce const-qualified
 const_pcpu_hot
Message-ID: <ZTY9CvT0B1a1M+Tk@gmail.com>
References: <20231021143739.843941-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021143739.843941-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

>  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
>  
> +/* const-qualified alias to pcpu_hot, aliased by linker. */
> +DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> +			const_pcpu_hot);

I added the fix below - just like pcpu_hot, const_pcpu_hot needs to be 
exported too, as it's (indirectly) used by various kernel modules.

Thanks,

	Ingo

---
 arch/x86/kernel/cpu/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6b848d..4cc0ab0dfbb5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2051,6 +2051,7 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
+EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
