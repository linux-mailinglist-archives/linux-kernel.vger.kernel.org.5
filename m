Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF67F1B51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjKTRq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjKTRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:46:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A8EABA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:46:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371801692;
        Mon, 20 Nov 2023 09:47:08 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.25.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26D43F7A6;
        Mon, 20 Nov 2023 09:46:20 -0800 (PST)
Date:   Mon, 20 Nov 2023 17:46:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     qiwuchen55@gmail.com
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [PATCH] arm64: Add user stacktrace support
Message-ID: <ZVubargzvLPmhSYd@FVFF77S0Q05N.cambridge.arm.com>
References: <20231118134504.154842-1-qiwu.chen@transsion.com>
 <ZVttPU64cCem6szI@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVttPU64cCem6szI@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 02:29:23PM +0000, Mark Rutland wrote:
> On Sat, Nov 18, 2023 at 09:45:04PM +0800, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <qiwu.chen@transsion.com>

> > 2. Add arch_stack_walk_user() implementation to support userstacktrace transsionce option.
> 
> What is this 'userstacktrace transsionce option' ?

Sorry, I evidently corrupted the mail at my end; "transsionce" was "trace" in
the original mail, which matches the ftrace output below.

Please ignore this specific comment; my other concerns still apply.

> > A example test about the output format of ftrace userstacktrace as shown below:
> >     bash-489     [000] .....  2167.660775: sched_process_fork: comm=bash pid=489 child_comm=bash child_pid=596
> >     bash-489     [000] .....  2167.660787: <user stack trace>
> >  => /lib/aarch64-linux-gnu/libc-2.32.so[+0xa76d8]
> >  => /bin/bash[+0x5f354]
> >  => /bin/bash[+0x4876c]
> >  => /bin/bash[+0x4aec4]
> >  => /bin/bash[+0x4da48]
> >  => /bin/bash[+0x4b710]
> >  => /bin/bash[+0x4c31c]
> >  => /bin/bash[+0x339b0]

Thanks,
Mark.
