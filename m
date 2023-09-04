Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE828791D79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjIDTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjIDTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:08:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256DACC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:08:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so18026055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693854488; x=1694459288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZYSHviYpzCs6UjibmT2X1y7LXAJYkLI7ZZRbnsdbz0=;
        b=MTRkYVVlo6a+8Jw9nFqs2nejnsdRtdN0APVU7vyaw+IGv7zKEZMtjtxzygkjQYqR1L
         wMu+4e6VVfM8hjRvgfUOW/R3ygiE6tU46xZMKYeqMJ3Ri654N6A3lNQ4L/E9EZ8qDqLq
         TvHjVx6PPpyL/5aoWC3m2QRtQQZ9szjJFgX74V3XC47ezds+fuuf3ai00Ja1q5TJ9tBs
         upaMhuE5aYohrSPMTL8hcZh+EIBenliMG/Fa/yNxKyBZ+iST4oJvmxlG54lZA9Ji3KOx
         0ZWdAoH+6/ygHg+NpbVu5A++DeopCTLwSxwZzFxoAQiZkBTVRJiDteC8b/d/5zrMifkj
         Klrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693854488; x=1694459288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZYSHviYpzCs6UjibmT2X1y7LXAJYkLI7ZZRbnsdbz0=;
        b=CxlSW4PYbQb06/rUumrizTsod3FXTeDPZ6x2POda81F1R+jTOkNfTFLmuPf4aF8Y0C
         KRdv9VH+1lxSsPfq6cJ4/eo9b5007Rs1HJCGkFhIT0tbZOKX9Q+/anTYrCkCte+MRSjl
         JFwrWZZYozo3Y0+XVTBpWJ5mNY1ojaraVMV22WNuVJF43H1Gb0kc+VzA3dTHhcK1Went
         tEwL5bGsVuKUAMrwuk9Q18mfWU9Ob5MYs1krjjoetbP0B8oyrPuJCxQNcuXDbRwgx3HC
         ZVEc8+I7UCkee92iS2YfbGLZ4tqg5sfO1kfcWKzuJEaiP8W+HWfD2Ncc5FuwjheNeXaC
         y2cA==
X-Gm-Message-State: AOJu0YwxGv5KNv7Ru9mTjXVwTaUyPuXF1dtZgAFbUreFGKa6gyxp3aU2
        1wVXaudWMSmb1SM4UHHXrAHvVAGtklQ=
X-Google-Smtp-Source: AGHT+IEApWArVfqoG+K1hcNFwRs2sUG5V2Io247JvFa9nppI0eAo+BlzDplrE98u/anVGovU2j6Y6w==
X-Received: by 2002:a05:600c:2308:b0:401:73b2:f03d with SMTP id 8-20020a05600c230800b0040173b2f03dmr7588885wmo.0.1693854488203;
        Mon, 04 Sep 2023 12:08:08 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b00401d6c0505csm14749969wmm.47.2023.09.04.12.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:08:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 4 Sep 2023 21:08:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Message-ID: <ZPYrFeAzWjESRiJD@gmail.com>
References: <49c7163433999cc1fc9367311fbe6c6d5fd9f251.1693693823.git.mirq-linux@rere.qmqm.pl>
 <20230904131853.GA12042@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904131853.GA12042@noisy.programming.kicks-ass.net>
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

> On Sun, Sep 03, 2023 at 12:33:19AM +0200, Michał Mirosław wrote:
> > use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
> > use_ww_ctx was true but ww_ctx == NULL leads to the same
> > __mutex_add_waiter() call via __ww_mutex_add_waiter().
> > 
> > Since now __ww_mutex_add_waiter() is called only with ww_ctx != NULL
> > (from both regular and PREEMPT_RT implementations), remove the
> > branch there.
> > 
> 
> There were compilers that failed to constant propagate the ww_ctx==NULL 
> thing properly and generated crap code, the use_ww_ctx thing fixed that.
> 
> I can't remember which compilers that were (my brain is saying <gcc-6 or 
> something, but I could be totally wrong) and if we still care about 
> people using them (probably not).

The changelog of the patch should probably include before/after generated 
code comparison & analysis - or at minimum a '/bin/size' comparison to 
quantify the changes to generated code.

Thanks,

	Ingo
