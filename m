Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8278D0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjH2X5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjH2X5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E0D114;
        Tue, 29 Aug 2023 16:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5C160DD5;
        Tue, 29 Aug 2023 23:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A989C433C8;
        Tue, 29 Aug 2023 23:57:21 +0000 (UTC)
Date:   Tue, 29 Aug 2023 19:57:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <20230829195719.0eaf9035@rorschach.local.home>
In-Reply-To: <20230825221321.faaa33e03afc48abc345c24f@kernel.org>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com>
        <20230824160859.66113-2-flaniel@linux.microsoft.com>
        <20230825211649.188a81321f00297ec161a046@kernel.org>
        <5704161.DvuYhMxLoT@pwmachine>
        <20230825221321.faaa33e03afc48abc345c24f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 22:13:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Excellent catch! Thank you, I will apply this patch and send v4 right after.
> > Regarding test, do you think I can add a test for the EADDRNOTAVAIL case?  
> 
> Hmm, in that case, you need to change something in tracefs/README so that
> we can identify the kernel has different behavior. Or we have to change
> this is a "Fix" for backporting.

I prefer this to be a Fix and backported.

Thanks,

-- Steve
