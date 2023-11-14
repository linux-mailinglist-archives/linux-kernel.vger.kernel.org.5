Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF997EB149
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjKNNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKNNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:55:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F59F132
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:55:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3090BC433C7;
        Tue, 14 Nov 2023 13:55:30 +0000 (UTC)
Date:   Tue, 14 Nov 2023 08:55:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Milian Wolff <milian.wolff@kdab.com>, akaher@vmware.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org
Subject: Re: NULL pointer dereference regression when running `chmod -R
 root:tracing /sys/kernel/debug/tracing`
Message-ID: <20231114085529.77099439@rorschach.local.home>
In-Reply-To: <2053f011-3c85-41e2-8685-1f46a2bc5fb8@leemhuis.info>
References: <20231105160139.660634360@goodmis.org>
        <20231112104158.6638-1-milian.wolff@kdab.com>
        <2053f011-3c85-41e2-8685-1f46a2bc5fb8@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 14:38:57 +0100
"Linux regression tracking #adding (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:

> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> On 12.11.23 11:41, Milian Wolff wrote:
> > 
> > this patch seems to have introduced a kernel bug causing
> > a NULL pointer dereference when one runs:
> > 
> >     sudo chown -R root:tracing /sys/kernel/debug/tracing/
> > 
> > See the archlinux bug report I created initially for some more information:
> > https://bugs.archlinux.org/task/80230
> > 
> > With 6.6.1 and 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b reverted,
> > the above `chmod` command works. With a normal 6.6.1 build, or re-applying
> > the patch again, the command fails and `dmesg` shows:  
> 
> Steven is already working on this, but to ensure the issue doesn't fall
> through the cracks unnoticed, I'm adding it to regzbot, the Linux kernel
> regression tracking bot (and from the context I assume it happens in
> mainline as well)

Note, the code in question was rewritten in 6.7 and the bug does not
exist there. It only exists in 6.6 and I already sent Greg the patch,
and he told me that it's in his queue.

It's only a regression in 6.6 and not in mainline.

-- Steve

