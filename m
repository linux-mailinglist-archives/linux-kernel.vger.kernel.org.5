Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E007C4CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjJKILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:11:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453092;
        Wed, 11 Oct 2023 01:11:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b64b98656bso1106031966b.0;
        Wed, 11 Oct 2023 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697011910; x=1697616710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGMCBTNusP70u42LHRRik7B8Z00QtRCIGDUylj6XYAw=;
        b=LFYbXMJdLFFKofPQfcjP5sKBAQDQwxOWuYH0r2LYwIXKj4xCvBTzqnFekiKAz7hoDD
         W50CxgIR7YJZYucTb0tuADchb7pnfJ+LCuBWNuWWZWcvjU/becloK6Dr2U3jzh7uTt1K
         AQfflP+b+tPORpyuEGeYR/nSObmb0wUIgKvzjC62dqNHnj6fQ4AamTYsf+i73WcXeBQD
         Blq0QA1XYDonToqG8VkbLhIxzM6YWXTQd5sPIPzUxR17F6+3E1MTpz+2/uaimL8mZbvZ
         yvpruf1qLIjH5pMuDa8ZM5fqP3OMkeTacWpyK+93kybAViFLbk9WQVVIUJjZVQE7W6V8
         I0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011910; x=1697616710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGMCBTNusP70u42LHRRik7B8Z00QtRCIGDUylj6XYAw=;
        b=b8FbygDjUfvOvnOyCVmlY6MDL9xM1+yeaVjnBcnwKTrT8BnVwhpgFy+3qYehrOq66T
         07NK3CLcsRcrYgdwSleWEdctHL1DKhOMLchD5/dLlVYNzBI26QDuVZ68QaH2ngC2/dNQ
         4v9t5KgUQD+TGmEQKH9DKFGeog/DH3yhhCKp4rCBDZ4DWtknVlT054b6GlKxmI6Uut1t
         y7bAk7dcildidZyNZGQ80biqT3Pi9NqsNXLo3fDrJqYh7bIsY3NITDCM/Yjzd3yErK70
         TWNMjbcawYlEnDQYq9LqaPYUTl1cGeeDiGu1cWB9o3JnasF0niBbY5aCGxCqMB8VX47o
         ya7w==
X-Gm-Message-State: AOJu0YymqR3Y1g6+Hm7ZxG3agec/R+f+Kd58sun9QgBEWi/kFp3C/IJs
        vIwmOjL16iR7jAMI+7yDs8g9hzjPsaQ=
X-Google-Smtp-Source: AGHT+IFS+xbyocKw0Ozogs/0xDvDxQz/wVDmhkbPI4KM123komulCh92pmTaWVBwf0yt3SKYqf8ORw==
X-Received: by 2002:a17:906:3050:b0:9ad:df85:97ae with SMTP id d16-20020a170906305000b009addf8597aemr16960697ejd.66.1697011910095;
        Wed, 11 Oct 2023 01:11:50 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id la18-20020a170906ad9200b0099cd008c1a4sm9501500ejb.136.2023.10.11.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:11:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Oct 2023 10:11:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2] x86/alternatives: Disable KASAN in apply_alternatives()
Message-ID: <ZSZYwvHTSapAaJQv@gmail.com>
References: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
 <20231011074616.GL14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074616.GL14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> >  	DPRINTK(ALT, "alt table %px, -> %px", start, end);
> > +
> > +	/*
> > +	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
> > +	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
> > +	 * During the process, KASAN becomes confused and triggers
> 
> 	because of partial LA57 convertion ..

Not all LA57 related sites are patched yet at this point, and KASAN sees
a weird & broken mixture of LA48 and LA57 runtime semantics, right?

Ie. as far as KASAN is concerned, the LA48 -> LA57 behavioral switchover
must be atomic, but during the kernel code patching process it isn't.

Thanks,

	Ingo
