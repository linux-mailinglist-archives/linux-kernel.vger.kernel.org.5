Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EBB7EF809
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjKQTvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:51:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21596D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:51:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E09C433C7;
        Fri, 17 Nov 2023 19:51:06 +0000 (UTC)
Date:   Fri, 17 Nov 2023 14:51:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 66/86] treewide: kernel: remove cond_resched()
Message-ID: <20231117145110.235879da@gandalf.local.home>
In-Reply-To: <ZVetiSheCDo49Zqm@bombadil.infradead.org>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-10-ankur.a.arora@oracle.com>
        <ZVetiSheCDo49Zqm@bombadil.infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 10:14:33 -0800
Luis Chamberlain <mcgrof@kernel.org> wrote:

> Sounds like the sort of test which should be put into linux-next to get
> test coverage right away. To see what really blows up.

No, it shouldn't have been added this early in the development. It depends
on the first part of this patch series, that needs to finished first.

Ankur just gave his full vision of the RFC. You can ignore the removal of
the cond_resched() for the time being.

Thanks for looking at it Luis!

-- Steve
