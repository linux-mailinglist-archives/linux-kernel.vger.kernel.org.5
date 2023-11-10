Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC237E829B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbjKJTV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346281AbjKJTVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:21:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F7F6499
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3KBKlPyabAb1VEzc2t5jFegmWW4HSqoV+YjAWnqQuYo=; b=VdnVK/QgB+5+J7r60l5LLiQODr
        5UIA//Y4Wj/FJmCWQsVOoILZc/TaeXSXIRi874nAc7aDopqKHjIc5dJIIMJNLAxGuq6fwd/fbQNSP
        quXtriotsil62i491P9pmbII5y6kVJwRqJD/EaQjLS7FCjQs7LSh/TieWlOUYeS6Qni0ZXPHmaHEU
        OuEk0PcVOvTQlQrqw6ol9fsWpzIUVjtlWpOJRv+QlrwSydVpNvFM7dUqyo5FFuAEjHjFv9Nx5r673
        iIVywEsncBeeTtgUZW9gMO/ywBOwlBHUrg5ZKNa7eBLivTFvzmRlGitlGXTfHiTGpqOlJyoBjtpM5
        0mT9cZ5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1Wyv-00F9Kb-BA; Fri, 10 Nov 2023 19:15:53 +0000
Date:   Fri, 10 Nov 2023 19:15:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Omkar Wagle <ov.wagle@gmail.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmemleak: Remove security and coding style warning
Message-ID: <ZU6BaXqlPtgq9uA1@casper.infradead.org>
References: <20231110191102.2029-1-ov.wagle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110191102.2029-1-ov.wagle@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:11:02AM -0800, Omkar Wagle wrote:
> Remove the security warning arised due to the use of strncpy
> Resolve coding style warning

No.  Stop removing these warnings.  Remove the use of strncpy by all
means, but don't run checkpatch over other people's code.

You've been told to stop doing it before.  Now I'm telling you again.
https://lore.kernel.org/linux-mm/134bb70e-db8a-0892-0a3c-d00ad57fcece@google.com/
