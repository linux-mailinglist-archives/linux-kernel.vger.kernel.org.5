Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FAB7BB617
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJFLN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjJFLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:13:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEAC5;
        Fri,  6 Oct 2023 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m9x5nJSGtvj8tMev8JZazalIgNXz+AIBAzfKnXkiukE=; b=eO5l1wlyUK/PSvaB33v2nCr752
        TZuPgp2rd9VTwb32Ta3sRBOindm1vxOvNLzp+NaoIXBMt94DwPDNF/JM0uU4NwBAU/3v+QAybe57w
        ctjlLl3lqL6dUC0YO/vTB0JIiOGlU80JnuLH+Y6yRpazyAl+nHRE4GkRuK0M90Qd1UdtNwoYoQ9vd
        8zhE0siUrwibVj1uGf75hs4i1v77n3hMvOoM3bHaO4jHGNwRSLAxpsQ83W2/0u8pTl7n4l4epE5GZ
        mthOTNQDz8sRFbqIsutcjlnSkPmBVP0CcZCqbKzsEStH3ql1XUzCcO4U0NwZFKcjUV3THoFskVs4/
        SAV5+GXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoimD-00CZfS-0v;
        Fri, 06 Oct 2023 11:13:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E55A300392; Fri,  6 Oct 2023 13:13:50 +0200 (CEST)
Date:   Fri, 6 Oct 2023 13:13:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate
 ABI defines
Message-ID: <20231006111349.GE36277@noisy.programming.kicks-ass.net>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
 <20231006104325.GC36277@noisy.programming.kicks-ass.net>
 <ZR/oKYY7R52wKYC5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR/oKYY7R52wKYC5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:57:45PM +0200, Ingo Molnar wrote:

> Hm, I did this after applying the patch, and it does work,
> but maybe I missed that those definitions were picked up
> from system headers...

Use an older distro :-) Or apply the FUTEX2 patches and remove the extra
definitions I did there.
