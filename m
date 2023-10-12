Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6017C685A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjJLIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJLIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:16:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318290
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uRhtON6jaCtsunY1zDoSSX/u+Cd/XARVX/NR2R963YU=; b=ba6jT/W/0iFESWBpAP5bN9xBmu
        gmJM9l7m1pFAUR+HdIHZMsRUl2lV3SvbVlQwSkLoLxtiZ3xrxtCN5dXi0gXzfW62T10WxJopeAIP3
        G0f+zLFs4xRv560xamg4f6T0LwTYEpik7zQ+tL7NFNzS6MPjPap3wp3boSnv7fu9Pxl3R04hn+x/a
        wFQXYmf9j8r6Oo9Ekmm8i9SnG7vZ9WJTXl0qpfqHNsarag/LvQwAZBG1zYnkJ3dylKw0ZdbrJ8TfX
        X/VJk2HcZIl64D9h49Po+YxSgOweYGekvYQZ+YG1CYSlFFHa9c1LTX5/gHCstu1XK41KvN486U3kw
        btp3p74g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqqru-001fFs-2x;
        Thu, 12 Oct 2023 08:16:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CFE730036C; Thu, 12 Oct 2023 10:16:32 +0200 (CEST)
Date:   Thu, 12 Oct 2023 10:16:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231012081631.GJ6307@noisy.programming.kicks-ass.net>
References: <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
 <20231011162843.grv6kixw4ides6uw@treble>
 <20231011223513.GH6307@noisy.programming.kicks-ass.net>
 <20231012022758.lf62lgf5jx5xrno7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012022758.lf62lgf5jx5xrno7@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:27:58PM -0700, Josh Poimboeuf wrote:
> From an object code standpoint, objtool is the only one who cares about
> the relocs.  It's a good idea to make objtool more robust against
> non-relocs regardless, as the reloc assumption could always be broken
> later by LTO.

AFAIK LTO runs before the actual link stage and doesn't resolve
inter-section references, but yeah, that might just be an implementation
detail.

Fair enough.
