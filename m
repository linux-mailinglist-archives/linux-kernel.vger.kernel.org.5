Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788EB7560F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGQKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:55:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17FE45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UHXTXeendIcXHGBHMmAW+Cz0JPgeegKc2b4Ui4pfKww=; b=WREFAtL/28QLXIGb5IVTGep3J1
        858BMD021ks39hVq5KxdHI7XGMc4K+UsK6RjVX4AwE4M/kL9aQYycNau0gRgilRRSNPn428ManW33
        +qh4soYjget1j7K468MjavjqHF+khC29LKDsBF9cmza6MCKOTx+us91j2qpYa/eCLGtBpfYflYu8N
        tbFQBGmNVoq4iG4o2gys89703jJ2Z12u5/Aaf0HJ4Hs67eVRPapxMV7VYJ3pwVc8WbZqy6Y55yJMP
        WAHNjvy90MjBOuSiVvii0O4E+PXAPnPO+iAq9yeFNyzN7+G74uI7bZHKS+qD4dIGr0LbPGHVhqemX
        oBMHPazg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLLsf-0095ow-2I;
        Mon, 17 Jul 2023 10:55:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3CC3300274;
        Mon, 17 Jul 2023 12:55:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6BF62463D7F1; Mon, 17 Jul 2023 12:55:04 +0200 (CEST)
Date:   Mon, 17 Jul 2023 12:55:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chin Yik Ming <yikming2222@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fixed typo in comment
Message-ID: <20230717105504.GG4253@hirez.programming.kicks-ass.net>
References: <20230717064952.2804-1-yikming2222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717064952.2804-1-yikming2222@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 02:49:52PM +0800, Chin Yik Ming wrote:
> task_struct's state member is prefixed by "__"

This isn't a typo, the member got renamed long after these comments were
written.

Also, nobody should be accessing task->__state, so it being spelled
wrong in a comment doesn't seem like a problem to me.
