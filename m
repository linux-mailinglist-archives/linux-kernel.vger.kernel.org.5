Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24E7CAE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjJPPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjJPPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAADF1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:52:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06237C433C7;
        Mon, 16 Oct 2023 15:52:07 +0000 (UTC)
Date:   Mon, 16 Oct 2023 11:53:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <20231016115342.30b3d357@gandalf.local.home>
In-Reply-To: <CAEf4Bza0ma+oRHYkHfQwmLPzJobRpq6-u2gog_uMNAHs0-KYiQ@mail.gmail.com>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
        <20231012114550.152846-1-asavkov@redhat.com>
        <20231012094444.0967fa79@gandalf.local.home>
        <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
        <ZSjdPqQiPdqa-UTs@wtfbox.lan>
        <20231013100023.5b0943ec@rorschach.local.home>
        <CAEf4Bza0ma+oRHYkHfQwmLPzJobRpq6-u2gog_uMNAHs0-KYiQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 12:43:18 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:


> > Correct. My Ack is based on the current way things are done upstream.
> > It was just that linux-rt showed the issue, where the code was not as
> > robust as it should have been. To me this was a correctness issue, not
> > an issue that had to do with how things are done in linux-rt.  
> 
> I think we should at least add some BUILD_BUG_ON() that validates
> offsets in syscall_tp_t matches the ones in syscall_trace_enter and
> syscall_trace_exit, to fail more loudly if there is any mismatch in
> the future. WDYT?

If you want to, feel free to send a patch.

> 
> >
> > As for the changes in linux-rt, they are not upstream yet. I'll have my
> > comments on that code when that happens.  
> 
> Ah, ok, cool. I'd appreciate you cc'ing bpf@vger.kernel.org in that
> discussion, thank you!

If I remember ;-)

-- Steve
