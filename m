Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50917E9265
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjKLT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLT7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:59:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D2258D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AxPWky8NgZXZgwIefkde46kXQyGnPtFMJa67Ozdq3xg=; b=N14OP4J2dGP4odkJ3Q3RdCOU1m
        M6xlmsUVo97FAKy8mkEFQTjOor2I/Xbh0qi55uqV0aQhX+jiu4h2GuybEusKh0uLcYS+LxZcjHhSm
        xd9Hvooh3jvSjPhIZ1eKnSnTtRvA59uVSAOFdhoq8bFJpPt/Zgi3ZIuNRFnmCU1rMqshGZLOzGDqp
        QDpHi6Psrjlw2L5UQFWk1Gy7+LnidkUYBtK+0sPa+UnIErNh2Qd2TMuFrlY807QGeOishUV+z7H7j
        WfIquTW+4yZ4xnrhqT3gj5i4xb2JEz5z1MxslOEHGhW8u28mpOwu7BvohWjzBGVlbNeuY89NyWTBq
        9Mn46J6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2GbP-000ZDz-2f;
        Sun, 12 Nov 2023 19:58:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AA97300427; Sun, 12 Nov 2023 20:58:39 +0100 (CET)
Date:   Sun, 12 Nov 2023 20:58:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231112195839.GA9987@noisy.programming.kicks-ass.net>
References: <202311031320.c3ebc782-oliver.sang@intel.com>
 <20231112193055.2072382-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112193055.2072382-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:00:55AM +0530, Abhinav Singh wrote:
> This patch fixes the sparse warning with this message 
> "dereference of noderef expression" , in this context 
> it means about directly dereferencing a pointer tagged 
> with __rcu annotation.

Please, stop this madness. Just accept that sparse is a stupid tool and
the code is actually fine.
