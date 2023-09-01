Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4E78FC94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349281AbjIALpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349218AbjIALos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:44:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD991709
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E19FCE2261
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DF6C433C8;
        Fri,  1 Sep 2023 11:44:02 +0000 (UTC)
Date:   Fri, 1 Sep 2023 07:44:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Eric Vaughn <ervaughn@linux.microsoft.com>,
        Sishuai Gong <sishuai.system@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [GIT PULL] tracing: Updates for 6.6
Message-ID: <20230901074400.349d5c41@rorschach.local.home>
In-Reply-To: <xhsmhr0nib674.mognet@vschneid.remote.csb>
References: <20230831115635.1bdea0d7@rorschach.local.home>
        <xhsmhr0nib674.mognet@vschneid.remote.csb>
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

On Fri, 01 Sep 2023 11:20:31 +0200
Valentin Schneider <vschneid@redhat.com> wrote:
> > Tracing updates for 6.6:
> >
> >  User visible changes:
> >
> >   - Added a way to easier filter with cpumasks:
> >      # echo 'cpumask & CPUS{17-42}' > /sys/kernel/tracing/events/ipi_send_cpumask/filter
> >  
> 
> It looks like the patches included are from v2 of [1], which still had some
> (small) issues to fix. I have addressed these in [2], but I haven't sent
> this out yet as I'm still working on the context_tracking/vmalloc part of
> the series.
> 
> I'm happy to send just the tracing bits, if that helps - or just send the
> deltas as separate fixes, whatever makes it easier.

I put these patches into linux-next for a while, so I'm not going to
rebase them. Can you send delta patches on top of this. This shouldn't
stop this pull request.

> 
> Apologies for not bringing this up when the patches were picked up in [3],
> I've only just come back from PTO/moving abroad and have started catching
> up.

I'm still trying to get home from my PTO, which I spent in Tampa and
was suppose to fly home on Tuesday. But they closed the airport in
preparation for Idalia, which forced my wife and I to hunker down in a
hotel room for the last few days :-p (we are now in a to hotel room in
Syracuse, and are about to drive home).

-- Steve
