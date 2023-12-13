Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F48115C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442115AbjLMPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442114AbjLMPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:06:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC951170A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7368BC433CA;
        Wed, 13 Dec 2023 15:05:45 +0000 (UTC)
Date:   Wed, 13 Dec 2023 10:06:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Naveen N Rao <naveen@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Message-ID: <20231213100629.338c358c@gandalf.local.home>
In-Reply-To: <20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
References: <20231213113802.1278600-1-naveen@kernel.org>
        <20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Wed, 13 Dec 2023 21:54:50 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 13 Dec 2023 17:08:02 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
> > Add a test to exercize cpu hotplug with the function tracer active to
> > ensure that sensitive functions in idle path are excluded from being
> > traced. This helps catch issues such as the one fixed by commit
> > 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> >   
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you,
> 

Thanks Naveen and Masami!

Shuah, can you take this through your tree?

-- Steve
