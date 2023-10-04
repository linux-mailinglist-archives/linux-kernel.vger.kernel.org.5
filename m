Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360207B7E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbjJDLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJDLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:50:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B390;
        Wed,  4 Oct 2023 04:50:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so3790427a12.1;
        Wed, 04 Oct 2023 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696420221; x=1697025021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxFN1579U8L5KSgdpnL27QtyaBIzDdnGagI0+P77qY8=;
        b=k2wi6IpRh/En1tJ4zkWUJIec8VT3cu5hyzL7mrfS/CCEZDUTLfXSEjob1zJQ+5FiMb
         PTIPl7GsBjCIrki+eJPOMYKvWqFVwdkMouWDpfhxdG4TVdWR+6ReVkQVgEpfI5KOO+7I
         T+s0qWjHO/joQBSTz/orvVz6/3+vW/K60CgM/LWNcMGmEWl9ilLmSKBdr07d48PkcOqI
         RRRFj5yRbeyME0cy05RYyw3/o7sZZ0LHfWQKTL99GFqaoFdv9kEj/MNTrEcGUq04vFAd
         NMjVof3jhbSKhRa6BUNz0656PM93lg7NgyYHmUvDKKWlHIA/pnYyviVowegzoYHUrzwy
         kNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696420221; x=1697025021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxFN1579U8L5KSgdpnL27QtyaBIzDdnGagI0+P77qY8=;
        b=UN6ozGoZMNc8h73z14RNiVQ8moR4xbJNJC2+DulAflx05PtbiaclA2DOf9o3U5zgj3
         yw30sicaIPjhbT9tmEuehdjHzhoirtgtXYqDJ8NKQf/BqenLbnpjNNmnpsU04oB7UWwM
         5NDBVuFQUbY4HJo0Jh1mFY+JmOYMqMYr3Fqh/4TKIKGYLSvOIRERS+H5nfmAS3+ZAhJT
         pwbm+aS4Mz1USsLYUAN6T/LrR/EtJo4nfY62ByVVROJ6CGzQ/W+9lZKfTxiYDg7EHJEk
         cSAuT59pE7i78kIOw/VYI7h/nsH2RYrwSVZHbq9SUaW9AkLadsJiH7/99R9LTY/Q0Bx0
         17Ng==
X-Gm-Message-State: AOJu0YzMQzWvQmHcu1sJhXo4CJHfaWq/2QRNityZBT/MAGIIVFs+cgKe
        ivE8jadEDWCH80/cYOTE9x0yYsKchik=
X-Google-Smtp-Source: AGHT+IH5apXuLQK1NmVSu/nMv7jihtF+iBMpQpy9TiewttB72QC1moRm3RYe5K2C7tpvO3najOrPFw==
X-Received: by 2002:aa7:c508:0:b0:534:78a6:36c4 with SMTP id o8-20020aa7c508000000b0053478a636c4mr1867077edq.36.1696420221177;
        Wed, 04 Oct 2023 04:50:21 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id g24-20020a056402115800b0053629f43083sm2321095edw.57.2023.10.04.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:50:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 13:50:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/4] x86/speculation: Disable IBRS when idle
Message-ID: <ZR1RePXx6/zZueI8@gmail.com>
References: <20230727184600.26768-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727184600.26768-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> For Intel processors that need to turn on IBRS to protect against
> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
> the performance of the whole core even if only one thread is turning
> it on when running in the kernel. For user space heavy applications,
> the performance impact of occasionally turning IBRS on during syscalls
> shouldn't be significant. Unfortunately, that is not the case when the
> sibling thread is idling in the kernel. In that case, the performance
> impact can be significant.
> 
> When DPDK is running on an isolated CPU thread processing network packets
> in user space while its sibling thread is idle. The performance of the
> busy DPDK thread with IBRS on and off in the sibling idle thread are:
> 
>                                 IBRS on         IBRS off
>                                 -------         --------
>   packets/second:                  7.8M           10.4M
>   avg tsc cycles/packet:         282.26          209.86
> 
> This is a 25% performance degradation. The test system is a Intel Xeon
> 4114 CPU @ 2.20GHz.

Ok, that's a solid improvement, and the feature has no obvious
downsides, so I've applied your series to tip:sched/core with a few
edits here and there.

Thanks!

	Ingo
