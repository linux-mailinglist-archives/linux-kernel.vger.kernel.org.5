Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE77DA0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbjJ0Sma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjJ0SmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:42:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F710D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:41:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698432094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v4xutzSKwaabZv37+vjE5gk1dVdFg168wJoFji94P1o=;
        b=YSLEysxhRWVTun9mPYxLg1ynzRLF7fV4jwD3IU3AjFssWOkgPniDTwHIFiPUaqg+m77F5P
        VGn31JrkF7TLRK1A4aZr+F2N/j93BUxuvKJGOON6wgeKkFRN7wzhJMZM5Q/sQf+ucoDqD5
        YEkyqARlOwxRjpz7E7UgkoIyei+apgGjzX3CEFoI8kS0xcENLiapBfbwg8kpZMfOv5likd
        cYvkEGVgqPKkAHE3JHhMHEFojXAoPMm6inbOBm/A2bZdy3u14cU2+SDofu92aabpi0VPur
        btpToPyjaXdstZkqrQyb4mezUO4FKg1gYSFJPp//xqWlWVW4A1MMenfbYnZDKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698432094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v4xutzSKwaabZv37+vjE5gk1dVdFg168wJoFji94P1o=;
        b=Se/oB8HvTS+E5EC0Sbokwk45mDehTFLXdxjMLikHS1QBCyuqIm07OgaBDhd9FtTWUxQuZ8
        yvg1gFGgbD27r6Bg==
To:     Brendan Jackman <jackmanb@google.com>, luto@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        laijs@linux.alibaba.com, yosryahmed@google.com, reijiw@google.com,
        oweisse@google.com, peterz@infradead.org
Subject: Re: [PATCH v2] x86/entry: Avoid redundant CR3 write on paranoid
 returns
In-Reply-To: <CA+i-1C29rULUPSKNtnnydqEh47KMhLHJw5EbLBJXo=mTvPK-xQ@mail.gmail.com>
References: <20230920150443.1789000-1-jackmanb@google.com>
 <CA+i-1C29rULUPSKNtnnydqEh47KMhLHJw5EbLBJXo=mTvPK-xQ@mail.gmail.com>
Date:   Fri, 27 Oct 2023 20:41:34 +0200
Message-ID: <8734xv3o2p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27 2023 at 14:22, Brendan Jackman wrote:

> Hi Thomas, others, any thoughts on this one?

Oops. This clearly fell through the cracks and now it's a tad late for
6.7. Let me stare at it though.

Thanks,

        tglx
