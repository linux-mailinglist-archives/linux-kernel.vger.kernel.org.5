Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71FD7F1278
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjKTLwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:52:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACDA2;
        Mon, 20 Nov 2023 03:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5XdCuoj3ZWv7tIC1R687J3jzogBO9cX6nsxcKPOxK7E=; b=Qyf3VtSwPzdruBsdkjs+P+Gbr6
        /YnNDcgwfR5pdPyUaU95uhBXYLlQobQrJ3FBxJmoceFt5RbLkldk8K0dl/yWiHmxYJBD4vhj3mhnu
        wPOSz2Hev+/OK6E9yErJyR8jsbEBAPWnhOa8b5gnpYhOqKfsMeykKnJ2qg4l4iKyk+lhZw7ipxtU7
        O3O89hDBKylgV24gIYDGpuFVQPQUzo7IZSiQ/SjF0QR4vXJ80vNGPj52LNF1/yX1KL4+CQrAOb8rm
        nYTGGcSARlThXoFVqxUMA4dQRPRUE/mhqfubjEH+x1r0hiXX+fHVrjftmTSE2VzGggsyteypPYCzd
        ilNQQjaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r52pN-004RcP-JF; Mon, 20 Nov 2023 11:52:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F86D300419; Mon, 20 Nov 2023 12:52:33 +0100 (CET)
Date:   Mon, 20 Nov 2023 12:52:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v4 1/4] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Message-ID: <20231120115233.GT8262@noisy.programming.kicks-ass.net>
References: <20231117145142.2378800-1-willy@infradead.org>
 <20231117145142.2378800-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117145142.2378800-2-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 02:51:39PM +0000, Matthew Wilcox (Oracle) wrote:
> Modelled after lockdep_assert_held() and lockdep_assert_held_write(),
> but are always active, even when lockdep is disabled.  Of course, they
> don't test that _this_ thread is the owner, but it's sufficient to catch
> many bugs and doesn't incur the same performance penalty as lockdep.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
