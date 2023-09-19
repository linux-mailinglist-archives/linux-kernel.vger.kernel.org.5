Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A37A5AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjISHVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjISHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:21:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B52100
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:21:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40413ccdd4cso31624455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695108099; x=1695712899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5P1Oj6tRR6D7BKHA36fLGEJKYMNcXL/MMGKc90gm/RQ=;
        b=NfxMwLBwehuRAB5aTkHADaXsk5cLXeHHbeAjUc8PKhumQAJD4vN5IetPDp5iEc1YFl
         yg2u4FzRAl0KkFoXT1RZL2wpOtyjuu9pQpWugmAKWdQhmFQIj+VYFFKiMx5eqmVXxhpI
         4yrSV30yvauLkbByDA/Lp/yhbUeoDMauVkVJmwTtuMDRicfieATT+Fdkm7JlUqSZB3Lz
         KG3pDI4InmknmrxNX6sb/b3g2lgwh9cSfKmdSG7q+dWJ5E9Xb+kCnRxgIfvVtmIlUaIY
         gzWB/GCT4Go8ijiK3CTc3bhekQMT+KFKzxUtP6TnXuDhTsENVrMRQm7MU9GeCQfXXIuK
         EAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108099; x=1695712899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P1Oj6tRR6D7BKHA36fLGEJKYMNcXL/MMGKc90gm/RQ=;
        b=kCgWU0ah+FeytxKcjzOJ8+i0Ltm52r00qCjujAfW7NSnKEK8kIgwEbEtt5smGQ2QW2
         FHX8uGK8Pb/j6KhyDSVtpn8Zs5e++vkSUpnfzpEBBX7RqXpBUVl5+tAQy33a+2yr3rij
         i+Onnrk5Oqa/NnNsHiryMuZHGCsuGwkkDLgg0uUzTZnd1SK1hB12JQVYXY8LNcIdzZk9
         DsPsMK7smEF4Dp5n1U5hDNmhxgMNK+u0wqzOYtPtQGGU+FkFDphAMR2pKkVAh7cOfksy
         YYprY4ijnNskoWW/3h2CjFwsJbMQl6gqFDZJiomgaIVoix1vMQ6y4PCUFISUypblqG0Y
         heuQ==
X-Gm-Message-State: AOJu0YzmznsHMaElXduX5X+a2uE4hxUVu7lWm+K6e6Mu7cGnZf+wwALQ
        B6TKbo83zZWlKLiVP8fujX4=
X-Google-Smtp-Source: AGHT+IHqM6AMmY3FVHS0y50CbgU2hSHyR/MaH8Pm1yvLKLKYSjZC5d3UtrNokEPpM6jdmMef1grJBA==
X-Received: by 2002:a05:600c:286:b0:404:730c:e7c1 with SMTP id 6-20020a05600c028600b00404730ce7c1mr1291132wmk.15.1695108099065;
        Tue, 19 Sep 2023 00:21:39 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c251200b003fe24df4182sm293735wma.1.2023.09.19.00.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:21:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 19 Sep 2023 09:21:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZQlL//7xWPlaykpa@gmail.com>
References: <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyyfxd4k.ffs@tglx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Additionally we have PREEMPT=FULL which utilizes every zero transition
> of preeempt_count as a potential preemption point.

Just to complete this nice new entry to Documentation/sched/: in 
PREEMPT=FULL there's also IRQ-return driven preemption of kernel-mode code, 
at almost any instruction boundary the hardware allows, in addition to the 
preemption driven by regular zero transition of preempt_count in 
syscall/kthread code.

Thanks,

	Ingo
