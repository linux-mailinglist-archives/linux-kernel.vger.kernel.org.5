Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72087C0045
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJJPT5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJJPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:19:56 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD18A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:19:54 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qqEWE-0000qC-0t;
        Tue, 10 Oct 2023 11:19:34 -0400
Message-ID: <4d29a5c75d1120d095f27e8e453da9b00c1336d5.camel@surriel.com>
Subject: Re: [PATCH] bounds: Support non-power-of-two CONFIG_NR_CPUS
From:   Rik van Riel <riel@surriel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Date:   Tue, 10 Oct 2023 11:19:34 -0400
In-Reply-To: <20231010145549.1244748-1-willy@infradead.org>
References: <20231010145549.1244748-1-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 15:55 +0100, Matthew Wilcox (Oracle) wrote:
> ilog2() rounds down, so for example when PowerPC 85xx sets
> CONFIG_NR_CPUS
> to 24, we will only allocate 4 bits to store the number of CPUs
> instead
> of 5.  Use bits_per() instead, which rounds up.  Found by code
> inspection.
> The effect of this would probably be a misaccounting when doing NUMA
> balancing, so to a user, it would only be a performance penalty.
> The effects may be more wide-spread; it's hard to tell.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 90572890d202 ("mm: numa: Change page last {nid,pid} into
> {cpu,pid}")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
