Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74567782992
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHUMxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjHUMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:53:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9CB1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:53:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso578808b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692622418; x=1693227218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FGj7cgUeosSqTN/BBHBDpq4ZyUn/x93LQfy/ClJCFOc=;
        b=kyWX9hSLpAVOja1750OXW/QVKio4MmIVBBfRwhH6n/n9t+blozapD0mxyh02Dn7QWy
         U8B3x0hIcNQPaIOb69glmycvy9xsWk5i00uLFy3iAwWUsoCWOM/6rEmHPj/y2vPT3IR8
         43ZBusyxagmEdEWUZD7G3j1U+bUd31oBHxMETewPTlwhl4eZnvmgRfsNVeX7sZ24MDKS
         ZnAG0p/YCbCuOaQSWJFFKGXrwVU7FNSjkFB2/NsY6gya2dfvDjceZavWXbm3GGpoiUKT
         o1MCjctSze9XfjOwEWS5DFwWEZVNCzoJsJ2sMBiJ5QIwrVVxIfso+zQoUd/kQzexbAgl
         6YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622418; x=1693227218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGj7cgUeosSqTN/BBHBDpq4ZyUn/x93LQfy/ClJCFOc=;
        b=UkYy0RoB15mUYyoG9AJN5qlnVNEe6GpDx5ec7UnO0OT/H/dI04qsAygi0dbvf28iYc
         YoT+HkDmW8CPB/pcPY6czpjgdTFGTRR3pKxJ+C/1e6WB9Egobb4Yo0kkbdFOTX5DAAf1
         C+aujO/wBKV0US2cKqsrt1FtKSxdwYq9s9OrfHKf0/BLTSfOVf3T/x7C+6LNXiFThjNS
         yhYyKS0qk/GEuw9qpGq6vrvdZcaUoQ8cfNGVbhKKEsFdcy5obCwzCHZzynwwgJMBLs3N
         KI2Z+ArQbEWcWXHykd/hg65ZWUolWFJLi7aAuE/YwexWmzDcGjBiu9kVrSBifo+rbgBI
         8XSA==
X-Gm-Message-State: AOJu0YzoKalo71n5JI+6ci0exDWWARDfNQE9YMTwqIspAeymaFLzlgtv
        fI10ytbba27Hx/A7SjikIXnGnUTvRW5lxTwiTHs4Qe1J
X-Google-Smtp-Source: AGHT+IGe4iVmkOrwuPWAugYbuiVpJRW6VeHjDTj1eIWYsr7cFWnlIOuVBua0w1tuWmu3DBw6edBQmQ==
X-Received: by 2002:a05:6a20:96ce:b0:131:f3a:4020 with SMTP id hq14-20020a056a2096ce00b001310f3a4020mr3477088pzc.33.1692622418516;
        Mon, 21 Aug 2023 05:53:38 -0700 (PDT)
Received: from leoy-huanghe.lan ([94.177.131.100])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001b83dc8649dsm6942852plh.250.2023.08.21.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:53:38 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:53:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Gang Li <gang.li@linux.dev>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Message-ID: <20230821125322.GB57731@leoy-huanghe.lan>
References: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
 <20230819162526.GA274478@leoy-huanghe.lan>
 <f7eac106-abe4-aba1-14df-6c9d1bfdf3b3@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7eac106-abe4-aba1-14df-6c9d1bfdf3b3@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:39:15PM +0800, Gang Li wrote:
> Thanks for your review!
> 
> Your suggestions will be integrated into the next version(v2).
> 
> On 2023/8/20 00:25, Leo Yan wrote:
> > > +		|       |   :   |        |   :   |       |
> > > +		|       |   :   |        |   :   |       |
> > > +		| CPU 1 |<----->|  内存  |<----->| CPU 2 |
> > 
> > Unalignment caused by extra space around "内存".
> > 
> If using Chinese, it is impossible to align properly no matter
> how it is modified. If strict alignment is needed, the text in the
> charts should not be translated.

In my editor (vim), a Chinese character is two-width of English
character.  So you could see in above, I can simply remove a space for
alignment.

Anyway, if you have different editor or configuration, using either
langauge is fine for me.

Please expect I will have more review.

Thanks,
Leo
