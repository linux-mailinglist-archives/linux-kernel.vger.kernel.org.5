Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A99753508
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjGNIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGNIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8B1BF9;
        Fri, 14 Jul 2023 01:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31C4961BCB;
        Fri, 14 Jul 2023 08:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4534DC433C7;
        Fri, 14 Jul 2023 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689323489;
        bh=mOp/R3MA1WgB2aSIsMXA6AzT7d3U2Y9fSh5X+yprt9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OPrbxERWT526fi8A956vfRZeMSg4HyOJB8lpCxd/1njffucGHJ20Z8afB77WMuuyQ
         16I8HYyZtW8WC7xXceKt00QYOgOqbYWngfeYnxFrRkMAYgoGr1vdZH1d6ps790E9SS
         c7dmelsU0nkoYiQvsHSlvFEGqsY4j0152aMmx+uvf+wVpvOwxe4Lo+Mstqm1jGMUJ0
         KQPpCdduzvYLtnLvCII8CWL2azGXmc/2C8Lz/mQHF4FMM494YKqi2ioULdQS4gqjqB
         LzEaGMiQdNC8XXruKwksfJ7SwCgA3HOOhXEWWKep6Ugx/0h6N1W6uBOQotGNLbRSY5
         WYPY67pXmuGqQ==
Date:   Fri, 14 Jul 2023 17:31:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Akanksha J N <akanksha@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: linux-next: duplicate patches in the ftrace tree
Message-Id: <20230714173126.37313c540cc998f5653a6848@kernel.org>
In-Reply-To: <20230714145404.115c7be1@canb.auug.org.au>
References: <20230714145404.115c7be1@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the caution!

On Fri, 14 Jul 2023 14:54:04 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   e46ad59233cf ("selftests/ftrace: Add new test case which checks for optimized probes")
>   bd2cdc432190 ("selftests/ftrace: Add new test case which adds multiple consecutive probes in a function")

These are only in next-20230714.

> 
> These are commits
> 
>   5985329c7073 ("selftests/ftrace: Add new test case which checks for optimized probes")
>   cf9071dd46e7 ("selftests/ftrace: Add new test case which adds multiple consecutive probes in a function")

I confirmed the latter pair was pushed by my probes-v6.5.
So the latter one should be kept.

Ah, sorry, I missed to update probes/for-next. That caused this issue.
Let me update the probes/for-next branch.

Thank you,

> 
> in Linus' tree.
> 
> -- 
> Cheers,
> Stephen Rothwell


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
